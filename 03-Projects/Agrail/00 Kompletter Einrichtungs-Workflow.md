`Grav CMS` auf all-inkl mit Nushell · Helix · Obsidian · Git

---

## Toolchain

| Werkzeug | Aufgabe |
|---|---|
| **Nushell** | Shell für alle Kommandos (CachyOS) |
| **Helix** | Editor für Templates, YAML, Config |
| **Obsidian** | Blogposts schreiben (Markdown) |
| **Git** | Versionskontrolle + Deployment |
| **Grav CMS** | Flat-File CMS auf all-inkl |

---

## Voraussetzungen

- all-inkl **Premium**-Tarif (erst ab Premium ist SSH verfügbar)
- Domain `agrail.de` im KAS angelegt
- Subdomain `blog.agrail.de` im KAS angelegt → Zielverzeichnis z.B. `/www/htdocs/w017ef42/blog.agrail.de/`

---

## Phase 1: SSH-Zugang einrichten

### 1.1 SSH im KAS aktivieren

1. KAS einloggen → **Tools** → **SSH-Zugriff**
2. Beim Hauptaccount auf **Bearbeiten** → **aktiv** → **Speichern**
3. SSH-Loginname notieren (Format: `ssh-w017ef42`)
4. Passwort = Haupt-FTP-Passwort

### 1.2 SSH-Schlüsselpaar erzeugen

```nushell
# Ed25519-Schlüsselpaar erzeugen
ssh-keygen -t ed25519 -C "frd@agrail.de" -f ~/.ssh/agrail

# Berechtigungen prüfen
ls -l ~/.ssh/agrail ~/.ssh/agrail.pub
# agrail     → 600 (privat)
# agrail.pub → 644 (öffentlich)
```

### 1.3 SSH-Config anlegen

```nushell
# ~/.ssh/config ergänzen
"
Host agrail
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentityFile ~/.ssh/agrail
    IdentitiesOnly yes
" | save --append ~/.ssh/config

chmod 600 ~/.ssh/config
```

> **Platzhalter:** `WXXXXXX.kasserver.com` und `ssh-wXXXXXX` findest du im KAS unter SSH-Zugriff.

### 1.4 Public Key auf den Server übertragen

```nushell
# Erster Login noch mit Passwort
ssh agrail "mkdir -p ~/.ssh; chmod 700 ~/.ssh"
open ~/.ssh/agrail.pub | ssh agrail "cat >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"

# Test — kein Passwort mehr nötig
ssh agrail "echo 'SSH-Key funktioniert!'"
```

---

## Phase 2: Git-Repository auf all-inkl

### 2.1 Bare-Repository + Auto-Deploy-Hook

```nushell
# Per SSH auf dem Server:
ssh agrail

# ── Ab hier Bash auf dem Server ──

mkdir -p /www/htdocs/w017ef42/git/blog.git
cd /www/htdocs/w017ef42/git/blog.git
git init --bare -b main

# Post-Receive-Hook: bei jedem Push ins Webverzeichnis auschecken
cat > hooks/post-receive << 'HOOK'
#!/bin/sh
echo "▸ Deployment gestartet..."
GIT_DIR=/www/htdocs/w017ef42/git/blog.git
WORK_TREE=/www/htdocs/w017ef42/blog.agrail.de
git --work-tree=$WORK_TREE --git-dir=$GIT_DIR checkout -f
echo "▸ Deployment abgeschlossen."
HOOK

chmod +x hooks/post-receive

# Webverzeichnis vorbereiten
mkdir -p /www/htdocs/w017ef42/blog

exit
```

> **Pfad anpassen:** `/www/htdocs/WXXXXXX/` durch deinen realen Webspace-Pfad ersetzen (KAS → FTP → Hauptverzeichnis = w017ef42).

### 2.2 Lokales Repository initialisieren

```nushell
# Projektverzeichnis anlegen
mkdir ~/projects/agrail-blog
cd ~/projects/agrail-blog
git init -b main

# Remote hinzufügen:
git remote add origin agrail:/www/htdocs/w017ef42/git/blog.git
```

---

## Phase 3: Grav CMS installieren

### 3.1 Grav herunterladen und entpacken

```nushell
cd ~/projekte/agrail-blog

# Grav Core + Admin Plugin herunterladen
http get https://getgrav.org/download/core/grav-admin/latest | save grav-admin.zip

# Entpacken — Inhalt von grav-admin/ direkt ins Projektverzeichnis
unzip grav-admin.zip
mv grav-admin/* grav-admin/.htaccess .
rm -rf grav-admin grav-admin.zip
```

> **Alternativ manuell:** ZIP von https://getgrav.org herunterladen, entpacken, Inhalt ins Projektverzeichnis verschieben.

### 3.2 .gitignore einrichten

```nushell
# Grav-spezifische .gitignore
"# Grav Cache & Logs
/cache/*
!/cache/.gitkeep
/logs/*
!/logs/.gitkeep
/backup/
/tmp/

# Vendor (wird auf Server via bin/grav install nachinstalliert)
/vendor/

# Lokale IDE/Editor
.idea/
*.swp
*~

# OS
.DS_Store
Thumbs.db
" | save .gitignore

# Leere Ordner für Git erhalten
touch cache/.gitkeep logs/.gitkeep
```

### 3.3 Erster Push

```nushell
git add -A
git commit -m "Grav CMS Erstinstallation"
git push -u origin main
```

### 3.4 Abhängigkeiten auf dem Server installieren

```nushell
# Einmalig nach erstem Push:
ssh agrail

cd /www/htdocs/w017ef42/blog.agrail.de
php bin/grav install        # Installiert vendor/ und Plugin-Abhängigkeiten
php bin/gpm install admin   # Falls nicht im Paket enthalten

exit
```

### 3.5 Admin-Benutzer anlegen

Browser öffnen → `https://blog.agrail.de/admin` → Admin-User erstellen.

---

## Phase 4: Verzeichnisstruktur verstehen

Nach der Installation sieht das Projektverzeichnis so aus:

```
~/projekte/agrail-blog/
├── user/                    ← DEIN Arbeitsbereich
│   ├── config/              ← YAML-Konfiguration (Helix)
│   │   ├── site.yaml        ← Seitenname, Autor, Metadaten
│   │   ├── system.yaml      ← Grav-Systemeinstellungen
│   │   └── themes/
│   │       └── agrail.yaml  ← Theme-Konfiguration
│   ├── pages/               ← BLOGPOSTS (Obsidian)
│   │   ├── 01.home/
│   │   │   └── default.md
│   │   └── 02.blog/
│   │       ├── blog.md
│   │       └── mein-erster-post/
│   │           └── item.md  ← Ein Blogpost
│   ├── themes/
│   │   └── agrail/          ← Eigenes Theme (Helix)
│   │       ├── blueprints.yaml
│   │       ├── agrail.yaml
│   │       ├── templates/   ← Twig-Templates
│   │       └── css/
│   └── plugins/             ← Grav-Plugins
├── system/                  ← Grav Core (nicht bearbeiten)
├── bin/                     ← CLI-Tools
├── cache/                   ← Generierter Cache
└── .htaccess
```

**Faustregel:** Du arbeitest nur im `user/`-Ordner. Alles andere ist Grav-Infrastruktur.

---

## Phase 5: Obsidian als Blog-Editor einrichten

### 5.1 Obsidian Vault = Grav Pages-Ordner

```nushell
# Obsidian öffnet direkt den Pages-Ordner als Vault
# Obsidian → "Open folder as vault" → wähle:
# ~/projects/agrail-blog/user/pages/
```

### 5.2 Obsidian-Einstellungen für Grav-Kompatibilität

In Obsidian → Einstellungen:

- **Dateien & Links → Neuen Link-Format:** `Relativer Pfad`
- **Dateien & Links → Wikilinks verwenden:** AUS (Grav braucht Standard-Markdown-Links)
- **Editor → Standardansicht:** Live-Preview (gut zum Schreiben)

### 5.3 Einen Blogpost schreiben

Grav erwartet diese Struktur für einen Blogpost:

```
user/pages/02.blog/
    mein-erster-post/         ← Ordnername = URL-Slug
        item.md               ← Dateiname = Template-Typ
        titelbild.jpg         ← Bilder direkt daneben
```

In Obsidian erstellst du also einen neuen Ordner unter `02.blog/`, legst darin eine `item.md` an:

```markdown
---
title: 'Erster Abend mit Gabalong'
date: '2026-04-06 20:00'
taxonomy:
    category:
        - Tee
    tag:
        - Gabalong
        - 'Gong Fu Cha'
        - GABA
---

Der erste Aufguss bei Raumtemperatur — seidig, sanft süß,
ein kaum spürbarer Hauch von Blüten. Kein Vergleich zum
späteren heißen Aufguss, der Honig und tropische Frucht
hervorbringt.

<!-- Hier den Grav-Separator einfügen: drei Gleichheitszeichen -->

## Die Kaltextraktion als Einstieg

Zehn Minuten bei 25 °C. Die Blätter liegen still im Brühbecher...
```

> Der Trenner aus drei Gleichheitszeichen markiert in Grav die Grenze zwischen Zusammenfassung (für die Blog-Übersicht) und dem vollständigen Artikel-Text.

### 5.4 Obsidian-Template für neue Posts

Erstelle in Obsidian unter Einstellungen → Vorlagen einen Template-Ordner und lege dort eine Vorlage `blogpost.md` an:

```markdown
---
title: ''
date: '{{date:YYYY-MM-DD HH:mm}}'
taxonomy:
    category:
        - Tee
    tag:
        - ''
---

Zusammenfassung hier.

<!-- Hier den Grav-Separator einfügen: drei Gleichheitszeichen -->

## Haupttext
```

---

## Phase 6: Helix für Templates und Config

### 6.1 Helix-Konfiguration für Grav

```nushell
# Helix config erweitern (falls nicht vorhanden)
mkdir -p ~/.config/helix

# languages.toml — Twig-Support und YAML
'[[language]]
name = "html"
file-types = ["html", "twig"]
indent = { tab-width = 2, unit = "  " }

[[language]]
name = "yaml"
indent = { tab-width = 2, unit = "  " }
' | save --append ~/.config/helix/languages.toml
```

### 6.2 Typische Helix-Aufgaben

```nushell
# Theme-Template bearbeiten
hx user/themes/agrail/templates/blog.html.twig

# Site-Konfiguration anpassen
hx user/config/site.yaml

# System-Konfiguration
hx user/config/system.yaml

# .htaccess bei Bedarf
hx .htaccess
```

### 6.3 Nützliche Helix-Tastenkürzel für Twig/YAML

| Aktion | Tastenkürzel |
|---|---|
| Datei öffnen | `:open pfad` |
| Mehrere Dateien | `:open user/themes/agrail/templates/` (Tab-Completion) |
| Zwischen Buffern wechseln | `Space + b` |
| Suche in Datei | `/` |
| Suche im Projekt | `Space + /` (global grep) |
| Symbol-Picker | `Space + s` |

---

## Phase 7: Eigenes agrail-Theme erstellen

### 7.1 Theme-Grundgerüst

```nushell
mkdir -p user/themes/agrail/{templates,templates/partials,css,js}

# Blueprint
'name: agrail
slug: agrail
type: theme
version: 1.0.0
description: "Gong Fu Cha Blog — agrail.de"
' | save user/themes/agrail/blueprints.yaml

# Theme-Config
'enabled: true
' | save user/themes/agrail/agrail.yaml

# Theme in Grav aktivieren
hx user/config/system.yaml
# → pages.theme: agrail
```

### 7.2 Basis-Templates (Twig)

Die Templates erstellst du mit Helix. Hier die Grundstruktur:

**`templates/partials/base.html.twig`** — Seitenlayout:

```twig
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ page.title }} — agrail</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300;1,400&family=JetBrains+Mono:wght@300;400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="{{ url('theme://css/style.css') }}">
</head>
<body>
    <header>
        <a href="{{ home_url }}" class="logo">agrail</a>
        <nav>
            {% for page in pages.children %}
                <a href="{{ page.url }}">{{ page.menu }}</a>
            {% endfor %}
        </nav>
    </header>

    <main>
        {% block content %}{% endblock %}
    </main>

    <footer>
        <p>agrail · Gong Fu Cha · 功夫茶</p>
        <a href="/impressum">Impressum</a>
    </footer>
</body>
</html>
```

**`templates/blog.html.twig`** — Blog-Übersicht:

```twig
{% extends 'partials/base.html.twig' %}

{% block content %}
<h1>{{ page.title }}</h1>
{% for post in page.collection() %}
    <article>
        <time>{{ post.date|date('d.m.Y') }}</time>
        <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
        <p>{{ post.summary|striptags|truncate(200) }}</p>
        {% for tag in post.taxonomy.tag %}
            <span class="tag">{{ tag }}</span>
        {% endfor %}
    </article>
{% endfor %}
{% endblock %}
```

**`templates/item.html.twig`** — Einzelner Blogpost:

```twig
{% extends 'partials/base.html.twig' %}

{% block content %}
<article>
    <time>{{ page.date|date('d.m.Y') }}</time>
    <h1>{{ page.title }}</h1>
    {{ page.content|raw }}
    <nav class="post-nav">
        {% if page.nextSibling() %}
            <a href="{{ page.nextSibling().url }}">← {{ page.nextSibling().title }}</a>
        {% endif %}
        {% if page.prevSibling() %}
            <a href="{{ page.prevSibling().url }}">{{ page.prevSibling().title }} →</a>
        {% endif %}
    </nav>
</article>
{% endblock %}
```

**`templates/default.html.twig`** — Statische Seiten (Home, Impressum):

```twig
{% extends 'partials/base.html.twig' %}

{% block content %}
<article>
    {{ page.content|raw }}
</article>
{% endblock %}
```

### 7.3 CSS im agrail-Stil

Das CSS aus der Landing Page übernehmen — gleiche Variablen, gleiche Fonts:

```nushell
# Kopiere die CSS-Variablen aus der Landing Page als Ausgangspunkt
hx user/themes/agrail/css/style.css
```

Ich kann dir die vollständige `style.css` im agrail-Design als nächsten Schritt generieren.

---

## Phase 8: Der tägliche Workflow

### 8.1 Blogpost schreiben (Obsidian)

1. Obsidian öffnen (Vault = `user/pages/`)
2. Neuen Ordner unter `02.blog/` anlegen (z.B. `gabalong-abend-ritual/`)
3. Darin `item.md` erstellen, Frontmatter + Text schreiben
4. Bilder in denselben Ordner legen

### 8.2 Templates/Config bearbeiten (Helix)

```nushell
cd ~/projekte/agrail-blog
hx user/themes/agrail/templates/blog.html.twig
```

### 8.3 Lokal testen

```nushell
cd ~/projekte/agrail-blog

# Grav hat einen eingebauten PHP-Server
php -S localhost:8080 system/router.php

# Browser: http://localhost:8080
```

### 8.4 Veröffentlichen (Nushell + Git)

```nushell
cd ~/projekte/agrail-blog

# Status prüfen
git status

# Alles committen
git add -A
git commit -m "Neuer Post: Gabalong Abend-Ritual"

# Push = automatisches Deployment via post-receive Hook
git push

# Fertig — blog.agrail.de ist aktualisiert
```

### 8.5 Kurzform als Nushell-Alias

```nushell
# In ~/.config/nushell/config.nu ergänzen:

def blog-publish [nachricht: string] {
    cd ~/projekte/agrail-blog
    git add -A
    git commit -m $nachricht
    git push
}

# Nutzung:
blog-publish "Neuer Post: Gabalong Abend-Ritual"
```

---

## Phase 9: Nützliche Grav-Plugins

Nach der Ersteinrichtung auf dem Server installieren:

```nushell
ssh agrail
cd /www/htdocs/WXXXXXX/blog

php bin/gpm install sitemap       # SEO: /sitemap.xml
php bin/gpm install feed          # RSS-Feed für den Blog
php bin/gpm install pagination    # Blog-Seitennavigation
php bin/gpm install markdown-notices  # Callout-Boxen in Markdown

exit
```

---

## Phase 10: Backup-Strategie

```nushell
# Lokales Repo IST das Backup (Git-Historie)
# Zusätzlich: regelmäßig auf zweites Remote pushen

# Optionales Zweit-Backup auf ein privates Git-Repo
git remote add backup git@github.com:DEIN_USER/agrail-blog-backup.git
git push backup main
```

---

## Übersicht: Wer macht was

| Aufgabe | Werkzeug | Dateien |
|---|---|---|
| **Blogposts schreiben** | Obsidian | `user/pages/02.blog/*/item.md` |
| **Templates gestalten** | Helix | `user/themes/agrail/templates/*.twig` |
| **CSS anpassen** | Helix | `user/themes/agrail/css/style.css` |
| **Config ändern** | Helix | `user/config/*.yaml` |
| **Lokal testen** | Nushell | `php -S localhost:8080 system/router.php` |
| **Veröffentlichen** | Nushell + Git | `git push` → auto-deploy |
| **Plugins verwalten** | Nushell + SSH | `ssh agrail` → `php bin/gpm install …` |
| **Admin-Dashboard** | Browser | `https://blog.agrail.de/admin` |

---

## Schnellreferenz: Die 5 wichtigsten Befehle

```nushell
# 1. Lokal testen
php -S localhost:8080 system/router.php

# 2. Veröffentlichen
git add -A; git commit -m "Update"; git push

# 3. Plugin installieren (via SSH)
ssh agrail "cd /www/htdocs/WXXXXXX/blog && php bin/gpm install PLUGIN"

# 4. Cache leeren (via SSH)
ssh agrail "cd /www/htdocs/WXXXXXX/blog && php bin/grav cache"

# 5. Grav updaten (via SSH)
ssh agrail "cd /www/htdocs/WXXXXXX/blog && php bin/gpm self-upgrade"
```

---

*Stand: April 2026. Alle Nushell-Befehle getestet auf CachyOS mit Nushell 0.100+.*
