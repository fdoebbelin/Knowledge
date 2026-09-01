`MariaDB` verwaltet Benutzer getrennt von den Betriebssystembenutzern. Jeder Benutzer wird mit einem `benutzername` und einem `hostname` definiert, z. B.:

```sql
'benutzername'@'hostname'
```

Der Host gibt an, von welchem Rechner aus sich der Benutzer anmelden darf (`'%'` bedeutet „von überall“).

#### **1. Benutzer erstellen**

```sql
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'sicherespasswort';
```

Dieser Befehl erstellt einen neuen Benutzer **testuser**, der sich nur von **localhost** anmelden kann.

#### **2. Benutzer anzeigen**

```sql
SELECT User, Host FROM mysql.user;
```

Zeigt eine Liste aller existierenden Benutzer in der Datenbank.

#### **3. Benutzer löschen**

```sql
DROP USER 'testuser'@'localhost';
```

Entfernt den Benutzer aus der Datenbank.