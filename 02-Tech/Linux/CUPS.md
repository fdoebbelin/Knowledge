---
title: CUPS
aliases:
  - Drucksystem
tags:
  - linux
  - cups
  - drucker
created: 2026-09-22
updated: 2026-09-22
status: draft
---

# CUPS

Drucksystem unter Linux und macOS. Verwaltet Warteschlangen, spricht Drucker über Backends an und bringt eine Weboberfläche unter <http://localhost:631> mit.

> [!note] Stichwortnotiz
> Einstieg in das Thema. Die Einrichtung zweier Netzwerkdrucker ist in [[2026-09-22 Netzwerkdrucker Fedora Sway Atomic]] Schritt für Schritt protokolliert.

## IPP Everywhere statt Herstellertreiber

Moderne Netzwerkdrucker melden ihre Fähigkeiten selbst über IPP. CUPS richtet sie damit treiberlos ein:

```bash
lpadmin -p <QUEUE> -E -v ipp://<IP>/ipp/print -m everywhere -D "<Klartext>" -L "<Standort>"
```

Auf image-basierten Systemen ist das der bevorzugte Weg, weil Herstellertreiber mit eigenen Filtern einen `rpm-ostree`-Layer erfordern würden, siehe [[Fedora Sway Atomic]]. Warteschlangennamen ohne Leerzeichen wählen, Klartext gehört in `-D`, der Standort in `-L`.

## Wichtige Befehle

```bash
ippfind                                     # IPP-Drucker per mDNS finden
avahi-browse -rt _ipp._tcp                  # gefundene Drucker mit IP
lpinfo -v                                   # Backends und erkannte Geräte
lpstat -v                                   # eingerichtete Warteschlangen
lpoptions -p <QUEUE> -l                     # verfügbare Druckoptionen
ipptool -tv ipp://<IP>/ipp/print get-printer-attributes.test   # Modell, Fähigkeiten
```

Findet die Erkennung per mDNS nichts, hilft ein Portscan auf 631 (IPP) und 9100 (RAW) im Subnetz – `nmap` dafür in einer [[Toolbx]] statt im Basisimage.

## Verwandt

- [[2026-09-22 Netzwerkdrucker Fedora Sway Atomic]] – Protokoll der Einrichtung
- [[Fedora Sway Atomic]]
