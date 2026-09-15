---
title: "Understanding usage and length limits | Claude Help Center"
source: "https://support.claude.com/en/articles/11647753-understanding-usage-and-length-limits"
author:
published:
created: 2026-02-20
description:
tags:
  - "clippings"
---
Wenn Sie mit Claude chatten, stoßen Sie möglicherweise auf zwei verschiedene Arten von Einschränkungen, die auf unterschiedliche Weise funktionieren: **Nutzungsgrenzen** und **Längengrenzen**. Wenn Sie den Unterschied zwischen diesen verstehen, können Sie Claude effektiver nutzen.

Nutzungsgrenzen steuern, wie viel Sie über einen bestimmten Zeitraum mit Claude interagieren können. Stellen Sie sich dies als Ihr „Konversationsbudget“ vor, das bestimmt, wie viele Nachrichten Sie an Claude senden können oder wie lange Sie mit Claude Code arbeiten können, bevor Sie warten müssen, bis Ihr Limit zurückgesetzt wird.

Ihre Nutzung wird von mehreren Faktoren beeinflusst, darunter der Länge und Komplexität Ihrer Gespräche, den von Ihnen verwendeten Funktionen und dem Claude-Modell, mit dem Sie chatten. Verschiedene Abonnementpläne (Pro, Max, Team usw.) haben unterschiedliche Nutzungsfreibeträge, wobei kostenpflichtige Pläne höhere Limits bieten.

Beachten Sie, dass Ihre Nutzung aller verschiedenen Claude-Produktoberflächen (claude.ai, Claude Code, Claude Desktop) auf dasselbe Nutzungslimit angerechnet wird.

Abhängig von Ihrem Plan gibt es verschiedene Möglichkeiten, Ihre Nutzung zu steigern:

- Wenn Sie einen kostenpflichtigen Plan verwenden, einschließlich Pro-, Max-, Team- oder sitzplatzbasierter Enterprise-Pläne, finden Sie in diesen Artikeln Einzelheiten zum Kauf zusätzlicher Nutzung:
	- **[Zusätzliche Nutzung für kostenpflichtige Claude-Pläne](https://support.claude.com/en/articles/12429409-extra-usage-for-paid-claude-plans)**
	- **[Zusätzliche Nutzung für team- und sitzbasierte Enterprise-Pläne](https://support.claude.com/en/articles/12005970-extra-usage-for-team-and-seat-based-enterprise-plans)**
- Wenn Ihr Unternehmen über einen nutzungsbasierten Enterprise-Plan verfügt, basiert Ihre Nutzung auf dem Verbrauch. Weitere Informationen finden Sie in diesem Artikel: **[Wie werden mir meine Enterprise-Pläne in Rechnung gestellt?](https://support.claude.com/en/articles/11526368-how-am-i-billed-for-my-enterprise-plan)**

Strategien zur Maximierung Ihrer Nachrichtenzuteilung finden Sie unter **[Best Practices für Nutzungslimits](https://support.claude.com/en/articles/9797557-usage-limit-best-practices)**.

Längenbeschränkungen beziehen sich auf Claudes Kontextfenster—die Menge an Informationen, mit denen Claude in einem einzigen Chat arbeiten kann. Stellen Sie sich das Kontextfenster als Claudes Arbeitsgedächtnis vor, das bestimmt, wie viele Inhalte es gleichzeitig verarbeiten und sich merken kann.

Die Kontextfenstergröße von Claude beträgt 200.000 Token für alle Modelle und kostenpflichtigen Pläne, mit einer Ausnahme: Claude Sonnet 4.5 verfügt über ein 500.000-Kontextfenster für Benutzer von Enterprise-Plänen. Weitere Informationen finden Sie unter **[Was ist der Enterprise-Plan?](https://support.claude.com/en/articles/9797531-what-is-the-enterprise-plan)**

Für Benutzer mit aktivierter Codeausführung verwaltet Claude jetzt automatisch lange Gespräche. Wenn sich Ihr Gespräch der Kontextfenstergrenze nähert, fasst Claude frühere Nachrichten zusammen, um das Gespräch nahtlos fortzusetzen. So können Sie längere, natürlichere Gespräche mit weniger Unterbrechungen führen.

Ihr vollständiger Chatverlauf bleibt erhalten, sodass Claude auch nach der Zusammenfassung darauf verweisen kann. Sie können gelegentlich sehen, dass Claude während langer Gespräche „seine Gedanken organisiert“ —dies deutet darauf hin, dass das automatische Kontextmanagement funktioniert.

**Hinweis:****[Die Codeausführung muss aktiviert sein](https://support.claude.com/en/articles/12111783-create-and-edit-files-with-claude#h_1c99382190)** zur automatischen Kontextverwaltung. Seltene Randfälle (z. B. sehr große erste Nachrichten) können immer noch auf Kontextbeschränkungen stoßen.

Obwohl Sie die feste Kontextfenstergröße für Ihren Plan nicht erhöhen können, können Sie diese Strategien verwenden, um den verfügbaren Kontextraum zu maximieren und sowohl Ihr Kontextfenster als auch Ihre Nutzungsgrenzen zu optimieren:

- **Projekte effektiv nutzen:** Projekte verwenden Retrieval-Augmented Generation (RAG), wodurch Claude effizienter mit größeren Informationsmengen arbeiten kann, indem nur relevante Inhalte in das Kontextfenster geladen werden.
- **Projektanweisungen kürzen:** Halten Sie Ihre Projektanweisungen prägnant und konzentrieren Sie sich auf wesentliche Informationen. Claude schneidet am besten ab, wenn Sie Projektanweisungen für den allgemeinen Kontext Ihres Projekts, wichtige Richtlinien und Claudes Rolle verwenden. Reservieren Sie aufgabenspezifische Anweisungen für den Chat selbst.
- **Nicht verwendete Projektdateien entfernen:** Bereinigen Sie regelmäßig Dateien, die Sie nicht mehr aktiv in Ihren Projekten verwenden.
- **Erweitertes Denken ausschalten:** Schalten Sie diese Funktion aus, wenn Sie Claudes verbesserte Argumentation für eine bestimmte Aufgabe nicht benötigen.
- **Deaktivieren Sie vorübergehend nicht kritische Tools und Konnektoren:** Deaktivieren Sie Websuch-, Forschungs- und MCP-Konnektoren in Ihren „Such- und Tool“-Einstellungen, wenn sie für bestimmte Konversationen nicht benötigt werden.

**Hinweis:** Tools und Konnektoren sind tokenintensiv, daher hilft ihre Verwaltung sowohl dabei, Ihr verfügbares Kontextfenster zu maximieren als auch Ihre Nutzungsgrenzen zu optimieren.

Der Hauptunterschied besteht darin, dass die Nutzung die Kontrolle einschränkt *Wie viel* Sie können Claude in allen Ihren Gesprächen verwenden, während die Längenbeschränkungen kontrollieren *Wie lange* Jedes einzelne Gespräch kann werden. Bei Nutzungsgrenzen geht es um die Quantität im Zeitverlauf, während es bei Längengrenzen um die Tiefe und Komplexität einzelner Gespräche geht.

Wenn Sie Ihr Nutzungslimit erreichen, müssen Sie warten, bis es zurückgesetzt wird, Ihren Plan aktualisieren oder zusätzliche Nutzung erwerben. Wenn Sie ein Längenlimit erreichen, können Sie ein neues Gespräch beginnen oder verwenden **[Funktionen wie Projekte](https://support.claude.com/en/articles/9517075-what-are-projects)** um effizienter mit großen Informationsarbeiten zu können.