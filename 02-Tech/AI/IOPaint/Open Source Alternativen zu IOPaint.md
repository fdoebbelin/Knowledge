---
title: Open Source Alternativen zu IOPaint
tags:
  - ki
  - bildbearbeitung
  - inpainting
created: 2025-12-15
updated: 2026-09-15
---

# Open Source Alternativen zu IOPaint

> [!abstract] Zusammengeführt
> Vereint zwei frühere Recherche-Antworten vom 2025-12-15 („01“ und „02 Open Source Alternativen zu IOPaint“). Stand: Ende 2025.

IOPaint (ehemals Lama Cleaner) ist hervorragend für das **schnelle Entfernen** von Objekten (Eraser-Modus mit LaMa-Modell). Für **generative Aufgaben** („ersetze den Hund durch eine Katze“, „erweitere den Hintergrund realistisch“) sind Werkzeuge auf Basis von **Stable Diffusion XL** oder **Flux** meist überlegen. Was „bessere Ergebnisse“ heißt, entscheidet also über die Wahl: sauberes Entfernen ohne Spuren oder Generieren neuer Inhalte (Inpainting/Outpainting).

## 1 · Fooocus – beste Qualität „out of the box“

Kombiniert die Einfachheit von Midjourney mit SDXL. Die stärkste Empfehlung für bessere Ergebnisse ohne Konfigurationsaufwand.

- **Warum besser als IOPaint?** Eigene Inpainting-Engine, die Licht, Schatten und Stil des Originals beibehält; Ergebnisse wirken organischer. SDXL bietet höhere Auflösung und besseres Textverständnis als die Standardmodelle in IOPaint.
- **Funktionen:** Smart Inpainting (versteht Kontext besser als LaMa), Modify Content (z. B. „Kleidung ändern“), Outpainting, Face-Swap und Gesichtsverbesserung, Stil-Transfer.
- **Hosting:** Ein-Klick-Installer (Windows), Docker für Linux/Server; Colab-Notebook im Repo.
- **Ideal für:** sofort fotorealistische Ergebnisse ohne Node-Verkabelung.
- **Link:** [GitHub – Fooocus](https://github.com/lllyasviel/Fooocus)

## 2 · InvokeAI – professioneller Workflow mit „Unified Canvas“

- **Warum besser?** Der Unified Canvas ist eine unendliche Arbeitsfläche: fließender Übergang zwischen Inpainting und Outpainting, Bild Stück für Stück erweitern („Stitching“), Generationen als Layer bearbeiten (Photoshop-ähnlich). Sehr gutes Masking, benutzerfreundliche Verwaltung von Modellen und LoRAs, optionaler Node-Editor.
- **Hosting:** robuster Installer für Windows/Mac/Linux.
- **Ideal für:** Kreative und Künstler, die Kontrolle über Komposition und Ebenen brauchen.
- **Link:** [invoke-ai.com](https://invoke-ai.com/)

## 3 · ComfyUI – maximale Kontrolle, State of the Art

Node-basiert, steile Lernkurve, aber ungeschlagen flexibel. Zugriff auf jedes neue Modell am Tag der Veröffentlichung.

- **Warum besser?** Nutzung der neuesten **Flux**-Modelle für Inpainting; Workflows wie „Crop & Stitch“ (nur den maskierten Bereich hochskalieren, bearbeiten, wieder einfügen) für extreme Details. Läuft auf schwächerer Hardware effizienter als andere Tools.
- **Spezialmodelle:**
  - **PowerPaint v2:** speziell auf Befehle wie „remove object“ / „insert object“ trainiert; übertrifft klassisches SD-Inpainting oft deutlich.
  - **BrushNet:** Plug-and-Play-Ansatz (2024/2025), der Bildmerkmale besser erhält und die Konsistenz drastisch verbessert.
- **Hosting:** selbstgehostet; viele fertige Workflows (JSON) zum Laden. Demos auf Hugging Face Spaces („PowerPaint“, „BrushNet“).
- **Ideal für:** Power-User, die das Maximum an Qualität wollen.

## 4 · Krita + AI Diffusion Plugin – KI im Malprogramm

Oft der „Game Changer“: Die KI steckt direkt in Krita statt in einem Web-Interface.

- **Warum besser?** Keine grobe Maske nötig: Ebenen, pixelgenaue Masken, sofortige manuelle Nachbearbeitung. Im Hintergrund läuft ComfyUI (inkl. ControlNet, IP-Adapter), die Komplexität bleibt verborgen.
- **Besonderheit:** „Live Painting“, grob gemalte Formen werden in Echtzeit verfeinert.
- **Hosting:** Krita + Plugin + ComfyUI-Backend, lokal.
- **Link:** [GitHub – Krita AI Diffusion](https://github.com/Acly/krita-ai-diffusion)

## 5 · DiffBIR – Spezialist für Restaurierung

Für das **Reparieren** alter, unscharfer oder beschädigter Fotos statt für das Ersetzen von Objekten. Diffusion-based Blind Image Restoration stellt realistische Texturen in unscharfen Bereichen wieder her, wo IOPaint „rät“. Ideal für Fotorestaurierung und Upscaling.

## Vergleich

| Tool | Hauptstärke | Lernkurve | Modelle | Hardware |
|---|---|---|---|---|
| **IOPaint** | schnelles Entfernen (Eraser) | sehr niedrig | LaMa, PowerPaint, SD 1.5 | auch CPU (langsam) |
| **Fooocus** | Fotorealismus, Einfachheit | niedrig | SDXL (optimiert) | gute Nvidia-GPU |
| **InvokeAI** | professioneller Canvas | mittel | SD 1.5, SDXL, Flux | gute GPU |
| **ComfyUI** | maximale Kontrolle, PowerPaint/BrushNet | hoch | alle (SD, Flux …) | GPU, aber effizient |
| **Krita + AI** | präzise Bearbeitung, Kompositionen | mittel | wie ComfyUI | lokal, Desktop |
| **DiffBIR** | Restaurierung, Upscaling | mittel | eigenes Modell | GPU |

## Empfehlung

1. **Objekte löschen, schnelle Korrekturen:** bei **IOPaint** (LaMa) bleiben, dafür ungeschlagen schnell.
2. **Bildinhalte ändern (generatives Fill):** **Fooocus** installieren. SDXL-Inpainting ist ein deutlicher Sprung gegenüber den IOPaint-Standardmodellen.
3. **Komplexe Kompositionen:** **InvokeAI**, oder für Krita-Nutzer das **AI-Diffusion-Plugin**.
4. **Neueste Forschungsmodelle:** **ComfyUI** mit PowerPaint v2 oder BrushNet.

**Online testen:** Kostenlose Dauer-Demos sind wegen des GPU-Bedarfs selten. Auf **Hugging Face Spaces** nach „Fooocus“, „ComfyUI“ oder „PowerPaint v2 Demo“ suchen. Bezahlte Cloud-Instanzen bieten RunDiffusion oder ThinkDiffusion.

## Quellen (aus der Recherche)

- https://www.iopaint.com
- https://github.com/lllyasviel/Fooocus · https://www.libhunt.com/compare-Fooocus-vs-InvokeAI
- https://github.com/open-mmlab/PowerPaint · https://dataloop.ai/library/model/junhaozhuang_powerpaint-v2-1/
- https://arxiv.org/abs/2403.06976 (BrushNet) · https://arxiv.org/html/2502.06593v1
- https://github.com/Acly/krita-ai-diffusion · https://github.com/Acly/comfyui-inpaint-nodes/issues/63
- https://wiki.shakker.ai/en/inpainting-methods-in-comfyUI
- https://www.reddit.com/r/StableDiffusion/comments/1m9pkg7/invokeai_vs_comfyui_overall_outputs_quality/
- https://www.reddit.com/r/StableDiffusion/comments/1fciq4d/the_best_ai_inpainter_at_the_moment/
- https://openaccess.thecvf.com/content/CVPR2022W/NTIRE/papers/Cipolina-Kun_Comparison_of_CoModGans_LaMa_and_GLIDE_for_Art_Inpainting_Completing_CVPRW_2022_paper.pdf
