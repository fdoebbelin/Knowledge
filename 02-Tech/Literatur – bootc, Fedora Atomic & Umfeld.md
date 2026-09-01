---
title: "Literatur – bootc, Fedora Atomic & Umfeld"
tags: [literatur, linux, fedora, atomic, bootc, podman, ostree, nushell, helix, sway, noctalia, kursmaterial]
erstellt: 2026-07-08
typ: literaturliste
verwandt: "[[Fedora Sway Atomic – Noctalia, Nushell & Helix ins bootc-Image backen]]"
---
> [!abstract] Einordnung
> Zu **bootc** und **Noctalia** gibt es noch keine gedruckten Fachbücher – die Themen sind zu jung. Das beste „buchartige" Material sind offizielle Dokus (teils als PDF exportierbar) plus wenige Verlagstitel zu den Grundlagen darunter. Sortiert nach Nähe zum Thema.
>
> **Echtes kommerzielles E-Book/PDF** ist nur *Podman in Action*. Der Rest ist Doku (mehrheitlich frei).

---

## 1 · Direkt zum Kern – Image Mode / bootc / Atomic

> [!quote] Red Hat: „Using image mode for RHEL to build, deploy, and manage operating systems"
> Offizielle Doku (RHEL 9 & 10). Inhaltlich das Umfassendste zu genau diesem Workflow: Images mit Podman/Containerfiles bauen und testen, in eine Registry pushen und teilen, deployen und Day-2-Management. Deckt transaktionale In-Place-Updates mit Rollback, das Stagen neuer Registry-Stände sowie manuelle/automatische Rollbacks ab.
> - **Läuft unter RHEL, Konzepte gelten 1:1 für Fedora bootc.**
> - Pro Kapitel als **PDF** herunterladbar auf `docs.redhat.com`.

- **Red Hat Blog – „Image mode for RHEL: A quick start guide"**
  Kompakter Einstieg über ein LAMP-Beispiel, ganzer Bogen build → push → deploy. Gut als 20-Minuten-Überblick vor der langen Doku.
  → `redhat.com/en/blog/image-mode-red-hat-enterprise-linux-quick-start-guide`

- **bootc – offizielle Projekt-Doku**
  Referenz für `bootc switch` / `upgrade` / `rollback`, Update-Modell und abgeleitete Images.
  → `bootc-dev.github.io/bootc`

- **Fedora bootc-Doku**
  Der Fedora-spezifische Gegenpart zur RHEL-Doku – relevanter, weil deine Basis Fedora ist.
  → `docs.fedoraproject.org` (Bereich *bootc*)

---

## 2 · Das Container-Fundament darunter

> [!tip] „Podman in Action" – Daniel Walsh (Manning, 2023)
> Beim Kauf des gedruckten Buchs ist ein **kostenloses E-Book in PDF, Kindle und ePub** von Manning enthalten. Geschrieben vom Leiter des Red-Hat-Podman-Teams – also vom Erfinder.
> - **Besonders relevant:** Kapitel zu systemd-Integration und automatischem Container-Update – bootc überträgt genau dieses Modell auf das gesamte OS.
> - ISBN 9781633439689
> - Inhalt u. a.: rootless Container, Pods, Podman-Security (SELinux/SECCOMP), systemd-Lifecycle, Kubernetes-Integration.

---

## 3 · Die Schicht OSTree / rpm-ostree

- **rpm-ostree-Doku** → `coreos.github.io/rpm-ostree`
- **OSTree-Doku** → (libostree Projektseite)

Erklären das hybride Image/Paket-Modell und warum Layering auf Atomic teuer ist – der theoretische Unterbau zu **Phase 1** (rpm-ostree-Schnelltest) im Workflow.

---

## 4 · Frameworks für die Fleet-Automatisierung

- **Universal Blue / BlueBuild** → `blue-build.org`
  YAML-basiertes Framework über bootc mit fertigem GitHub-Template. Interessant, wenn die Fleet-Builds deklarativer statt per handgeschriebenem Containerfile laufen sollen.

- **Fedora Magazine – „Building your own Atomic (bootc) Desktop"**
  Praxisartikel mit komplettem Beispiel-Repo (KDE-Variante), im Browser als PDF druckbar. Nah an dem, was hier gebaut wird.
  → `fedoramagazine.org/building-your-own-atomic-bootc-desktop`

---

## 5 · Die Werkzeuge im Image

| Werkzeug | Quelle | Format |
|---|---|---|
| **Nushell** | `nushell.sh/book` | kostenloses E-Book, browserbasiert, als PDF druckbar |
| **Helix** | `docs.helix-editor.com` | Online-Doku |
| **Noctalia** | `docs.noctalia.dev/v5` | Online-Doku |
| **Sway / Wayland** | `sway(5)`-Manpages + Sway-Wiki | kein empfehlenswertes Buch |

> [!info] Nushell-Buch
> Die maßgebliche Referenz für die Nushell-Skripte im Build (`build.nu`) – deckt Datentypen, Pipelines und Skripting sauber ab.

---

## Fallstricke bei der Quellenwahl

> [!warning] Achtung
> - **RHEL- vs. Fedora-Spezifika:** Registry-Pfade (`registry.redhat.io/...`) und Subscription-Themen aus der RHEL-Doku gelten **nicht** für Fedora – dort `quay.io/fedora/...` bzw. `quay.io/fedora-ostree-desktops/...`.
> - **Sway:** Kein gutes gedrucktes Buch; Manpages/Wiki bleiben die beste Quelle.
> - **Aktualität:** bootc und Noctalia entwickeln sich schnell – bei Kommandos/Optionen immer gegen die Online-Doku gegenprüfen, bevor die Fleet umgestellt wird.

---

## Verwandte Notizen

- [[Fedora Sway Atomic – Noctalia, Nushell & Helix ins bootc-Image backen]]
- [[Fedora Atomic – rpm-ostree vs. bootc]]
- [[bootc – Fleet-Verteilung & Signierung]]
- [[Nushell – Daily Driver Setup]]
