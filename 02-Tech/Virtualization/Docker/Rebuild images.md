Um in Docker Compose einen erzwungenen Neuaufbau der Images durchzuführen, kannst du den Befehl `--build` zusammen mit `docker-compose up` verwenden. Dadurch werden die Images neu gebaut, auch wenn sie seit dem letzten Build nicht geändert wurden.

Hier ist der Befehl:

```bash
docker-compose up --build
```

Falls du nur bestimmte Services neu bauen möchtest, kannst du den Servicenamen angeben, z. B.:

```bash
docker-compose up --build <service_name>
```

Wenn du außerdem möchtest, dass die bestehenden Container, Netzwerke und Images neu erstellt werden, kannst du den Befehl mit der Option `--force-recreate` erweitern:

```bash
docker-compose up --build --force-recreate
```

Dieser Befehl stellt sicher, dass die Images neu gebaut und die Container komplett neu erstellt werden.