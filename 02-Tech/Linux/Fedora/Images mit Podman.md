Hier ist eine Schritt-für-Schritt-Anleitung zum Erstellen eines lokalen Images mit Podman:

## Grundlegender Build-Befehl

```bash
podman build -t mein-image:tag .
```

- `-t`: Tag für das Image (Name und optional Version)
- `.`: Pfad zum Build-Kontext (Verzeichnis mit dem Dockerfile)

## Beispiel mit einem einfachen Dockerfile

Erstelle zunächst ein `Dockerfile`:

```dockerfile
FROM alpine:latest
RUN apk add --no-cache curl
COPY . /app
WORKDIR /app
CMD ["echo", "Hello from Podman!"]
```

Dann baue das Image:

```bash
podman build -t mein-alpine-app:latest .
```

## Nützliche Build-Optionen

```bash
# Mit spezifischem Dockerfile-Namen
podman build -f custom.dockerfile -t mein-image .

# Build-Argumente übergeben
podman build --build-arg VERSION=1.0 -t mein-image .

# Ohne Cache bauen
podman build --no-cache -t mein-image .

# Mit Labels
podman build --label version=1.0 -t mein-image .

# Mehrstufiger Build
podman build --target production -t mein-image .
```

## Image überprüfen

Nach dem Build kannst du das Image überprüfen:

```bash
# Alle Images anzeigen
podman images

# Spezifisches Image testen
podman run --rm mein-image:latest
```

## Buildah als Alternative

Du kannst auch Buildah direkt verwenden (ist bei der Podman-Installation dabei):

```bash
buildah build -t mein-image .
```

Buildah bietet manchmal mehr Kontrolle über den Build-Prozess und ist speziell für das Erstellen von Container-Images optimiert.

Hast du bereits ein spezifisches Dockerfile, mit dem du arbeiten möchtest?