---
modul: M00
titel: Umgebung erweitern und Vue-Projekt anlegen
ue: 3
phase: Orientierung
ort: Toolbx
tags: [tauri/kurs/modul, setup, toolbx, nushell]
status: entwurf
---

# M00 – Umgebung erweitern und Vue-Projekt anlegen

> [!abstract] Worum es geht
> Der Container `tauri-dev` aus [[Von der leeren Toolbx zur installierten Flatpak-App]] steht bereits. Dieses Modul prüft den Stand, ergänzt Node.js **im Container** und legt das Kursprojekt an.

## Lernziele

- Den eigenen Umgebungsstand systematisch verifizieren
- Begründen, warum Node.js in den Container und nicht auf den Host gehört
- Ein Vite-Projekt anlegen und mit dem bestehenden `src-tauri` verbinden
- Den Unterschied zwischen `cargo tauri dev` und `npm run dev` benennen

## Kontrollpunkte aus dem Leitfaden

Alles in **Nushell**, im Container:

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "FEHLER: Host" }
$env.CARGO_HOME                                  # muss unter .local/share/toolbox/tauri-dev liegen
which cargo cargo-tauri
cargo tauri --version
pkg-config --modversion webkit2gtk-4.1
```

Auf dem **Host** dagegen:

```nu
which --all cargo                                # darf nichts finden
rpm-ostree status --json | from json | get deployments.0.requested-packages?
flatpak list --app --columns=application | lines | where $it =~ "metarow"
```

> [!danger] Abbruchkriterium
> Findet der Host ein `cargo` oder zeigt `requested-packages` Build-Abhängigkeiten, wurde der Leitfaden nicht sauber abgeschlossen. Vor dem Weitermachen Abschnitt 9 und 16 des Leitfadens nacharbeiten.

## Node.js im Container

```nu
sudo dnf install -y nodejs npm
node --version
npm --version
which node                                       # muss /usr/bin/node sein, also im Container
```

> [!question] Warum ist das kein Regelbruch?
> Der Container ist wegwerfbar und wird in Modul 11 nicht ausgeliefert. Node erzeugt ausschließlich **statische Dateien** ohne Bindung an eine glibc-Version. Das Rust-Binary entsteht weiterhin in der Flatpak-SDK. Die Regel des Leitfadens gilt für nativen Code und bleibt unverletzt.

Gegenprobe auf dem Host, muss fehlschlagen:

```nu
node --version
```

## Kursprojekt anlegen

```nu
cd ~/Projekte
cp -r notizblock noteflow                        # Ausgangsstand aus dem Leitfaden sichern
cd noteflow
```

Vite-Frontend danebenlegen, ohne `src-tauri` anzufassen:

```nu
npm create vite@latest frontend -- --template vue-ts
cd frontend
npm install
npm install @tauri-apps/api @tauri-apps/plugin-dialog
cd ..
```

## Konfiguration umstellen

**`frontend/vite.config.ts`** ergänzen:

```ts
export default defineConfig({
  plugins: [vue()],
  clearScreen: false,
  server: { port: 1420, strictPort: true, watch: { ignored: ["**/src-tauri/**"] } },
});
```

**`src-tauri/tauri.conf.json`**, Abschnitt `build` ersetzen:

```json
"build": {
  "frontendDist": "../frontend/dist",
  "devUrl": "http://localhost:1420",
  "beforeDevCommand": "npm --prefix frontend run dev",
  "beforeBuildCommand": "npm --prefix frontend run build"
}
```

> [!note] `withGlobalTauri` kann jetzt entfallen
> Der Leitfaden brauchte `app.withGlobalTauri: true`, weil ohne Bundler kein `import` möglich war. Mit Vite werden die Tauri-APIs regulär importiert. Der Schalter darf auf `false` und sollte es auch, weil er sonst unnötig globale Objekte bereitstellt.

## Praxisteil

- [ ] Alle Kontrollpunkte durchlaufen und Ergebnisse dokumentieren
- [ ] Node im Container installieren, Gegenprobe auf dem Host
- [ ] Projekt `noteflow` anlegen und Konfiguration umstellen
- [ ] `cargo tauri dev` starten, Vue-Startseite erscheint im Fenster
- [ ] `.gitignore` um `frontend/node_modules`, `frontend/dist` und `src-tauri/target` ergänzen

## Typische Fallstricke

> [!warning]
> - **`node_modules` liegt im geteilten `$HOME`.** Genau wie `src-tauri/target` überlebt es das Löschen des Containers und enthält plattformspezifische Binärdateien wie `esbuild`. Nach einem Containerwechsel gilt: `rm -rf frontend/node_modules` gefolgt von `npm install`, analog zu `cargo clean`.
> - **Weißes Fenster.** Das bekannte DMA-BUF-Problem. In Nushell nicht als Präfix: `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }`. Dauerhaft in den `if`-Block aus Leitfaden-Abschnitt 9.
> - **`npm run dev` direkt aufgerufen.** Öffnet nur den Vite-Server im Browser, ohne Tauri-Fenster. `invoke` schlägt dort fehl. Immer `cargo tauri dev` verwenden.
> - **Portnummer belegt.** `strictPort: true` bricht sauber ab, statt still auf 1421 auszuweichen, was `devUrl` ins Leere laufen ließe.

## Verknüpfung

Weiter mit [[M01 Architektur im Ebenenmodell]] · [[Anhang Nushell-Befehlsreferenz]] · zurück zu [[00 Kurskonzept Tauri]]
