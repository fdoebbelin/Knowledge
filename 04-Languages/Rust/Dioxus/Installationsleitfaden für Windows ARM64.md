## Voraussetzungen

- Installiertes **Rust Toolchain**
- **Code-Editor** (z.B. VS Code)
- Optional: **Visual Studio** oder andere ARM64-kompatible IDE

## Schritt 1: Rust für ARM64 installieren

1. **Rustup** herunterladen und installieren:
    
    - Öffnen Sie eine PowerShell oder Eingabeaufforderung und geben Sie ein:
        
        bash
        
        `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
        
2. **Rust-Architekturziel für Webanwendungen hinzufügen**:
    
    bash
    
    `rustup target add wasm32-unknown-unknown`
    
3. Überprüfen Sie, dass Ihr Rust Toolchain auf dem aktuellen Stand ist:
    
    bash
    
    `rustup update`
    

## Schritt 2: cargo-binstall installieren

Die einfachste Möglichkeit, Dioxus CLI zu installieren:

bash

`cargo install cargo-binstall`

Alternativ via Paketmanager (z.B. `brew` auf Windows über WSL, falls installiert)[1](https://dioxuslabs.com/learn/0.6/getting_started/).

## Schritt 3: Dioxus CLI installieren

- Mit cargo-binstall:
    
    bash
    
    `cargo binstall dioxus-cli`
    
- Alternativ aus dem Quellcode:
    
    bash
    
    `cargo install dioxus-cli`
    

**Hinweis:** Wenn während der Installation Fehler im Zusammenhang mit OpenSSL auftreten, stellen Sie sicher, dass Sie die passenden ARM64-Bibliotheken installiert haben. Unter Umständen müssen Sie OpenSSL für ARM64 selbst bauen oder entsprechende Pakete (z.B. über MSYS2 oder vcpkg) nachinstallieren[1](https://dioxuslabs.com/learn/0.6/getting_started/)[2](https://github.com/DioxusLabs/dioxus/issues/2893)[3](https://learn.microsoft.com/en-us/windows/arm/add-arm-support).

## Schritt 4: Projekt anlegen und starten

- Neues Dioxus-Projekt erstellen:
    
    bash
    
    `dx new projektname cd projektname`
    
- Projekt lokal starten (z.B. für Web):
    
    bash
    
    `dx serve`
    
- Hilfemenü anzeigen:
    
    bash
    
    `dx help`
    
    Hier werden alle verfügbaren CLI-Kommandos aufgelistet[4](https://juejin.cn/post/7512389237409939507).
    

## Architektur-spezifische Hinweise für ARM64

- Stellen Sie sicher, dass alle nativen Abhängigkeiten in Ihrem Projekt ARM64 unterstützen.
    
- Sollte eine Abhängigkeit keine ARM64-Version bieten, prüfen Sie den Bezug über vcpkg oder bauen Sie diese selbst.
    
- Windows ARM64 unterstützt die Emulation von x64-Apps, für native ARM64-Performance ist jedoch ein ARM64-Build notwendig[3](https://learn.microsoft.com/en-us/windows/arm/add-arm-support)[5](https://support.microsoft.com/de-de/windows/h%C3%A4ufig-gestellte-fragen-zu-windows-arm-basierten-pcs-477f51df-2e3b-f68f-31b0-06f5e4f8ebb5).
    

## Kompatibilität testen

- Überprüfen Sie die Installation des Dioxus CLI:
    
    bash
    
    `dx --version`
    
- Nutzen Sie die relevanten Kommandos (z.B. `dx serve`, `dx build`), um die Funktionalität auf Ihrer ARM64-Maschine sicherzustellen[4](https://juejin.cn/post/7512389237409939507).
    

## Fehlerbehebung

- OpenSSL-Probleme: Prüfen Sie, ob `OPENSSL_DIR` korrekt gesetzt ist und ARM64-Bibliotheken eingebunden sind[2](https://github.com/DioxusLabs/dioxus/issues/2893).
    
- Fehlende Abhängigkeiten: Nutzen Sie vcpkg oder informieren Sie sich beim Paketbetreuer zu ARM64-Support[3](https://learn.microsoft.com/en-us/windows/arm/add-arm-support).
    

## Zusammenfassung der wichtigsten Kommandos

|Zweck|Befehl|
|---|---|
|Rust installieren|rustup-init.exe|
|Zielarchitektur hinzufügen|rustup target add wasm32-unknown-unknown|
|cargo-binstall installieren|cargo install cargo-binstall|
|Dioxus CLI installieren|cargo binstall dioxus-cli|
|Neues Projekt anlegen|dx new projektname|
|Projekt im Web-Modus starten|dx serve|

Mit diesen Schritten können Sie Dioxus nativ auf Windows ARM64 installieren und nutzen[1](https://dioxuslabs.com/learn/0.6/getting_started/)[4](https://juejin.cn/post/7512389237409939507)[3](https://learn.microsoft.com/en-us/windows/arm/add-arm-support).

1. [https://dioxuslabs.com/learn/0.6/getting_started/](https://dioxuslabs.com/learn/0.6/getting_started/)
2. [https://github.com/DioxusLabs/dioxus/issues/2893](https://github.com/DioxusLabs/dioxus/issues/2893)
3. [https://learn.microsoft.com/en-us/windows/arm/add-arm-support](https://learn.microsoft.com/en-us/windows/arm/add-arm-support)
4. [https://juejin.cn/post/7512389237409939507](https://juejin.cn/post/7512389237409939507)
5. [https://support.microsoft.com/de-de/windows/h%C3%A4ufig-gestellte-fragen-zu-windows-arm-basierten-pcs-477f51df-2e3b-f68f-31b0-06f5e4f8ebb5](https://support.microsoft.com/de-de/windows/h%C3%A4ufig-gestellte-fragen-zu-windows-arm-basierten-pcs-477f51df-2e3b-f68f-31b0-06f5e4f8ebb5)
6. [https://dioxuslabs.com/learn/0.6/guide/bundle/](https://dioxuslabs.com/learn/0.6/guide/bundle/)
7. [https://dioxuslabs.com/learn/0.6/CLI/configure/](https://dioxuslabs.com/learn/0.6/CLI/configure/)
8. [https://github.com/DioxusLabs/dioxus/issues/3034](https://github.com/DioxusLabs/dioxus/issues/3034)
9. [https://learn.microsoft.com/en-us/windows/arm/arm64x-build](https://learn.microsoft.com/en-us/windows/arm/arm64x-build)
10. [https://github.com/xmrig/xmrig/issues/3668](https://github.com/xmrig/xmrig/issues/3668)
11. [https://github.com/DioxusLabs/dioxus/issues/3418](https://github.com/DioxusLabs/dioxus/issues/3418)
12. [https://www.youtube.com/watch?v=_Klr2PQxvQ8](https://www.youtube.com/watch?v=_Klr2PQxvQ8)
13. [https://github.com/dioxuslabs/dioxus/releases](https://github.com/dioxuslabs/dioxus/releases)
14. [https://groups.google.com/g/innosetup/c/_k3ddQ2CV8E](https://groups.google.com/g/innosetup/c/_k3ddQ2CV8E)
15. [https://docs.rs/crate/dioxus-desktop/latest](https://docs.rs/crate/dioxus-desktop/latest)
16. [https://github.blog/changelog/2025-04-14-windows-arm64-hosted-runners-now-available-in-public-preview/](https://github.blog/changelog/2025-04-14-windows-arm64-hosted-runners-now-available-in-public-preview/)
17. [https://lib.rs/crates/subsecond](https://lib.rs/crates/subsecond)
18. [https://crates.io/crates/dioxus-desktop/0.6.0-rc.0/dependencies](https://crates.io/crates/dioxus-desktop/0.6.0-rc.0/dependencies)
19. [https://youtrack.jetbrains.com/issue/RIDER-54094/Windows-Support-for-running-on-ARM64-architectures](https://youtrack.jetbrains.com/issue/RIDER-54094/Windows-Support-for-running-on-ARM64-architectures)
20. [https://crates.io/crates/dioxus-desktop/0.2.3](https://crates.io/crates/dioxus-desktop/0.2.3)