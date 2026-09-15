> Bearbeitung erfolgt in **Obsidian**, das Deployment auf den entfernten Grav-Host wird vollständig über **Nushell-Funktionen** automatisiert. Eine einzige Konfigurationsdatei (`grav.nuon`) steuert Domain, Pfade und Repo-Daten.

---

## 0. Architektur auf einen Blick

```
┌──────────────────┐    git push      ┌────────────────────────┐
│  Obsidian-Vault  │ ───────────────► │  Bare-Repo (Remote)    │
│  (lokales git-   │ ◄─────────────── │  ~/repos/<alias>.git   │
│   Working-Tree)  │    git pull      │                        │
└──────────────────┘                  │  post-receive Hook     │
                                      │   ├─ checkout -f       │
                                      │   └─ grav clear-cache  │
                                      └──────────┬─────────────┘
                                                 │
                                                 ▼
                                      ┌────────────────────────┐
                                      │  Grav: user/pages/     │
                                      │  (Working-Tree)        │
                                      └────────────────────────┘
```

**Workflow:** In Obsidian schreiben → `grav push` → Hook deployt und leert
den Cache → Grav rendert die neuen Inhalte. Kein manuelles `rsync`, kein
manuelles Cache-Leeren.

---

## 1. Konvention: Domain ohne TLD = SSH-Alias

Für jede Grav-Installation wird eine Konfigurationsdatei `grav.nuon` angelegt.
Die **Domain ohne TLD** dient als:

- SSH-Alias (`Host agrail`)
- Repo-Name (`agrail-pages.git`)
- Vault-Ordnername (`agrail-pages`)

Beispiel: Domain `agrail.de` → Alias `agrail`.

---

## 2. Nushell-Modul `grav.nu`

Lege das Modul unter `~/.config/nushell/scripts/grav.nu` ab und lade es per
`use grav.nu *` in deiner `config.nu` (oder bei Bedarf manuell).

```nushell
# ~/.config/nushell/scripts/grav.nu
#
# Helfer für Grav-Deployments mit Obsidian-Vault und Bare-Repo.
# Eine Konfigurationsdatei pro Site, Format: nuon.

const DEFAULT_CONFIG = "grav.nuon"

# ─── Konfiguration ────────────────────────────────────────────────────────

# Erstellt eine neue Konfigurationsdatei. Domain wird in Alias (ohne TLD)
# und vollen Hostnamen aufgeteilt.
export def "grav config init" [
    domain: string                              # z. B. agrail.de
    --remote-user: string                       # SSH-User, z. B. ssh-w017ef42
    --remote-hostname: string                   # Realer Hostname, z. B. w017ef42.kasserver.com
    --remote-grav-root: string                  # Absoluter Pfad zur Grav-Installation
    --vault-base: path = "~/Documents/Obsidian" # Elternordner für lokalen Vault
    --git-host: string = "github.com"           # Git-Host für Spiegel-Repo (optional)
    --identity-file: path = "~/.ssh/id_ed25519" # SSH-Key
    --out: path = $DEFAULT_CONFIG
] {
    let alias = ($domain | split row "." | first)
    let conf = {
        domain:           $domain
        alias:            $alias
        remote_user:      $remote_user
        remote_hostname:  $remote_hostname
        remote_grav_root: $remote_grav_root
        identity_file:    ($identity_file | path expand)
        local_vault:      ($vault_base | path expand | path join $"($alias)-pages")
        bare_repo_remote: $"~/repos/($alias)-pages.git"
        git_host:         $git_host
    }
    $conf | save -f $out
    print $"Konfiguration geschrieben: ($out)"
    print $conf
}

# Lädt die Konfiguration (aus aktuellem Verzeichnis oder explizit angegeben).
export def "grav config load" [
    path: path = $DEFAULT_CONFIG
] {
    if not ($path | path exists) {
        error make {msg: $"Konfiguration nicht gefunden: ($path). Lege sie mit `grav config init` an."}
    }
    open $path
}

# ─── SSH ──────────────────────────────────────────────────────────────────

# Trägt einen Host-Eintrag in ~/.ssh/config ein, falls noch nicht vorhanden.
export def "grav ssh install" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    let ssh_config = ("~/.ssh/config" | path expand)

    # Sicherstellen, dass die Datei existiert
    if not ($ssh_config | path exists) {
        touch $ssh_config
        chmod 600 $ssh_config
    }

    let existing = (open $ssh_config)
    let marker = $"Host ($c.alias)"
    if ($existing | str contains $marker) {
        print $"SSH-Eintrag für '($c.alias)' existiert bereits – übersprungen."
        return
    }

    let entry = $"

# ($c.domain) – via grav.nu
Host ($c.alias)
    HostName ($c.remote_hostname)
    User ($c.remote_user)
    IdentityFile ($c.identity_file)
    IdentitiesOnly yes
"
    $entry | save -a $ssh_config
    print $"SSH-Eintrag '($c.alias)' eingetragen → ($ssh_config)."
}

# Schneller Verbindungstest.
export def "grav ssh test" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    ^ssh $c.alias "echo OK von $(hostname); pwd"
}

# ─── Remote-Setup ─────────────────────────────────────────────────────────

# Legt das Bare-Repo und den post-receive-Hook auf dem Server an.
export def "grav remote init" [
    --config (-c): path = $DEFAULT_CONFIG
    --branch: string = "main"
] {
    let c = (grav config load $config)
    let hook = $"#!/bin/bash
set -e
WORK_TREE=\"($c.remote_grav_root)/user/pages\"
GIT_DIR=\"($c.bare_repo_remote)\"
GRAV_ROOT=\"($c.remote_grav_root)\"

while read oldrev newrev ref; do
    if [ \"$ref\" = \"refs/heads/($branch)\" ]; then
        mkdir -p \"$WORK_TREE\"
        git --work-tree=\"$WORK_TREE\" --git-dir=\"$GIT_DIR\" checkout -f ($branch)
        \"$GRAV_ROOT/bin/grav\" clear-cache >/dev/null
        echo \"[deploy] ($c.domain) auf ($branch) aktualisiert.\"
    fi
done
"
    # Hook lokal puffern, dann via ssh installieren
    let tmp = (mktemp)
    $hook | save -f $tmp

    let setup = $"
set -e
mkdir -p ($c.bare_repo_remote)
if [ ! -f ($c.bare_repo_remote)/HEAD ]; then
    git init --bare -b ($branch) ($c.bare_repo_remote)
fi
"
    $setup | ^ssh $c.alias bash
    ^scp $tmp $"($c.alias):($c.bare_repo_remote)/hooks/post-receive"
    ^ssh $c.alias $"chmod +x ($c.bare_repo_remote)/hooks/post-receive"
    rm $tmp
    print $"Bare-Repo + Hook eingerichtet auf ($c.alias):($c.bare_repo_remote)."
}

# Initialer Import bestehender Inhalte aus user/pages in das Bare-Repo.
# Nur einmal nach `grav remote init` ausführen.
export def "grav remote import" [
    --config (-c): path = $DEFAULT_CONFIG
    --branch: string = "main"
] {
    let c = (grav config load $config)
    let script = $"
set -e
cd ($c.remote_grav_root)/user/pages
if [ -d .git ]; then
    echo 'user/pages ist bereits ein Git-Working-Tree.'
    exit 0
fi
git init -b ($branch)
git config user.email 'grav@($c.domain)'
git config user.name 'grav'
git add .
git commit -m 'Initial import von user/pages' --allow-empty
git remote add origin ($c.bare_repo_remote)
git push -u origin ($branch)
echo 'Import abgeschlossen.'
"
    $script | ^ssh $c.alias bash
}

# ─── Lokaler Vault ────────────────────────────────────────────────────────

# Klont das Bare-Repo in den lokalen Vault. Anschließend in Obsidian öffnen.
export def "grav vault init" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    let parent = ($c.local_vault | path dirname)
    if not ($parent | path exists) { mkdir $parent }

    if ($c.local_vault | path exists) {
        print $"Vault existiert bereits: ($c.local_vault)"
        return
    }

    ^git clone $"($c.alias):($c.bare_repo_remote)" $c.local_vault
    print $"Vault eingerichtet: ($c.local_vault)"
    print "Öffne diesen Ordner jetzt in Obsidian (File → Open Vault)."
}

# ─── Tagesgeschäft ────────────────────────────────────────────────────────

# Commit + Push des Vaults; löst auf dem Server automatisch das Deployment aus.
export def "grav push" [
    --config (-c): path = $DEFAULT_CONFIG
    --message (-m): string = "Update via Obsidian"
] {
    let c = (grav config load $config)
    cd $c.local_vault
    ^git add -A
    let dirty = (^git status --porcelain | str trim)
    if ($dirty | is-empty) {
        print "Keine lokalen Änderungen – pushe trotzdem (für ausstehende Commits)."
    } else {
        ^git commit -m $message
    }
    ^git push origin HEAD
}

# Pull, falls der Server (oder ein zweites Gerät) Änderungen hat.
export def "grav pull" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    cd $c.local_vault
    ^git pull --rebase
}

# Status des lokalen Vaults.
export def "grav status" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    cd $c.local_vault
    ^git status -sb
}

# ─── Wartung ──────────────────────────────────────────────────────────────

# Cache auf dem Server manuell leeren.
export def "grav cache clear" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    ^ssh $c.alias $"($c.remote_grav_root)/bin/grav clear-cache"
}

# Templates aus einem lokalen Verzeichnis ins Theme synchronisieren.
export def "grav templates push" [
    local_dir: path                # z. B. ./theme-templates
    --theme (-t): string           # Theme-Name auf dem Server
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    let target = $"($c.alias):($c.remote_grav_root)/user/themes/($theme)/templates/"
    ^rsync -avz --delete-after $"($local_dir | path expand)/" $target
    grav cache clear --config $config
}

# Interaktiv neuen Login-Benutzer auf dem Server anlegen.
export def "grav user new" [
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    ^ssh -t $c.alias $"cd ($c.remote_grav_root) && bin/plugin login newuser"
}

# Plugin auf dem Server installieren.
export def "grav plugin install" [
    name: string
    --config (-c): path = $DEFAULT_CONFIG
] {
    let c = (grav config load $config)
    ^ssh $c.alias $"cd ($c.remote_grav_root) && bin/gpm install -y ($name)"
}
```

---

## 3. Erstmaliges Setup

Alle Befehle werden im **lokalen Arbeitsverzeichnis** der jeweiligen Site
ausgeführt. Die `grav.nuon` liegt dort und ist die Single-Source-of-Truth.

```nushell
use grav.nu *

# (1) Projektordner anlegen, in dem die Konfig liegt
mkdir ~/Projekte/grav-agrail
cd ~/Projekte/grav-agrail

# (2) Konfig erzeugen
grav config init "agrail.de" `
    --remote-user "ssh-w017ef42" `
    --remote-hostname "w017ef42.kasserver.com" `
    --remote-grav-root "/www/htdocs/w017ef42/agrail"

# (3) SSH-Eintrag in ~/.ssh/config
grav ssh install
grav ssh test                  # → "OK von …"

# (4) Remote-Repo + Hook anlegen, vorhandene Inhalte importieren
grav remote init
grav remote import

# (5) Lokalen Vault klonen
grav vault init
```

Anschließend in Obsidian: `File → Open Vault → ~/Documents/Obsidian/agrail-pages`.

---

## 4. Beispielinhalt der `grav.nuon`

Wird automatisch von `grav config init` geschrieben. Bei mehreren Sites
einfach für jede ein eigenes Projektverzeichnis mit eigener `grav.nuon`.

```nuon
{
    domain: "agrail.de",
    alias: "agrail",
    remote_user: "ssh-w017ef42",
    remote_hostname: "w017ef42.kasserver.com",
    remote_grav_root: "/www/htdocs/w017ef42/agrail",
    identity_file: "/home/fritz/.ssh/id_ed25519",
    local_vault: "/home/fritz/Documents/Obsidian/agrail-pages",
    bare_repo_remote: "~/repos/agrail-pages.git",
    git_host: "github.com",
}
```

Der entsprechende Eintrag in `~/.ssh/config`, den `grav ssh install` erzeugt:

```
# agrail.de – via grav.nu
Host agrail
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentityFile /home/fritz/.ssh/id_ed25519
    IdentitiesOnly yes
```

---

## 5. Plugins und Gruppen einrichten

Einmalig pro Site:

```nushell
grav plugin install login
grav plugin install admin
```

Anschließend `user/config/groups.yaml` lokal im Vault (oder direkt auf dem
Server) anlegen:

```yaml
mitglieder:
  readableName: 'Mitglieder'
  description: 'Angemeldete Personen mit Zugriff auf interne Beiträge'
  access:
    site:
      login: true
```

Hinweis: `groups.yaml` liegt in `user/config/`, **nicht** in `user/pages/`.
Wenn der Vault auf `user/pages/` beschränkt ist, lege diese Datei manuell
auf dem Server an oder erweitere den Bare-Repo-Hook auf den `user/`-Pfad.
Für die meisten Setups ist es sauberer, `groups.yaml` einmal manuell per
SSH zu pflegen:

```nushell
^ssh agrail "vi /www/htdocs/w017ef42/agrail/user/config/groups.yaml"
```

Benutzer anlegen:

```nushell
grav user new
```

---

## 6. Seitentemplates

### 6.1 Gemeinsame Basis

`user/themes/<theme>/templates/partials/article-base.html.twig`:

```twig
{% extends 'partials/base.html.twig' %}

{% block content %}
  <article class="beitrag {{ block('beitrag_klasse') }}">
    <header>
      <h1>{{ page.title }}</h1>
      {% if page.date %}
        <time datetime="{{ page.date|date('c') }}">
          {{ page.date|date('d.m.Y') }}
        </time>
      {% endif %}
      {% block beitrag_badge %}{% endblock %}
    </header>

    <div class="beitrag-body">
      {{ page.content|raw }}
    </div>
  </article>
{% endblock %}
```

### 6.2 Public

`templates/public.html.twig`:

```twig
{% extends 'partials/article-base.html.twig' %}
{% block beitrag_klasse %}beitrag--public{% endblock %}
```

### 6.3 Private

`templates/private.html.twig`:

```twig
{% extends 'partials/article-base.html.twig' %}
{% block beitrag_klasse %}beitrag--private{% endblock %}

{% block beitrag_badge %}
  <span class="beitrag-badge">Nur für Mitglieder</span>
{% endblock %}
```

### 6.4 Listing-Template (Filter)

```twig
{% set sichtbar = user.authenticated
    ? page.children.published.order('date', 'desc')
    : page.children.published.ofType('public').order('date', 'desc') %}

<section class="beitragsliste">
  {% for p in sichtbar %}
    <article class="teaser teaser--{{ p.template }}">
      <h2><a href="{{ p.url }}">{{ p.title }}</a></h2>
      {% if p.template == 'private' %}<span class="badge">Intern</span>{% endif %}
      <p>{{ p.summary }}</p>
    </article>
  {% else %}
    <p>Keine Beiträge vorhanden.</p>
  {% endfor %}
</section>
```

### 6.5 Templates deployen

Wenn die Theme-Templates lokal in `./theme-templates/` gepflegt werden:

```nushell
grav templates push ./theme-templates --theme my-theme
```

---

## 7. Frontmatter-Konventionen

### 7.1 `public.md`

```yaml
---
title: Willkommen im neuen Jahr
date: '2026-01-08 09:00'
taxonomy:
  category: blog
  tag: [news]
---

Inhalt …
```

### 7.2 `private.md`

```yaml
---
title: Protokoll der Mitgliederversammlung
date: '2026-01-15 18:00'
taxonomy:
  category: intern
access:
  site.login: true
  groups.mitglieder: true
---

Nur für Mitglieder sichtbar …
```

---

## 8. Obsidian-Workflow

### 8.1 Vault-Struktur (durch Grav vorgegeben)

```
agrail-pages/                ← Vault-Root = user/pages/
├── 01.start/
│   └── default.md
├── 02.blog/
│   ├── blog.md
│   ├── 01.willkommen-2026/
│   │   └── public.md
│   └── 02.protokoll-januar/
│       └── private.md
└── 06.intern/
    ├── intern.md
    └── 01.satzung/
        └── private.md
```

### 8.2 Templater-Vorlagen

Im Vault einen Ordner `.vorlagen/` (Punkt-Präfix → von Grav ignoriert)
anlegen:

**`.vorlagen/public.md`**

```markdown
---
title: <% tp.file.folder() %>
date: '<% tp.date.now("YYYY-MM-DD HH:mm") %>'
taxonomy:
  category: blog
  tag: []
---

```

**`.vorlagen/private.md`**

```markdown
---
title: <% tp.file.folder() %>
date: '<% tp.date.now("YYYY-MM-DD HH:mm") %>'
taxonomy:
  category: intern
access:
  site.login: true
  groups.mitglieder: true
---

```

In den Templater-Einstellungen `.vorlagen/` als Template-Folder eintragen.

### 8.3 Neuen Beitrag erstellen

1. In Obsidian Elternordner öffnen, z. B. `02.blog/`.
2. Unterordner anlegen, z. B. `03.neuer-beitrag/`.
3. Datei `public.md` oder `private.md` erstellen.
4. Templater einfügen, Inhalt schreiben, speichern.

### 8.4 Veröffentlichen

Im Terminal:

```nushell
grav push -m "Neuer Beitrag: Vorstandstreffen"
```

Der post-receive-Hook auf dem Server checkt den neuen Stand aus und leert
den Cache automatisch.

---

## 9. Tagesgeschäft – Befehlsreferenz

| Aktion                              | Befehl                                  |
| ----------------------------------- | --------------------------------------- |
| Konfig anlegen                      | `grav config init <domain> --…`         |
| SSH-Eintrag schreiben               | `grav ssh install`                      |
| Verbindung testen                   | `grav ssh test`                         |
| Bare-Repo + Hook aufsetzen          | `grav remote init`                      |
| Bestehende Inhalte importieren      | `grav remote import`                    |
| Lokalen Vault klonen                | `grav vault init`                       |
| Veröffentlichen                     | `grav push -m "…"`                      |
| Externe Änderungen holen            | `grav pull`                             |
| Vault-Status                        | `grav status`                           |
| Cache leeren                        | `grav cache clear`                      |
| Templates ins Theme spiegeln        | `grav templates push <dir> --theme <t>` |
| Login-Benutzer anlegen              | `grav user new`                         |
| Plugin installieren                 | `grav plugin install <name>`            |

Alle Befehle akzeptieren `--config <pfad>`, falls die `grav.nuon` woanders
liegt.

---

## 10. Mehrere Sites parallel

Pro Site ein eigenes Projektverzeichnis mit eigener `grav.nuon`:

```
~/Projekte/
├── grav-agrail/
│   └── grav.nuon          # alias: agrail
├── grav-doebbelin/
│   └── grav.nuon          # alias: doebbelin
└── grav-t3md/
    └── grav.nuon          # alias: t3md
```

`grav ssh install` aus jedem Verzeichnis ergänzt einen eigenen Host-Eintrag.
Die Vaults landen unter `~/Documents/Obsidian/<alias>-pages` und können
parallel in Obsidian geöffnet werden.

---

## 11. RSS und Sitemap

Zur Sicherheit: Verzeichnisse mit privaten Inhalten in
`user/config/plugins/sitemap.yaml` und `feed.yaml` ausschließen:

```yaml
ignores:
  - '/intern'
  - '/*/private'
```

---

## 12. Schnell-Checkliste

- [ ] `grav.nu` als Modul geladen
- [ ] `grav.nuon` für die Site erzeugt
- [ ] `grav ssh install` + `grav ssh test` erfolgreich
- [ ] `grav remote init` + `grav remote import` ausgeführt
- [ ] `grav vault init` und Vault in Obsidian geöffnet
- [ ] Login-Plugin und Gruppe `mitglieder` auf dem Server eingerichtet
- [ ] Templates `public.html.twig` / `private.html.twig` deployed
- [ ] Listing-Template filtert via `ofType('public')` für Gäste
- [ ] Templater-Vorlagen `.vorlagen/public.md` / `.vorlagen/private.md` aktiv
- [ ] Erster `grav push` löst Auto-Deploy aus
