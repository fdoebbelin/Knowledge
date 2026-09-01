Um eine Markdown-Datei (.md), die z.B. in Jupytext-Format geschrieben ist, in eine Jupyter Notebook-Datei (.ipynb) umzuwandeln, genügt ein einfacher Terminal-Befehl mit Jupytext. Voraussetzungen sind, dass die Markdown nach Jupytext-Spezifikationen formatiert ist (z.B. mit MyST oder speziellen Regionen für Code und Markdown).[^1][^2]

## Schritt-für-Schritt Anleitung

- Stelle sicher, dass die Datei die nötigen Jupytext-Formatierungen enthält, z.B. einen YAML-Header sowie korrekt markierte Codeblöcke („```{code-cell}“ bei MyST oder „<!-- #region code -->“ für andere Formate)[web:6][web:7].
- Öffne ein Terminal und führe folgenden Befehl aus:

```
jupytext --to ipynb deine_datei.md
```

Damit wird automatisch eine „deine_datei.ipynb“ erzeugt[web:1][web:7].

- Optionale Ausführung: Um das Notebook nach Konvertierung direkt ausführen zu lassen:

```
jupytext --to notebook --execute deine_datei.md
```

Das führt die enthaltenen Code-Zellen aus[web:1].

### Hinweise zur Formatierung

- Damit die Zellen im Notebook als einzelne Code- oder Markdown-Zellen erscheinen, achte auf das richtige Format (z.B. MyST-Markdown für MyST-Notebooks, oder die Region-Tags für klassische Jupytext-Formate)[web:6][web:7].
- YAML-Header am Anfang der Datei erleichtern die Konvertierung und speichern Kernel- und Formatinformationen:

```
***
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  display_name: Python 3
  language: python
  name: python3
***
```
