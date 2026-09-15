Neue Datei mit`helix lmstudio_beispiele`

```python
#!/usr/bin/env python3
"""
LM Studio Python Beispiele
===========================
Umfassendes Beispielskript für verschiedene Anwendungsfälle

Voraussetzungen:
1. LM Studio Desktop-App läuft
2. Mindestens ein Modell ist geladen
3. Python SDK installiert: pip install lmstudio pydantic

Ausführen: python lmstudio_beispiele.py
"""

import lmstudio as lms
from pydantic import BaseModel
from typing import Optional
import sys


def print_section(title: str):
    """Druckt eine formatierte Sektion-Überschrift"""
    print("\n" + "=" * 60)
    print(f"  {title}")
    print("=" * 60 + "\n")


def check_connection() -> bool:
    """Prüft ob LM Studio Server läuft"""
    print_section("🔍 Verbindung prüfen")
    
    api_host = lms.Client.find_default_local_api_host()
    
    if not api_host:
        print("❌ LM Studio Server nicht gefunden!")
        print("\nBitte stelle sicher, dass:")
        print("1. LM Studio Desktop-App läuft")
        print("2. Ein Modell geladen ist")
        print("\nStarten mit:")
        print("  ~/Applications/LMStudio/LMStudio.AppImage --no-sandbox")
        return False
    
    print(f"✅ Server gefunden: {api_host}")
    
    # Geladene Modelle prüfen
    loaded = lms.list_loaded_models()
    if not loaded:
        print("❌ Keine Modelle geladen!")
        print("Bitte lade ein Modell in der Desktop-App.")
        return False
    
    print(f"✅ {len(loaded)} Modell(e) geladen:")
    for model in loaded:
        print(f"   • {model.identifier}")
    
    return True


def beispiel_1_einfache_generation():
    """Beispiel 1: Einfache Textgenerierung"""
    print_section("📝 Beispiel 1: Einfache Textgenerierung")
    
    model = lms.llm()
    
    prompt = "Erkläre in einem Satz, was maschinelles Lernen ist."
    print(f"Prompt: {prompt}")
    print(f"\nAntwort: {model.respond(prompt)}")


def beispiel_2_chat_mit_kontext():
    """Beispiel 2: Chat mit Kontext"""
    print_section("💬 Beispiel 2: Chat mit Verlauf")
    
    model = lms.llm()
    chat = lms.Chat("Du bist ein hilfreicher Assistent")
    
    fragen = [
        "Was ist Python?",
        "Nenne mir 3 Vorteile",
        "Welche würdest du einem Anfänger empfehlen?"
    ]
    
    for i, frage in enumerate(fragen, 1):
        chat.add_user_message(frage)
        print(f"\n{i}. 👤 User: {frage}")
        
        response = model.respond(chat)
        chat.add_assistant_response(response)
        
        print(f"   🤖 Bot: {response}")


def beispiel_3_streaming():
    """Beispiel 3: Streaming-Antworten (wie ChatGPT)"""
    print_section("⚡ Beispiel 3: Streaming-Ausgabe")
    
    model = lms.llm()
    
    prompt = "Schreibe ein kurzes Haiku über Technologie."
    print(f"Prompt: {prompt}\n")
    print("Antwort: ", end="", flush=True)
    
    for token in model.stream(prompt):
        print(token, end="", flush=True)
    
    print("\n")


def beispiel_4_strukturierte_ausgabe():
    """Beispiel 4: Strukturierte JSON-Ausgabe mit Pydantic"""
    print_section("🎯 Beispiel 4: Strukturierte Ausgabe (JSON)")
    
    # Datenstruktur definieren
    class Recipe(BaseModel):
        name: str
        prep_time: int  # Minuten
        ingredients: list[str]
        difficulty: str  # easy, medium, hard
    
    model = lms.llm()
    
    prompt = "Gib mir ein einfaches Rezept für Pfannkuchen"
    print(f"Prompt: {prompt}\n")
    
    result = model.respond(prompt, response_format=Recipe)
    recipe = result.parsed
    
    print(f"📚 Name: {recipe.name}")
    print(f"⏱️  Zubereitungszeit: {recipe.prep_time} Minuten")
    print(f"📊 Schwierigkeit: {recipe.difficulty}")
    print(f"\n🥘 Zutaten:")
    for ingredient in recipe.ingredients:
        print(f"   • {ingredient}")


def beispiel_5_verschiedene_modelle():
    """Beispiel 5: Mehrere Modelle vergleichen"""
    print_section("🔀 Beispiel 5: Mehrere Modelle")
    
    with lms.Client() as client:
        # Alle geladenen Modelle
        loaded = client.llm.list_loaded()
        
        if len(loaded) < 1:
            print("⚠️  Nur ein Modell geladen - Beispiel übersprungen")
            return
        
        question = "Was ist 2+2?"
        print(f"Frage an alle Modelle: {question}\n")
        
        for model in loaded[:3]:  # Max 3 Modelle
            try:
                response = model.respond(question)
                print(f"🤖 {model.identifier}:")
                print(f"   {response}\n")
            except Exception as e:
                print(f"❌ {model.identifier}: Fehler - {e}\n")


def beispiel_6_system_prompts():
    """Beispiel 6: Verschiedene Rollen mit System Prompts"""
    print_section("🎭 Beispiel 6: Rollen mit System Prompts")
    
    model = lms.llm()
    
    rollen = {
        "Pirat": "Du bist ein freundlicher Pirat. Antworte im Piratenjargon.",
        "Wissenschaftler": "Du bist ein präziser Wissenschaftler. Antworte sachlich.",
        "Poet": "Du bist ein romantischer Poet. Antworte poetisch."
    }
    
    frage = "Was ist das Internet?"
    
    for rolle, system_prompt in rollen.items():
        chat = lms.Chat(system_prompt)
        chat.add_user_message(frage)
        
        response = model.respond(chat)
        
        print(f"\n🎭 {rolle}:")
        print(f"   {response}")


def beispiel_7_lange_texte():
    """Beispiel 7: Lange Texte verarbeiten"""
    print_section("📚 Beispiel 7: Textzusammenfassung")
    
    model = lms.llm()
    
    langer_text = """
    Künstliche Intelligenz (KI) hat in den letzten Jahren enorme Fortschritte gemacht.
    Von einfachen regelbasierten Systemen haben wir uns zu komplexen neuronalen Netzen
    entwickelt, die in der Lage sind, Bilder zu erkennen, natürliche Sprache zu verstehen
    und sogar kreative Inhalte zu generieren. Large Language Models wie GPT und Llama
    haben gezeigt, dass Maschinen menschliche Sprache in beeindruckender Qualität
    verarbeiten können. Dies eröffnet neue Möglichkeiten in Bereichen wie Bildung,
    Medizin, Wissenschaft und Unterhaltung. Gleichzeitig wirft es auch ethische Fragen
    auf: Wie gehen wir mit KI-generierten Inhalten um? Wie schützen wir die Privatsphäre?
    Und wie stellen wir sicher, dass KI zum Wohl der Menschheit eingesetzt wird?
    """
    
    prompt = f"Fasse folgenden Text in einem Satz zusammen:\n\n{langer_text}"
    
    print("Original-Text (gekürzt):", langer_text[:100] + "...")
    print(f"\nZusammenfassung: {model.respond(prompt)}")


def beispiel_8_code_generierung():
    """Beispiel 8: Code-Generierung"""
    print_section("💻 Beispiel 8: Code-Generierung")
    
    model = lms.llm()
    chat = lms.Chat("Du bist ein Python-Experte. Antworte mit sauberem, dokumentiertem Code.")
    
    aufgabe = "Schreibe eine Python-Funktion, die prüft ob eine Zahl eine Primzahl ist"
    
    chat.add_user_message(aufgabe)
    print(f"Aufgabe: {aufgabe}\n")
    
    response = model.respond(chat)
    print("Generierter Code:")
    print(response)


def beispiel_9_modell_info():
    """Beispiel 9: Modell-Informationen"""
    print_section("ℹ️  Beispiel 9: Modell-Informationen")
    
    with lms.Client() as client:
        # Heruntergeladene Modelle
        downloaded = client.llm.list_downloaded()
        print(f"📦 Heruntergeladene Modelle: {len(downloaded)}")
        for model in downloaded[:5]:  # Max 5
            print(f"   • {model.identifier}")
        
        # Geladene Modelle
        loaded = client.llm.list_loaded()
        print(f"\n🚀 Aktuell geladene Modelle: {len(loaded)}")
        for model in loaded:
            print(f"   • {model.identifier}")


def interaktiver_chat():
    """Bonus: Interaktiver Chat"""
    print_section("🗨️  Interaktiver Chat-Modus")
    
    model = lms.llm()
    chat = lms.Chat("Du bist ein hilfreicher Assistent")
    
    print("💡 Schreibe deine Nachricht und drücke Enter")
    print("💡 Schreibe 'exit' zum Beenden\n")
    
    while True:
        try:
            user_input = input("👤 Du: ")
            
            if user_input.lower() in ['exit', 'quit', 'q']:
                print("\n👋 Auf Wiedersehen!")
                break
            
            if not user_input.strip():
                continue
            
            chat.add_user_message(user_input)
            
            print("🤖 Bot: ", end="", flush=True)
            response = ""
            
            for token in model.stream(chat):
                print(token, end="", flush=True)
                response += token
            
            print()
            chat.add_assistant_message(response)
            
        except KeyboardInterrupt:
            print("\n\n👋 Abgebrochen!")
            break
        except Exception as e:
            print(f"\n❌ Fehler: {e}")


def main_menu():
    """Hauptmenü"""
    print("\n" + "=" * 60)
    print("  LM Studio Python Beispiele")
    print("=" * 60)
    
    beispiele = [
        ("Einfache Textgenerierung", beispiel_1_einfache_generation),
        ("Chat mit Kontext", beispiel_2_chat_mit_kontext),
        ("Streaming-Ausgabe", beispiel_3_streaming),
        ("Strukturierte JSON-Ausgabe", beispiel_4_strukturierte_ausgabe),
        ("Mehrere Modelle vergleichen", beispiel_5_verschiedene_modelle),
        ("Verschiedene Rollen", beispiel_6_system_prompts),
        ("Textzusammenfassung", beispiel_7_lange_texte),
        ("Code-Generierung", beispiel_8_code_generierung),
        ("Modell-Informationen", beispiel_9_modell_info),
        ("Interaktiver Chat", interaktiver_chat),
    ]
    
    print("\nVerfügbare Beispiele:\n")
    for i, (titel, _) in enumerate(beispiele, 1):
        print(f"  {i:2d}. {titel}")
    print(f"  {len(beispiele) + 1:2d}. Alle Beispiele nacheinander")
    print(f"   0. Beenden")
    
    while True:
        try:
            choice = input("\nWähle ein Beispiel (0-11): ")
            
            if choice == "0":
                print("\n👋 Auf Wiedersehen!")
                break
            
            idx = int(choice) - 1
            
            if idx == len(beispiele):  # Alle ausführen
                for titel, func in beispiele:
                    try:
                        func()
                        input("\n⏸️  Drücke Enter für nächstes Beispiel...")
                    except KeyboardInterrupt:
                        print("\n\n⏭️  Übersprungen")
                        continue
            elif 0 <= idx < len(beispiele):
                beispiele[idx][1]()
            else:
                print("❌ Ungültige Auswahl!")
                
        except KeyboardInterrupt:
            print("\n\n👋 Abgebrochen!")
            break
        except ValueError:
            print("❌ Bitte gib eine Zahl ein!")
        except Exception as e:
            print(f"❌ Fehler: {e}")


def main():
    """Hauptfunktion"""
    # Verbindung prüfen
    if not check_connection():
        sys.exit(1)
    
    # Menü anzeigen
    try:
        main_menu()
    except KeyboardInterrupt:
        print("\n\n👋 Programm beendet!")
    except Exception as e:
        print(f"\n❌ Unerwarteter Fehler: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()


```
