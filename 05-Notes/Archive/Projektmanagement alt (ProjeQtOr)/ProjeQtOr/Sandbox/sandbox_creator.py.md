
```python
#!/usr/bin/env python3
"""
ProjeQtOr Sandbox Automation Script
===================================

Automatisiert die Erstellung von Sandbox-Projekten und -Nutzern in ProjeQtOr
über die REST API.

Requirements:
    pip install requests pycryptodome

Usage:
    python sandbox_creator.py --config config.json
"""

import json
import requests
import base64
import hashlib
import secrets
import string
from datetime import datetime
from typing import Dict, Optional, Tuple
from Crypto.Cipher import AES
from Crypto.Util import Counter
import argparse
import logging

# Logging Setup
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class ProjeQtOrAPI:
    """ProjeQtOr REST API Client für Sandbox-Automatisierung"""
    
    def __init__(self, base_url: str, username: str, password: str):
        """
        Initialisiert den API Client
        
        Args:
            base_url: ProjeQtOr Server URL (z.B. https://projeqtor.example.com)
            username: Benutzername für API-Zugriff
            password: Passwort für API-Zugriff
        """
        self.base_url = base_url.rstrip('/')
        self.api_url = f"{self.base_url}/api"
        self.username = username
        self.password = password
        self.session = requests.Session()
        
        # Basic Auth Header setzen
        credentials = base64.b64encode(f"{username}:{password}".encode()).decode()
        self.session.headers.update({
            'Authorization': f'Basic {credentials}',
            'Content-Type': 'application/json'
        })
        
        # API Key für Verschlüsselung
        self.api_key = None
        self._get_api_key()
    
    def _get_api_key(self) -> None:
        """Holt den API Key des aktuellen Benutzers für Verschlüsselung"""
        try:
            response = self.session.get(f"{self.api_url}/User/search/name/{self.username}")
            if response.status_code == 200:
                data = response.json()
                if 'elements' in data and len(data['elements']) > 0:
                    user_data = data['elements'][0]
                    self.api_key = user_data.get('apiKey', '')
                    logger.info(f"API Key erfolgreich abgerufen für User: {self.username}")
                else:
                    raise Exception(f"Benutzer {self.username} nicht gefunden")
            else:
                raise Exception(f"Fehler beim Abrufen der User-Daten: {response.status_code}")
        except Exception as e:
            logger.error(f"Fehler beim Abrufen des API Keys: {e}")
            raise
    
    def _encrypt_data(self, data: str) -> str:
        """
        Verschlüsselt Daten mit AES-CTR für PUT/POST/DELETE Requests
        Implementiert die gleiche Logik wie ProjeQtOr's AesCtr PHP Klasse
        """
        if not self.api_key:
            raise Exception("API Key nicht verfügbar für Verschlüsselung")
        
        # AES Key aus API Key generieren (MD5 Hash)
        key = hashlib.md5(self.api_key.encode()).digest()
        
        # Initialer Vektor (Counter) erstellen
        nonce = secrets.token_bytes(8)
        counter = Counter.new(64, prefix=nonce, initial_value=0)
        
        # AES-CTR Cipher erstellen
        cipher = AES.new(key, AES.MODE_CTR, counter=counter)
        
        # Daten verschlüsseln
        encrypted = cipher.encrypt(data.encode('utf-8'))
        
        # Nonce + verschlüsselte Daten als Base64
        result = base64.b64encode(nonce + encrypted).decode()
        
        return result
    
    def test_connection(self) -> bool:
        """Testet die API-Verbindung"""
        try:
            response = self.session.get(f"{self.api_url}/Project/all")
            if response.status_code == 200:
                logger.info("✅ API-Verbindung erfolgreich getestet")
                return True
    
    def _set_project_manager(self, project_id: str, user_id: str) -> bool:
        """Setzt einen Benutzer als Projektleiter"""
        try:
            # Projekt aktualisieren mit Projektleiter
            project_update = {
                "id": project_id,
                "idUser": user_id  # Projektleiter setzen
            }
            
            json_data = json.dumps(project_update)
            encrypted_data = self._encrypt_data(json_data)
            
            response = self.session.put(
                f"{self.api_url}/Project",
                data=encrypted_data,
                headers={'Content-Type': 'application/json'}
            )
            
            if response.status_code == 200:
                logger.info("✅ Benutzer als Projektleiter gesetzt")
                return True
            else:
                logger.warning(f"⚠️  Projektleiter konnte nicht gesetzt werden: {response.status_code}")
                return False
                
        except Exception as e:
            logger.warning(f"⚠️  Fehler beim Setzen des Projektleiters: {e}")
            return False
            else:
                logger.error(f"❌ API-Test fehlgeschlagen: {response.status_code}")
                logger.error(f"Response: {response.text}")
                return False
        except Exception as e:
            logger.error(f"❌ Verbindungsfehler: {e}")
            return False
    
    def get_projects(self) -> list:
        """Holt alle Projekte"""
        try:
            response = self.session.get(f"{self.api_url}/Project/all")
            if response.status_code == 200:
                data = response.json()
                return data.get('elements', [])
            else:
                logger.error(f"Fehler beim Abrufen der Projekte: {response.status_code}")
                return []
        except Exception as e:
            logger.error(f"Fehler beim Abrufen der Projekte: {e}")
            return []
    
    def get_profiles(self) -> list:
        """Holt alle verfügbaren Profile"""
        try:
            response = self.session.get(f"{self.api_url}/Profile/all")
            if response.status_code == 200:
                data = response.json()
                return data.get('elements', [])
            else:
                logger.error(f"Fehler beim Abrufen der Profile: {response.status_code}")
                return []
        except Exception as e:
            logger.error(f"Fehler beim Abrufen der Profile: {e}")
            return []
    
    def create_project(self, project_data: Dict) -> Optional[Dict]:
        """
        Erstellt ein neues Projekt
        
        Args:
            project_data: Dictionary mit Projektdaten
            
        Returns:
            Dictionary mit erstelltem Projekt oder None bei Fehler
        """
        try:
            # Daten als JSON serialisieren und verschlüsseln
            json_data = json.dumps(project_data)
            encrypted_data = self._encrypt_data(json_data)
            
            response = self.session.post(
                f"{self.api_url}/Project",
                data=encrypted_data,
                headers={'Content-Type': 'application/json'}
            )
            
            if response.status_code == 200:
                result = response.json()
                logger.info(f"✅ Projekt erstellt: {project_data.get('name', 'Unbekannt')}")
                return result
            else:
                logger.error(f"❌ Projekt-Erstellung fehlgeschlagen: {response.status_code}")
                logger.error(f"Response: {response.text}")
                return None
                
        except Exception as e:
            logger.error(f"❌ Fehler beim Erstellen des Projekts: {e}")
            return None
    
    def create_user(self, user_data: Dict) -> Optional[Dict]:
        """
        Erstellt einen neuen Benutzer
        
        Args:
            user_data: Dictionary mit Benutzerdaten
            
        Returns:
            Dictionary mit erstelltem Benutzer oder None bei Fehler
        """
        try:
            # Daten als JSON serialisieren und verschlüsseln
            json_data = json.dumps(user_data)
            encrypted_data = self._encrypt_data(json_data)
            
            response = self.session.post(
                f"{self.api_url}/User",
                data=encrypted_data,
                headers={'Content-Type': 'application/json'}
            )
            
            if response.status_code == 200:
                result = response.json()
                logger.info(f"✅ Benutzer erstellt: {user_data.get('name', 'Unbekannt')}")
                return result
            else:
                logger.error(f"❌ Benutzer-Erstellung fehlgeschlagen: {response.status_code}")
                logger.error(f"Response: {response.text}")
                return None
                
        except Exception as e:
            logger.error(f"❌ Fehler beim Erstellen des Benutzers: {e}")
            return None
    
    def create_assignment(self, assignment_data: Dict) -> Optional[Dict]:
        """
        Erstellt eine Zuordnung (Assignment) zwischen Benutzer und Projekt
        
        Args:
            assignment_data: Dictionary mit Zuordnungsdaten
            
        Returns:
            Dictionary mit erstellter Zuordnung oder None bei Fehler
        """
        try:
            # Daten als JSON serialisieren und verschlüsseln
            json_data = json.dumps(assignment_data)
            encrypted_data = self._encrypt_data(json_data)
            
            response = self.session.post(
                f"{self.api_url}/Assignment",
                data=encrypted_data,
                headers={'Content-Type': 'application/json'}
            )
            
            if response.status_code == 200:
                result = response.json()
                logger.info("✅ Zuordnung erstellt")
                return result
            else:
                logger.error(f"❌ Zuordnung-Erstellung fehlgeschlagen: {response.status_code}")
                logger.error(f"Response: {response.text}")
                return None
                
        except Exception as e:
            logger.error(f"❌ Fehler beim Erstellen der Zuordnung: {e}")
            return None

class SandboxCreator:
    """Hauptklasse für die Sandbox-Erstellung"""
    
    def __init__(self, config_file: str):
        """
        Initialisiert den SandboxCreator
        
        Args:
            config_file: Pfad zur Konfigurationsdatei
        """
        self.config = self._load_config(config_file)
        self.api = ProjeQtOrAPI(
            self.config['server']['url'],
            self.config['server']['username'],
            self.config['server']['password']
        )
    
    def _load_config(self, config_file: str) -> Dict:
        """Lädt die Konfiguration aus JSON-Datei"""
        try:
            with open(config_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            logger.error(f"Konfigurationsdatei nicht gefunden: {config_file}")
            raise
        except json.JSONDecodeError as e:
            logger.error(f"Fehler beim Parsen der Konfigurationsdatei: {e}")
            raise
    
    def _generate_password(self, length: int = 12) -> str:
        """Generiert ein sicheres Passwort"""
        alphabet = string.ascii_letters + string.digits + "!@#$%^&*"
        return ''.join(secrets.choice(alphabet) for _ in range(length))
    
    def _generate_unique_name(self, prefix: str) -> str:
        """Generiert einen eindeutigen Namen mit Zeitstempel"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        return f"{prefix}_{timestamp}"
    
    def create_sandbox(self, sandbox_name: Optional[str] = None) -> Tuple[bool, Dict]:
        """
        Erstellt eine komplette Sandbox (Projekt + Benutzer + Zuordnung)
        
        Args:
            sandbox_name: Optional benutzerdefinierter Name für die Sandbox
            
        Returns:
            Tuple (success: bool, result: dict)
        """
        try:
            # Eindeutige Namen generieren
            if not sandbox_name:
                sandbox_name = self._generate_unique_name("Sandbox")
            
            username = self._generate_unique_name("sandbox_user")
            password = self._generate_password()
            
            logger.info(f"🚀 Erstelle Sandbox: {sandbox_name}")
            
            # 1. Projekt erstellen
            project_data = {
                "name": sandbox_name,
                "description": f"Automatisch erstellte Sandbox - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
                "projectType": self.config['project']['project_type'],
                "color": self.config['project'].get('color', '#4CAF50'),
                "sortOrder": "999"
            }
            
            # Optional: Parent Project setzen
            if self.config['project'].get('parent_project_id'):
                project_data['idProject'] = self.config['project']['parent_project_id']
            
            project_result = self.api.create_project(project_data)
            if not project_result:
                return False, {"error": "Projekt konnte nicht erstellt werden"}
            
            # Projekt ID extrahieren
            if 'elements' in project_result and len(project_result['elements']) > 0:
                project_id = project_result['elements'][0]['id']
            else:
                project_id = project_result.get('id')
            
            if not project_id:
                return False, {"error": "Projekt ID konnte nicht ermittelt werden"}
            
            # 2. Benutzer erstellen
            user_data = {
                "name": username,
                "realName": f"Sandbox User {username}",
                "email": f"{username}@sandbox.local",
                "password": password,
                "idProfile": self.config['user']['profile_id'],
                "description": f"Automatisch erstellter Sandbox-Benutzer für {sandbox_name}"
            }
            
            user_result = self.api.create_user(user_data)
            if not user_result:
                return False, {
                    "error": "Benutzer konnte nicht erstellt werden",
                    "project_id": project_id
                }
            
            # Benutzer ID extrahieren
            if 'elements' in user_result and len(user_result['elements']) > 0:
                user_id = user_result['elements'][0]['id']
            else:
                user_id = user_result.get('id')
            
            if not user_id:
                return False, {
                    "error": "Benutzer ID konnte nicht ermittelt werden",
                    "project_id": project_id
                }
            
            # 3. Zuordnung erstellen (Benutzer dem Projekt zuweisen)
            assignment_data = {
                "idProject": project_id,
                "idResource": user_id,
                "idProfile": self.config['user']['profile_id'],
                "rate": "100",  # 100% Zuordnung
                "description": f"Vollzugriff auf Sandbox-Projekt {sandbox_name}"
            }
            
            assignment_result = self.api.create_assignment(assignment_data)
            
            # 4. Optional: Benutzer als Projektleiter setzen (falls konfiguriert)
            if self.config.get('user', {}).get('make_project_manager', False):
                self._set_project_manager(project_id, user_id)
            
            # Erfolgsergebnis zusammenstellen
            result = {
                "success": True,
                "sandbox_name": sandbox_name,
                "project": {
                    "id": project_id,
                    "name": sandbox_name,
                    "url": f"{self.api.base_url}/view/dynamicDialog.php?class=Project&id={project_id}"
                },
                "user": {
                    "id": user_id,
                    "username": username,
                    "password": password,
                    "email": user_data['email'],
                    "login_url": f"{self.api.base_url}"
                },
                "assignment": {
                    "created": assignment_result is not None,
                    "profile_id": self.config['user']['profile_id']
                },
                "created_at": datetime.now().isoformat()
            }
            
            logger.info("🎉 Sandbox erfolgreich erstellt!")
            logger.info(f"   📁 Projekt: {sandbox_name} (ID: {project_id})")
            logger.info(f"   👤 Benutzer: {username}")
            logger.info(f"   🔐 Passwort: {password}")
            
            return True, result
            
        except Exception as e:
            logger.error(f"❌ Fehler bei der Sandbox-Erstellung: {e}")
            return False, {"error": str(e)}
    
    def list_sandboxes(self) -> list:
        """Listet alle Sandbox-Projekte auf"""
        try:
            projects = self.api.get_projects()
            sandboxes = [
                p for p in projects 
                if p.get('name', '').startswith('Sandbox_') or 
                   'sandbox' in p.get('description', '').lower()
            ]
            return sandboxes
        except Exception as e:
            logger.error(f"Fehler beim Abrufen der Sandboxes: {e}")
            return []
    
    def test_api_access(self) -> bool:
        """Testet den API-Zugriff"""
        logger.info("🔍 Teste API-Zugriff...")
        
        # Verbindung testen
        if not self.api.test_connection():
            return False
        
        # Profile prüfen
        profiles = self.api.get_profiles()
        profile_names = [p.get('name', 'Unbekannt') for p in profiles]
        logger.info(f"📋 Verfügbare Profile: {', '.join(profile_names)}")
        
        # Konfiguriertes Profil prüfen
        target_profile_id = self.config['user']['profile_id']
        profile_exists = any(str(p.get('id')) == str(target_profile_id) for p in profiles)
        
        if profile_exists:
            logger.info(f"✅ Konfiguriertes Profil (ID: {target_profile_id}) gefunden")
        else:
            logger.error(f"❌ Konfiguriertes Profil (ID: {target_profile_id}) nicht gefunden")
            return False
        
        return True

def create_sample_config():
    """Erstellt eine Beispiel-Konfigurationsdatei"""
    config = {
        "server": {
            "url": "https://projeqtor.example.com",
            "username": "api_user",
            "password": "api_password"
        },
        "project": {
            "project_type": "Development",
            "color": "#4CAF50",
            "parent_project_id": None
        },
        "user": {
            "profile_id": "3"
        }
    }
    
    with open('config_sample.json', 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=2, ensure_ascii=False)
    
    print("📝 Beispiel-Konfigurationsdatei erstellt: config_sample.json")
    print("   Bitte anpassen und als config.json speichern!")

def main():
    """Hauptfunktion mit CLI-Interface"""
    parser = argparse.ArgumentParser(description='ProjeQtOr Sandbox Automation')
    parser.add_argument('--config', default='config.json', help='Pfad zur Konfigurationsdatei')
    parser.add_argument('--test', action='store_true', help='Nur API-Zugriff testen')
    parser.add_argument('--list', action='store_true', help='Bestehende Sandboxes auflisten')
    parser.add_argument('--create', help='Neue Sandbox erstellen (optional: Name angeben)')
    parser.add_argument('--sample-config', action='store_true', help='Beispiel-Konfiguration erstellen')
    
    args = parser.parse_args()
    
    if args.sample_config:
        create_sample_config()
        return
    
    try:
        creator = SandboxCreator(args.config)
        
        if args.test:
            success = creator.test_api_access()
            exit(0 if success else 1)
        
        elif args.list:
            sandboxes = creator.list_sandboxes()
            if sandboxes:
                print(f"\n📦 Gefundene Sandboxes ({len(sandboxes)}):")
                for sb in sandboxes:
                    print(f"   • {sb.get('name', 'Unbekannt')} (ID: {sb.get('id', 'N/A')})")
            else:
                print("📦 Keine Sandboxes gefunden")
        
        elif args.create is not None:
            sandbox_name = args.create if args.create else None
            success, result = creator.create_sandbox(sandbox_name)
            
            if success:
                print("\n🎉 Sandbox erfolgreich erstellt!")
                print(f"📁 Projekt: {result['project']['name']}")
                print(f"👤 Benutzer: {result['user']['username']}")
                print(f"🔐 Passwort: {result['user']['password']}")
                print(f"🔗 Login: {result['user']['login_url']}")
                
                # Ergebnis in Datei speichern
                output_file = f"sandbox_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
                with open(output_file, 'w', encoding='utf-8') as f:
                    json.dump(result, f, indent=2, ensure_ascii=False)
                print(f"💾 Details gespeichert in: {output_file}")
            else:
                print(f"❌ Fehler: {result.get('error', 'Unbekannter Fehler')}")
                exit(1)
        
        else:
            parser.print_help()
    
    except FileNotFoundError:
        print(f"❌ Konfigurationsdatei nicht gefunden: {args.config}")
        print("💡 Verwenden Sie --sample-config zum Erstellen einer Beispiel-Konfiguration")
        exit(1)
    except Exception as e:
        print(f"❌ Fehler: {e}")
        exit(1)

if __name__ == "__main__":
    main()
```
