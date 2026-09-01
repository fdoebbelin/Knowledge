
| Kategorie                 | Befehl                   | Beschreibung                                       |
| ------------------------- | ------------------------ | -------------------------------------------------- |
| **Hilfe**                 | `h(elp)`                 | Hilfe anzeigen, ggf. zu einem Befehl (`help step`) |
| **Programmfluss**         | `c(ontinue)`             | Weiter bis nächster Breakpoint                     |
|                           | `s(tep)`                 | Nächste Zeile, *in* Funktion hinein                |
|                           | `n(ext)`                 | Nächste Zeile, Funktion überspringen               |
|                           | `r(eturn)`               | Bis Funktionsende laufen                           |
|                           | `unt(il)`                | Bis bestimmte Zeile oder nächster Breakpoint       |
|                           | `j(ump) N`               | Zur Zeile `N` springen                             |
| **Breakpoints**           | `b`                      | Breakpoints anzeigen                               |
|                           | `b N`                    | Breakpoint in aktueller Datei (Zeile `N`)          |
|                           | `b file.py:N`            | Breakpoint in Datei setzen                         |
|                           | `b func`                 | Breakpoint in Funktion                             |
|                           | `cl(ear)`                | Alle Breakpoints löschen                           |
|                           | `cl N` / `cl bpnum`      | Bestimmten Breakpoint löschen                      |
|                           | `disable N` / `enable N` | Breakpoint deaktivieren/aktivieren                 |
| **Stack & Code**          | `l(ist)`                 | Quellcode (10 Zeilen) anzeigen                     |
|                           | `ll`                     | Ganze Funktion anzeigen                            |
|                           | `w(here)` / `bt`         | Stacktrace                                         |
|                           | `u(p)` / `d(own)`        | Stack-Frame wechseln                               |
|                           | `a(rgs)`                 | Funktionsargumente anzeigen                        |
| **Variablen & Ausdrücke** | `p expr`                 | Ausdruck auswerten                                 |
|                           | `pp expr`                | Ausdruck „pretty printen“                          |
|                           | `!stmt`                  | Python-Code ausführen                              |
|                           | `display expr`           | Ausdruck bei jedem Stopp anzeigen                  |
|                           | `undisplay N`            | Automatische Anzeige abschalten                    |
|                           | `retval`                 | Rückgabewert letzter Funktion                      |
| **Bedingte Breakpoints**  | `b N, if cond`           | Breakpoint bei Bedingung (`x > 10`)                |
| **Sonstiges**             | `interact`               | Interaktive Python-Shell starten                   |
| **Beenden**               | `q(uit)` / `exit`        | Debugger & Programm beenden                        |
