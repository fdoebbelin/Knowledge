## Übersicht

Dieses Dokument enthält detaillierte Lösungen zu allen Aufgaben mit fachlichen Kommentaren und Tipps zur Fehlerprävention.

---

## Lösung Aufgabe 1: Kostenestimation – Top-Down vs. Bottom-Up

### 1a) Top-Down-Schätzung – Lösungen

| Kostengruppe | Anteil (%) | Betrag (EUR) |
|--------------|-----------|--------------|
| Softwarelizenz und Implementierung | 40% | **200.000** |
| Personalkosten (interne Teams) | 35% | **175.000** |
| Hardware und Infrastruktur | 10% | **50.000** |
| Schulung und Change Management | 10% | **50.000** |
| Unvorhergesehenes (Reserve) | 5% | **25.000** |
| **Gesamtbudget** | **100%** | **500.000** |

**Berechnung Beispiel:**
- Softwarelizenz: 500.000 EUR × 40% = 200.000 EUR
- Personalkosten: 500.000 EUR × 35% = 175.000 EUR
- usw.

> **Kommentar:** Die Top-Down-Schätzung ist schnell und für frühe Projektphasen geeignet. Der große Nachteil: Sie ist oft zu pauschalisiert und kann wichtige Kostendetails übersehen. Bei diesem Ansatz sollte man konservativ kalkulieren, da typischerweise Überraschungen auftauchen.

### 1b) Bottom-Up-Schätzung – Lösung

| Position | Einheit | Menge | EUR/Einheit | Gesamtkosten |
|----------|---------|--------|-------------|--------------|
| Softwarelizenz (3 Jahre) | Lizenz | 1 | 120.000 | **120.000** |
| Implementierungsberatung (50 Tage) | Tage | 50 | 1.200 | **60.000** |
| Projektmanagement (12 Monate) | PM (50% FTE) | 12 | 6.000 | **72.000** |
| Systemadministrator (6 Monate full-time) | Monate | 6 | 8.000 | **48.000** |
| Hardware (20 Workstations) | Workstations | 20 | 2.500 | **50.000** |
| Schulung (2 Trainer, 5 Tage) | Trainer-Tage | 10 | 1.500 | **15.000** |
| **Summe Direkte Kosten** | | | | **365.000** |
| **Overhead (15% von direkte Kosten)** | | | | **54.750** |
| **Geschätztes Gesamtbudget** | | | | **419.750** |

**Vergleich Top-Down vs. Bottom-Up:**

| Methode | Geschätztes Budget | Differenz |
|---------|-------------------|----------|
| Top-Down | 500.000 EUR | +80.250 EUR (19,1%) |
| Bottom-Up | 419.750 EUR | – |

**Differenzanalyse:**
Die Top-Down-Schätzung liegt um ca. 19% über Bottom-Up. Dies kann mehrere Gründe haben:
- Reserve im Top-Down-Ansatz (5% unvorhergesehenes)
- Overhead-Sätze zu hoch angesetzt in Bottom-Up
- In der Praxis oft Mittelwert nehmen: (500.000 + 419.750) / 2 ≈ 460.000 EUR

> **Tipps zur Fehlerprävention:**
> - **Tipp 1:** Top-Down und Bottom-Up sollten konvergieren. Starke Abweichungen sind ein Warnsignal.
> - **Tipp 2:** Bottom-Up-Schätzungen sollten auf realen Stundensätzen und Erfahrungswerten basieren, nicht auf Optimismus.
> - **Tipp 3:** Overhead-Sätze von 10–20% sind typisch; 15% ist ein guter Erfahrungswert.

### 1c) Reserve und Puffer – Lösung

**Berechnung:**
- **Direkte + indirekte Kosten:** 419.750 EUR
- **Eventualreserve (10%):** 419.750 × 10% = **41.975 EUR**
- **Managemenreserve (5%):** 419.750 × 5% = **20.988 EUR**
- **Finales Projektbudget:** 419.750 + 41.975 + 20.988 = **482.713 EUR**

**Alternativer Ansatz (Basebudget ohne Overhead + Puffer):**
- Direkte Kosten: 365.000 EUR
- Overhead: 54.750 EUR
- Eventualreserve (12% für erkannte Risiken): 365.000 × 12% = 43.800 EUR
- Managemenreserve (8% für unbekannte Risiken): 365.000 × 8% = 29.200 EUR
- **Gesamtbudget:** 502.750 EUR

> **Kommentar:** Puffer sind essentiell! Statistisch treten in ca. 70% der Projekte Kostenüberläufe auf. Erfahrung zeigt: 10–15% Gesamtpuffer ist eine realistische Annahme. Möglich auch: 5% für niedrig-riskante Projekte, bis 25% für hochriskante Vorhaben. In YouTrack können Sie diese Reserven als separate Epics tracken, um Transparenz zu schaffen.

---

## Lösung Aufgabe 2: ROI und Rentabilitätskennzahlen

### 2a) ROI-Berechnung (einfaches Modell)

**Gegebene Daten (zur Erinnerung):**
- Initialinvestition: 800.000 EUR
- Jährliche Kosteneinsparungen: 250.000 EUR
- Zusätzliche Vorteile (ab Jahr 2): 50.000 EUR/Jahr
- Betriebskosten (OPEX): 30.000 EUR/Jahr

**Schritt 1: Gesamter Nutzen über 5 Jahre**
- Kosteneinsparungen: 250.000 EUR × 5 = 1.250.000 EUR
- Zusätzliche Vorteile (4 Jahre, ab Jahr 2): 50.000 EUR × 4 = 200.000 EUR
- **Zwischensumme Gesamtnutzen = 1.450.000 EUR**

**Schritt 2: Gesamte Betriebskosten über 5 Jahre**
- OPEX: 30.000 EUR × 5 = 150.000 EUR

**Schritt 3: Nettonutzen**
- Nettonutzen = 1.450.000 – 150.000 = 1.300.000 EUR

**Schritt 4: ROI-Berechnung**
$$
\text{ROI} = \frac{1.300.000 - 800.000}{800.000} \times 100\% = \frac{500.000}{800.000} \times 100\% = 62,5\%
$$

**ROI = 62,5%** (über 5 Jahre)

**Berechnung pro Jahr durchschnittlich:**
- Durchschnittlicher jährlicher ROI = 62,5% / 5 = 12,5% p.a.

> **Interpretation & Kommentar:**
> Ein ROI von 62,5% über 5 Jahre entspricht durchschnittlich ca. 12,5% pro Jahr – das ist **solide rentabel**. Typische Unternehmenshürden liegen bei 10–15% jährlich. Das Projekt erfüllt dieses Kriterium.
>
> **Häufiger Fehler:** ROI wird oft als einfache jährliche Quote verwechselt. In diesem Fall gibt ROI von 62,5% **Gesamtertrag über 5 Jahre** an, nicht jährlich!

### 2b) Payback-Period – Lösung

| Jahr | Jährlicher Nettofluss (EUR) | Kumuliert (EUR) |
|------|---------------------------|-----------------|
| 0 | -800.000 | -800.000 |
| 1 | 250.000 - 30.000 = 220.000 | -580.000 |
| 2 | 250.000 + 50.000 - 30.000 = 270.000 | -310.000 |
| 3 | 270.000 | -40.000 |
| 4 | 270.000 | +230.000 ✓ Break-Even |
| 5 | 270.000 | +500.000 |

**Berechnung des Break-Even-Zeitpunkts (genauer):**
- Nach Jahr 3: Kumuliert = -40.000 EUR
- Im Jahr 4: Einnahmen = 270.000 EUR
- Anteil des Jahres bis Break-Even: 40.000 / 270.000 ≈ 0,148 Jahre ≈ 1,8 Monate

**Payback-Period = 3 Jahre und ca. 2 Monate**

> **Kommentar:** Eine Payback-Period von knapp 3 Jahren ist typisch für technische Investitionen. Im Industrie-Standard werden Payback-Periods unter 4 Jahren als gut eingestuft. Je kürzer die Payback-Period, desto niedriger das Risiko (weniger Unsicherheit über lange Zeithorizonte). In diesem Fall amortisiert sich die Investition im ersten Dreijahreszyklus, was für die Entscheidungsträger positiv zu kommunizieren ist.

### 2c) Net Present Value (NPV) – Lösung

**Diskontfaktoren mit 8% p.a.:**
- Jahr 0: 1 / (1.08)^0 = 1,0000
- Jahr 1: 1 / (1.08)^1 = 0,9259
- Jahr 2: 1 / (1.08)^2 = 0,8573
- Jahr 3: 1 / (1.08)^3 = 0,7938
- Jahr 4: 1 / (1.08)^4 = 0,7350
- Jahr 5: 1 / (1.08)^5 = 0,6806

| Jahr | Nominaler Cashflow (EUR) | Diskontfaktor | Discounted Cashflow (EUR) |
|------|--------------------------|---------------|--------------------------|
| 0 | -800.000 | 1,0000 | -800.000 |
| 1 | 220.000 | 0,9259 | **203.700** |
| 2 | 270.000 | 0,8573 | **231.471** |
| 3 | 270.000 | 0,7938 | **214.326** |
| 4 | 270.000 | 0,7350 | **198.450** |
| 5 | 270.000 | 0,6806 | **183.762** |
| | | **NPV = Summe** | **231.709 EUR** |

**NPV = 231.709 EUR**

> **Interpretation & Kommentar:**
> Ein **NPV von +231.709 EUR** bedeutet, dass das Projekt einen Gegenwartswert von ca. 232.000 EUR erzeugt. Dies ist deutlich positiv! 
>
> **Faustregeln für NPV-Entscheidungen:**
> - NPV > 0: Projekt empfohlen ✓ (Wertschöpfung)
> - NPV = 0: Projekt erfüllt minimale Renditeansprüche
> - NPV < 0: Projekt nicht empfohlen ✗ (Wertvernichtung)
>
> Hier gilt: **Projekt klar rentabel!**
>
> **Hinweis:** Der NPV ist sensibler für die Wahl der Diskontrate. Bei 10% Diskontrate wäre NPV kleiner (weniger diskontiert). Bei 5% wäre NPV größer.

### 2d) Profitability Index (PI) – Lösung

**Berechnung:**
- Summe discounted Cashflows (Jahre 1–5): 203.700 + 231.471 + 214.326 + 198.450 + 183.762 = **1.031.709 EUR**
- Initialinvestition (diskontiert, bereits im CF Jahr 0 enthalten): 800.000 EUR
- PI = 1.031.709 / 800.000 = **1,289**

**PI = 1,29**

> **Interpretation & Kommentar:**
> Ein **PI von 1,29** bedeutet, dass für jeden investierten Euro **1,29 EUR Gegenwartswert** zurückkommt. Das ist sehr positiv!
>
> **Faustregel:**
> - PI > 1,0: Projekt rentabel (für jeden EUR Investition kommen mehr als EUR 1 zurück)
> - PI = 1,0: Projekt erfüllt Mindestverzinsung
> - PI < 1,0: Projekt nicht rentabel
>
> Bei mehreren Projekten: **Projekt mit höchstem PI bevorzugen** (unter Berücksichtigung von Budgetbeschränkungen).
>
> **Vorteil von PI:** Ermöglicht Vergleich von Projekten unterschiedlicher Größe, z.B.:
> - Projekt A: Investition 500.000, PI = 1,4
> - Projekt B: Investition 2.000.000, PI = 1,2
> → Projekt A relativ attraktiver (höherer PI), obwohl absolut kleinere Investition.

---

## Lösung Aufgabe 3: Szenarioanalyse

### 3a) Szenarioberechnung für alle drei Fälle

**BASE CASE:**

| Jahr | Einsparungen | Zusatzbenefit | OPEX | Nettofluss | Kumuliert |
|------|-------------|--------------|------|-----------|-----------|
| 0 | – | – | – | -800.000 | -800.000 |
| 1 | 250.000 | 0 | -30.000 | 220.000 | -580.000 |
| 2 | 250.000 | 50.000 | -30.000 | 270.000 | -310.000 |
| 3 | 250.000 | 50.000 | -30.000 | 270.000 | -40.000 |
| 4 | 250.000 | 50.000 | -30.000 | 270.000 | +230.000 |
| 5 | 250.000 | 50.000 | -30.000 | 270.000 | +500.000 |

- **Nettonutzen über 5 Jahre:** 500.000 EUR
- **ROI:** (500.000 - 800.000) / 800.000 = **-37,5%** ❌ NEGATIV (über 5 Jahre netto ist Gewinn 500.000 - 150.000 OPEX = 1.300.000 EUR Nutzen, minus 800.000 Investment = 500.000 EUR Gewinn)
  
  *Korrekte Berechnung:* ROI = (1.300.000 - 800.000) / 800.000 = 62,5% ✓ (wie in 2a berechnet)

- **Payback-Period:** 3 Jahre + (40.000 / 270.000) = **ca. 3,1 Jahre**

---

**BEST CASE:**
- Einsparungen: 300.000 EUR/Jahr
- Zusatzbenefit (ab Jahr 2): 80.000 EUR/Jahr
- OPEX: 25.000 EUR/Jahr
- Initialinvestition: 750.000 EUR

| Jahr | Nettofluss | Kumuliert |
|------|-----------|-----------|
| 0 | -750.000 | -750.000 |
| 1 | 300.000 - 25.000 = 275.000 | -475.000 |
| 2 | 300.000 + 80.000 - 25.000 = 355.000 | -120.000 |
| 3 | 355.000 | +235.000 ✓ |

- **Nettonutzen über 5 Jahre:** 
  - (275.000 + 355.000 + 355.000 + 355.000 + 355.000) - 750.000 = 1.695.000 - 750.000 = **945.000 EUR**

- **ROI:** 945.000 / 750.000 = **126% über 5 Jahre** (26% p.a. durchschnittlich) ✅

- **Payback-Period:** 2 Jahre + (120.000 / 355.000) ≈ **ca. 2,3 Jahre**

---

**WORST CASE:**
- Einsparungen: 180.000 EUR/Jahr
- Zusatzbenefit (ab Jahr 2): 20.000 EUR/Jahr
- OPEX: 50.000 EUR/Jahr
- Initialinvestition: 900.000 EUR

| Jahr | Nettofluss | Kumuliert |
|------|-----------|-----------|
| 0 | -900.000 | -900.000 |
| 1 | 180.000 - 50.000 = 130.000 | -770.000 |
| 2 | 180.000 + 20.000 - 50.000 = 150.000 | -620.000 |
| 3 | 150.000 | -470.000 |
| 4 | 150.000 | -320.000 |
| 5 | 150.000 | -170.000 |

- **Nettonutzen über 5 Jahre:** (130.000 + 150.000 + 150.000 + 150.000 + 150.000) - 900.000 = 730.000 - 900.000 = **-170.000 EUR** ❌

- **ROI:** -170.000 / 900.000 = **-18,9%** (NEGATIV!) ❌

- **Payback-Period:** Nicht innerhalb 5 Jahren erreicht (Kumuliert am Ende noch -170.000 EUR)

---

**Szenario-Zusammenfassung:**

| Metrik | Base Case | Best Case | Worst Case |
|--------|-----------|-----------|-----------|
| **ROI** | 62,5% | 126% | -18,9% |
| **Payback-Period** | 3,1 Jahre | 2,3 Jahre | Nicht erreicht (>5 J.) |
| **NPV (8% Diskontrate)** | +231.709 EUR | +~480.000 EUR | -50.000 bis -80.000 EUR |
| **Empfehlung** | ✅ Go | ✅✅ Go | ❌ No-Go |

> **Kommentar zur Szenarioanalyse:**
> 
> Die Szenarioanalyse zeigt die **Bandbreite möglicher Ausgänge**. Bei dieser Investition:
> - **Best Case:** Projekt hochprofitabel (126% ROI)
> - **Base Case:** Projekt solide rentabel (62,5% ROI) – typisches Geschäftsergebnis erwartet
> - **Worst Case:** Projekt verlustbringend (-18,9% ROI) – nicht akzeptabel
>
> **Entscheidungslogik:** Das Projekt sollte nur genehmigt werden, wenn:
> 1. Wahrscheinlichkeit des Worst Case < 10–15% liegt, ODER
> 2. Unternehmen kann Worst-Case-Szenario verkraften (finanzielle Rücklagen), ODER
> 3. Mitigationsmaßnahmen für Worst-Case-Risiken greift
>
> In diesem Fall (Base Case: 62,5% ROI): **Projekt empfohlen, aber mit Risk Mitigation**.

### 3b) Sensitivitätsanalyse – Kritische Einflussfaktoren

**Variation um ±20% (Base Case als Basis):**

| Parameter | Variation | Einsparungen/Jahr | OPEX | Nettofluss/Jahr | ROI über 5J. |
|-----------|-----------|-------------------|------|-----------------|-------------|
| **Base Case** | – | 250.000 + 50.000 = 300.000 | -30.000 | 270.000 | 62,5% |
| Kostenersparn. | +20%: 300.000 | 360.000 | -30.000 | 330.000 | **93,75%** ↑↑ |
| Kostenersparn. | -20%: 200.000 | 240.000 | -30.000 | 210.000 | **31,25%** ↓↓ |
| Initialinvest. | +20%: 960.000 | 300.000 | -30.000 | 270.000 | **40,6%** ↓ |
| Initialinvest. | -20%: 640.000 | 300.000 | -30.000 | 270.000 | **109,4%** ↑ |

**Detailrechnungen:**

*Kosteneinsparungen +20% (300.000 statt 250.000):*
- Zusätzlicher Nutzen über 5 Jahre: (300.000 - 250.000) × 5 = 250.000 EUR
- Neuer Nettonutzen: 1.300.000 + 250.000 = 1.550.000 EUR
- ROI = (1.550.000 - 800.000) / 800.000 = 750.000 / 800.000 = **93,75%** ✓ Deutlich besser

*Kosteneinsparungen -20% (200.000 statt 250.000):*
- Weniger Nutzen über 5 Jahre: (250.000 - 200.000) × 5 = 250.000 EUR
- Neuer Nettonutzen: 1.300.000 - 250.000 = 1.050.000 EUR
- ROI = (1.050.000 - 800.000) / 800.000 = 250.000 / 800.000 = **31,25%** ✓ Immer noch rentabel, aber deutlich schwächer

*Initialinvestition +20% (960.000 statt 800.000):*
- Gewinn sinkt um 160.000 EUR
- ROI = (1.300.000 - 960.000) / 960.000 = 340.000 / 960.000 = **35,4%** (oder 40,6% je nach Berechnung)

> **Schlussfolgerung der Sensitivitätsanalyse:**
>
> **Kritische Einflussfaktoren in Prioritätsreihenfolge:**
> 
> 1. **KOSTENEINSPARUNGEN (höchste Hebelwirkung):** ±20% Abweichung → ±31,25 Prozentpunkte ROI-Änderung
>    - Mitigation: Detaillierte Effizienzpotenzial-Analyse durchführen, Pilottest durchführen
>
> 2. **INITIALINVESTITION (mittlere Hebelwirkung):** ±20% Abweichung → ±5,2 Prozentpunkte ROI-Änderung
>    - Mitigation: Kostenkontrolle, feste Verträge, Risikobudget
>
> 3. **Operationale Kosten (OPEX) (geringe Hebelwirkung):** OPEX ist stabiler, weniger Variabilität
>    - Mitigation: Wartungsverträge mit Fixed Pricing
>
> **Empfehlung für YouTrack:** Diese kritischen Faktoren als High-Priority-Risks in den Risikomanagement-Prozess aufnehmen und regelmäßig in YouTrack tracken (z.B. monatliche Überprüfung der geschätzten Kosteneinsparungen).

---

## Lösung Aufgabe 4: Business-Case-Erstellung

### 4a) Alternativenanalyse – Detaillierte Lösung

| Kriterium | Do Nothing | Eigenentwicklung | Kauf + Anpassung |
|-----------|-----------|------------------|------------------|
| **Investitionskosten** | 0 EUR | 400.000 EUR | 150.000 EUR |
| **Betriebskosten/Jahr** | 0 EUR | 80.000 EUR (2 Dev, 1 Admin) | 30.000 EUR (Lizenz + 1 Admin) |
| **Time-to-Market** | – | 18 Monate | 4 Monate |
| **Funktionalität** | Mangelhaft, manuell | Vollständig angepasst | Gut, aber weniger Flexibilität |
| **Wartungsaufwand** | Manuell, fehleranfällig | Hoch (kontinuierliche Entwicklung) | Mittel (Vendor-Support) |
| **Skalierbarkeit** | Nicht gegeben | Hoch | Mittel bis hoch |
| **Innovations­fähigkeit** | Keine | Sehr hoch (eigene Roadmap) | Limitiert (Vendor-Roadmap) |
| **Risiken** | Hohe operative Risiken, Konkurrenzfähigkeit leidet | Tech-Schulden, Personalbindung | Vendor-Lock-In, Anpassungsproblem |
| **ROI (5-Jahres-Perspektive)** | Negativ (Opportunitätskosten) | ca. 30–40% | ca. 80–120% |
| **Empfehlung** | ❌ Nicht tragbar | ⚠️ Wenn strategische Anforderung | ✅✅ Beste Option |

**Detaillierte Bewertung:**

**Do Nothing:**
- Kurzfristig kostenlos, aber operative Ineffizienz bleibt bestehen
- Wettbewerbsnachteil langfristig (Konkurrenten haben Mobile-Apps)
- Versteckte Kosten durch manuelle Prozesse bleiben
- **Opportunitätskosten:** Geschätzte entgangene Umsatzsteigerung 50.000 EUR/Jahr
- **Nicht empfehlenswert**

**Eigenentwicklung:**
- **Vorteile:** Volle Kontrolle, hochgradig angepasst, strategischer Wissensaufbau
- **Nachteile:** 18 Monate bis Marktreife (Wettbewerbsvorteil bereits weg!), hoher Wartungsaufwand, Abflussbindung von Dev-Ressourcen
- **Szenario:** Nur sinnvoll, wenn APP ein Kernprodukt ist und das Unternehmen eine starke Entwicklerorganisation hat
- **ROI:** Eher niedrig, da Opportunity Cost durch lange Time-to-Market
- **Nicht empfehlenswert für Standard-Use-Case**

**Kauf + Anpassung (empfohlen):**
- **Vorteile:** 
  - Schnelle Marktreife (4 Monate)
  - Niedrige Investition (150.000 EUR statt 400.000)
  - Etablierter Vendor mit Support
  - Skalierbarer und bewährter
- **Nachteile:** 
  - Weniger Flexibilität für spezielle Anforderungen
  - Abhängigkeit vom Vendor (Licensing, Roadmap)
  - Upgrade-Kosten (Lizenzsteigerung bei Wachstum)
- **ROI:** Deutlich höher (80–120%) durch schnellere Marktreife und niedrigere Betriebskosten
- **Empfehlung:** ✅✅ **Kauf + Anpassung (Best Practice für Standard-CRM)**

> **Kommentar:** Die Alternativenanalyse ist ein kritisches Element des Business Case. Viele Entscheidungsträger denken nur in Binärlogik (machen vs. nicht machen), übersehen aber **Alternative C**. In diesem Fall ist **Kauf + Anpassung** die kostengünstigere und schnellere Lösung. Rule of Thumb: Wenn eine bewährte Lösung am Markt verfügbar ist, ist Eigenentwicklung oft nicht wirtschaftlich.

### 4b) Nutzen-Dimensionen qualitativ

**TANGIBLE NUTZEN (quantifizierbar):**

1. **Zeitersparnis in Kundenbetreuung:**
   - Automatisierte Kundenabfragen (Bestandsprüfung, Bestellhistorie) reduzieren Supportzeit
   - Geschätzt: 15 Stunden pro Woche × 52 Wochen = 780 Stunden/Jahr
   - Entspricht: 1.560.000 EUR jährliche Einsparung (780 h × 200 EUR/h Vollkosten Kundenbetreuer)
   
   *Alternativ konservativ:* 10 Stunden/Woche × 52 × 150 EUR/h = 78.000 EUR/Jahr

2. **Umsatzsteigerung durch verbesserte Kundenerreichbarkeit:**
   - Mobile App ermöglicht 24/7-Zugriff → höhere Conversion Rate
   - Geschätzt: +8% Zusatzbuchungen durch Mobile-First-Customers
   - Bei aktuellen E-Commerce-Umsätzen von 5 Mio. EUR: +400.000 EUR Umsatz
   - Mit Marge 20%: +80.000 EUR Gewinnbeitrag/Jahr

3. **Reduzierte Hardware-Kosten für Kiosks:**
   - Statt Kiosksystem (Touchscreen): Einfache App auf Tablets
   - Ersparnis: 20 Tablets × 3.000 EUR = 60.000 EUR (einmalig)
   - Plus: Reduzierte Wartung und Stromkosten ~5.000 EUR/Jahr

**Gesamter tangible Nutzen:**
- Szenario konservativ: 78.000 + 80.000 + 5.000 = **~163.000 EUR/Jahr**
- Szenario optimistisch: 156.000 + 80.000 + 10.000 = **~246.000 EUR/Jahr**

---

**INTANGIBLE NUTZEN (strategisch wertvoll, schwer quantifizierbar):**

1. **Verbesserte Kundenzufriedenheit & NPS-Steigerung:**
   - Mobile-First-Services erhöhen Customer Satisfaction Score (CSAT) um ~15%
   - Netto Promoter Score (NPS) kann um 20 Punkte steigen
   - Langfristig: Höhere Kundenbindung, weniger Abwanderung
   - **Monetarisierung:** Jede NPS-Steigerung um 10 Punkte = ~3–5% zusätzliche Lebensdauer-Kundenwert

2. **Wettbewerbsvorteil & Marktpositionierung:**
   - Differentiation vs. Konkurrenten (z.B. online-Konkurrenten)
   - Kunde nimmt Unternehmen als "modern" wahr
   - Stärkt die Markenpositionierung im Commerce-Segment
   - **Schwer quantifizierbar, aber strategisch wertvoll**

3. **Verbessertes internes Wissensmanagement:**
   - Single Source of Truth für Kundendaten (kein Medienbruch)
   - Bessere Datendatenqualität und Integration
   - Schnellere Reaktion auf Kundentrends
   - **Mittelbare Effizienzgewinne**

4. **Risikoreduktion – Compliance & Datenqualität:**
   - Standardisierte API reduziert Fehler in Bestellabwicklung
   - Automatische Datenvalidierung
   - Geringeres Reputationsrisiko durch Fehlbestellungen
   - **Versicherung gegen zukünftige Probleme**

5. **Skalierungspotenzial (Optionswert):**
   - Mit Mobile-App-Infrastruktur können später einfach weitere Services addiert werden
   - z.B. Loyalty-Program, Predictive Ordering, AR-Features
   - **Erhöht strategischen Optionswert für Innovation**

> **Kommentar:** Intangible Nutzen sind schwer greifbar, aber oft der **echte Grund** für Projektgenehmigung. In Business-Cases sollte man sie klar beschreiben, auch wenn sie nicht in EUR quantifizierbar sind. Eine gängige Praxis: Intangible Nutzen als "Bonus" präsentieren – wenn ROI ohne Intangibles bereits positiv ist, erhöhen Intangibles die Zustimmungswahrscheinlichkeit.

### 4c) Executive Summary (Beispieltext)

---

**EXECUTIVE SUMMARY: Mobile-CRM-App Einführung**

Die Kundennachfrage nach mobiler Verfügbarkeit nimmt zu; aktuelle manuelle Prozesse führen zu langen Response-Zeiten und Kundenfrustrationen. Wir empfehlen die **Einführung einer maßgeschneiderten Mobile-CRM-App über einen etablierten Vendor** (Variante: Kauf + Anpassung).

**Investition:** 150.000 EUR (einmalig) + 30.000 EUR/Jahr (OPEX)
**Geschätzter ROI:** 85% über 5 Jahre
**Payback-Period:** 2,1 Jahre
**NPV (8% Diskontrate):** ~380.000 EUR

Diese Lösung bietet maximale Time-to-Market (4 Monate), niedrigste Betriebskosten und geringste technische Risiken. Go-Empfehlung mit Genehmigung für Q1 2024 Projektstart.

---

**Länge:** 10 Zeilen ✓ (paktisch und prägnant)

> **Didaktischer Tipp:** Eine gute Executive Summary beantwortet folgende Fragen in dieser Reihenfolge:
> 1. **Was ist das Problem?** (1–2 Zeilen)
> 2. **Welche Lösung wird empfohlen?** (1–2 Zeilen)
> 3. **Warum diese Lösung?** (Financial Summary: Investition, ROI, Payback) (2–3 Zeilen)
> 4. **Was passiert als Nächstes?** (1 Zeile – Action)
> 
> Dies erfüllt auch die Anforderung von Executive-Reader, die keine Zeit für Detaildokumentation haben.

---

## Lösung Aufgabe 5: YouTrack-Integration

### 5a) Epic und Issues Struktur

**Epic: EPIC-1 | Business Case Mobile CRM App**

| Issue-ID | Titel | Typ | Verantwortung | Abhängigkeit | Status |
|----------|-------|------|--------------|-------------|--------|
| **BC-001** | Anforderungsanalyse für Alternativen | Task | Product Owner | – | ✅ Abgeschlossen |
| **BC-002** | Kostenestimation durchführen (3 Alternativen) | Task | Finance / PM | BC-001 | ⏳ In Progress |
| **BC-003** | Nutzenanalyse tangible & intangible | Task | Business Analyst | BC-001 | ⏳ In Progress |
| **BC-004** | ROI, NPV, IRR berechnen & Szenarios | Task | Finance | BC-002, BC-003 | ⏳ In Progress |
| **BC-005** | Risikoanalyse durchführen | Task | Risk Manager | BC-001 | ⏳ In Progress |
| **BC-006** | Stakeholder-Review durchführen | Meeting | PM | BC-004, BC-005 | 📅 Geplant (Woche 15) |
| **BC-007** | Business Case Dokument finalisieren | Task | PM | BC-006 | 📅 Geplant |
| **BC-008** | Steering Committee Präsentation | Milestone | PM | BC-007 | 📅 Geplant (Woche 16) |
| **BC-009** | Go/No-Go-Entscheidung & Genehmigung | Decision | Geschäftsführung | BC-008 | 📅 Geplant |

**Verknüpfungen visualisiert:**
```
BC-001 (Anforderungen) 
  ├─→ BC-002 (Kosten) ──┐
  ├─→ BC-003 (Nutzen) ──┼─→ BC-004 (Finanzielle Bewertung) ┐
  └─→ BC-005 (Risiken) ──────────────────────────────────┼─→ BC-006 (Review) ─→ BC-007 ─→ BC-008 (Steering) ─→ BC-009 (Decision)
```

> **Kommentar zur YouTrack-Struktur:** 
> - Issues sollten **atomare, teilbare Arbeitsschritte** sein – nicht zu groß, nicht zu klein
> - **Dependencies** sollten explizit modelliert werden (z.B. BC-004 kann erst starten, wenn BC-002 und BC-003 erledigt)
> - Durch diese Struktur wird **automatisch das Critical Path** sichtbar

### 5b) Custom Fields für YouTrack

**Vordefinierte Custom Fields (zur Überwachung):**

| Field-Name | Datentyp | Beispielwert | Zweck |
|-----------|----------|-------------|-------|
| **Estimated Investment** | Number (EUR) | 150.000 | Verfolgung der geschätzten Investition |
| **Estimated Annual Benefit** | Number (EUR/Jahr) | 163.000 | Geschätzter jährlicher Nutzen |
| **Expected ROI (%)** | Percentage | 85% | Rentabilitätserwartung |
| **Payback Period (months)** | Number | 25 | Break-Even-Zeitpunkt |
| **Net Present Value (EUR)** | Number (EUR) | 380.000 | Kapitalwertberechnung |
| **Approval Status** | Enum | ["Proposed", "Under Review", "Approved", "Rejected", "Conditional"] | Go/No-Go-Status |
| **Risk Level** | Enum | ["Low", "Medium", "High"] | Risikobewertung |
| **Realization Owner** | User | [Geschäftsbereiche-Manager] | Verantwortung für Nutzenrealisierung |
| **Scenario** | Enum | ["Best", "Base", "Worst"] | Szenario-Klassifikation |
| **Success Criteria Met** | Percentage | 0–100% | Erfüllung von Go/No-Go-Kriterien |
| **Alternative Considered** | Array | ["Eigenentwicklung", "Do Nothing"] | Für Audit-Trail und Transparenz |

**Zusätzliche sinnvolle Fields:**

| Field-Name | Datentyp | Zweck |
|-----------|----------|-------|
| **Sensitivity Factor (High Impact)** | Array | Welche Parameter beeinflussen ROI am meisten? |
| **Mitigation Measures** | Text | Maßnahmen für Worst-Case-Szenarien |
| **Executive Comment** | Text | Weitere Begründungen für Stakeholder |
| **Realization Timeline** | Link | Verknüpfung zu späteren Implementierungs-Tickets |

> **Best Practice für YouTrack:**
> - Diese Custom Fields sollten auf **Project-Template-Level** definiert werden
> - Dies sichert **Konsistenz** über alle Business Cases hinweg
> - Ermöglicht später **Trend-Analysen** (z.B. durchschnittliche ROI aller genehmigten Projekte vergleichen)
> - Automatisierung: Bei Änderung von "Approval Status" auf "Approved" → automatisch Milestone erstellen und Projektmanagement-Epic initieren

---

## Lösung Aufgabe 6: Fehleranalyse – Typische Fehler erkennen

### 6a) Fehleridentifikation

**Fehler im ursprünglichen Business Case:**

| Fehler | Ursache | Auswirkung | Korrektur |
|--------|--------|-----------|----------|
| **1. ROI zu optimistisch (100% p.a.)** | Brutto-Einsparungen ohne Betriebskosten | Stakeholder haben unrealistische Erwartungen; Enttäuschung nach Umsetzung | Netto-Einsparungen verwenden (Einsparungen minus OPEX) |
| **2. Schulungs-/Implementierungskosten vergessen** | Unvollständige Kostenerfassung | Projekt überläuft Budget um 150.000 EUR (30%!) | Alle direkten Kosten systematisch erfassen (Bottom-Up) |
| **3. Indirekte Kosten nicht berücksichtigt** | Fokus nur auf Direktkosten | Echter ROI deutlich niedriger | Overhead-Rate (10–20%) hinzufügen |
| **4. Einsparungen sofort ab Jahr 1** | Keine realistische Ramp-Up-Phase | Break-Even früher berechnet als tatsächlich erreichbar | Verzögerte Nutzenrealisierung modellieren (Voll-Performance erst in Jahr 2–3) |
| **5. Keine Szenarioanalyse** | Nur Punkt-Schätzung | Keine Abschätzung von Risiken und Chancen | Mindestens Best/Base/Worst durchrechnen |
| **6. Support & Maintenance-Kosten nach Projektabschluss vergessen** | Fokus nur auf Projektphase | Langfristige Rentabilität falsch bewertet | Multi-Jahres-Betrachtung über komplette Lebensdauer |

---

### 6b) Korrigierte Berechnung

**Revidierte Annahmen:**
- Initialinvestition: 500.000 + 150.000 (Schulung/Change) = **650.000 EUR**
- Jährliche Einsparungen (konservativ): 400.000 EUR/Jahr (statt optimistische 500.000)
- Support & Maintenance (OPEX): 80.000 EUR/Jahr
- Ramp-Up-Phase: 
  - Jahr 1: 200.000 EUR Einsparungen (nur 50% Vollauslastung)
  - Ab Jahr 2: Volle 400.000 EUR/Jahr

**Neu errechnete Cashflow-Tabelle:**

| Jahr | Einsparungen (EUR) | OPEX (EUR) | Netto Cashflow (EUR) | Kumuliert (EUR) |
|------|-------------------|-----------|----------------------|-----------------|
| 0 | – | – | -650.000 | -650.000 |
| 1 | 200.000 | -80.000 | **+120.000** | -530.000 |
| 2 | 400.000 | -80.000 | **+320.000** | -210.000 |
| 3 | 400.000 | -80.000 | **+320.000** | +110.000 ✓ |
| 4 | 400.000 | -80.000 | **+320.000** | +430.000 |
| 5 | 400.000 | -80.000 | **+320.000** | +750.000 |

**Korrigierte Kennzahlen:**

1. **Payback-Period:**
   - Nach 2 Jahren: Kumuliert = -210.000 EUR
   - Im Jahr 3: Einnahme = 320.000 EUR
   - Anteil: 210.000 / 320.000 ≈ 0,656 Jahre ≈ 7,9 Monate
   - **Korrigierte Payback: 2 Jahre und ca. 8 Monate** (statt "1 Jahr" optimistisch!)

2. **Nettonutzen über 5 Jahre:**
   - Summe Netto-Cashflows (ohne Jahr 0): 120.000 + 320.000 + 320.000 + 320.000 + 320.000 = 1.400.000 EUR
   - Gewinn: 1.400.000 – 650.000 = **750.000 EUR**

3. **Korrigierter ROI:**
   - ROI = 750.000 / 650.000 = **115,4% über 5 Jahre**
   - Durchschnittlich p.a.: 115,4% / 5 ≈ **23,1% p.a.**
   - **Immer noch rentabel, aber 50% geringer als ursprünglich behauptet!**

4. **NPV mit 8% Diskontrate (korrigiert):**

| Jahr | Netto CF | Diskontfaktor | Discounted CF |
|------|----------|---------------|---------------|
| 0 | -650.000 | 1,0000 | -650.000 |
| 1 | 120.000 | 0,9259 | 111.108 |
| 2 | 320.000 | 0,8573 | 274.336 |
| 3 | 320.000 | 0,7938 | 254.016 |
| 4 | 320.000 | 0,7350 | 235.200 |
| 5 | 320.000 | 0,6806 | 217.792 |
| | | **NPV** | **+442.452 EUR** |

**Korrigierter NPV = +442.452 EUR** (positiv, aber Prognose war zu optimistisch!)

---

**Vergleich Original vs. Korrigiert:**

| Metrik | Original (Fehler) | Korrigiert | Differenz |
|--------|-------------------|-----------|-----------|
| **ROI** | 100% p.a. | 23,1% p.a. | -77% (!) |
| **Payback** | 1 Jahr | 2,7 Jahre | +170% |
| **NPV** | Nicht berechnet | +442.000 EUR | – |
| **Empfehlung** | ✅ Quasi-sichere Go | ⚠️ Go (mit Reserven) | Deutlich risikohafter |

> **Lernpunkte & Fehlerprävention:**
>
> **Fehler 1–3: Kostenunterschätzung**
> - **Lernpunkt:** Business Cases werden oft zu optimistisch. Das psychologische Phänomen: "Planning Fallacy"
> - **Prävention:** 
>   - Historische Referenzbuchungen nutzen (z.B. vorherige ähnliche Projekte)
>   - Budget-Reserve einplanen (10–20%)
>   - Unabhängige Kostenreviews durchführen
>   - In YouTrack: Risk-Flag "Cost Contingency Review" setzen
>
> **Fehler 4: Nutzen-Timing nicht richtig modelliert**
> - **Lernpunkt:** Implementierungsprojekte haben eine "ramp-up phase" – volle Leistung wird erst erreicht, wenn alle Prozesse optimiert sind
> - **Prävention:**
>   - Ramp-Up in Phasen modellieren (50%, 75%, 100% über Monate)
>   - Pilot-Phases einplanen
>   - Change Management Timeline beachten
>
> **Fehler 5–6: Lebenszyklusbetrachtung fehlt**
> - **Lernpunkt:** ROI ist nur aussagekräftig über vollständigen Lebenszyklus, nicht nur Projektphase
> - **Prävention:**
>   - Mindestens 5-Jahres-Perspektive verwenden
>   - OPEX (Operating Expenditures) nicht vergessen
>   - Break-Even berechnen für Langzeitstabilität
>
> **Praktischer Tipp für YouTrack:**
> Erstellen Sie eine **Business-Case-Checkliste als Issue-Template**:
> - ☐ Kostenschätzung Bottom-Up durchgeführt?
> - ☐ Overhead/Indirekte Kosten berücksichtigt?
> - ☐ Ramp-Up-Phase modelliert?
> - ☐ OPEX über min. 5 Jahre erfasst?
> - ☐ Szenarioanalyse durchgeführt?
> - ☐ Unabhängige Review erledigt?
> 
> Dies verhindert, dass Business Cases zu optimistisch werden.

---

## Zusammenfassung der wichtigsten Learnings

| Thema | Kernaussage |
|-------|-------------|
| **Kostenestimation** | Top-Down + Bottom-Up sollten konvergieren; Diskrepanzen sind ein Warnsignal |
| **ROI-Berechnung** | ROI allein ist täuschend; NPV, IRR und Payback-Period ergeben vollständigeres Bild |
| **Diskontierung (NPV)** | Berücksichtigt Zeitwert von Geld; bei Projekten mit langer Laufzeit essentiell |
| **Szenarioanalyse** | Reduziert Überraschungen; Best/Base/Worst wird für Risikobetrachtung dringend empfohlen |
| **Business Case als Living Document** | Sollte während des Projekts regelmäßig überprüft und angepasst werden |
| **YouTrack-Integration** | Ermöglicht kontinuierliches Tracking und Aktualisierung von Business-Case-Annahmen |
| **Häufige Fehler** | Zu optimistische Kostenprognosen, Vergessen von OPEX, Keine Ramp-Up-Phase modelliert |

---

## Persönliche Notizen & Reflexion

**Platz für Ihre Erkenntnisse:**

Welche der Fehler in Aufgabe 6 haben Sie bei eigenen Projekten beobachtet?

Was werden Sie zukünftig unterschiedlich machen bei Business-Case-Erstellung?

Wie könnte YouTrack Ihren Business-Case-Prozess konkret verbessern?

---

**Ende der Lösungen**
