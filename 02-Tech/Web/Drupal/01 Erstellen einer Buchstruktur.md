---
title: "DeepSeek"
source: "https://chat.deepseek.com/a/chat/s/c7183630-0a85-41db-8120-67a5946f3c33"
author:
published:
created: 2025-04-14
description: "Chat with DeepSeek AI – your intelligent assistant for coding, content creation, file reading, and more. Upload documents, engage in long-context conversations, and get expert help in AI, natural language processing, and beyond. | 深度求索（DeepSeek）助力编程代码开发、创意写作、文件处理等任务，支持文件上传及长文本对话，随时为您提供高效的AI支持。"
tags:
  - "clippings"
---
### Handlungsanweisung: Erstellen einer Buchstruktur mit dem Paragraphs-Modul in Drupal 10  
**Ziel**: Eine hierarchische Inhaltsstruktur (ähnlich dem Book-Modul) mit Kapiteln, Unterkapiteln und automatischer Navigation erstellen.  

---

#### **1. Vorbereitung**  
**Benötigte Module**:  
- **Paragraphs** (und Abhängigkeiten: *Entity Reference Revisions*)  
- **Menu Block** (für die Navigation)  
- **Twig Tweak** (optional, für Template-Logik)  

**Installation**:  
```bash
composer require drupal/paragraphs drupal/menu_block drupal/twig_tweak  
drush en paragraphs menu_block twig_tweak  
```

---

#### **2. Paragraph-Typen erstellen**  
**Schritt 1**: *Kapitel-Paragraph*  
- Gehe zu **Structure > Paragraph types > Add paragraph type**  
- **Name**: `Kapitel`  
- **Felder hinzufügen**:  
  - **Textfeld**: `Titel` (Maschinenname: `field_kapitel_titel`, Typ: *Plain Text*)  
  - **Inhaltsfeld**: `Inhalt` (Maschinenname: `field_kapitel_inhalt`, Typ: *Text (formatted, long)*)  
  - **Paragraph-Referenz**: `Unterkapitel` (Maschinenname: `field_unterkapitel`, Typ: *Paragraph*, Erlaubte Typen: `Kapitel`)  
    → *Einstellung: "Unlimited" für mehrstufige Hierarchie*  

---

#### **3. Content-Typ für das Buch**  
**Schritt 1**: *Content-Typ "Buch" anlegen*  
- Gehe zu **Structure > Content types > Add content type**  
- **Name**: `Buch`  
- **Felder hinzufügen**:  
  - **Paragraphs-Feld**: `Kapitelstruktur` (Maschinenname: `field_kapitelstruktur`, Typ: *Paragraph*, Erlaubte Typen: `Kapitel`)  

---

#### **4. Inhaltshierarchie erstellen**  
**Beispiel**: *Buch "Drupal-Guide" mit zwei Kapiteln und Unterkapiteln*  
1. **Neuen Inhalt erstellen**: Content > Add content > Buch  
   - **Titel**: `Drupal-Guide`  
2. **Kapitel hinzufügen**:  
   - Klicke auf *"Add Paragraph"* > `Kapitel`  
   - **Titel**: `Installation`  
   - **Inhalt**: Text zur Installation  
   - **Unterkapitel hinzufügen**:  
     - Klicke auf *"Add Paragraph"* innerhalb von `Unterkapitel`  
     - **Titel**: `Systemvoraussetzungen`, **Inhalt**: Beschreibung  
3. Wiederhole dies für ein zweites Kapitel `Konfiguration` mit Unterkapiteln.  

---

#### **5. Navigation automatisieren**  
**Option 1**: *Menüblock mit Hierarchie*  
1. **Menü erstellen**:  
   - Gehe zu **Structure > Menus > Add menu**  
   - **Name**: `Buch-Navigation`  
2. **Menüeinträge automatisch generieren** (via *Custom Code* oder Modul wie **Menu Block**):  
   - Nutze einen **View** oder ein **Custom Modul**, um die Kapitelstruktur als Menübaum zu exportieren.  

**Option 2**: *Template-Anpassung*  
1. **Template für den Buch-Content-Typ** (`node--buch.html.twig`):  
   ```twig
   {% extends "node.html.twig" %}  
   {% block content %}  
     <div class="buch-struktur">  
       {{ content.field_kapitelstruktur }}  
       {{ drupal_menu('buch-navigation') }}  {# Mit Twig Tweak #}  
     </div>  
   {% endblock %}  
   ```  
2. **CSS/JS für Einrückungen** hinzufügen, um Unterkapitel visuell zu gliedern.  

---

#### **6. Breadcrumb-Anpassung**  
- Installiere **Custom Breadcrumbs** oder füge in der `THEME.theme`-Datei hinzu:  
  ```php  
  function THEME_preprocess_breadcrumb(&$variables) {  
    // Logik zur Erkennung der aktuellen Kapitelposition  
  }  
  ```  

---

#### **7. Rechteverwaltung**  
- Gehe zu **People > Permissions**:  
  - Erlaube *Authenticated Users* das Bearbeiten von Paragraphs (`administer paragraphs`).  

---

#### **8. Ergebnisprüfung**  
- **Frontend**: Die Buchseite zeigt eine verschachtelte Kapitelliste mit automatischer Navigation.  
- **Bearbeitung**: Redakteure können im Backend per Drag-and-Drop Kapitel verschieben oder Unterkapitel hinzufügen.  

---

#### **Hinweise & Troubleshooting**  
- **Verschachtelungstiefe**: Begrenze die Anzahl der Unterkapitel-Ebenen in den Paragraph-Einstellungen, um Performance-Probleme zu vermeiden.  
- **Caching**: Deaktiviere Caching während der Entwicklung oder nutze *Dynamic Page Cache* mit passenden Tags.  
- **Alternative**: Für komplexe Bücher kann **Content Moderation** für Entwurfsstatus ergänzt werden.  

---

Mit dieser Anleitung lässt sich eine flexible Buchstruktur erstellen, die die Kernfunktionen des Book-Moduls nachbildet, aber durch Paragraphs erweiterbar bleibt.