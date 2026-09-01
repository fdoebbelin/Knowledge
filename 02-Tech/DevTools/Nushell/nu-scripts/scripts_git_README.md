# Git Module

Git-Workflows und hilfreiche Shortcuts für schnellere Entwicklung.
## Commands

### `gs`
Git Status mit Farben und Icons.

```
gs
```

### `gc [message]`
Schneller Commit mit automatischem `add --all`.

```
gc "feat: add new feature"
```

### `gp`
Push zu Remote mit Fehlerbehandlung.

```
gp
```

### `gl [-n N]`
Zeige letzte N Commits (default: 10).

```
gl
gl -n 20
```

### `gb`
Zeige alle Branches (aktueller Branch wird gehighlightet).

```
gb
```

### `gco [branch]`
Branch erstellen oder auschecken.

```
gco feature/new-feature
gco main
```

### `grh [n]`
Letzte N Commits zurücksetzen (Änderungen erhalten).

```
grh          \# 1 Commit zurücksetzen
grh 3        \# 3 Commits zurücksetzen
```

### `gcd`
Alle lokalen Änderungen verwerfen (⚠️ nicht rückgängig zu machen).

```
gcd
```

### `gd`
Zeige Git Diff in schöner Darstellung.

```
gd
```

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts