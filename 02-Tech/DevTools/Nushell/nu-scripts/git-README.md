# Git Module

Git-Workflows und hilfreiche Shortcuts für schnellere Entwicklung.

## Commands

### `gs`
Git Status mit Farben und Icons.

```nu
gs
```

### `gc [message]`
Schneller Commit mit automatischem `add --all`.

```nu
gc "feat: add new feature"
```

### `gp`
Push zu Remote mit Fehlerbehandlung.

```nu
gp
```

### `gl [-n N]`
Zeige letzte N Commits (default: 10).

```nu
gl
gl -n 20
```

### `gb`
Zeige alle Branches (aktueller Branch wird gehighlightet).

```nu
gb
```

### `gco [branch]`
Branch erstellen oder auschecken.

```nu
gco feature/new-feature
gco main
```

### `grh [n]`
Letzte N Commits zurücksetzen (Änderungen erhalten).

```nu
grh          # 1 Commit zurücksetzen
grh 3        # 3 Commits zurücksetzen
```

### `gcd`
Alle lokalen Änderungen verwerfen (⚠️ nicht rückgängig zu machen).

```nu
gcd
```

### `gd`
Zeige Git Diff in schöner Darstellung.

```nu
gd
```

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts
