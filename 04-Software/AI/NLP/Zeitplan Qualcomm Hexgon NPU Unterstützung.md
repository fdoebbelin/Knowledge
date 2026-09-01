Die vollständige Unterstützung der Qualcomm GPU und NPU über DirectML für Copilot+ PCs ist in der Entwicklung, aber ein genauer Zeitplan ist noch nicht bekannt. Hier sind die wichtigsten Informationen zum aktuellen Stand:

## Aktuelle Entwicklungen

**Unterstützung für Copilot+ PCs**
DirectML unterstützt jetzt Copilot+ PCs, die von der Qualcomm Hexagon NPU im Snapdragon X Elite Compute Platform angetrieben werden[2]. Dies ermöglicht Entwicklern, die Leistung dieser NPUs für KI-Anwendungen auf Windows zu nutzen.

**Systemanforderungen**
Für die Nutzung von DirectML auf Copilot+ PCs gelten folgende Mindestanforderungen:
- DirectML Version 1.15.2 (ARM64) oder höher
- ONNX Runtime Version 1.18 (ARM64) oder höher
- Windows 11, Version 24H2 oder neuer
- Qualcomm Hexagon NPU Treiber Version 30.0.31.250 oder neuer[3]

## Zukünftige Entwicklungen

**Erweiterung der Unterstützung**
Microsoft plant, die Unterstützung für NPUs auf Copilot+ PCs und Frameworks wie WebNN und ONNX Runtime weiter auszubauen[2]. Allerdings wurde kein konkreter Zeitplan für diese Erweiterungen veröffentlicht.

**Verfügbarkeit von Anwendungen**
Einige Anwendungen, die die NPU-Unterstützung nutzen, werden voraussichtlich Anfang 2025 auf Snapdragon X Series-Geräten kommerziell verfügbar sein[5].

**Entwicklervorschau und Einschränkungen**
Derzeit befindet sich die Unterstützung noch in einer Entwicklervorschau-Phase. Es gibt noch einige Einschränkungen und Probleme:
- Die erste Version weist schwerwiegende Fehler auf, die sie fast unbenutzbar machen.
- Die Anzahl der unterstützten Modelle ist begrenzt, was die Anwendungsmöglichkeiten einschränkt[6].

Zusammenfassend lässt sich sagen, dass die Unterstützung für Qualcomm GPUs und NPUs über DirectML stetig voranschreitet, aber noch kein vollständiger Zeitplan für eine umfassende Unterstützung vorliegt. Entwickler und Nutzer sollten die offiziellen Ankündigungen von Microsoft und Qualcomm im Auge behalten, um über zukünftige Fortschritte und Veröffentlichungen informiert zu bleiben.

Quellen
[1] Entwicklerhandbuch – Copilot+-PCs | Microsoft Learn https://learn.microsoft.com/de-de/windows/ai/npu-devices/
[2] DirectML expands NPU support to Copilot+ PCs and WebNN https://blogs.windows.com/windowsdeveloper/2024/08/29/directml-expands-npu-support-to-copilot-pcs-and-webnn/
[3] Microsoft DirectML now supports Copilot+ PCs and WebNN - Neowin https://www.neowin.net/news/microsoft-directml-now-supports-copilot-pcs-and-webnn/
[4] DirectML unlocks new silicon for AI experiences across Windows ... https://blogs.windows.com/windowsdeveloper/2024/11/12/directml-unlocks-new-silicon-for-ai-experiences-across-windows-copilot-pcs/
[5] Elevating AI in Capture One with DirectML and Qualcomm Hexagon ... https://www.qualcomm.com/developer/blog/2024/10/elevating-ai-capture-one-directml-qualcomm-hexagon-npu
[6] DirectML on Arm is here at last, almost - InfoWorld https://www.infoworld.com/article/3504916/directml-on-arm-is-here-at-last.html
