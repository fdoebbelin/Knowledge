---
title: "Clawdbot-Moltbot: Openclaw nach rasanten Namensänderungen unter Beschuss"
source: "https://www.golem.de/news/clawdbot-moltbot-openclaw-nach-rasanten-namensaenderungen-unter-beschuss-2601-204840.html"
author:
  - "[[Michael Linden]]"
published: 2026-01-30
created: 2026-02-02
description: "Nach zwei Umbenennungen ist das KI-Agent-Projekt Openclaw zu einem Sicherheitsalbtraum geworden: Es lockt Betrüger und Hacker an."
tags:
  - "clippings"
---
[Zur Navigation](https://www.golem.de/news/#nav)

![](_resources/9ec43969de082ba9b4ddafa4faa32bc8_MD5%201.jpg)

Openclaw-Maskottchen Bild: OpenClaw

Inhalt
1. [Clawdbot-Moltbot: Openclaw nach rasanten Namensänderungen unter Beschuss](https://www.golem.de/news/clawdbot-moltbot-openclaw-nach-rasanten-namensaenderungen-unter-beschuss-2601-204840.html)
2. [Komplexe Installation erhöht Risiken](https://www.golem.de/news/clawdbot-moltbot-openclaw-nach-rasanten-namensaenderungen-unter-beschuss-2601-204840-2.html)
![](_resources/284a80ad71fd5596545f28ba148c3a2b_MD5%201.png)

Das Open-Source-Projekt von Peter Steinberger hat innerhalb weniger Wochen bereits zweimal [den Namen gewechselt (öffnet im neuen Fenster)](https://openclaw.ai/blog/introducing-openclaw) – von Clawdbot über Moltbot zu [Openclaw (öffnet im neuen Fenster)](https://openclaw.ai/). Die erste Umbenennung erfolgte auf Druck von Anthropic. Im Rahmen der Umbenennungen und wegen der Komplexität gerieten Projekt und Nutzer in gefährliches Fahrwasser.

Der KI-Agent sammelte mehr als 100.000 Github-Stars und lockte binnen einer Woche nach der Erstveröffentlichung zwei Millionen Besucher an. Als [lokale Alternative zu Cloud-basierten Assistenten](https://www.golem.de/news/moltbot-alias-clawdbot-der-ki-agent-mit-seele-und-vorliebe-fuer-mac-minis-2601-204731.html) konzipiert, ermöglicht das Tool die Computersteuerung über Messaging-Plattformen wie Whatsapp und Slack.

[Neue Angebote bei Golem Jobs (öffnet im neuen Fenster)](https://jobs.golem.de/)

[IT Berater\*in / Consulting für IT-Sicherheit IT-Dienstleistungszentrum (ITDZ Berlin), Berlin,Homeoffice (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/3626980.html)

[Administrator\*in Windows Server Deutsche Rentenversicherung Bund, Würzburg,Berlin,Home Office (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/3625297.html)

[Application Engineer (d/m/f) ams Sensors Germany GmbH, Jena (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923160845.html)

[IT Software Engineer (m/w/d) Enrichment Technology Company Limited, Jülich (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923284925.html)

[Systemadministratorin / Systemadministrator DBA (m/w/d) - Hauptabteilung IT Berufsgenossenschaft Handel und Warenlogistik, Bonn (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923184625.html)

[IT-Service Designer:in (w/m/d) Berliner Wasserbetriebe, Berlin (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923275495.html)

[Mitarbeiter\*in für die IT-Abteilung (m/w/d) Pirastro GmbH, Offenbach (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923284275.html)

[Junior Developer / Game Designer (m/w/d) TOUGH Training GmbH, Würzburg,Essen (öffnet im neuen Fenster)](https://jobs.golem.de/stellenanzeigen/golem_jw_1923330005.html)

## Typosquatting und gefälschte Repositories

Das rapide Wachstum und die Namensverwirrung schufen Einfallstore für böswillige Akteure. [Malwarebytes dokumentierte (öffnet im neuen Fenster)](https://www.malwarebytes.com/blog/threat-intel/2026/01/clawdbots-rename-to-moltbot-sparks-impersonation-campaign) Versuche, Typosquat-Domains zu registrieren.

Die Idee dahinter: Nutzer, die sich vertippen oder nicht genau hinschauen, landen auf der gefälschten Seite oder laden schädliche Software herunter. Bei Open-Source-Projekten wie Openclaw ist das besonders tückisch, weil Entwickler den Code direkt aus dem Repository installieren. Wenn sie versehentlich das falsche Repository erwischen, installieren sie möglicherweise Malware statt der echten Software.

![](_resources/284a80ad71fd5596545f28ba148c3a2b_MD5%201.png)

Zunächst wird vom Angreifer das Original-GitHub-Repository geklont und dann umbenannt. Diese gefälschten Repositories wirken legitim, schädlicher Code wird erst in späteren Updates hinzugefügt – eine gängige Technik bei Supply-Chain-Angriffen.

Im Fall von Openclaw war das Problem durch die häufigen Namensänderungen noch größer. Das sorgte für Verwirrung und gab Betrügern weitere Gelegenheiten, ähnlich klingende Namen zu registrieren.

## Hunderte offene Kontrollpanels im Internet

Ein Sicherheitsforscher [identifizierte Hunderte falsch konfigurierter Moltbot-Installationen (öffnet im neuen Fenster)](https://www.linkedin.com/pulse/hacking-clawdbot-eating-lobster-souls-jamieson-o-reilly-whhlc/) im Internet. [Axios berichtete (öffnet im neuen Fenster)](https://www.axios.com/2026/01/29/moltbot-cybersecurity-ai-agent-risks), dass diese exponierten Kontrollpanels Gesprächsverläufe, API-Schlüssel und Zugangsdaten offenlegen könnten. Einige Konfigurationen erlaubten angeblich die Befehlsausführung über die Agent-Schnittstelle.

[Bitdefender (öffnet im neuen Fenster)](https://www.bitdefender.com/en-us/blog/hotforsecurity/moltbot-security-alert-exposed-clawdbot-control-panels-risk-credential-leaks-and-account-takeovers) bestätigte ähnliche Funde und beschrieb öffentlich zugängliche Administrationspanels, die Konfigurationsdaten und Chat-Protokolle preisgaben. Die Bedenken gehen über einfache Fehlkonfigurationen hinaus. Der Agent benötigt Root-Zugriff und erhält damit Kontrolle über Shell-Befehle, Dateisysteme, Browserdaten, E-Mails und Kalender.

[Token Security (öffnet im neuen Fenster)](https://www.token.security/blog/the-clawdbot-enterprise-ai-risk-one-in-five-have-it-installed) stellte fest, dass 22 Prozent seiner Kunden Mitarbeiter hatten, die das Tool innerhalb einer Woche nach Veröffentlichung nutzten. [Noma Security (öffnet im neuen Fenster)](https://noma.security/blog/moltbot-the-agentic-trojan-horse/) behauptete, 53 Prozent der Unternehmenskunden hätten privilegierten Zugriff ohne formelle Genehmigung erteilt. Das Muster deutet auf weitverbreitete Nutzung durch einzelne Mitarbeiter ohne IT-Aufsicht hin.

- [Hier geht es zu Künstliche Intelligenz: Wissensverarbeitung bei Amazon](https://www.amazon.de/K%C3%BCnstliche-Intelligenz-Wissensverarbeitung-Neuronale-Netze/dp/3446459146?__mk_de_DE=%C3%85M%C3%85%C5%BD%C3%95%C3%91&keywords=k%C3%BCnstliche+intelligenz&qid=1639670167&sr=8-6&linkCode=ll1&tag=golem-de-21&linkId=da098c873a3fb2f74f07f0b8c2dced09&language=de_DE&ref_=as_li_ss_tl)

---