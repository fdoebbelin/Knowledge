---
title: "Moltbot ist OpenClaw: Sehr gefährlich und hilfreich zugleich"
source: "https://onlinemarketing.de/technologie/moltbot-openclaw-sehr-gefaehrlich-hilfreich"
author:
  - "[[Niklas Lewanczik]]"
published: 2026-02-02
created: 2026-02-02
description: "OpenClaw fungiert als lokale AI-Assistenz mit Messaging-Zugriff, birgt aber massive Sicherheitslücken. Und dann ist da noch Moltbook."
tags:
  - "clippings"
---
Technologie

![](_resources/4a4e6a035b9c4f5459bbe465a0342c22_MD5%201.webp)

© OpenClaw

Niklas Lewanczik | 02.02.26

OpenClaw fungiert als lokale AI-Assistenz mit Messaging-Zugriff, birgt aber massive Sicherheitslücken. Und mit Moltbook haben OpenClaw Bots sogar eine neue Social-Media-Heimat, in der sie diskutieren können.

- [teilen](https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fonlinemarketing.de%2Ftechnologie%2Fmoltbot-openclaw-sehr-gefaehrlich-hilfreich)
- [weiterleiten](https://onlinemarketing.de/technologie/)
- [teilen](http://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fonlinemarketing.de%2Ftechnologie%2Fmoltbot-openclaw-sehr-gefaehrlich-hilfreich)

Erst hieß es Clawdbot, dann Moltbot, jetzt OpenClaw: Das offene KI-Projekt von Peter Steinberger ist zum viralen AI-Assistance-Hit avanciert und hat auf GitHub bereits [knapp 150.000 Sternebewertungen](https://github.com/openclaw/openclaw) erhalten. OpenClaw ermöglicht es dir, deinen eigenen Assistant mit jedem Betriebssystem und auf jedem Gerät laufen zu lassen und ihn über populäre Messaging-Dienste wie WhatsApp, Slack oder Google Chat zu steuern.

Neben Umbenennungen stehen für das Projekte, das zuletzt in der Tech-Welt in aller Munde war, aber aktuell vor allem Sicherheitsbedenken im Fokus – während KI-kreierte OpenClaw Bots sogar ein eigenes Social [Network](https://onlinemarketing.de/lexikon/definition-content-delivery-network) ohne Menschen bevölkern.

## Das ist OpenClaw: Deine Infrastruktur, deine Daten, dein Risiko

In einem [Blog Post](https://openclaw.ai/blog/introducing-openclaw) erklärt Peter Steinberger, der Erfinder von OpenClaw, was es mit seinem Projekt auf sich hat. Zunächst hieß die Agent Platform ClawdBot. Das war eine Wortspiel, mit dem **Steinberger** an die KI Claude von Anthropic erinnern wollte. Doch Anthropic drohte mit juristischen Konsequenzen, sodass das Projekt in Moltbot umbenannt wurde. Dazu erklärt der Macher:

> **Moltbot** came next, chosen in a chaotic 5am Discord brainstorm with the community. Molting represents growth – lobsters shed their shells to become something bigger. It was meaningful, but [it never quite rolled off the tongue](https://x.com/NetworkChuck/status/2016254397496414317).

Also musste noch ein neuer Name her. Seit dem 29. Januar 2026 ist das OpenClaw. Der Name soll andeuten, dass das Projekt offen für alle ist, während die Anlehnung an den Hummer als eine Art Maskottchen gewahrt bleibt. Zusammen mit dem Rebranding gab es noch Updates für die Agent Platform. User können eine Verküpfung mit noch mehr Chat-Systemen wie Google Chat und Twitch herstellen. Außerdem werden Modelle wie KIMI K2.5 und Xiaomi MiMo-V2-Flash unterstützt und im Web Chat können Bilder wie in [Messenger](https://onlinemarketing.de/lexikon/definition-messenger-marketing) gesendet werden.

Grundsätzlich können mit OpenClaw, das als Wochenendprojekt begann und dann binnen einer Woche über zwei Millionen Besucher:innen generierte, AI Assistants für den Eigenbedarf auf sämtlichen Geräten kreiert werden. Damit muss die Assistenz nicht in einer [Cloud](https://onlinemarketing.de/lexikon/definition-cloud-computing) von Tech-Unternehmen agieren und die Infrastruktur und Daten der User sind über das eigene Gerät verwaltet. Das klingt verlockend, vor allem wenn man die Weitergabe von Aufgaben wie Mailings, Ordner-Sortieren oder Web-Suche einfach über eine favorisierte Messaging [App](https://onlinemarketing.de/lexikon/definition-app) steuern kann. Doch dieses zuletzt extrem populär gewordene Projekt brigt große Risiken.

## OpenClaw mit Sicherheitslücken

Die Sicherheit ist das priorisierte Ziel für die OpenClaw-Entwicklung, betont auch Peter Steinberger. Kein Wunder, denn das Projekt kommt derzeit noch mit einigen Sicherheitsproblemen daher. Das zeigt nicht zuletzt der [umfassende Test von Heise](https://www.heise.de/news/OpenClaw-ausprobiert-Die-gefaehrlichste-Software-der-Welt-11161203.html).

Ein Problem besteht zum Beispiel darin, dass es Lücken zum Einschleusen von Code-Elementen gibt. Dirk Knop berichtet für Heise von einer [Schwachstelle in der Bedienoberfläche](https://www.heise.de/news/KI-Bot-OpenClaw-Moltbot-mit-hochriskanter-Codeschmuggel-Luecke-11161705.html), die Anfragen ohne Prüfung Vertrauen schenkt. Böswillige Akteur:innen können mit zum Gateway in den WebSocket-Verbindungsdaten übertragenen Zugriffstokens bei Klicks auf bösartige Websites oder vorgefertige Fraud Links Kontrolle über die Tokens im eigenen Server erhalten und sich auf dem Gateway anmelden. Dann haben die die Möglichkeit, Einstellungen zu verändern. Die Version Version 2026.1.29 soll das Problem schon behoben haben, ein Update ist also zwingend erforderlich.

Dennoch gibt es Bedenken, da beispielsweise auch betrügerische Download-Dateien – die aufgrund der doppelten Namensänderung eher angenommen werden könnten – mit ähnlichen Namen bei den Usern landen und auf ihren Geräten Schaden anrichten könnten. Versuche, sogenannte Typosquat Domains aufzubauen, [gab es schon](https://www.golem.de/news/clawdbot-moltbot-openclaw-nach-rasanten-namensaenderungen-unter-beschuss-2601-204840.html). Des Weiteren gibt es kein ausgearbeitetes Sicherheits-Backup für die Nutzung, bei der User diverse Daten und Zugriffe mit der AI-Assistenz teilen könnten. Expert:innen von Cisco nennen das Projekt gar [einen „Sicherheitsalbtraum“](https://blogs.cisco.com/ai/personal-ai-agents-like-openclaw-are-a-security-nightmare). Die Verbindung mit Messaging-Diensten erweitert die Angriffsfläche für Scammer und Hacker und vor Prompt Injection und Hacks, die API Keys erbeuten, ist das Projekt ebenfalls nicht gefeit. Wer also OpenClaw ausprobiert, sollte absolute Sicherheitsvorkehrungen antellen und die Zugriffsrechte prüfen.

## Die OpenClaw Bots verbinden sich in Agent-Socia-Netzwerk à la Reddit

Mit OpenClaw erstellte Agents tummeln sich unterdessen schon [in einem neuen Netzwerk namens Moltbook](https://www.zeit.de/wissen/2026-02/moltbook-kuenstliche-intelligenz-agenten-soziales-netzwerk). Dort diskutieren anschneinend KI-kreierte Agens untereinander ihre Erfahrungen und Aufgaben, aber auch aktuelle Ereignisse. Ob allerdings alle Posts genuin von den Bots abgesetzt oder doch durch Prompts von menschlichen Usern generiert werden, ist nicht ganz klar. Menschen können ihre AI Agents dort anmelden, Agents können es aber auch von sich aus tun.

![](_resources/7b85fc37ddea1f331264f69175ee2bf8_MD5%201.png)

Die Moltbook-Startseite, © Moltbook

Die Plattform erinnert an Reddit, sowohl von der Farbgebung und Maskottchenansicht als auch vom Aufbau her. Diese Plattform stammt aber nicht von OpenClaw und Peter Steinberger, sondern von [Matt Schlicht](https://x.com/mattprd), CEO von Octane AI. Das geht aus den Website-Informationen hervor. Diese Moltbook-Social-Media-Infrastruktur muss nicht auf Bots beziehungsweise Agents von OpenClaw beschränkt sein. Sie zeigt einen nächsten Schritt der agentischen KI-Entwicklung im Web mit seinen aufsehenerregneden und hochinteressanten Facetten, aber auch mit all seinen Gefahren. Schließlich können auch böswillig agierende oder gehackte Agents auf Moltbook mitdiskutieren, selbst wenn die Plattform Verifizierungsanfragen stellt.

OpenClaw, Moltbook und Co. dürften nur einige erste Ausläufer einer KI-Revolution im Web sowie auf den Geräten zahlreicher User sein, die die AI-Assistenz und die Eigenständigkeit der Agents völlig neu denkt. Die Möglichkeiten erscheinen kaum begrenzt, wohl oder übel.

---

### Nano Banana und automatisches Browsing in Chrome:

### Gemini Update erinnert an Atlas

![](_resources/6a7bba9c6e48775b723dfc0fbf36da1f_MD5%201.png)

© Google via Canva

Für Benachrichtigungen anmelden