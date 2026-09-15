# 🤝 Contributing

Beiträge sind willkommen! Hier sind die Guidelines:

## Vor dem Commit

1. **Branch erstellen**:
```
git checkout -b feature/my-new-command
```

2. **Code testen** (lokal laden und prüfen):
```
use scripts/utils/module.nu

# Test commands...
```

3. **Commit mit beschreibender Message**:
```
git commit -m "feat: add new-command for X"
```

## Struktur für neue Commands

```
# Kommentar mit Beschreibung

def my-command [param: type = "default"] {
\# Implementierung
\# ...

    # Erfolgs-Output
    print "✅ Erfolgreich!"
    }
```

## Naming Conventions

- `def` Namen: `lowercase-with-dashes`
- Parameter: `lowercase_with_underscores`
- Module: In entsprechenden Ordner (`utils/`, `git/`, `system/`)

## Commit Message Format

```

type(scope): subject

```

Types: `feat`, `fix`, `docs`, `refactor`, `test`

Beispiel:
```

feat(utils): add uuid generator
fix(git): improve gs status display
docs: update README with new commands

```

---

Danke! 🙏