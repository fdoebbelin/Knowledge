Das ist die Syntax des **Meta Bind**-Plugins (`obsidian-meta-bind-plugin`, von mProjectsCode). Es bindet Eingabefelder direkt an Properties im Frontmatter.

**Inline-Variante** (in Backticks, mitten im Text):

```markdown
Teemenge: `INPUT[number:teemenge_g]` g
```

**Block-Variante:**

````markdown
```meta-bind
INPUT[number:teemenge_g]
```
````

Der Teil nach dem Doppelpunkt ist der Bind-Target, also der Property-Name im YAML-Frontmatter derselben Datei. Du kannst auch auf andere Dateien zeigen: `INPUT[number:03-Projects/Tee.md#teemenge_g]`.

**Argumente** für Default, Placeholder, Min/Max:

```markdown
`INPUT[number(placeholder(Menge in g), defaultValue(5)):teemenge_g]`
`INPUT[slider(minValue(1), maxValue(20), addLabels)):teemenge_g]`
```

**Nützliche Feldtypen:** `text`, `number`, `toggle`, `slider`, `date`, `time`, `select`, `multiSelect`, `suggester`, `list`, `textArea`, `progressBar`, `editor`.

**Berechnete Ausgaben** über `VIEW`:

```markdown
`VIEW[{teemenge_g} * 3][math]`
```

Typisches Vollbeispiel für eine Teenotiz:

```markdown
---
teemenge_g: 5
wassertemp: 80
ziehzeit_s: 120
---

Menge: `INPUT[number:teemenge_g]` g  
Temperatur: `INPUT[slider(minValue(60), maxValue(100), addLabels)):wassertemp]` °C  
Ziehzeit: `INPUT[number:ziehzeit_s]` s → `VIEW[{ziehzeit_s} / 60][math]` min
```

Zwei Hinweise aus der Praxis: Die Felder rendern in Live Preview und Reading Mode, nicht im reinen Source Mode. Und wenn du JS-Logik in den Views brauchst, ist zusätzlich das **JS Engine**-Plugin nötig — für reine Zahlen-/Textbindungen reicht Meta Bind allein.

Für Buttons gibt es analog `BUTTON[id]` mit einem `meta-bind-button`-Block, falls du z. B. Werte per Klick zurücksetzen willst.