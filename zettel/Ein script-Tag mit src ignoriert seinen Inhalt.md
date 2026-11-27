---
id: 202611270944
title: Ein script-Tag mit src ignoriert seinen Inhalt
type: zettel
tags:
  - web/html
created: 2026-11-27
herkunft: 01-Courses/Programming/JavaScript-STEM
---

Ein `<script>`-Tag bringt JavaScript entweder als Text zwischen Start- und End-Tag oder als externe Datei über das Attribut `src` in die Seite – aber nie beides. Sobald `src` gesetzt ist, lädt der Browser die Datei und übergeht stillschweigend, was zwischen den Tags steht:

```html
<script src="app.js">
  alert("wird nie ausgeführt");
</script>
```

Es gibt keine Fehlermeldung, der Code fehlt einfach. Wer beides braucht, schreibt zwei Tags:

```html
<script src="app.js"></script>
<script>
  alert("läuft nach app.js");
</script>
```

Die Tags werden in ihrer Reihenfolge ausgeführt, das zweite Skript kann also auf alles zugreifen, was `app.js` definiert hat – sofern keins von beiden `async` oder `defer` trägt.

## Verbindungen

- [[p5.js ist Processing für den Browser]] – auch eine p5.js-Seite bindet Bibliothek und Sketch als zwei getrennte script-Tags ein
- [[Programmieren lernen]] – Strukturzettel, Abschnitt erste Schritte im Browser

## Quellen

- [[javascript.info – Hello, world!]]
