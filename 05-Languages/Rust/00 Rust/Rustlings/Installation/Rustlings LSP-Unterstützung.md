**Hintergrund:**
- Die `lsp`-Unterstützung war zeitweise in Rustlings enthalten, wurde aber wieder entfernt oder ist nur in bestimmten (Nightly-)Versionen verfügbar[5](https://gist.github.com/jackos/7332fa8ab0b67a87f382fd566696f412?permalink_comment_id=4522104).
- In der aktuellen stabilen Version von Rustlings (z.B. 6.4.0) gibt es den Befehl `rustlings lsp` nicht mehr[5](https://gist.github.com/jackos/7332fa8ab0b67a87f382fd566696f412?permalink_comment_id=4522104).

**Was bedeutet das für dich?**
- **Autocomplete und andere rust-analyzer-Features funktionieren in Rustlings-Übungen weiterhin nicht,** solange kein Cargo-Projekt oder keine spezielle Projektdatei (`rust-project.json`) vorhanden ist[2](https://users.rust-lang.org/t/new-user-rustlings-vscode/111442)[5](https://gist.github.com/jackos/7332fa8ab0b67a87f382fd566696f412?permalink_comment_id=4522104).
- Es gibt aktuell keinen offiziellen, einfachen Weg, rust-analyzer für Rustlings zu aktivieren, wenn `rustlings lsp` fehlt.

**Workaround:**
- Es gibt ein Community-Tool namens `rustlings-fix`, das eine passende Projektdatei generieren kann:

```bash
cargo install rustlings-fix
rustlings-fix
```

Damit wird eine Datei erzeugt, die `rust-analyzer` erkennt, sodass Autocomplete und LSP-Features funktionieren können[5](https://gist.github.com/jackos/7332fa8ab0b67a87f382fd566696f412?permalink_comment_id=4522104).

**Fazit:**  
Ohne Cargo-Projekt und ohne `rustlings lsp`-Befehl musst du auf diesen Workaround zurückgreifen, um rust-analyzer in Rustlings nutzen zu können. Andernfalls arbeitest du in Rustlings ohne Autocomplete-Unterstützung.