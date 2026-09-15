## Pixi als Scoop-Ersatz auf WoA? Noch nicht.

conda-forge hat nur **experimentellen, partiellen** win-arm64-Support – aktuell gerade mal ~300 Pakete. Das reicht noch lange nicht für einen Scoop-Ersatz.

---

## Die realistische Tool-Strategie für WoA

**1. winget** → deine beste Wahl für native Tools

```powershell
winget install pandoc
winget install git.git
winget install Microsoft.PowerShell
```

Pandoc, Git, VS Code, Python – alles mit nativen ARM64-Binaries verfügbar. Winget ist von Microsoft gepflegt und hat den besten WoA-Support überhaupt.

**2. Pixi global** → dort wo conda-forge win-arm64 schon liefert

```bash
pixi global install --platform win-64 ripgrep fd-find bat jq
```

Notfalls mit `--platform win-64` und x64-Emulation. Für reine Dev-Tools akzeptabel.

**3. WSL2** → der eigentliche Linux-Ersatz Für alles aus dem Linux-Umfeld, was nativ auf WoA nicht läuft. WSL2 läuft auf WoA nativ und gibt dir die volle Linux-Toolchain.

---

## Konkret für deinen Use Case

|Tool|Empfehlung WoA|
|---|---|
|pandoc|`winget install pandoc` ✅|
|git|`winget install git.git` ✅|
|ffmpeg|`winget install ffmpeg` ✅|
|ripgrep, bat, fd|Pixi global (x64-Emulation) oder WSL2|
|Python-Umgebungen|Pixi oder uv ✅|
|alles andere Linux|WSL2|

---

## Fazit

**winget + WSL2** ist die solideste Kombination auf WoA – winget für native Windows-Apps und Tools, WSL2 für echte Linux-Tools. Pixi kommt als Ergänzung dazu, sobald conda-forge win-arm64 mehr Pakete hat. Das wächst gerade aktiv, aber ist 2025/2026 noch kein Scoop-Ersatz.