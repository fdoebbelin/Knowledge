## Spiellogik-Funktionen:

1. `erstelle_geheimcode(farben_anzahl, code_laenge)`: 
	- Generiert zufällig den geheimen Farbcode
2. `pruefe_rate_versuch(geheimcode, rateversuch)`: 
	- Vergleicht einen Rateversuch mit dem Geheimcode und gibt Feedback zurück
	- Berechnet wie viele Farben richtig und an richtiger Position sind (schwarze Stifte) 
		- und wie viele richtig aber falsch positioniert sind (weiße Stifte)
3. `ist_gewonnen(feedback, code_laenge)`: 
	- Prüft, ob alle Positionen korrekt geraten wurden

## Ein-/Ausgabe-Funktionen:

4. `erstelle_spielanleitung()`: 
	- Erklärt die Spielregeln
5. `erstelle_farbauswahl(farben)`: 
	- Zeigt verfügbare Farben an
6. `lies_rateversuch(farben, code_laenge)`: 
	- Liest Benutzereingabe für einen Rateversuch ein
7. `zeige_feedback(feedback)`: 
	- Zeigt das Feedback zu einem Rateversuch an
8. `zeige_spielbrett(versuche, feedbacks)`: 
	- Zeigt alle bisherigen Rateversuche und deren Feedback an
9. `zeige_ergebnis(gewonnen, versuche, geheimcode)`: 
	- Zeigt das Spielergebnis an

## Hilfsfunktionen:

10. `validiere_eingabe(eingabe, farben, code_laenge)`: 
	- Überprüft, ob die Eingabe, die von der Funktion `lies_rateversuch()` geliefert wird, gültig ist
## Hauptfunktion:

11. `spiele_mastermind()`: 
	- Steuert den Spielablauf und nutzt die oben definierten Funktionen

## Erweiterungsmöglichkeiten
Diese Implementierung kann in folgenden Bereichen erweitert werden:
1. **Farbige Ausgabe**: 
	- Die Konsolen-Ausgabe könnte mit Bibliotheken wie `colorama` farbig gestaltet werden.
2. **Schwierigkeitsgrade**: 
	- Verschiedene Schwierigkeitsgrade könnten eingeführt werden, indem die Anzahl der Farben oder die Codelänge variiert wird.
3. **Grafische Oberfläche**: 
	- Mit Bibliotheken wie `tkinter` oder `pygame` könnte eine grafische Benutzeroberfläche implementiert werden.
4. **Highscore**: 
	- Eine Funktion zum Speichern und Laden von Highscores könnte hinzugefügt werden.
