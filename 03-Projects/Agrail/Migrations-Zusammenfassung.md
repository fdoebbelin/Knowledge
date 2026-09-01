---
title: "Migrations-Zusammenfassung — chaji & agrail"
erstellt: 2026-05-06
projekt: "agrail · chaji · Aufgussplan-Vault"
zweck: "Strukturierter Projekt-Snapshot für Wiederaufnahme oder Übergabe"
---

# Migrations-Zusammenfassung — chaji & agrail

Kurz vorab: Das Projekt verbindet eine philosophisch-kuratierte Website (agrail.de), eine PWA für Gong-Fu-Cha-Sessions (chaji), eine wachsende Sammlung standardisierter Aufgusspläne im Obsidian-Vault und einen Grav-Blog. Alle Dosierangaben beziehen sich ab sofort auf das 150 ml Profi Tea Taster Set. Aufgusspläne werden aus dem Projekt-Template abgeleitet und vor Übernahme um Template-Header und Dataview-Installations­hinweise gekürzt — die Plan-Datei beginnt mit einer kurzen Zusammenfassung im `> [!summary]`-Callout.

---

## Project Purpose

Fritz-Rainer baut ein integriertes Gong-Fu-Cha-Ökosystem aus drei aufeinander bezogenen Säulen:

**agrail.de** — philosophische Landing Page, organisiert um das Akronym A.G.R.A.I.L. (Achtsamkeit, Genuss, Ritual, Aufguss, Intention, Langsamkeit). Designsystem: Cormorant Garamond + Noto Serif SC, JetBrains Mono für UI; Palette dunkelbraun/gold (`--bg-deep: #0e0a07`, `--gold: #b8943f`, `--cream: #e8dcc8`); 道-Watermark im Hero.

**chaji** (茶事, chaji.agrail.de) — PWA-Sessionbegleiter, Vanilla HTML/CSS/JS mit ES-Modulen, IndexedDB für Persistenz, Service Worker für Offline-Betrieb, optimiert für iPhone 13 mini. In Migration von v1 (hardcodiertes `teas.js`) zu v2, wo Obsidian-Markdown-Aufgusspläne mit YAML-Frontmatter zur kanonischen Datenquelle werden.

**Aufgussplan-Vault** — Obsidian-basierte Sammlung standardisierter Brüh­dokumente (YAML-Frontmatter + DataviewJS-Tabellen + Prosa). Diese Dateien sind gleichzeitig persönliches Brauhandbuch, Datenquelle für die App und Vorlage für PDF-Export und Blog-Artikel.

Dazu **agrail.blog** auf Grav CMS (all-inkl, Auto-Deploy via Git Bare Repo + post-receive Hook), und eine begleitende Selbstbeobachtungs­praxis mit Kardia Mobile EKG und Kubios-HRV-Analyse.

---

## Custom Instructions (verbatim)

Aus der aktuellen Nachricht:

> Alle Dosierangaben sollen sich ab jetzt auf das 150ml Profi Teataster Set beziehen.

> Die Aufgusslisten für Gong Fu Cha werden als Obsidian-Markdown-Dateien über das im Projekt hinterlegte Template.

> Im abgeleiteten Aufgussplan werden die Verweise auf das Template entfernen auch ohne die Hinweise auf die Installation des dataview-plugin, wir beginnen mit einer kurzen Zusammenfassung.

Bestand davor: Anweisung "Alle Dosierangaben für Tee beziehen sich auf das 150ml Profi Tea Taster Set (nicht auf 250ml oder andere Gefäße)" war bereits im Memory.

---

## Key Decisions and Outcomes

**Sammlungsregel (chaji)**: Synthetisch aromatisierte Tees sind ausgeschlossen — sie peaken nach 1–2 Aufgüssen und passen nicht zu Gong Fu Cha. Traditionell beduftete (Hua Cha, Jasmin Perlen) und traditionell co-gereifte Tees (Xiao Qing Gan) sind kategoriell anders und gehören dazu. Weißer Mangotraum daher explizit ausgeschlossen.

**Dosierungs-Anker**: 150 ml Profi Tea Taster Set ist Referenzgefäß. TEZEN-Hinweise "pro Tasse" sind auf TEZENs 150-ml-Vessel kalibriert, nicht auf 250-ml-Tassen.

**Aufguss-2-Verkürzung** bei kompakten/dichten Blattformen (Mini Tuo, Bi Luo Chun, Jasmin Perlen, Tie Guan Yin, Houjicha): Aufguss 2 ist absichtlich kürzer als Aufguss 1 wegen beschleunigter Extraktion aus teilgeöffneten Blättern bzw. oberflächennaher Maillard-Produkte. Kyobancha bricht diese Regel — gleichmäßig ansteigende Sequenz, weil Röstcharakter strukturell, nicht oberflächlich ist.

**Waschaufguss-Mythos**: Ein 30-Sekunden-Rinse entfernt nur ~9 % des Koffeins (Hicks/Hsieh/Bell 1996). Der Waschaufguss hat seine Berechtigung (Rehydration, Öffnen kompakter Profile), ist aber **kein** Entkoffeinierungs­werkzeug. Bei vielen Tees daher entfallen — explizit dokumentiert.

**Gabalong-Logik**: GABA extrahiert zu ~80 % im ersten kurzen Aufguss; Koffein nur 10–15 %. Daher: Kaltextraktion als Aufguss 0, niemals wegschütten, niedrige Temperatur (65–70 °C bei Sencha-Basis, 80–85 °C bei Oolong-Basis).

**Xiao Qing Gan-Technik**: Schwanenhalskessel zwingend; Wasser durch die Mandarinenöffnung (~8–12 mm), niemals außen über die Schale.

**Abendrepertoire-Kern**: Houjicha > Shou Pu Erh > Bancha; Kukicha und gealterter Sheng als sinnvolle Ergänzung. Physiologische Effekte von Atemführung und Thermoregulation sind mindestens so wirksam wie die Pharmakologie.

**Stack-Entscheidungen**: Grav statt WordPress (flat-file, kein DB). Vanilla JS statt Framework. Obsidian als Editor für Vault und Blog. Helix für Twig/YAML. Nushell als Shell. WebStorm explizit ausgeschlossen. Aider mit lokalem Qwen2.5-Coder:32b für Parser-Arbeit, Claude Code für Multi-File-Refactors und Deployment.

**Geräte-Entscheidung (anstehend)**: RHD Heißwasserspender wurde gegenüber TIMEMORE Fish Smart als besser passend identifiziert — größere Kapazität (~6 Aufgüsse ohne Nachfüllen), längere Warmhaltung, Memory-Funktion beim Anheben. Kauf noch nicht abgeschlossen.

---

## Work in Progress

**chaji v2 Migration**: Architektur-Plan steht (parser.js + teaDB.js als neue Module, teas.js als Fallback, Service-Worker-Cache erweitert um `/aufguesse/`, CLAUDE.md-Template angelegt). Parser-Implementierung ist der nächste konkrete Schritt — Aider mit lokalem Modell ist dafür vorbereitet.

**Per-Tee-CSS-Theming**: YAML-Feld `farben.primär` soll als CSS Custom Property pro geöffnetem Tee gesetzt werden. Folgearbeit nach Parser.

**Aufgussplan-Erweiterungen**: Lücken im Oolong-Bereich identifiziert (kein Dong Ding, wenig Yancha außer Da Hong Pao). Gealterter Sheng (15+ Jahre, Bing Cha) und Kukicha als sinnvolle Sammlungs­ergänzungen markiert. Manßhardt Teehandel und Tee-Kontor Kiel werden für Pu-Erh- und Oolong-Kandidaten ausgewertet.

**Equipment**: Schwanenhalskessel-Kauf steht aus (RHD favorisiert).

**agrail.de**: Landing Page fertig; Impressum-Modal mit § 5 DDG juristisch sauber. Blog auf Grav läuft, Auto-Deploy funktioniert, Eröffnungspost "Eine erste Schale" geschrieben. Eigenes agrail-Theme noch im Aufbau (Twig-Templates und CSS aus der Landing Page übernehmen).

---

## Knowledge Base Contents

In `/mnt/project/`:

**Template & Schema** — `Aufgussplan-Template.md` (kanonische Vorlage mit YAML-Frontmatter, DataviewJS-Blöcken, Prosa­abschnitten; Beispiel: Bai Mu Dan Bio).

**Fertige Aufgusspläne** — Bio Sencha Gabalong, Bergamotte Oolong Formosa, New Earl Grey of Grey, Earl Green, Kaiserliche Jasmin Perlen, Yunnan Black, Lapsang Souchong, Huoshan Huangya, Bio Shou Pu Erh Mini Tuo, Houjicha Traditionell, Xiaoqing Mandarine, Kyobancha. Frühere Pläne (Bi Luo Chun, Sencha Sommersonne, Bai Mu Dan, Genmaicha, Moonlight White, GABA Oolong, Darjeeling Ambootia FF) sind im Vault, nicht alle in `/mnt/project/`.

**Hintergrundtexte** — `Abendlicher_Gong_Fu_Cha__Tee-Auswahl_und_Bruehpraxis_jenseits_des_Stimulanz-Paradigm.md` (Recherche­grundlage für Abendpraxis), `Bergamotte-Vergleich-Gruen-Schwarz-Oolong.md` (Drei-Sorten-Vergleich), `Gabalong-Zusammenfassung.md` und `Gabalong-Gong-Fu-Cha-Aufgussliste.md` und `Gabalong-Anbieter-DACH.md` (vollständige GABA-Domäne).

**Workflow** — `agrail-blog-workflow.md` (10-Phasen-Anleitung Grav auf all-inkl).

**Inventar** — `sortenliste1.txt` (TEZEN-Bestand, 20 Sorten, Stand März 2026).

**PDF-Exemplar** — `BaiMuDanBioGongFuCha.pdf` (Beispiel-Layout für PDF-Export aus Aufgussplan).

---

## Recurring Context

**Person**: Fritz-Rainer, 68, fortgeschrittener Gong-Fu-Cha-Praktiker, deutsche Sprache als Standard für Tee-Domäne, technische Doku darf gemischt sein. Aktive Wellness-Praxis (Yoga, Entspannung, Tongue Drum). Selbst­beobachtung mit Kardia Mobile EKG und Kubios HRV.

**Lieferanten**: TEZEN (primär), Tee-Kontor Kiel (sekundär; auch Quelle für ZU1726-Bambus-Chá-Dào-Set), Manßhardt Teehandel / darjeelingtee.de (für Pu Erh und Oolong-Erweiterungen evaluiert).

**Brühgefäß**: 150 ml Profi Tea Taster Set (Brühbecher mit Deckel + Tasse) ist die Referenz.

**Plattform**: CachyOS-Laptop (Entwicklung), iPhone 13 mini (chaji-Zielgerät). Editor-Stack: Obsidian (Vault), Helix (Twig/YAML/Code), keine JetBrains-Tools.

**Arbeitsmuster**: Schema­getriebene Integration neuer Tees ins etablierte Template, niemals ad hoc. Iterative Verfeinerung nach erstem funktionierenden Artefakt. Vibe-Coding-Workflow (Architect Mode mit Claude als Planner, lokales Modell als Coder). Philosophisch-substanziell statt kommerziell für öffentliche Inhalte.

**Domain-Vokabular** (oft wiederkehrend): Aufguss / Aufgussplan, Hui Gan, Cha Qi, Maillard, Pyrazine, L-Theanin, Catechine, GABA, Men Huang, Wo Dui, Schwanenhalskessel, Mini Tuo, Hua Cha, Sheng / Shou, Bing Cha, Maocha.

**Bekannte Stolpersteine**: DataviewJS `===` kollidiert mit Dataview-Inline-Field-Parsing (in Doku­dateien durch HTML-Kommentare ersetzen, in echten Plan­dateien ist `===` unproblematisch). `php bin/grav install` meldet bei ZIP-Installation einen scheinbaren Fehler (vendor/ schon vorhanden — harmlos). Dataview-Plugin auf CachyOS-AppImage-Obsidian erfordert manuelle curl-Installation.

---

## Recommended Starting Prompt

Für die Wiederaufnahme in einem neuen Chat oder einer neuen Projekt­instanz:

> Ich arbeite an meinem integrierten Gong-Fu-Cha-Ökosystem (agrail.de Website, chaji PWA, Obsidian-Aufgussplan-Sammlung, Grav-Blog). Das Projekt enthält Migrations-Zusammenfassung, Template, fertige Aufgusspläne und Workflow-Dokumentation. Bitte les die Migrations-Zusammenfassung ein, bestätige die wichtigsten Konventionen (150 ml Profi Tea Taster als Referenzgefäß, Aufgusspläne aus dem Template ohne Template-Header und ohne Dataview-Installations­hinweise, kurze Zusammenfassung als Einstieg, deutsche Tee-Domäne) und sag mir kurz, was du vor dir hast. Dann nenne ich dir die nächste Aufgabe — typisch: neuer Aufgussplan für eine konkrete Sorte, chaji-Parser-Arbeit, Blog-Post, oder Sammlungs­erweiterung.

---

*Erstellt am 6. Mai 2026 · Stand: chaji v2 in Migration, agrail.de live, Blog läuft, Vault wächst*
