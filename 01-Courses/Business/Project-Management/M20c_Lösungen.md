## Vorwort für Teilnehmer

Die folgenden Lösungen sind **Musterlösungen**. Im Projektmanagement gibt es selten nur "die eine richtige" Antwort. Es kommt oft darauf an, wie Sie Ihre Entscheidung begründen. Diese Lösungen zeigen Ihnen, wie eine professionelle Herangehensweise für einen Fachinformatiker aussieht.

Achten Sie besonders auf die **Kommentarboxen**. Hier erkläre ich, *warum* eine Lösung so gewählt wurde.

---

## LÖSUNG ZU AUFGABE 1: Projektstart & Stakeholder

### 1.1 Stakeholder-Analyse

**Musterlösung:**

| Stakeholder | Interesse (Was wollen sie?) | Macht | Befürchtung (Risiko) | Strategie |
|---|---|---|---|---|
| **Geschäftsführer** | Will Effizienz, weniger Kosten, ROI (Return on Investment). | **Hoch** | Dass das Projekt teurer wird als 80.000 EUR. | Eng einbinden, regelmäßig über Kosten berichten. |
| **IT-Leiter** | Will ein stabiles System, wenig Wartungsaufwand. | **Mittel** | Dass das System technisch schlecht ist oder Sicherheitslücken hat. | Als technischen Experten nutzen, früh Tests machen lassen. |
| **Lagerarbeiter** | Wollen einfache Bedienung, Arbeitsplatzsicherheit. | **Niedrig** (aber wichtig für Erfolg!) | Dass sie den Job verlieren oder die Software zu kompliziert ist. | Schulung anbieten, Ängste ernst nehmen ("Change Management"). |
| **Externer Berater** | Will den Auftrag erfolgreich abschließen und bezahlt werden. | **Mittel** | Unklare Anforderungen vom Kunden, späte Bezahlung. | Klare Verträge, regelmäßige Meetings. |

> **Experten-Kommentar:**
> Viele Anfänger unterschätzen die "kleinen" Stakeholder wie die Lagerarbeiter.
> *Warum ist das gefährlich?* Wenn die Lagerarbeiter die Software boykottieren oder falsch bedienen, nützt die beste Technik nichts. Das Projekt scheitert in der Praxis, obwohl die Software läuft. Daher ist die **Akzeptanz der Nutzer** ein kritischer Erfolgsfaktor.

### 1.2 Projektauftrag (Project Charter)

**Musterlösung:**

**Projektname:** RetailPro Digital 2.0

**Projektziel (SMART):**
Einführung und Inbetriebnahme des ERP-Systems "EasyStore" bis zum **30.10.2025**, wobei alle Lager- und Verkaufsprozesse digitalisiert werden und die Fehlerquote bei Bestandsbuchungen um **mindestens 50%** gegenüber dem Vorjahr sinkt.

**Projektumfang (Scope):**
*   **In-Scope (Machen wir):** Installation Software, Migration der Kundendaten, Schulung der 50 Mitarbeiter, Kauf von 5 neuen Handscannern.
*   **Out-of-Scope (Machen wir NICHT):** Neugestaltung der Webseite, Anbindung der Buchhaltung (kommt erst in Phase 2), Austausch aller PC-Arbeitsplätze.

**Budget-Verteilung (Schätzung):**
*   Lizenzen: 30.000 EUR
*   Beratung/Installation (Extern): 30.000 EUR
*   Hardware (Scanner): 5.000 EUR
*   Schulung: 5.000 EUR
*   Puffer (Reserve): 10.000 EUR

> **Experten-Kommentar:**
> *Warum ist "Out-of-Scope" so wichtig?*
> In IT-Projekten passiert oft das sogenannte **Scope Creep** (schleichende Umfangserweiterung). Jemand sagt: "Können wir nicht auch noch gleich die Webseite neu machen?". Wenn Sie im Auftrag nicht klar definiert haben, dass das *nicht* dazugehört, wird Ihr Projekt immer größer, aber Budget und Zeit bleiben gleich. Das führt zum Scheitern.
> *Zum Budget:* Ein Puffer von 10-15% ist Standard und lebensnotwendig für unvorhergesehene Probleme.

---

## LÖSUNG ZU AUFGABE 2: Planung

### 2.1 Projektstrukturplan (PSP / WBS)

**Musterlösung (Hierarchisch):**

1.  **Phase: Vorbereitung & Analyse**
    *   1.1 Ist-Analyse der aktuellen Prozesse
    *   1.2 Erstellung Lastenheft (Anforderungen)
    *   1.3 Auswahl des Software-Anbieters

2.  **Phase: Technische Umsetzung**
    *   2.1 Server und Netzwerk vorbereiten (Infrastruktur)
    *   2.2 Installation ERP-Basis-System
    *   2.3 Anpassung (Customizing) der Software
    *   2.4 Datenmigration (Altdaten importieren)

3.  **Phase: Qualität & Rollout**
    *   3.1 Funktionstests durch IT
    *   3.2 User Acceptance Test (Test durch Benutzer)
    *   3.3 Schulung der Mitarbeiter
    *   3.4 Go-Live (Systemstart)

> **Experten-Kommentar:**
> Der PSP ist das Herzstück der Planung. Er muss **vollständig** sein. Was hier fehlt, wird später vergessen und verursacht Kosten.
> *Tipp für Fachinformatiker:* Trennen Sie technische Aufgaben (Installation) von organisatorischen (Schulung). Beides ist Arbeit, beides kostet Zeit.

### 2.2 Zeitplan (Gantt) & Kritischer Pfad

**Lösungshinweis:**

1.  **Reihenfolge:** Erst muss die Hardware da sein, bevor installiert werden kann. Erst muss installiert sein, bevor geschult werden kann.
2.  **Parallel:** Während die IT den Server installiert (2.1), kann die Personalabteilung schon die Schulungsunterlagen erstellen (Teil von 3.3). Das spart Zeit.
3.  **Kritischer Pfad:** Das ist die längste Kette von Aufgaben.
    *   *Beispiel:* Hardware bestellen -> Liefern -> Installieren -> Konfigurieren -> Testen.
    *   Wenn sich die Lieferung verzögert, verzögert sich alles nach hinten.

**Antwort zur Diskussionsfrage:**
*Wenn sich die Hardware-Lieferung um 2 Wochen verzögert...*
*Antwort:* **Ja**, das Projektende verschiebt sich wahrscheinlich, **WENN** die Hardware-Installation auf dem Kritischen Pfad liegt (was meistens der Fall ist). Man kann nicht installieren, ohne Hardware zu haben.

> **Experten-Kommentar:**
> Viele Projektleiter versuchen, Zeit aufzuholen, indem sie Aufgaben parallel machen, die eigentlich nacheinander gehören (z. B. schon schulen, obwohl die Software noch nicht fertig konfiguriert ist). Das führt oft zu Verwirrung und muss später doppelt gemacht werden.

---

## LÖSUNG ZU AUFGABE 3: Risiken & Qualität

### 3.1 Risikoanalyse

**Musterlösung:**

| Risiko (Wenn... dann...) | Wahrscheinlichkeit | Schaden | Maßnahme |
|---|---|---|---|
| **Wenn** die Altdaten (Excel) sehr fehlerhaft sind, **dann** dauert der Import viel länger. | Mittel | Hoch | **Vermindern:** Frühzeitig (jetzt!) eine Datenanalyse machen und Daten bereinigen, bevor das Projekt richtig startet. |
| **Wenn** der Haupt-Entwickler krank wird, **dann** steht die Entwicklung still. | Mittel | Mittel | **Vermeiden/Vermindern:** Dokumentation erzwingen, damit ein anderer übernehmen kann. Ggf. zweiten Entwickler einplanen. |
| **Wenn** die Hardware teurer wird, **dann** reicht das Budget nicht. | Niedrig | Niedrig | **Akzeptieren:** Wir haben einen Puffer von 10.000 EUR eingeplant. |

> **Experten-Kommentar:**
> Risikomanagement ist proaktiv. Man wartet nicht, bis es knallt.
> Besonders bei **Datenmigrationen** wird der Aufwand fast immer unterschätzt. "Clean your data first" ist eine wichtige Regel.

### 3.2 Qualitätssicherung (Abnahmekriterien)

**Musterlösung:**

1.  **Funktional:** "Das System muss in der Lage sein, einen Wareneingang in unter 30 Sekunden zu verbuchen (gemessen mit Stoppuhr)."
2.  **Technisch:** "Das System muss stabil laufen (Verfügbarkeit 99,5%) und Backups müssen automatisch jede Nacht laufen und wiederherstellbar sein."

> **Experten-Kommentar:**
> Kriterien müssen **testbar** sein.
> Schlecht: "Das System soll schnell sein." (Was ist schnell?)
> Gut: "Das System muss unter 2 Sekunden antworten."
> Als Fachinformatiker müssen Sie auf solche messbaren Anforderungen bestehen, sonst sagt der Kunde am Ende immer "Ist mir zu langsam".

---

## LÖSUNG ZU AUFGABE 4: Steuerung (Change Request)

**Szenario:** Lagerleiter will noch "Mobiles Drucken" haben.

**Lösungsweg:**

1.  **Nicht einfach "Ja" sagen!** Das wäre der Tod des Zeitplans.
2.  **Prüfung (Impact Analysis):**
    *   *Zeit:* Schaffen wir das noch bis zum 30.10.? (Wahrscheinlich dauert es 2 Wochen extra).
    *   *Kosten:* Brauchen wir neue Drucker? Programmieraufwand? (Kostet ca. 3.000 EUR).
    *   *Risiko:* Wird das System dadurch instabil?
3.  **Empfehlung:**
    *   *Option A:* Wir machen es, aber der Go-Live verschiebt sich um 2 Wochen.
    *   *Option B (Besser):* Wir nehmen den Wunsch auf, verschieben ihn aber auf "Phase 2" (nach dem Weihnachtsgeschäft), um den jetzigen Termin nicht zu gefährden.

> **Experten-Kommentar:**
> Ein Projektleiter ist ein "Gatekeeper" (Türsteher). Sie schützen das Projekt vor unkontrollierten Änderungen. Die beste Antwort ist oft: "Gute Idee, machen wir gerne – aber erst nach dem ersten Go-Live."

---

## LÖSUNG ZU AUFGABE 5: Abschluss (Lessons Learned)

**Musterlösung (Gute Fragen für das Team):**

1.  "Was haben wir bei der Zeitschätzung gelernt? Wo lagen wir total daneben und warum?"
2.  "Wie gut war die Zusammenarbeit mit den externen Beratern? Würden wir sie wieder buchen?"
3.  "Welche technischen Probleme hätten wir vermeiden können, wenn wir sie früher bemerkt hätten?"

> **Experten-Kommentar:**
> *Lessons Learned* dienen nicht dazu, Schuldige zu suchen ("Wer hat es verbockt?"), sondern dazu, als Organisation schlauer zu werden ("Wie verhindern wir den Fehler beim nächsten Mal?"). Das nennt man **Fehlerkultur**.

---
**Ende des Moduls**
Sie haben nun einmal den kompletten Zyklus eines IT-Projekts durchdacht. Nehmen Sie diese Denkweise ("Erst planen, dann bauen, Risiken beachten") mit in Ihre berufliche Praxis!
