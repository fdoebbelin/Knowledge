## TL;DR
- Die Entwicklungslinie führt von klassischen VMs (vollständige Hardware-Isolation über einen Hypervisor) über Container (Kernel-geteilte Prozessisolation via Namespaces/cgroups) hin zu microVMs (VM-Isolation mit Container-Geschwindigkeit) und bootc/Image-Mode (das Betriebssystem selbst wird als OCI-Container gebaut und atomar aktualisiert) – die drei Welten wachsen 2025/2026 über OCI-Standards und gemeinsames Tooling (Podman, Buildah, Containerfiles) zusammen.
- Marktbewegend sind 2025/2026 vier Kräfte: die Broadcom/VMware-Preispolitik treibt eine große Migrationswelle zu Proxmox VE und XCP-ng; Podman (rootless, daemonless) und Incus (Community-Fork von LXD) etablieren sich als Open-Source-Standards; bootc/RHEL Image Mode erreichen Produktionsreife; und Docker Desktop bleibt für größere Unternehmen kostenpflichtig.
- Praxisregel: VM für starke Isolation und Fremd-Kernel/Legacy; Container für dichte, schnelle App-Deployments; microVM (Firecracker/Kata) für nicht vertrauenswürdige/mandantengetrennte Workloads; immutable OS/bootc für flottenweite, driftfreie, atomar aktualisierbare Server-, Edge- und Desktop-Systeme.

## Key Findings

- **VMware-Nachfolge:** Nach der Broadcom-Übernahme (Ende 2023) sind die Lizenzkosten je nach Konfiguration und vorherigen Rabatten um etwa 150 % bis über 1000 % gestiegen (Quellen: ColocationPlus, Juni 2025; AT&T bezifferte die Steigerung in einer US-Bundesgerichtsklage 2024 auf 1.050 %; eine britische Universität meldete +1.250 %, d. h. jährliche Supportkosten von £40.000 auf £500.000 unter dem VCF-Bundle-Zwang). vSphere Standard erreichte am 31. Juli 2025 das End-of-Sale. Proxmox VE (aktuell 9.x, basierend auf Debian 13 „Trixie") ist der führende Zielhafen für SMB/Mid-Market, XCP-ng (Xen-basiert) die zweite große Open-Source-Alternative.
- **KVM/QEMU** ist die technologische Basis nahezu aller offenen Virtualisierungsplattformen (Proxmox, oVirt, OpenStack, Incus-VMs, Harvester via KubeVirt).
- **oVirt** ist faktisch im Erhaltungsmodus: Red Hat hat die Entwicklung eingestellt, eine Community pflegt es weiter (Release 4.5.7 im Januar 2026), verweist Nutzer aber weg von den oVirt-Node-ISOs.
- **Container-Grundlagen:** Namespaces (Sichtbarkeit), cgroups v2 (Ressourcenlimits), Capabilities (Aufteilung der Root-Rechte in ~40 Einheiten), Seccomp (Syscall-Filterung) und LSMs (SELinux/AppArmor) bilden die Isolationsschichten. Container teilen den Host-Kernel – daher ist ein Container-Escape prinzipiell einfacher als ein VM-Escape.
- **Podman** (rootless, daemonless) ist die zentrale Open-Source-Alternative zu Docker; Quadlets (systemd-Integration) lösen `podman generate systemd` ab. Sowohl „Podman Container Tools" als auch „Podman Desktop" wurden am 21. Januar 2025 als eigenständige CNCF-Sandbox-Projekte aufgenommen. Aktuelle Podman-Version ist die im Juni 2026 erschienene 6.0.0-Linie (parallel gepflegte 5.8.x).
- **Incus** (Fork von LXD durch die ursprünglichen Entwickler nach Canonicals CLA-/Lizenzänderung) ist in Debian, Fedora, openSUSE und NixOS paketiert und gilt 2026 als bevorzugte Wahl für System-Container + VMs außerhalb des Ubuntu-Ökosystems; aktuelle LTS ist Incus 7.0 (Mai 2026).
- **bootc / RHEL Image Mode:** Bootable Containers sind produktionsreif – Image Mode für RHEL ist seit RHEL 9.6 und 10 generell verfügbar (GA zeitgleich mit RHEL 10, Mai 2025) und in allen RHEL-Subscriptions enthalten; bootc ist CNCF-Sandbox-Projekt (seit 21. Januar 2025).
- **microVMs** (Firecracker, Cloud Hypervisor, Kata Containers, gVisor) sind der Wachstumsbereich 2025/2026, getrieben durch AI-Agenten-Sandboxing und Multi-Tenant-Isolation.

## Details

### 1. Klassische Virtualisierung (VMs)

**Hypervisor-Grundlagen.** Ein Hypervisor (Virtual Machine Monitor, VMM) abstrahiert physische Hardware und stellt VMs jeweils eigene virtuelle CPUs, Speicher und Geräte bereit. Unterschieden werden:
- **Typ-1 (bare-metal):** läuft direkt auf der Hardware (VMware ESXi, Xen, Microsoft Hyper-V, KVM als Kernel-Modul). Höhere Performance und Isolation, typisch für Server/Rechenzentrum.
- **Typ-2 (hosted):** läuft als Anwendung auf einem Host-Betriebssystem (VirtualBox, VMware Workstation/Player, QEMU im User-Mode). Typisch für Desktop/Entwicklung.

Die Grenze ist bei Linux fließend: **KVM** verwandelt den Linux-Kernel selbst in einen Typ-1-Hypervisor, wird aber aus einem laufenden Linux heraus betrieben. Grundvoraussetzung ist **Hardware-Virtualisierung**: Intel **VT-x** (mit EPT für Speicher) bzw. AMD-**V** (mit RVI/NPT). Ohne diese CPU-Erweiterungen ist nur langsame Software-Emulation möglich.

**KVM/QEMU-Stack.** Der offene De-facto-Standard unter Linux:
- **KVM** (Kernel-based Virtual Machine): Kernel-Modul, das VT-x/AMD-V nutzt und die eigentliche CPU-/Speicher-Virtualisierung übernimmt.
- **QEMU**: emuliert Geräte (Festplatten, NICs, USB) und stellt – oft beschleunigt durch KVM – die komplette Maschine bereit. Moderne Gäste nutzen paravirtualisierte **virtio**-Treiber für nahezu native I/O-Performance.
- **libvirt**: Abstraktions-API und Daemon (`libvirtd`) zur Verwaltung von VMs, Netzwerken, Storage-Pools.
- **virsh** (CLI) und **virt-manager** (GUI) sind die klassischen libvirt-Frontends; `virt-install` erstellt VMs.

**Xen** ist ein reifer Typ-1-Hypervisor mit dom0/domU-Architektur, im Enterprise-Einsatz heute vor allem über **XCP-ng** (Fork von Citrix XenServer, seit 2020 Xen-Project-Inkubationsprojekt unter der Linux Foundation, getragen von Vates). Aktuelle LTS ist XCP-ng 8.3; verwaltet wird es über **Xen Orchestra** (XO 6.0 erschien im Dezember 2025, mit QCOW2-Unterstützung für Disks über 2 TiB im Release-Candidate-Stadium). Xen ist zudem stark im Automotive-/Embedded-Bereich.

**VirtualBox** (Oracle) bleibt der verbreitetste Typ-2-Hypervisor für Desktop-/Test-Zwecke, GPL-lizenziert (mit proprietärem Extension Pack).

**VMware-Alternativen und Broadcom-Kontext.** Broadcoms Übernahme von VMware (Ende 2023) hat das Marktgefüge verschoben: Wegfall unbefristeter Lizenzen, Umstellung auf Abo-Modell mit per-Core-Lizenzierung, Bündelung in VMware Cloud Foundation (VCF)/vSphere Foundation (VVF), zeitweise ein kontrovers diskutiertes Minimum von 72 Kernen pro Bestellung (im April 2025 wieder zurückgenommen). vSphere Standard erreichte am 31. Juli 2025 das End-of-Sale. Die Lizenzkosten stiegen je nach Konfiguration und vorheriger Rabattierung um etwa 150 % bis über 1000 % (Beispiele: AT&T +1.050 % laut US-Bundesgerichtsklage 2024; eine britische Universität +1.250 %; Broadcom senkte allerdings die VCF-Per-Core-Jahresgebühr um 50 % von 700 auf 350 USD).

Die wichtigsten offenen Ziele der Migrationswelle:
- **Proxmox VE** (aktuell 9.x, basierend auf Debian 13 „Trixie", Linux-Kernel 6.14/6.17-Linie, QEMU 10.x, LXC 6.0, OpenZFS 2.3, Ceph Squid): kombiniert KVM-VMs und LXC-System-Container mit integriertem Cluster, HA, Live-Migration, ZFS/Ceph-Storage und Web-UI. Ein integrierter **ESXi-Import-Wizard** (seit Ende 2024) erleichtert die Migration. Mit **Proxmox Datacenter Manager (PDM) 1.0** (stabil am 4. Dezember 2025, in Rust geschrieben) existiert erstmals ein zentrales Multi-Cluster-Management (als „vCenter-Herausforderer") inkl. cross-cluster Live-Migration, RBAC und zentralem Update-Management; PDM 1.1 (Mai 2026) ergänzte u. a. zentrales Ceph-Monitoring. **Proxmox Backup Server (PBS)** liefert deduplizierte, inkrementelle Backups; **Veeam** unterstützt Proxmox VE seit 2025 offiziell. Proxmox VE 9.1 (November 2025) brachte u. a. LXC-Container aus OCI-Images und Intel TDX; 9.2 einen dynamischen Load-Balancer (kontinuierliches CRS).
- **XCP-ng + Xen Orchestra** (Vates-Stack): Xen-basierte, API-first-Plattform mit Terraform/Pulumi-Providern.
- **oVirt**: Die einst als vSphere-Pendant gedachte KVM-Management-Plattform (oVirt Engine + oVirt Node) ist seit Red Hats Rückzug faktisch im Community-Erhaltungsmodus. Release 4.5.7 erschien im Januar 2026 und ist lauffähig auf CentOS/RHEL/Alma/Rocky 9/10; die Node-NG-ISOs werden zur Deprekation vorgeschlagen. Red Hat verweist Interessenten auf **OpenShift Virtualization/KubeVirt**.
- **Harvester** (SUSE/Rancher): moderne Hyperkonverged-Infrastruktur (HCI) auf Basis von RKE2 (Kubernetes), **KubeVirt** (VMs in K8s) und **Longhorn** (Storage). Für Umgebungen, die VM- und Container-Workloads unter einer Kubernetes-nativen Oberfläche konsolidieren wollen.
- **OpenStack** (kurz): umfassendes IaaS-„Cloud-Betriebssystem" (Nova/Compute auf KVM-Basis, Neutron/Networking, Cinder/Storage etc.), Release-Serie 2025.2. Sehr mächtig, aber komplex; Ziel für große private Clouds.

**Aktuelle Entwicklungen – microVMs.** Zwischen VM und Container hat sich eine eigene Klasse etabliert:
- **Firecracker** (AWS, in Rust, ~2018): minimalistischer VMM auf KVM-Basis, der nur fünf Geräte emuliert (virtio-net, virtio-block, virtio-vsock, serielle Konsole, minimaler Keyboard-Controller). Powert AWS Lambda und Fargate. Laut offizieller Firecracker-Spezifikation vergehen ≤ 125 ms vom `InstanceStart`-API-Aufruf bis zum Start des Gast-`/sbin/init`, der Speicher-Overhead der VMM-Threads liegt bei ≤ 5 MiB, und ein Host unterstützt bis zu 150 microVMs pro Sekunde – drastisch reduzierte Angriffsfläche (~50.000 Zeilen Rust gegenüber QEMUs Millionen Zeilen C).
- **Cloud Hypervisor** (Intel/Microsoft, Rust): funktionsreicherer microVM-Monitor, Standard-Backend vieler Kata-Deployments, läuft auf KVM und Microsoft Hypervisor (MSHV).
- Beide bauen auf dem gemeinsamen **rust-vmm**-Crate-Ökosystem (auch crosvm, libkrun, Dragonball nutzen es).

### 2. Container-Technologien

**Technische Grundlagen (Kernel-Primitive).** Container sind keine VMs, sondern isolierte Prozesse auf einem geteilten Kernel:
- **Namespaces** isolieren die *Sicht* eines Prozesses: `pid` (Prozess-IDs), `net` (Netzwerk-Stack), `mnt` (Mountpoints), `uts` (Hostname), `ipc` (Shared Memory/Queues), `user` (UID/GID-Mapping – Basis für rootless), `cgroup` und `time`.
- **cgroups v2** begrenzen den *Verbrauch* (CPU, Speicher, I/O, PIDs). Die unified hierarchy von cgroups v2 ist heute Standard; Kubernetes hat cgroups v1 mit Version 1.31 (August 2024) in den Maintenance-Modus versetzt.
- **OverlayFS** realisiert das schichtweise Image-Modell (Copy-on-Write): jede Containerfile-Anweisung erzeugt eine content-adressierte Layer.
- **Capabilities** zerlegen die Allmacht von Root in ~40 einzeln zuweisbare Einheiten (z. B. `CAP_NET_BIND_SERVICE`, `CAP_CHOWN`); gefährliche wie `CAP_SYS_ADMIN` werden standardmäßig entzogen.
- **Seccomp** filtert erlaubte Syscalls (Default-Profile blockieren Dutzende Syscalls). LSMs (**SELinux**, **AppArmor**) ergänzen mandatory access control.

Der `--privileged`-Modus hebt praktisch alle diese Schutzschichten auf und ist in Produktion zu vermeiden.

**System- vs. Application-Container.**
- **Application-Container** (Docker, Podman) verpacken einzelne Anwendungen/Prozesse; kurzlebig, ideal für Microservices.
- **System-Container** (LXC/Incus) simulieren ein vollständiges Linux-Userland mit init/systemd – „leichtgewichtige VMs" für persistente, stateful Umgebungen.

**LXC/LXD/Incus.** LXC ist die zugrundeliegende Low-Level-Technologie für System-Container. **LXD** war Canonicals Management-Layer darüber. 2023 zog Canonical LXD aus dem Linux-Containers-Projekt heraus und stellte auf AGPLv3 mit verpflichtendem Contributor License Agreement (CLA) um (Lizenzwechsel ab LXD 5.20, Dezember 2023; LXD 5.21.0 LTS im März 2024 AGPL-3.0-only); die Maintainer-Rolle wurde auf Canonical-Mitarbeiter beschränkt. Daraufhin forkten die ursprünglichen Entwickler (Aleksa Sarai, Stéphane Graber u. a.) das Projekt noch am selben Tag als **Incus** (Apache-2.0, ohne CLA), das vom Linux-Containers-Projekt adoptiert wurde. Incus verwaltet System-Container (über LXC), Application-Container und VMs (über QEMU) mit einer einheitlichen CLI und REST-API; es bietet OIDC-Auth und OpenFGA-basiertes RBAC. Incus ist inzwischen in Debian stable, Fedora, openSUSE und NixOS paketiert. Aktuell ist **Incus 7.0 LTS** (Mai 2026, Support bis Juni 2031) neben der monatlichen Feature-Linie (7.x); die vorige LTS 6.0 (Support bis Juni 2029) ist in der Security-Only-Phase. LXD wird von Canonical weiterentwickelt (Feature-Linie 6.x, LTS 5.21.x), jedoch primär via Snap und mit bestem Support auf Ubuntu. Migration von LXD zu Incus wird durch ein Migrationswerkzeug unterstützt (das nur gegen einen leeren Incus-Server läuft).

**Docker-Ökosystem und OCI-Werkzeuge.**
- **Docker**: das ursprüngliche Werkzeug, das Container populär machte; Client-Server-Architektur mit zentralem Daemon (`dockerd`). Laut Stack Overflow Developer Survey 2025 nutzen weiterhin rund 71 % der Entwickler weltweit Docker (gegenüber ca. 11 % Podman).
- **Podman** (Red Hat): daemonless, standardmäßig **rootless** (User-Namespaces); Docker-kompatible CLI (`alias docker=podman` funktioniert weitgehend); Konzept der **Pods** (Gruppen von Containern). Tiefe **systemd-Integration** über **Quadlets** (deklarative `.container`/`.pod`/`.network`/`.volume`/`.kube`-Unit-Dateien, seit Podman 4.4), die `podman generate systemd` ablösen – letzteres erhält nur noch dringende Bugfixes, keine neuen Features. `podman auto-update` erlaubt automatische Image-Updates mit Rollback. Aktuelle Version: Podman 6.0.0-Linie (Juni 2026).
- **containerd**: High-Level-Runtime (CNCF-graduated seit Februar 2019), Standard-Runtime unter Kubernetes (~95 % der Cluster); verwaltet Image-Pull, Storage, Container-Lifecycle und ruft eine Low-Level-Runtime auf. Die 2.x-Linie ist seit November 2024 etabliert.
- **CRI-O**: schlanke, Kubernetes-spezifische CRI-Implementierung (Red Hat).
- **Buildah**: Image-Bau (Containerfiles/Dockerfiles) ohne Daemon.
- **Skopeo**: Kopieren, Signieren und Inspizieren von Images zwischen Registries.

**OCI-Standards.** Die Open Container Initiative definiert drei Kernspezifikationen: **Image Spec** (Aufbau von Images als Manifest + content-adressierte Layer), **Runtime Spec** (wie ein Bundle aus `config.json` + rootfs ausgeführt wird; aktuell v1.3.0, November 2025) und **Distribution Spec** (Registry-Protokoll). Die klare Trennung ermöglicht Austauschbarkeit:
- **runc** (Go): Referenzimplementierung der Runtime Spec; erzeugt Namespaces/cgroups und startet den Container-Prozess.
- **crun** (C, Red Hat/Giuseppe Scrivano): schneller, speichereffizienter (~400 KB vs. ~10 MB), native cgroups-v2-Unterstützung; Default bei Podman und CRI-O.
- **youki** (Rust): jüngere Alternative.
- **runsc** (gVisor) und **kata-runtime** implementieren dieselbe Schnittstelle mit stärkerer Isolation.

Die Zweischichtigkeit ist wichtig: Kubernetes' kubelet spricht über die **CRI** (gRPC) mit einer CRI-Implementierung (containerd, CRI-O), die wiederum eine **OCI-Runtime** (runc, crun) aufruft.

**Sandboxed Container (stärkere Isolation ohne volle VM).**
- **gVisor** (Google): User-Space-Kernel („Sentry", in Go), der Syscalls abfängt und neu implementiert – kleinere Angriffsfläche, aber kein Hardware-Isolationslayer; ~50–100 ms Startlatenz. Basis für Googles Agent Sandbox.
- **Kata Containers** (CNCF): kein eigener Isolationsmechanismus, sondern ein Orchestrierungs-Framework, das jeden Container in einer leichtgewichtigen VM startet (Backends: QEMU, Firecracker, Cloud Hypervisor). Aus Kubernetes-Sicht ein normaler Container, unter der Haube eine echte VM mit Hardware-Isolation; ~150–300 ms Start.

**Orchestrierung.**
- **Kubernetes (K8s)**: der De-facto-Standard für Container-Orchestrierung im großen Maßstab; deklarativ, selbstheilend, aber komplex (Wochen bis Monate Einarbeitung).
- **K3s** (Rancher/SUSE): CNCF-zertifizierte, leichtgewichtige K8s-Distribution in einem einzigen Binary unter 100 MB, läuft mit ~512 MB RAM; ideal für Edge/IoT und Homelab.
- **MicroK8s** (Canonical): snap-basierte K8s-Distribution mit Add-ons; gut auf Ubuntu.
- **Docker Swarm**: funktional, aber faktisch im Maintenance-Modus – kein großer Cloud-Provider bietet Managed Swarm, keine neuen Features; für neue Projekte wird Kubernetes bzw. K3s/MicroK8s empfohlen.
- **Podman Quadlets/systemd**: für Single-Host-Szenarien eine schlanke Alternative zur Orchestrierung; `podman kube play` kann Kubernetes-YAML lokal ausführen.

**Compose-Ökosystem.** `docker compose` (heute als Plugin, YAML-basiert) ist der Standard für Multi-Container-Setups auf einem Host. Im Podman-Umfeld existieren `podman compose` (Wrapper) und der native Podman-Compose-Support; alternativ werden Compose-Files mit Werkzeugen wie **podlet** in Quadlets konvertiert.

### 3. Image-basierte / immutable Betriebssysteme und bootc

**Konzept.** Immutable (atomic) Betriebssysteme machen das Wurzeldateisystem (v. a. `/usr`) schreibgeschützt; nur definierte Bereiche (`/etc`, `/var`) sind veränderbar. Updates erfolgen **transaktional/atomar**: Ein neues, vollständig getestetes Systemabbild wird gestaged und beim nächsten (Soft-)Reboot aktiviert – schlägt es fehl, wird sauber auf die vorige Version zurückgerollt. Vorteile: keine Konfigurations-Drift, reproduzierbare Flotten, einfache Rollbacks, kleinere Angriffsfläche.

**OSTree / rpm-ostree.** **libostree** ist ein „Git-artiges" System für bootfähige Dateisystem-Bäume plus Bootloader-Management. **rpm-ostree** ist ein hybrider Image-/Paket-Manager, der RPM-Inhalte in atomare Deployments überführt. Er ist die Update-Basis von:
- **Fedora Silverblue** (GNOME) und **Kinoite** (KDE): immutable Desktops (Fedora 42/43-Linie). `rpm-ostree status` zeigt die Deployments, `rpm-ostree install` layert Pakete (erst nach Reboot wirksam).
- **Fedora CoreOS**: minimales, automatisch aktualisierendes Server-/Container-Host-OS (Ignition-Provisionierung).
- **Fedora IoT**.

Fedora migriert diese Editionen zunehmend zu **OCI-Container-Images als Transport** (z. B. `quay.io/fedora/fedora-silverblue`), womit rpm-ostree und bootc technisch konvergieren.

**bootc – Bootable Containers im Detail.** bootc überträgt das Docker-Layer-Modell auf das gesamte Host-System: Ein Standard-OCI-Container-Image enthält zusätzlich Kernel (`/usr/lib/modules`), initrd und Bootloader und wird zum Booten verwendet. Wichtig: **Zur Laufzeit läuft das System nicht als Container** – systemd ist wie gewohnt PID 1, es gibt keinen „äußeren" Prozess. bootc ist ein CLI-Werkzeug plus systemd-Services, das transaktionale In-Place-Updates über Container-Images ausführt:
- `bootc status` zeigt aktuelles/gestagtes Image; `bootc upgrade` zieht das neueste Image (aktiv beim nächsten Reboot); `bootc switch` wechselt die Image-Quelle.
- Der Workflow ist container-nativ: Man schreibt ein **Containerfile** (`FROM quay.io/fedora/fedora-bootc:42` oder `quay.io/centos-bootc/centos-bootc:stream10`), fügt Pakete/Konfiguration hinzu, baut mit Podman/Buildah, pusht in eine Registry und aktualisiert Flotten daraus. **bootc-image-builder** erzeugt aus dem Container installierbare Disk-Images (ISO, qcow2, AMI, VMDK, raw, VHD, GCE).
- Sicherheit: Container-Scanning, -Signierung (cosign) und SBOMs gelten damit für das gesamte OS inkl. Kernel. Sealed Images mit UKI, composefs, Secure Boot und TPM-Attestierung sind in Fedora Atomic in Arbeit.

bootc-**Status**: APIs im November 2024 als stabil erklärt; **CNCF-Sandbox-Projekt seit 21. Januar 2025**; hohe Release-Frequenz (aktuell 1.x-Linie); Basis-Images für Fedora, CentOS Stream und RHEL vorhanden, Arbeit an Debian/Arch läuft (Hauptschmerzpunkt: Bootloader). Auch der Anaconda-Installer unterstützt inzwischen ein `bootc`-Kickstart-Kommando.

**RHEL Image Mode.** Red Hats Produktisierung von bootc: **Image Mode für RHEL** ist seit RHEL 9.6 und 10 **generell verfügbar** (GA zeitgleich mit RHEL 10, Mai 2025) und in allen RHEL-Subscriptions enthalten. Neben dem klassischen „Package Mode" (dnf/RPM, mutable) baut, deployt und aktualisiert man im „Image Mode" das gesamte OS als OCI-Image (`registry.redhat.io/rhel10/rhel-bootc`). Neuere Fähigkeiten: **soft reboot** (userspace-only Neustart über `/run/nextroot/`, Updates in Sekunden statt Minuten, RHEL 10), **logically bound images** (an den OS-Lifecycle gekoppelte App-Container wie Security-Agents), EUS-bootc-Images und `bootc-base-imagectl` für eigene Basis-Images. Podman Desktop enthält eine bootc-Extension inklusive lokalem VM-Start.

**Vergleichbare Ansätze.**
- **openSUSE MicroOS / Aeon (Desktop) / Kalpa**: nutzen **BTRFS-Snapshots** und **transactional-update** (`transactional-update pkg in <paket>`) statt OSTree; Snapper/YaST für Snapshot-Management; Podman als Container-Engine. Aeon war bis in 2025 im Release-Candidate-Stadium.
- **Ubuntu Core** (Canonical): alles – Kernel, Base, Apps – als **Snaps** paketiert; `snapd` managt transaktionale Updates und Rollbacks; Snap-Confinement isoliert Komponenten. Fokus auf IoT/Edge; ein immutables Ubuntu-Desktop-Modell wird vorangetrieben.
- **NixOS**: **deklarativer** Ansatz über die Nix-Sprache; das gesamte System wird aus einer Konfiguration reproduzierbar gebaut, mit generationsbasiertem Rollback. Streng genommen nicht image-immutable wie bootc/Ubuntu Core, aber funktional verwandt; steile Lernkurve.
- **Vanilla OS**: Debian/Ubuntu-basiert, nutzt **ABRoot** (A/B-Root-Partitionen) und **Apx** (Multi-Distro-Paketverwaltung via Container); Flatpak für Desktop-Apps.
- Weitere: **Flatcar Container Linux** (Container-Host mit read-only OS-Partition), **Talos Linux** (immutable Kubernetes-OS, API-only, kein Shell/SSH), **SteamOS**, **Bazzite** (Fedora-Atomic-basiert, Gaming), **Endless OS**.

**Zusammenhang zum Container-Tooling.** Der entscheidende didaktische Punkt: bootc schließt den Kreis. Dieselben Werkzeuge und Formate (Podman/Buildah, Containerfiles, OCI-Images, Registries, Signierung, CI/CD-Pipelines), die Azubis für Application-Container lernen, gelten nun auch für das Betriebssystem selbst („GitOps auf OS-Ebene"). Anwendungs- und OS-Delivery verwenden dieselbe „Sprache".

### 4. Einordnung und Vergleich

**Wann was?**
- **VM**: wenn ein anderer Kernel/OS nötig ist (Windows-Gäste, Legacy), bei starken Isolations-/Compliance-Anforderungen, für „Pets" mit langem Lebenszyklus, klassische Server-Konsolidierung. Overhead: höchster (voller Gast-Kernel), Start in Sekunden.
- **Container**: für dichte, schnell startende, portable App-Deployments, Microservices, CI/CD, skalierbare zustandslose Dienste. Overhead: minimal (geteilter Kernel), Start in Millisekunden. Sicherheits-Caveat: geteilter Kernel.
- **System-Container (Incus/LXC)**: „VM-Gefühl" (persistent, systemd, SSH) bei Container-Effizienz – Dev-Boxen, Mail-/DB-Server, Multi-User-Hosts.
- **microVM (Firecracker/Kata/gVisor)**: wenn nicht vertrauenswürdiger Code oder echte Mandantentrennung Hardware-Isolation verlangt, aber Container-Geschwindigkeit/-Dichte gewünscht ist – Serverless, Function-as-a-Service, AI-Agenten-Sandboxes, Multi-Tenant-SaaS.
- **immutable OS / bootc**: für flottenweite, driftfreie, atomar aktualisierbare und leicht zurückrollbare Systeme – Edge/IoT, Server-Flotten, Kiosk-/Appliance-Systeme, zunehmend auch Desktops.

**Sicherheits-Isolationsgrad (aufsteigend):** Standard-Container (Namespaces/cgroups, geteilter Kernel – ein Kernel-Exploit kompromittiert alle Container) < gVisor (User-Space-Kernel, kleinere Angriffsfläche, aber kein Hardware-Boundary) < microVM/Kata/Firecracker (dedizierter Gast-Kernel, hardware-erzwungene Isolation via VT-x/AMD-V) ≈ vollständige VM. Ein VM-Escape erfordert einen Hypervisor-CVE (selten, hochbezahlt); Container-Escapes über Kernel-/Konfigurationsfehler sind dokumentiert und häufiger. Härtung von Containern: rootless, `--cap-drop=ALL`, `--read-only`, `no-new-privileges`, non-root-UID, SELinux/AppArmor, minimale Basis-Images.

**Trends und Marktentwicklung 2025/2026.**
- **VMware-Exodus**: größte Hypervisor-Migrationswelle seit Jahren; Proxmox VE und XCP-ng als Hauptprofiteure. Realistische Migrationsprojekte dauern jedoch oft länger als geplant, sobald DR-Orchestrierung (SRM/Zerto/Veeam Orchestrator) neu gebaut werden muss – ein als 6-monatig geplantes Projekt kann zu 24 Monaten werden.
- **Podman-Adoption**: rootless/daemonless als Sicherheits- und Lizenzargument; Default bei RHEL/OpenShift und SUSE; Podman-Tools und Podman Desktop seit Januar 2025 CNCF-Sandbox. Docker bleibt laut Stack-Overflow-Umfrage 2025 dennoch das meistgenutzte Werkzeug (~71 % vs. ~11 % Podman).
- **Incus-Entwicklung**: Community-Fork hat sich durchgesetzt (breite Distro-Paketierung, aktuell 7.0 LTS), gilt für Neustarts außerhalb von Ubuntu als empfohlene Wahl.
- **bootc-Momentum**: RHEL Image Mode GA, CNCF-Sandbox, Konvergenz von rpm-ostree-Editionen auf bootc, wachsende Zahl abgeleiteter Distributionen.
- **Docker-Lizenzsituation**: Docker Desktop ist für Unternehmen mit ≥250 Mitarbeitern *oder* ≥10 Mio. USD Umsatz kostenpflichtig (Personal-Tier frei für Einzelpersonen/kleine Firmen/OSS/Bildung); Docker Engine unter Linux bleibt frei. Docker Hub führte 2025 Pull-Limits ein (freie Tier auf 100 Pulls/6 h gedrosselt; bezahlte Tiers unlimitiert seit April 2025). Das treibt Wechsel zu Podman Desktop, Rancher Desktop und Colima.
- **CNCF-Landschaft**: containerd ist der Runtime-Standard unter Kubernetes (~95 % der Cluster); Kubernetes entfernte dockershim in v1.24 (2022). Auch Lima (lokale Linux-VMs für Container) wurde im November 2025 CNCF-Incubating. Der Trend geht zu spezialisierten Runtimes je Einsatzzweck und – getrieben durch AI-Agenten – zu microVM-Isolation.

## Recommendations

Für die Kurskonzeption (Fachinformatiker-Azubis) empfiehlt sich ein gestufter, praxisnaher Aufbau:

1. **Fundament zuerst (Woche 1–2):** VM-Grundlagen praktisch mit **KVM/QEMU + virt-manager** auf einem Linux-Host oder mit **VirtualBox** (niedrigste Einstiegshürde). Konkret: Typ-1 vs. Typ-2 erklären, VT-x/AMD-V im BIOS/UEFI zeigen, eine VM mit virtio-Treibern bauen. *Benchmark für den nächsten Schritt: Azubis können eine VM per `virsh` starten/stoppen und den Unterschied zu einem Prozess benennen.*

2. **Container-Kernmechanik (Woche 3–4):** Nicht mit Docker-Magie starten, sondern mit den **Kernel-Primitiven** – `lsns`, `/sys/fs/cgroup`, `unshare`, Capabilities/Seccomp praktisch demonstrieren, dann `runc`/`crun` mit einem OCI-Bundle. Erst danach **Podman (rootless)** und Docker als Komfortschicht. Quadlets als moderne systemd-Integration zeigen. *Benchmark: Azubis erklären, warum ein Container-Escape gefährlicher ist als ein VM-Escape.*

3. **System-Container & Orchestrierung (Woche 5):** **Incus** für „VM-Gefühl", dann `docker compose`/`podman kube play` für Multi-Container; **K3s** als niederschwelliger Kubernetes-Einstieg (statt vollem K8s). Docker Swarm nur als historische Randnotiz.

4. **Immutable OS & bootc (Woche 6):** **Fedora Silverblue** als anfassbares immutable-Desktop-Beispiel (`rpm-ostree status`), dann der bootc-Workflow: aus einem Containerfile ein bootfähiges OS bauen (`quay.io/fedora/fedora-bootc`), mit bootc-image-builder ein Disk-Image erzeugen, in einer VM starten. Den roten Faden betonen: *dieselben Container-Werkzeuge, jetzt für das ganze OS.*

5. **Marktkontext als Klammer:** Broadcom/VMware-Situation, Docker-Lizenzierung, Podman-/Incus-/bootc-Momentum als Motivation, warum Open-Source-Kompetenz 2026 gefragt ist.

**Schwellen, die die Empfehlung ändern:** Wenn die Zielgruppe primär Cloud/Kubernetes-orientiert ist, K3s/containerd früher und tiefer behandeln und bootc knapper halten. Wenn der Ausbildungsbetrieb bereits RHEL/Fedora einsetzt, Podman + Image Mode priorisieren; bei Ubuntu-Häusern LXD/MicroK8s ergänzen. Für reine Rechenzentrums-/VMware-Migrationskontexte Proxmox VE praktisch vertiefen (Import-Wizard, PBS, PDM).

## Caveats

- **Versionsstände sind Momentaufnahmen (Stand Juli 2026).** Container-/Virtualisierungsprojekte veröffentlichen häufig; konkrete Minor-Versionen (Podman 6.0.x, containerd 2.3.x, bootc 1.x, Incus 7.x, Proxmox 9.x, Docker Engine 29.x) sollten vor Kursbeginn gegen die offiziellen Release-Seiten geprüft werden.
- **Herstellernahe Quellen** (Red Hat zu bootc, Proxmox/SUSE zu ihren Produkten, Migrationsdienstleister zu VMware-Kosten) sind teils werblich; die genannten Kostensteigerungen (150 %–1000 %+) sind aggregierte Community-/Dienstleister- und Gerichtsangaben und variieren stark nach Organisationsgröße und Lizenztier.
- **oVirt** ist lauffähig, aber ohne Vendor-Backing – für Neuprojekte nicht mehr empfehlenswert; Bestandsnutzer sollten Migrationspfade (Proxmox, XCP-ng, OpenShift Virtualization/Harvester) evaluieren.
- **microVM-/AI-Sandbox-Aussagen** stammen teils von kommerziellen Anbietern (Northflank, Edera etc.); Start-/Overhead-Zahlen (z. B. Firecracker ≤ 125 ms Boot, ≤ 5 MiB VMM-Overhead laut offizieller Spezifikation) sind konfigurationsabhängige Richtwerte, keine garantierten Produktions-Benchmarks.
- **„Immutable" ist ein unscharfer Begriff:** OSTree-Deployments, BTRFS-Snapshots (MicroOS), Snap-basiertes Ubuntu Core, NixOS-Generationen und ABRoot lösen verwandte Probleme technisch unterschiedlich; sie sollten nicht als austauschbar dargestellt werden.