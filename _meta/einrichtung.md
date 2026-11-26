# Einrichtung: vom alten zum neuen Knowledge

Einmalige Schritte für den Wechsel. Reihenfolge einhalten – vor allem Schritt 1 vor Schritt 3.

## 1. Altes Repository umbenennen und Remotes umstellen

```nu
gh repo rename Knowledge-Archiv --repo fdoebbelin/Knowledge
```

GitHub leitet `fdoebbelin/Knowledge` danach auf das Archiv weiter – **aber nur, bis ein neues Repo diesen Namen belegt**. Deshalb jetzt auf **jedem Rechner** und überall sonst, wo `origin` auf das alte Repo zeigt (auch Obsidian-Git-Plugin, Skripte, Hooks):

```nu
git remote set-url origin git@github.com:fdoebbelin/Knowledge-Archiv.git
git remote -v   # prüfen
```

Die Grav-Kopplung abbauen: den `post-receive`-Hook im Bare-Repo auf All-Inkl deaktivieren, damit nichts mehr nach t3md.de veröffentlicht wird.

Zum Schluss das Archiv schreibschützen:

```nu
gh repo archive fdoebbelin/Knowledge-Archiv --yes
```

## 2. Archiv als Migrationsquelle bereitstellen

Ein lokaler Klon des Archivs ist die Quelle für `scripts/migration.nu`. Pfad dauerhaft in der Nushell-Umgebung setzen (`$nu.env-path` bzw. `env.nu`):

```nu
$env.KNOWLEDGE_ARCHIV = ($env.HOME | path join Projekte Knowledge-Archiv)
```

## 3. Neues Repository anlegen

Im Ordner dieses Gerüsts:

```nu
git init --initial-branch main
git config core.hooksPath .githooks
git add -A
git commit -m "Gerüst: Zettelkasten mit Agentenumgebung"
gh repo create fdoebbelin/Knowledge --public --source . --push --description "Wissensbasis zu Linux & Softwareentwicklung – Zettelkasten"
```

## 4. GitHub Pages einschalten

```nu
gh api --method POST repos/fdoebbelin/Knowledge/pages -f build_type=workflow
```

(oder Settings → Pages → Source: „GitHub Actions“). Danach baut jeder Push auf `main` die Website: <https://fdoebbelin.github.io/Knowledge/>

## 5. Kurse als eigene Repositorys herauslösen

Je Kurs aus einem frischen Klon des Archivs, mit Historie (`git filter-repo` muss installiert sein):

```nu
git clone https://github.com/fdoebbelin/Knowledge-Archiv.git Tauri-Kompaktkurs
cd Tauri-Kompaktkurs
git filter-repo --subdirectory-filter "01-Courses/Programming/Tauri-Kompaktkurs"
gh repo create fdoebbelin/Tauri-Kompaktkurs --public --source . --push
```

Vorher prüfen, ob der Kurs Anhänge aus Ordnern **außerhalb** seines Kursordners einbindet (z. B. `02-Tech/_resources`) – die fehlen sonst im neuen Repo. Im neuen Knowledge bekommt jeder Kurs eine `quelle` mit `art: kurs` und Link auf sein Repository.
