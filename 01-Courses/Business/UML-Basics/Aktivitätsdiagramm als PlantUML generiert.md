Hier ist ein Beispiel für ein UML-Aktivitätsdiagramm in PlantUML-Syntax, das einen einfachen Bestellprozess darstellt:

```plantuml
@startuml
start

:Bestellung erhalten;
if (Artikel auf Lager?) then (Ja)
  :Artikel verpacken;
  :Versand vorbereiten;
else (Nein)
  :Benachrichtigung an Kunden senden;
endif

if (Bezahlung erfolgreich?) then (Ja)
  :Bestellung abschließen;
  :Rechnung senden;
else (Nein)
  :Bestellung stornieren;
endif

stop
@enduml
```

Du kannst dieses Diagramm in einem PlantUML-Editor oder einer kompatiblen Anwendung rendern, um es visuell darzustellen. Lass mich wissen, falls du weitere Anpassungen oder ein komplexeres Diagramm benötigst!