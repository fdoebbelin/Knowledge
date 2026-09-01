---
aliases: 
tags: 
title: 5D3A Dekorator
---

Der in Flask verwendete Pfad-Dekorator `@app.route()` kann als eine Anwendung des Decorator-Entwurfsmusters betrachtet werden.

## Decorator Pattern in Flask

Der `@app.route()` Dekorator ist eine Implementierung des Decorator-Entwurfsmusters in Flask. Dieses Muster ermöglicht es, das Verhalten von Funktionen dynamisch zu erweitern, ohne deren Struktur zu ändern[4].

**Funktionsweise:**

- Der Dekorator wird über einer Funktion platziert und modifiziert deren Verhalten.
- In Flask wird `@app.route()` verwendet, um URL-Muster mit Funktionen zu verknüpfen, die diese Anfragen verarbeiten sollen.

## Vorteile des Decorator Patterns in Flask

1. **Trennung von Routing und Logik**: Der Dekorator trennt die URL-Definition von der eigentlichen Funktionslogik.
2. **Flexibilität**: Mehrere Routen können leicht derselben Funktion zugewiesen werden:

   ```python
   @app.route("/")
   @app.route("/home")
   @app.route("/index")
   def home():
       return "Hello World!"
   ```

3. **Erweiterbarkeit**: Zusätzliche Funktionalität kann einfach hinzugefügt werden, ohne den Kerncode zu ändern.

## Erweiterungen des Decorator Patterns

Flask nutzt das Decorator Pattern auch für andere Zwecke:

- **Vor-Anfrage-Verarbeitung**: Mit `@app.before_request()` können Funktionen definiert werden, die vor jeder Anfrage ausgeführt werden.
- **Fehlerbehandlung**: Dekoratoren wie `@app.errorhandler()` ermöglichen eine elegante Fehlerbehandlung.

## Benutzerdefinierte Dekoratoren

Entwickler können eigene Dekoratoren erstellen, um wiederholende Logik zu kapseln. Ein Beispiel ist ein Dekorator für die Authentifizierung:

```python
def require_api_key(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if request.headers.get('API-KEY') == 'my-secret-key':
            return f(*args, **kwargs)
        else:
            return jsonify({"error": "Unauthorized"}), 401
    return decorated_function

@app.route('/data')
@require_api_key
def get_data():
    return jsonify({"data": "Here is your data"})
```

- Zusammenfassend lässt sich sagen, 
	- dass der Pfad-Dekorator in Flask nicht nur ein praktisches Werkzeug für das URL-Routing ist, 
	- sondern auch ein hervorragendes Beispiel für die Anwendung des Decorator-Entwurfsmusters in der Webentwicklung darstellt. 
- Es ermöglicht eine 
	- saubere, modulare und erweiterbare Codestruktur 
	- in Flask-Anwendungen.