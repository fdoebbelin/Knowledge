# Utils Module

Allgemeine Hilfsfunktionen und Utilities für häufige Aufgaben.

## Commands

### `llm [path]`
Detaillierte Dateigrößen-Analyse mit Übersicht über Anzahl der Items.

```nu
llm .
llm /tmp
```

### `tree [--max-depth N] [path]`
Schöne Verzeichnis-Struktur mit Tiefe-Limitierung.

```nu
tree
tree --max-depth 2 /usr/local
```

### `uuid`
Generiere eine zufällige UUID v4.

```nu
uuid
# Output: 550e8400-e29b-41d4-a716-446655440000
```

### `hash-file --algorithm sha256 [path]`
Berechne Datei-Hash (MD5 oder SHA256).

```nu
hash-file --algorithm sha256 ~/myfile.txt
hash-file --algorithm md5 ~/myfile.iso
```

### `colored [color]`
Text mit Farbe ausgeben.

```nu
"Fehler!" | colored red
"Erfolg!" | colored green
```

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts
