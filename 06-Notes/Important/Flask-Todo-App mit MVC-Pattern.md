Um die bestehende Flask-Todo-App in ein MVC-Pattern umzustrukturieren und Flask-Migrate zur Datenbankeinrichtung zu verwenden, sollten wir den Code aufteilen, um Model-, View- und Controller-Schichten zu trennen. Zudem ersetzen wir `db.create_all()` durch Migrationsbefehle.

### Schritt-für-Schritt-Anpassungen

1. **Projektstruktur anpassen**
    
    Erstelle eine Verzeichnisstruktur nach dem MVC-Prinzip:
    
    ```
    /todo_app
    ├── app.py                  # Haupt-Startpunkt der App
    ├── config.py               # Konfigurationsdateien
    ├── models/
    │   ├── __init__.py         # Initialisierung
    │   └── task_model.py       # Task-Model
    ├── controllers/
    │   ├── __init__.py         # Initialisierung
    │   └── task_controller.py  # Controller-Funktionen
    ├── templates/              # HTML-Templates
    │   ├── index.html
    │   ├── add_task.html
    │   └── edit_task.html
    └── migrations/             # Migrationsdateien (erstellt durch Flask-Migrate)
    ```
    
2. **Konfigurationsdatei erstellen (`config.py`)**
    
    ```python
    # config.py
    import os
    
    class Config:
        SQLALCHEMY_DATABASE_URI = 'sqlite:///todo.db'
        SECRET_KEY = os.environ.get('SECRET_KEY', 'your_secret_key')
        SQLALCHEMY_TRACK_MODIFICATIONS = False
    ```
    
3. **Models definieren (`task_model.py`)**
    
    Verschiebe die `Task`- und `User`-Modelle in `models/task_model.py`:
    
    ```python
    # models/task_model.py
    from flask_sqlalchemy import SQLAlchemy
    from flask_login import UserMixin
    
    db = SQLAlchemy()
    
    class Task(db.Model):
        __tablename__ = 'tasks'
        id = db.Column(db.Integer, primary_key=True)
        title = db.Column(db.String(100), nullable=False)
        description = db.Column(db.String(200))
        done = db.Column(db.Boolean, default=False)
    
    class User(UserMixin, db.Model):
        __tablename__ = 'users'
        id = db.Column(db.Integer, primary_key=True)
        username = db.Column(db.String(80), unique=True, nullable=False)
        password = db.Column(db.String(120), nullable=False)
    ```
    
4. **Controller erstellen (`task_controller.py`)**
    
    Verschiebe die Routen-Logik in `controllers/task_controller.py`:
    
    ```python
    # controllers/task_controller.py
    from flask import render_template, request, redirect, url_for, jsonify
    from flask_login import login_required, current_user
    from models.task_model import Task, db
    
    def index():
        tasks = Task.query.all()
        return render_template('index.html', tasks=tasks)
    
    def add_task():
        if request.method == 'POST':
            title = request.form['title']
            description = request.form['description']
            new_task = Task(title=title, description=description)
            db.session.add(new_task)
            db.session.commit()
            return redirect(url_for('index'))
        return render_template('add_task.html')
    
    # Weitere Controller-Funktionen hier
    ```
    
5. **App Initialisierung und Flask-Migrate einrichten**
    
    In `app.py`:
    
    ```python
    from flask import Flask
    from config import Config
    from models.task_model import db
    from controllers import task_controller
    from flask_migrate import Migrate
    
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    migrate = Migrate(app, db)
    
    app.add_url_rule('/', 'index', task_controller.index)
    app.add_url_rule('/add', 'add_task', task_controller.add_task, methods=['GET', 'POST'])
    
    if __name__ == '__main__':
        app.run(debug=True)
    ```
    
6. **Flask-Migrate verwenden**
    
    - Installiere Flask-Migrate:
        
        ```bash
        pip install Flask-Migrate
        ```
        
    - Initialisiere die Migrationen:
        
        ```bash
        flask db init
        flask db migrate -m "Initial migration."
        flask db upgrade
        ```
        

Diese Änderungen strukturieren die App gemäß dem MVC-Muster und richten die Datenbank mithilfe von Flask-Migrate ein.