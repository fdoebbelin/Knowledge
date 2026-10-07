> [!missing] Bild nicht im Vault
> Die ursprüngliche Bilddatei `Pasted image 20250116094652.png` fehlt. Das Diagramm steht unten als Mermaid-Block und wird von Obsidian gerendert.

Hier ist ein aussagekräftiges UML-Aktivitätsdiagramm, das einen komplexen Prozessablauf darstellt. Lass mich wissen, ob es weitere Anpassungen geben soll!


```mermaid
graph LR
    A[Bestellung aufgeben] --> B{Produkt verfügbar?}
    B -- Ja --> C[Versand vorbereiten]
    B -- Nein --> D[Benachrichtigung über Verzögerung]
    C --> E[Versand durchführen]
    D --> F[Kunden informieren]
    E --> G[Bestellung abgeschlossen]
    F --> G
```
