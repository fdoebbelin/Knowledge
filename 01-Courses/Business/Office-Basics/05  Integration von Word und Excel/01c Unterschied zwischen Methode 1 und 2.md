### Methode 1: Einfügen der Excel-Tabelle als eingebettetes Objekt

**Vorgehensweise:**

- Die Excel-Tabelle wird als eingebettetes Objekt direkt in das Word-Dokument eingefügt.
- Die Daten werden direkt in das Word-Dokument kopiert und als Teil des Dokuments gespeichert.

**Vorteile:**

- **Autonomie**: Die eingebettete Tabelle wird unabhängig von der ursprünglichen Excel-Datei gespeichert. Das bedeutet, dass das Word-Dokument alle benötigten Daten enthält und ohne die Excel-Datei eigenständig ist.
- **Bearbeitung in Word**: Sie können die eingebettete Tabelle direkt in Word bearbeiten. Doppelklicken Sie auf die Tabelle, um sie zu bearbeiten, als ob Sie in Excel arbeiten würden.
- **Portabilität**: Da die Tabelle im Word-Dokument selbst gespeichert ist, wird sie beim Verschieben oder Versenden des Word-Dokuments nicht von der Verfügbarkeit der ursprünglichen Excel-Datei beeinflusst.

**Nachteile:**

- **Speicherplatz**: Die Größe des Word-Dokuments kann zunehmen, da die Excel-Daten vollständig integriert sind.
- **Keine automatische Aktualisierung**: Änderungen an der ursprünglichen Excel-Datei wirken sich nicht auf die eingebettete Tabelle im Word-Dokument aus. Sie müssen die Tabelle manuell aktualisieren.

### Methode 2: Einfügen der Excel-Tabelle als verknüpfte Tabelle

**Vorgehensweise:**

- Die Excel-Tabelle wird als verknüpftes Objekt in das Word-Dokument eingefügt.
- Das Word-Dokument enthält einen Link zur ursprünglichen Excel-Datei und zeigt die Daten an, die dort gespeichert sind.

**Vorteile:**

- **Automatische Aktualisierung**: Änderungen an der Excel-Datei werden automatisch im Word-Dokument aktualisiert. Dies ist besonders nützlich, wenn sich die Daten häufig ändern.
- **Speicherplatz**: Das Word-Dokument bleibt relativ klein, da es die Daten nicht speichert, sondern nur einen Link zur Excel-Datei enthält.

**Nachteile:**

- **Abhängigkeit**: Das Word-Dokument ist abhängig von der Verfügbarkeit der Excel-Datei. Wenn die Excel-Datei verschoben, umbenannt oder gelöscht wird, kann Word die verknüpfte Tabelle nicht mehr aktualisieren.
- **Bearbeitung**: Sie können die verknüpfte Tabelle nicht direkt in Word bearbeiten. Um Änderungen vorzunehmen, müssen Sie die Excel-Datei bearbeiten.

### Zusammenfassung der Unterschiede

| Eigenschaft                        | Eingebettetes Objekt                                    | Verknüpfte Tabelle                                      |
|------------------------------------|--------------------------------------------------------|--------------------------------------------------------|
| Speicherort der Daten              | Im Word-Dokument                                       | In der ursprünglichen Excel-Datei                      |
| Abhängigkeit von Excel-Datei       | Unabhängig                                             | Abhängig                                               |
| Automatische Aktualisierung        | Nein                                                   | Ja                                                     |
| Bearbeitung                        | Direkt in Word                                         | Nur in Excel                                           |
| Speicherplatz im Word-Dokument     | Größer                                                 | Kleiner                                                |
| Portabilität                       | Hohe (Dokument ist eigenständig)                       | Geringer (verknüpfte Datei muss verfügbar sein)        |

### Beispiel für die Verwendung:

- **Einfügen als eingebettetes Objekt**: Nützlich, wenn Sie sicherstellen möchten, dass alle Daten in einem einzigen Dokument vorhanden sind und es keine Änderungen an der ursprünglichen Excel-Datei geben wird.
- **Einfügen als verknüpfte Tabelle**: Ideal, wenn die Excel-Daten regelmäßig aktualisiert werden und Sie sicherstellen möchten, dass das Word-Dokument immer die neuesten Daten anzeigt.