# Virtualisierung und Container-Technologie: Grundlagen, Docker vs. Podman und weiterführende Quellen

## TL;DR
- **Klassische Virtualisierung** abstrahiert die Hardware und lässt vollständige Gastbetriebssysteme in VMs über einen Hypervisor laufen (starke Isolation, aber schwer und langsam); **Containerisierung** virtualisiert das Betriebssystem: Container teilen sich den Host-Kernel und kapseln nur die Anwendung samt Abhängigkeiten (leicht, schnell, weniger Isolation).
- Im Vergleich **Docker vs. Podman** gilt 2026: Docker punktet mit dem reiferen Ökosystem, komfortablem Docker Desktop und maximaler Werkzeug-Kompatibilität; Podman punktet mit daemonless/rootless-Architektur (mehr Sicherheit, kein Single Point of Failure), nativer systemd- und Kubernetes-Integration sowie kostenfreier Nutzung ohne Docker-Desktop-Lizenz. Für Lernende/Entwickler ist Docker der einfachste Einstieg, für sicherheitskritische Linux-/RHEL-Server ist Podman oft die bessere Wahl.
- Vier geprüfte, frei zugängliche PDFs sind am Ende gelistet (u. a. Vorlesungsfolien von Prof. Christian Baun, das „Dozentenhandbuch Virtualisierung" und zwei Red-Hat-Sicherheitsdokumente).

## Key Findings
- **VMs virtualisieren Hardware, Container virtualisieren das Betriebssystem.** Eine VM bringt ein komplettes Gast-OS mit und belegt typischerweise mehrere Gigabyte; ein Container teilt sich den Kernel und startet in Sekunden statt Minuten.
- **Typ-1-Hypervisor** (Bare-Metal, z. B. VMware ESXi, Microsoft Hyper-V, KVM, Citrix/Xen) laufen direkt auf der Hardware und bieten bessere Leistung, Effizienz und Isolation; **Typ-2-Hypervisor** (Hosted, z. B. VirtualBox, VMware Workstation, Parallels) laufen als Anwendung auf einem Host-Betriebssystem, sind einfacher einzurichten, aber langsamer.
- **Container basieren auf Linux-Kernelfeatures**: Namespaces (Isolation von PID, Netzwerk, Mount, IPC, UTS, User, Cgroup) und cgroups (Ressourcenbegrenzung). Images sind schreibgeschützte, geschichtete Dateisysteme (OverlayFS/UnionFS mit Copy-on-Write), die in Registries verteilt werden. Der OCI-Standard sorgt für Interoperabilität.
- **Docker = daemonbasiert** (dockerd läuft als root-Prozess, Single Point of Failure), **Podman = daemonless** (jeder Container ist ein direkter Kindprozess des Nutzers, fork/exec-Modell). Podman ist rootless by default und daher sicherheitstechnisch überlegen.
- **CLI-Kompatibilität ist hoch** (in der Praxis rund 95 %): `alias docker=podman` funktioniert für die meisten Alltagsbefehle. Unterschiede treten bei docker-compose, Netzwerk-Details und dem Pod-Konzept auf.
- **Docker Desktop ist für größere Unternehmen kostenpflichtig** (Personal-Plan nur frei bei unter 250 Mitarbeitern *und* unter 10 Mio. USD Umsatz); die Docker Engine selbst bleibt Open Source. Podman Desktop ist vollständig kostenlos (Apache 2.0).

## Details

### 1. Grundlagen der Virtualisierung

**Was ist Virtualisierung?** Durch Virtualisierung werden die Ressourcen eines Rechnersystems (Prozessor, Hauptspeicher, Datenspeicher, Netzwerk) aufgeteilt und von mehreren unabhängigen Instanzen genutzt. Das Ziel ist bessere Auslastung, Konsolidierung, Isolation und Flexibilität. Das Konzept ist nicht neu: IBM kündigte am 2. August 1972 die **VM/370** (offiziell „Virtual Machine Facility/370") gemeinsam mit den ersten System/370-Mainframes mit virtuellem Speicher an – eine Plattform, auf der mehrere Betriebssysteminstanzen in virtuellen Maschinen liefen.

**Klassische Virtualisierung (Hypervisor / VMs):** Ein Hypervisor (auch Virtual Machine Monitor, VMM) ist eine Softwareschicht, die mehrere voneinander unabhängige virtuelle Maschinen erstellt und verwaltet. Jede VM verhält sich wie ein vollwertiger Computer mit eigenem Betriebssystem, eigenem Kernel und emulierter/zugewiesener Hardware. Die Anwendungen in der VM merken nicht, dass sie virtualisiert laufen.

Man unterscheidet zwei Hypervisor-Typen:
- **Typ-1 (Bare-Metal / nativ):** Läuft direkt auf der Hardware und fungiert selbst als minimales Betriebssystem. Vorteile: bessere Performance, stärkere Isolation, Enterprise-Features wie Live-Migration, Hochverfügbarkeit, Snapshots, PCIe-Passthrough. Nachteile: komplexer einzurichten, benötigt Hardware-Virtualisierungsunterstützung (Intel VT-x, AMD-V). Beispiele: VMware ESXi, Microsoft Hyper-V, KVM, Citrix Hypervisor (Xen).
- **Typ-2 (Hosted):** Läuft als Anwendung auf einem vorhandenen Host-Betriebssystem und ist auf dieses für Ressourcenmanagement angewiesen. Vorteile: einfach zu installieren und zu bedienen, kostengünstig, ideal für Desktop/Entwicklung. Nachteile: geringere Performance (zusätzliche OS-Schicht), größere Angriffsfläche. Beispiele: Oracle VM VirtualBox, VMware Workstation, Parallels Desktop, QEMU.

*Hinweis:* KVM wird manchmal fälschlich als Typ-2 eingeordnet, weil es Teil des Linux-Kernels ist; funktional agiert es jedoch als Typ-1-Hypervisor, da es den Linux-Kernel selbst zum Hypervisor macht.

**Containerisierung (OS-Level-Virtualisierung):** Hier kommt kein Hypervisor zum Einsatz. Die Gäste („Container", historisch auch „Jails") sind lediglich eine Teilmenge des Host-Betriebssystems. Host und alle Gäste verwenden denselben Kernel, der die Ressourcen unter den Containern aufteilt. Alle Anwendungen in den Containern laufen als normale Prozesse auf dem Host-Kernel, sind aber durch Kernelmechanismen stark voneinander isoliert und sehen nur ihre eigenen Ressourcen. Da das Betriebssystem direkt auf die Hardware zugreift und die Abstraktionsschicht nur dünn ist, sind Container ressourcenschonend und starten sehr schnell.

**Vor- und Nachteile im Überblick:**

*VMs — Vorteile:* Starke Isolation auf Hardware-Ebene (jede VM hat eigenen Kernel; Kompromittierung einer VM betrifft andere nicht); vollständige Kompatibilität mit beliebigen x86-Betriebssystemen (auch Windows); können unterschiedliche OS parallel betreiben; Live-Migration und Portabilität. *Nachteile:* Hoher Ressourcenbedarf (Gigabyte für Gast-OS); langsame Bereitstellung (Sekunden bis Minuten); Lizenzkosten pro OS; begrenzte Dichte pro Host.

*Container — Vorteile:* Sehr leicht (Megabyte statt Gigabyte); Start in Sekunden; hohe Dichte pro Host; hervorragende Portabilität und Reproduzierbarkeit (dasselbe Image läuft auf Notebook, CI und Produktion); ideal für Microservices, CI/CD und schnelle Skalierung. *Nachteile:* Schwächere Isolation, da geteilter Kernel – ein Kernel-Exploit kann alle Container gefährden (Single Point of Failure); grundsätzlich an den Kernel-Typ des Hosts gebunden (Linux-Container brauchen Linux-Kernel).

**Typische Einsatzszenarien:**
- **VMs:** Legacy-Software, Datenbanken, Windows-Workloads, sicherheitskritische oder Multi-Tenant-Umgebungen (verschiedene Kunden auf gemeinsamer Infrastruktur), Betrieb unterschiedlicher Betriebssysteme.
- **Container:** cloud-native Anwendungen, Microservices, DevOps/CI-CD-Pipelines, häufig skalierende oder kurzlebige Workloads, reproduzierbare Entwicklungs- und Testumgebungen.
- **Hybrid:** In der Praxis dominiert die Kombination – Container laufen oft *innerhalb* von VMs, um die schnelle DevOps-Erfahrung mit der starken Isolation der VM zu verbinden. Ergänzend gibt es Micro-VMs (z. B. Firecracker/Kata Containers), die die Lücke zwischen beiden schließen.

### 2. Container-Grundlagen: Wie Container funktionieren

Ein Linux-Container ist im Kern nichts anderes als ein normaler Prozess (oder Prozessbaum), der durch mehrere Kernel-Primitive so isoliert wird, dass er glaubt, allein auf dem System zu laufen. Die wichtigsten Bausteine:

- **Namespaces** (Isolation): Ein Namespace kapselt eine globale Systemressource so, dass die Prozesse darin eine eigene, isolierte Instanz sehen. Die wichtigsten Typen: **pid** (eigene Prozess-IDs), **net** (eigener Netzwerkstack), **mnt** (eigene Mount-Tabelle), **ipc** (Inter-Prozess-Kommunikation), **uts** (eigener Hostname), **user** (Remapping von User-/Group-IDs) und **cgroup** (isolierte Sicht auf die cgroup-Hierarchie).
- **cgroups (Control Groups)** (Ressourcenverwaltung): Begrenzen und protokollieren den Ressourcenverbrauch (CPU, Speicher, Disk-I/O, Netzwerkbandbreite) einer Prozessgruppe und verhindern, dass ein Container die anderen aushungert. cgroups v2 ist Voraussetzung für moderne Features wie Podman-Quadlet.
- **Weitere Sicherheitsmechanismen:** SELinux/AppArmor (Mandatory Access Control), seccomp (Einschränkung erlaubter Systemaufrufe) und Linux Capabilities (feingranulare Rechtevergabe statt Voll-root).

**Images und Layer:** Ein Container wird aus einem **Image** gestartet – einer schreibgeschützten Vorlage. Images bestehen aus **Layern**: Jede Anweisung in einem Dockerfile/Containerfile (RUN, COPY, ADD) erzeugt eine neue Schicht. Beim Start eines Containers werden die Layer über ein **Union-Dateisystem** (heute meist **OverlayFS**, Treiber `overlay2`) zu einer einheitlichen Sicht zusammengeführt: mehrere schreibgeschützte `lowerdir`-Layer plus ein beschreibbarer `upperdir`-Layer für den Container. Änderungen erfolgen per **Copy-on-Write** – erst beim ersten Schreiben wird eine Datei aus dem Image in die Schreibschicht kopiert. Vorteil: identische Layer werden nur einmal auf der Platte gespeichert und über viele Images/Container hinweg geteilt (Deduplizierung), was Speicher spart und Builds beschleunigt.

**Registries:** Images werden in **Registries** gespeichert und verteilt (z. B. Docker Hub, Quay.io, GitHub Container Registry, Red Hat Registry). Mit `pull`/`push` werden sie heruntergeladen bzw. hochgeladen.

**OCI-Standard:** Die **Open Container Initiative** (OCI) wurde am 22. Juni 2015 auf der DockerCon (zunächst als „Open Container Project") von Docker, CoreOS und weiteren Branchengrößen unter dem Dach der Linux Foundation gegründet, um offene Standards zu schaffen. Drei Spezifikationen: **runtime-spec** (wie ein Container aus einem „Filesystem-Bundle" gestartet wird), **image-spec** (Image-Format) und **distribution-spec** (Verteilungs-/Registry-Protokoll). Dank OCI ist ein mit Docker gebautes Image mit Podman, CRI-O oder Kubernetes lauffähig und umgekehrt. Die verbreitetsten Low-Level-Runtimes sind **runc** (Go, Referenzimplementierung) und **crun** (C, von Red Hat, schneller). Docker nutzt zusätzlich die High-Level-Runtime **containerd**.

### 3. Docker vs. Podman im Detail

**Architektur (Daemon vs. daemonless):**
- **Docker** nutzt eine klassische Client-Server-Architektur. Der Docker-CLI-Client sendet Befehle über eine REST-API/Socket an den **dockerd**-Daemon, der standardmäßig als root-Prozess läuft und den gesamten Lebenszyklus (Images bauen, aus Registries ziehen, Netzwerke, Container starten) verwaltet. Vorteil: zentrale Zustandsverwaltung, einfache Auto-Restart-Policies, Remote-Management über die API. Nachteil: **Single Point of Failure** – stürzt der Daemon ab oder muss er für ein Update neu starten, sind standardmäßig alle Container betroffen (die „live restore"-Funktion muss manuell aktiviert werden). Zudem ist der root-Daemon eine große Angriffsfläche, und er verbraucht dauerhaft Ressourcen (typisch 80–150 MB RAM je nach Last und Anzahl der Container).
- **Podman** ist **daemonless** und folgt dem fork/exec-Modell: Jeder `podman run`-Befehl startet den Container direkt als Kindprozess des aufrufenden Nutzers, ohne zentralen Hintergrunddienst. Ein Update von Podman betrifft laufende Container nicht. Fällt ein Container-Prozess aus, sind die anderen unberührt (bessere Fehlerisolation). Podman ruft die OCI-Runtime (crun/runc) direkt auf, was den API-Umweg spart, und verbraucht im Leerlauf praktisch keinen Basis-Speicher (kein Dauer-Daemon).

**Root/Rootless und Sicherheit:**
- **Podman ist rootless by default.** Container laufen mit den Rechten des aufrufenden Nutzers. Über **User Namespaces** und die Dateien `/etc/subuid` und `/etc/subgid` wird ein Bereich von Subordinate-IDs gemappt: root (UID 0) im Container entspricht dem unprivilegierten Nutzer auf dem Host. Bricht ein Angreifer aus dem Container aus, erlangt er keine echten root-Rechte auf dem Host. Rootless Podman ist kein setuid-Binary und erhält beim Start keine zusätzlichen Privilegien.
- **Docker** benötigt für den Standardbetrieb den root-Daemon; ein Container-Ausbruch kann daher zu vollem root-Zugriff auf den Host führen. Ein „Rootless Docker"-Modus existiert, wurde aber nachträglich ergänzt und erfordert eine aufwändigere Zusatzinstallation. Zudem gewährt Mitgliedschaft in der `docker`-Gruppe faktisch root-Rechte.
- Podman integriert sich standardmäßig gut mit SELinux und vergibt Containern weniger Kernel-Capabilities. Beide Tools können grundsätzlich sicher konfiguriert werden, aber Podmans Standardeinstellungen sind „sicher by default".

**Kompatibilität (CLI, Compose, Pods):**
- **CLI:** Podman wurde bewusst als Drop-in-Replacement für die Docker-CLI entworfen; volle Docker-CLI-Kompatibilität ist bei Red Hat erklärte Produktpriorität, und die praktische Kompatibilität liegt bei rund 95 %. Die meisten Befehle (`run`, `build`, `ps`, `pull`, `push`) sind identisch; oft genügt `alias docker=podman` oder das Paket `podman-docker`. Bestehende Dockerfiles funktionieren unverändert. Verbleibende Lücken betreffen v. a. Docker-spezifische Extensions und einige Legacy-Netzwerkkonfigurationen.
- **Compose:** Docker Compose (heute `docker compose`, v2) ist der ausgereifte Industriestandard für Multi-Container-Setups. Für Podman gibt es zwei Wege: das Community-Projekt **podman-compose** (übersetzt `docker-compose.yml` in Podman-Befehle, deckt aber nur eine Teilmenge ab) oder – seit Podman eine Docker-kompatible API bereitstellt – die Nutzung des **originalen Docker Compose gegen den Podman-Socket**. Bei komplexen Netzwerk-Setups ist podman-compose nicht immer 100 % kompatibel.
- **Pods:** Podman unterstützt nativ das aus Kubernetes bekannte **Pod**-Konzept: eine Gruppe von Containern, die sich Netzwerk-Namespace (localhost), IP und Port-Mapping teilen. Mit `podman generate kube`/`podman kube play` lassen sich Kubernetes-YAMLs erzeugen bzw. lokal ausführen – ein direkter Brückenschlag zu Kubernetes/OpenShift. Docker kennt dieses Pod-Konzept nicht nativ (Docker Compose verbindet Container stattdessen über ein Bridge-Netzwerk mit DNS-Auflösung).

**systemd-Integration:**
- Da Podman-Container einfache Kindprozesse sind, integrieren sie sich natürlich in systemd. Früher wurde `podman generate systemd` genutzt, um Unit-Dateien aus laufenden Containern zu erzeugen; dieser Befehl ist inzwischen **deprecated**. Der empfohlene, moderne Weg ist **Quadlet** (seit Podman 4.4 integriert): deklarative `.container`, `.pod`, `.volume`, `.network`-Dateien, die ein systemd-Generator beim Boot automatisch in Service-Units umwandelt. Damit erhält man Restart-Policies, Logging (journalctl), Abhängigkeitsmanagement und Features wie `AutoUpdate=registry` ohne externe Tools wie Watchtower.
- Docker integriert sich ebenfalls mit systemd, aber wegen des daemon-zentrierten Designs indirekter: Der Daemon muss laufen, damit Container-Operationen funktionieren.

**Ökosystem, Verbreitung, Enterprise-Support:**
- **Docker** hat das reifere und größere Ökosystem: Docker Hub mit Millionen Images, Docker Compose, Docker Swarm, Docker Desktop und unzählige Tutorials/Integrationen. Docker ist nach wie vor die meistgenutzte Container-Plattform und „lingua franca" der Container.
- **Podman** stammt von **Red Hat** und ist der Standard-Container-Engine in RHEL, CentOS Stream und Fedora – mit entsprechendem Enterprise-Support. Es folgt der Unix-Philosophie und delegiert an spezialisierte Werkzeuge: **Buildah** (Image-Bau; `podman build` nutzt Buildah-Code), **Skopeo** (Images inspizieren/kopieren/signieren) und **crun** (Runtime). Podman richtet sich eng an Kubernetes/OpenShift aus (Kubernetes hat den „Dockershim" abgekündigt; Podman lehnt sich an CRI-O an).
- **Plattformen:** Docker Desktop ist unter Windows/macOS sehr ausgereift; Podman läuft auf diesen Systemen über `podman machine` (lightweight VM) und Podman Desktop, das aber in puncto Reife/Politur noch hinter Docker Desktop liegt.

**Performance:** Auf Linux ist die Laufzeit-Performance beider Engines weitgehend ähnlich, da beide auf denselben Kernel-Primitiven (namespaces, cgroups) und OCI-Runtimes (runc/crun) aufsetzen. Eine peer-reviewte Studie von Đorđević et al. („Performance comparison of Docker and Podman container-based virtualization", IEEE/IEEE Xplore, INFOTEH-JAHORINA 2022) mit dateisystem-intensiven Filebench-Workloads (CentOS 7) kam zu dem Schluss, dass „der Performance-Unterschied zwischen Docker und Podman im Wesentlichen nicht existent" ist und der Overhead „einen vernachlässigbaren Einfluss auf die Performance" hat. In der Tendenz zeigen Benchmarks für Podman leichte Vorteile bei Kaltstart-Latenz und Speicherverbrauch im Leerlauf (kein dauerhaft laufender Daemon), teils dank der schlankeren crun-Runtime; Docker kann bei anhaltendem Durchsatz durch Daemon-seitiges Caching leicht vorne liegen. In der Praxis sind Architektur und Sicherheit wichtigere Entscheidungskriterien als reine Performance.

**Lizenzierung/Kosten:** Die **Docker Engine** und CLI sind Open Source (Apache 2.0). **Docker Desktop** ist jedoch für größere Unternehmen kostenpflichtig – angekündigt von Docker-CEO Scott Johnston am 31. August 2021 mit Übergangsfrist bis 31. Januar 2022. Die Gratisnutzung (Personal-Plan) gilt nur für Firmen mit weniger als 250 Mitarbeitern *und* unter 10 Mio. USD Jahresumsatz; Behörden benötigen generell eine kostenpflichtige Subscription. Die kostenpflichtigen Pläne kosten (Stand 2026) ca. 9 USD (Pro), 15 USD (Team) bzw. 24 USD (Business) pro Nutzer/Monat bei jährlicher Abrechnung. **Podman Desktop** ist vollständig kostenlos ohne Lizenzbeschränkungen (Apache 2.0) – für viele Unternehmen ein Hauptgrund zum Wechsel.

**Wann welches Tool?**
- **Docker sinnvoll, wenn:** Sie einsteigen und lernen; auf macOS/Windows komfortabel entwickeln; ein reifes Ökosystem/Docker-Compose-Workflows und maximale Werkzeug-Kompatibilität brauchen; bereits stark in Docker investiert sind.
- **Podman sinnvoll, wenn:** Sicherheit Priorität hat (rootless, kein root-Daemon, Multi-User-/CI-Server); Sie RHEL/Fedora/CentOS einsetzen; systemd-Integration (Container als Dienste) oder Kubernetes-Nähe (Pods, YAML) wichtig sind; Sie Docker-Desktop-Lizenzkosten vermeiden wollen.
- **Pragmatisch:** Viele reife Teams nutzen beides – Docker auf Entwickler-Notebooks, Podman in CI und Produktion. Da die Images OCI-kompatibel sind, ist der Wechsel nahtlos.

### 4. Frei zugängliche PDF-Quellen (geprüft)

1. **Titel:** „Virtualisierung – Virtualisierungskonzepte – Vor- und Nachteile" (10. Foliensatz, Vorlesung Betriebssysteme, WS 2021/22)
   **Autor/Herausgeber:** Prof. Dr. Christian Baun, Frankfurt University of Applied Sciences
   **Link:** https://www.christianbaun.de/BTS2122/Skript/bts_WS2122_vorlesung_10_de.pdf
   **Inhalt:** Deutschsprachiger Vorlesungsfoliensatz (43 Folien), der Grundlagen und Konzepte der Virtualisierung systematisch erklärt – Partitionierung, Hardware-Emulation, Anwendungsvirtualisierung, vollständige Virtualisierung, Paravirtualisierung, Hardware-Virtualisierung, Betriebssystem-Virtualisierung/Container/Jails sowie Speicher- und Netzwerkvirtualisierung, jeweils mit Vor- und Nachteilen. Ideal als kompakter, akademischer Einstieg. *(Geprüft: erreichbar, Text extrahierbar.)*

2. **Titel:** „Dozentenhandbuch Virtualisierung" (Projekt „IT-Sicherheit im Handwerk", ISiK, 1. Auflage 2015)
   **Autor/Herausgeber:** Falk Gaentzsch und Prof. Norbert Pohlmann, Institut für Internet-Sicherheit – if(is), Westfälische Hochschule Gelsenkirchen; Herausgeber Handwerkskammer Rheinhessen, gefördert vom BMWi
   **Link:** https://norbert-pohlmann.com/app/uploads/2015/12/Virtualisierung-Prof-Norbert-Pohlmann.pdf
   **Inhalt:** Deutschsprachiges Handbuch, das Grundlagen der Virtualisierung (VMs, Hypervisor, Voll-/Paravirtualisierung, Betriebssystemvirtualisierung/Container, KVM, Emulation) sowie Vor-, Nachteile und IT-Sicherheitsaspekte praxisnah und verständlich vermittelt, mit Fokus auf kleine und mittlere Unternehmen. *(Geprüft: erreichbar, Text extrahierbar.)*

3. **Titel:** „OpenShift Container Platform 3.9 – Container Security Guide"
   **Autor/Herausgeber:** Red Hat, Inc. (2019, CC-BY-SA 3.0)
   **Link:** https://docs.redhat.com/en/documentation/openshift_container_platform/3.9/pdf/container_security_guide/openshift_container_platform-3.9-container_security_guide-en-us.pdf
   **Inhalt:** Englischsprachiger, tiefgehender Leitfaden zur Container-Sicherheit über alle Schichten des Stacks: Host/RHEL, Linux-Namespaces, SELinux, cgroups, seccomp, Registries, Build- und Deployment-Prozess, Netzwerk- und Storage-Sicherheit. Gute Referenz, um die Sicherheitsmechanismen hinter Containern zu verstehen. *(Geprüft: erreichbar, Text extrahierbar.)*

4. **Titel:** „A layered approach to container and Kubernetes security" (Whitepaper)
   **Autor/Herausgeber:** Red Hat
   **Link:** https://www.redhat.com/en/resources/layered-approach-container-kubernetes-security-whitepaper
   **Inhalt:** Englischsprachiges Whitepaper über einen mehrschichtigen „Defense-in-Depth"-Sicherheitsansatz für Container und Kubernetes/OpenShift – Host-OS-Isolation, Registry-/Image-Sicherheit, Build-Prozess, Netzwerk-Namespaces/Network Policies, Compliance. *(Hinweis: Die Original-Landingpage von Red Hat verlangt ggf. eine Registrierung zum Download; das inhaltlich identische PDF wird u. a. direkt unter https://www.fbcinc.com/source/virtualhall_images/NOAA_IT_Oct_21/Red_Hat/A_layered_approach.pdf gespiegelt – dort per Browser abrufbar, automatisierte Tools werden per robots.txt geblockt.)*

## Recommendations
- **Zum Lernen (Umschulung Fachinformatiker AE):** Starten Sie mit **Docker** – die einfachste Lernkurve, die meisten Tutorials, und alle Konzepte (Images, Layer, Registries, Dockerfile, Compose) sind übertragbar. Arbeiten Sie zunächst die Vorlesungsfolien von Prof. Baun (PDF 1) für die Theorie durch, dann praktische Docker-Übungen (Container starten, eigenes Image bauen, Volume/Port-Mapping).
- **Nächster Schritt:** Installieren Sie **Podman** parallel (unter Linux/Fedora ist es Standard) und testen Sie `alias docker=podman` mit Ihren vorhandenen Befehlen. So verstehen Sie rootless-Betrieb und das Pod-Konzept praktisch – wertvoll, weil beide Tools im Berufsleben vorkommen.
- **Für den Einsatz auf einem eigenen Linux-Server/Homelab:** Nutzen Sie **Podman + Quadlet** für dauerhaft laufende Dienste (Container als systemd-Services mit Auto-Restart und Auto-Update) – sicherer und „linux-nativer" als ein Docker-Daemon.
- **Sicherheit generell (gilt für beide):** Immer non-root-Container, minimale Basis-Images, Image-Scanning, signierte Images und ein Patch-Prozess. Für nicht vertrauenswürdige oder Multi-Tenant-Workloads zusätzliche Isolation (VM, gVisor, Kata Containers) ergänzen.
- **Entscheidungs-Benchmark:** Wechseln Sie zu Podman, sobald (a) Docker-Desktop-Lizenzkosten anfallen (Firma > 250 Mitarbeiter oder > 10 Mio. USD Umsatz), (b) Sie auf RHEL/Fedora produktiv gehen, oder (c) Compliance-/Sicherheitsvorgaben rootless-Betrieb verlangen. Bleiben Sie bei Docker, solange komplexe Compose-Workflows oder Docker-spezifische Drittanbieter-Tools zentral sind.

## Caveats
- **Marktzahlen und „bis zu X % schneller"-Angaben aus Blogs sind mit Vorsicht zu genießen:** Viele Podman-vs-Docker-Vergleiche stammen von Hosting-/Tool-Anbietern und sind nicht peer-reviewt; Benchmark-Ergebnisse hängen stark von Hardware, Workload und Konfiguration ab. Die belastbare, peer-reviewte Aussage (Đorđević et al., 2022) lautet: der Performance-Unterschied ist in der Regel vernachlässigbar. Eine exakte Einzelprozentzahl aus dieser Studie ist frei nicht verifizierbar (Volltext hinter IEEE-Paywall).
- **Schnelllebiges Feld:** Docker-Preise/Editionen, Podman-Versionen (aktuell 5.x) und Standardeinstellungen (z. B. Netzwerk-Backend pasta statt slirp4netns, containerd-Image-Store in Docker 29+) ändern sich häufig. Prüfen Sie vor Entscheidungen die aktuellen offiziellen Quellen.
- **Windows-Container** sind ein Sonderfall (eigene Isolationsmechanismen über den Windows Host Compute Service statt Linux-Namespaces) und hier nicht behandelt.
- Das Red-Hat-OpenShift-Dokument (PDF 3) bezieht sich auf Version 3.9; die grundlegenden Sicherheitskonzepte gelten weiterhin, neuere OpenShift-Versionen haben aber zusätzliche Features.