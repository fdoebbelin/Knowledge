---
title: "Arbeitsblatt: Container-Registries – ghcr.io im Vergleich zu quay.io"
date: 2026-07-21
tags:
  - arbeitsblatt
  - fachinformatiker
  - container
  - registry
  - ghcr
  - quay
  - devops
lernfeld: "Container & Bereitstellung"
niveau: "Grundlagen / Vertiefung"
dauer: "45–90 min"
aliases:
  - "Registry-Vergleich GHCR Quay"
status: active
---

# Arbeitsblatt: Container-Registries – `ghcr.io` vs. `quay.io`

> [!info] Lernziele
> Nach diesem Arbeitsblatt kannst du …
> - erklären, was eine OCI-Container-Registry ist und wozu sie dient,
> - die beiden Registries **GHCR** und **Quay.io** in Betreiber, Funktionsumfang und Auth-Modell unterscheiden,
> - Images an beiden Registries an- und abmelden sowie hoch- und herunterladen,
> - begründet entscheiden, welche Registry sich für ein konkretes Szenario eignet.

---

## 1. Fachlicher Einstieg

Eine **Container-Registry** ist ein Dienst, der Container-Images speichert und verteilt – vergleichbar mit einem Paket-Repository, nur für ganze Betriebssystem-Abbilder statt einzelner Programme. Ein Image wird mit `podman push` (oder `docker push`) hochgeladen und mit `podman pull` heruntergeladen.

Wichtig für das ganze Arbeitsblatt: Beide hier behandelten Registries sind **OCI-konform** (Open Container Initiative). Das heißt, aus Sicht der Werkzeuge (`podman`, `docker`, `bootc`) verhalten sie sich identisch – derselbe `pull`-Befehl funktioniert gegen `ghcr.io` wie gegen `quay.io`. Die Unterschiede liegen nicht im Protokoll, sondern in **Betreiber, Zusatzfunktionen, Authentifizierung und Preismodell**.

> [!abstract] Zwei Kurzsteckbriefe
> **GHCR (`ghcr.io`)** – die *GitHub Container Registry*, Teil von GitHub Packages, betrieben von GitHub (Microsoft). Stärke: nahtlose Integration in GitHub-Repos und GitHub Actions.
>
> **Quay.io (`quay.io`)** – die Registry von *Red Hat* (IBM). Stärke: integriertes Schwachstellen-Scanning und Nähe zur Red-Hat-/OpenShift-Welt; die zugrunde liegende Software ist als *Project Quay* auch selbst betreibbar.

---

## 2. Gegenüberstellung

| Merkmal | **GHCR — `ghcr.io`** | **Quay.io — `quay.io`** |
|---|---|---|
| Betreiber | GitHub (Microsoft) | Red Hat (IBM) |
| Teil von | GitHub Packages | eigenständig; Software auch self-hostbar (Project Quay / Red Hat Quay) |
| Öffentliche Images | kostenlos, unbegrenzte Pulls | kostenlos |
| Private Images | gegen Speicher-/Transfer-Kontingent des GitHub-Plans | kostenpflichtig (Plan-basiert) |
| Authentifizierung | GitHub-PAT (Scopes `read:packages` / `write:packages`, ggf. `repo`) **oder** automatischer `GITHUB_TOKEN` in Actions | Benutzer-Login, **Robot Accounts** (maschinelle Zugänge mit eigenem Token), OAuth |
| Maschineller Zugang | `GITHUB_TOKEN` (an Person/Repo gebunden) bzw. Service-Account-PAT | Robot Account (nicht an eine Person gebunden) |
| Integriertes Schwachstellen-Scanning | **nein** – über CI-Tools (z. B. Trivy) nachrüsten | **ja** – **Clair** ist eingebaut und automatisch aktiv; jedes gepushte Image wird gegen eine CVE-Datenbank geprüft |
| Signierung / Authentizität | extern via **cosign/sigstore** (nicht registry-nativ) | extern via cosign; zusätzlich Audit-Log, Tag-History |
| CI/CD-Integration | sehr eng mit GitHub Actions | Build-Trigger, Git-Hooks, Robot Accounts |
| Weitere Stärken | ein Ort für Code + Image; Sichtbarkeit erbt vom Repo oder frei setzbar | Geo-Replikation, Audit-Log, Red-Hat-/OpenShift-Integration |
| Typisches Einsatzfeld | GitHub-zentrierte Projekte, Open Source | Red-Hat-Umgebungen, hohe Sicherheits-/Compliance-Anforderungen |

> [!tip] Merksatz
> **GHCR** bringt das Image zum Code (GitHub-nativ). **Quay** bringt Sicherheit & Betrieb zum Image (Scanning, self-host, OpenShift). Weil beide OCI-konform sind, kannst du sie im selben Workflow mischen.

---

## 3. Praxisbezug: beide Registries in *einem* Workflow

Beim Bau eines eigenen bootc-Images begegnen dir **beide** Registries gleichzeitig – ein gutes Beispiel dafür, dass die Wahl keine Entweder-oder-Entscheidung sein muss:

- Das **Basisimage** wird von `quay.io` bezogen, z. B. `quay.io/fedora-ostree-desktops/sway-atomic:44`.
- Das **selbstgebaute Image** wird nach `ghcr.io` gepusht, z. B. `ghcr.io/DEIN-NAME/coaching-brew:latest`.

Das funktioniert reibungslos, weil beide OCI-Registries sind: `podman pull` zieht von Quay, `podman build`/`podman push` schiebt nach GHCR, und `bootc switch` aktiviert das Ergebnis – identische Befehle, egal welche Registry dahintersteht.

```nu
# Abmelden/Anmelden und Push an GHCR
echo $env.GH_TOKEN | podman login ghcr.io -u DEIN-NAME --password-stdin
podman push ghcr.io/DEIN-NAME/coaching-brew:latest

# Basisimage von Quay ziehen (öffentlich, kein Login nötig)
podman pull quay.io/fedora-ostree-desktops/sway-atomic:44
```

> [!note] Sicherheits-Lücke bewusst schließen
> Weil **GHCR kein Clair** mitbringt, übernimmt das Basisimage von Quay dort das Scanning nicht mehr. Für das eigene GHCR-Image ergänzt man deshalb typischerweise **Trivy** im CI-Build (Scan) und **cosign** (Signatur), um Schwachstellen-Prüfung und Authentizität selbst herzustellen.

---

## 4. Aufgaben

### Teil A — Verständnis

1. Erkläre in einem Satz, was eine Container-Registry ist.
2. Was bedeutet „OCI-konform", und welche praktische Folge hat das für den Wechsel zwischen `ghcr.io` und `quay.io`?
3. Nenne je **eine** typische Stärke von GHCR und von Quay.io.

### Teil B — Zuordnung

Ordne jedes Merkmal der passenden Registry zu (GHCR, Quay.io – manche können auf beide zutreffen):

| Merkmal | GHCR | Quay.io |
|---|:---:|:---:|
| Integriertes Clair-Scanning | ☐ | ☐ |
| Robot Accounts als maschineller Zugang | ☐ | ☐ |
| Automatischer `GITHUB_TOKEN` in der CI | ☐ | ☐ |
| Software auch selbst betreibbar (self-host) | ☐ | ☐ |
| Geo-Replikation | ☐ | ☐ |
| OCI-konform | ☐ | ☐ |

### Teil C — Praxis

4. Schreibe den vollständigen Befehl, um dich mit einem Token (`$GH_TOKEN`) und Benutzer `azubi01` bei `ghcr.io` anzumelden.
5. Schreibe den `podman push`-Befehl für das Image `mein-tool:1.0` in das GHCR-Konto `azubi01`.
6. Ein öffentliches Basisimage `quay.io/fedora/fedora-bootc:44` soll heruntergeladen werden. Wie lautet der Befehl – und warum ist hier kein `login` nötig?

### Teil D — Transfer & Diskussion

7. Warum wird ein selbstgebautes bootc-Image häufig nach **GHCR** gepusht, obwohl sein Basisimage von **Quay** stammt? Nenne zwei Gründe.
8. GHCR bietet **kein** eingebautes Schwachstellen-Scanning. Mit welchen zwei Bausteinen stellst du für ein GHCR-Image dennoch (a) Schwachstellen-Prüfung und (b) Authentizität her?
9. Entscheide begründet: In welchem der folgenden Szenarien würdest du **Quay.io** statt GHCR wählen?
   a) Ein Open-Source-Nebenprojekt, das ohnehin auf GitHub liegt.
   b) Eine Firma mit OpenShift-Cluster und strengen Compliance-Vorgaben, die Scanning-Berichte für jedes Image braucht.
   c) Eine abgeschottete Umgebung, in der die Registry selbst betrieben werden muss.

---

## 5. Lösungshinweise (für Dozenten)

> [!success]- Lösungen aufklappen
> **Teil A**
> 1. Ein Dienst, der Container-Images speichert und zum Herunterladen bereitstellt.
> 2. OCI-konform = standardisiertes Format/Protokoll; Folge: dieselben Werkzeuge und Befehle funktionieren gegen beide Registries, ein Wechsel erfordert keine neuen Tools.
> 3. GHCR: enge GitHub-Actions-/Repo-Integration. Quay.io: integriertes Clair-Scanning bzw. self-hostbar.
>
> **Teil B**
> Clair-Scanning → Quay · Robot Accounts → Quay · `GITHUB_TOKEN` → GHCR · self-host → Quay · Geo-Replikation → Quay · OCI-konform → **beide**.
>
> **Teil C**
> 4. `echo $GH_TOKEN | podman login ghcr.io -u azubi01 --password-stdin`
> 5. `podman push ghcr.io/azubi01/mein-tool:1.0`
> 6. `podman pull quay.io/fedora/fedora-bootc:44` – kein Login, weil das Image **öffentlich** ist; anonyme Pulls sind erlaubt.
>
> **Teil D**
> 7. Z. B.: (a) automatischer `GITHUB_TOKEN` und nahtlose Actions-Integration, (b) kostenloser, unbegrenzter Pull für öffentliche Images und Code+Image an einem Ort. Möglich, weil beide OCI-konform sind.
> 8. (a) **Trivy** (oder anderer Scanner) im CI-Build; (b) **cosign**-Signatur plus passende Signaturprüfungs-Policy beim Pull/Switch.
> 9. **b) und c)**: Compliance/Scanning-Berichte → Clair spielt seine Stärke aus; abgeschottet/self-host → Project Quay lässt sich selbst betreiben. Szenario **a)** spricht klar für GHCR.

---

## Verwandte Notizen

- [[Leitfaden bootc-Image mit Homebrew]]
- [[OCI und Container-Grundlagen]]
- [[cosign Signierung]]
- [[Trivy Schwachstellen-Scanning]]
