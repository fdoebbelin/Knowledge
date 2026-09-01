# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Python script (`workout_video.py`) that generates MP4 workout videos directly from Obsidian Markdown files. The Markdown files serve as the sole data source — no JSON, no separate config. The project lives inside an Obsidian vault.

## Setup

```bash
uv venv
uv pip install moviepy pillow python-frontmatter
```

Requires `ffmpeg` installed system-wide (`sudo pacman -S ffmpeg` on CachyOS).

## Running the Script

```bash
# Single circuit → Zirkel 1.mp4
uv run workout_video.py "Zirkel 1.md"

# Multiple circuits combined
uv run workout_video.py "Zirkel 1.md" "Zirkel 3.md" --output montag.mp4

# Fast test render
uv run workout_video.py "Zirkel 1.md" --preset ultrafast
```

## Architecture

The pipeline has three stages:

1. **Parse** — `frontmatter.load()` reads Zirkel files (circuit definitions) and lazily loads referenced exercise files (`load_exercise_meta()`). The `sequenz` list is expanded by `rounds`, producing `full_sequence`.

2. **Deduplicate & Render** — Each clip is hashed by content (`get_clip_hash()`). Only unique clips are rendered, using `ProcessPoolExecutor` for parallelism. Each clip is a self-contained ffmpeg invocation inside `render_worker()`. Filter graphs are written to temp files (`-filter_complex_script`) to avoid shell escaping issues with long filter strings.

3. **Concat** — All clips (with pauses interleaved) are concatenated via `ffmpeg -f concat` into the final MP4.

### Markdown File Formats

**Zirkel file** (circuit definition):
```yaml
---
rounds: 3
training_duration: 40   # seconds, overridable per exercise
rest_duration: 20
sequenz:
  - uebung: "Y-Handschellen"   # → loads Y-Handschellen.md
    seite: ~                    # ~ = bilateral; "links"/"rechts" appended to title
  - uebung: "Kniender Ausfallschritt"
    seite: links
---
```

**Exercise file** (loaded by name, e.g. `Y-Handschellen.md`):
```yaml
---
title: "Y-Handschellen"
fokus: ["Schultern"]      # shown as description, fades after 3s
muskeln: ["Trapezius"]
image: "_resources/000204.jpg"
---
```

Image lookup order: relative to MD file → `_resources/` subfolder → vault root.

### Video Layout

- **1280×720**, 30fps, H.264/AAC
- Exercise clips: orange progress bar, title top-left, focus+muscles fade after 3s
- Pause clips: blurred/darkened background, yellow "PAUSE" centered, next exercise hinted
- Optional `gong.mp3` plays at the end of each clip (auto-detected in vault root)

## Key Implementation Details

- Font discovery (`find_font()`) checks Windows/Linux/macOS paths; falls back to ffmpeg's built-in font
- Text written to `.txt` files in `tmp_dir` to safely pass unicode through ffmpeg `drawtext=textfile=`
- Pause clips use the *exercise image* from the preceding exercise (blurred) as background
- The concat list uses single-quoted paths; backslashes converted to forward slashes for ffmpeg cross-platform compatibility
