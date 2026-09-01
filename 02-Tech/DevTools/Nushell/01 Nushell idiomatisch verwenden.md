„**Nushell idiomatisch verwenden**“ bedeutet, **Nushell so zu benutzen, wie es gedacht ist** – also im typischen Stil der Sprache, statt klassische Bash-/Unix-Gewohnheiten einfach zu übernehmen.

Kurz gesagt: **Du arbeitest mit strukturierten Daten statt mit Text.**

---

## 🔹 1. Nicht Text-Pipes, sondern Daten-Pipelines

In Bash:

```bash
ls | grep txt | awk '{print $1}'
```

→ Alles ist reiner Text.

In Nushell (idiomatisch):

```nu
ls | where name =~ "txt" | get name
```

→ `ls` liefert eine **Tabelle**, keine Textliste.

Du filterst **Spalten**, nicht Zeichenketten.

---

## 🔹 2. Mit Tabellen statt mit Strings arbeiten

In Nushell ist fast alles strukturiert:

```nu
ls
```

ergibt etwa:

|name|size|type|modified|
|---|---|---|---|

Dann kannst du:

```nu
ls | sort-by size
ls | where size > 1mb
ls | select name size
```

👉 Idiomatisch = wie mit einer Datenbank-Tabelle arbeiten.

---

## 🔹 3. Keine externen Tools, wenn Nushell es kann

Unidiomatisch:

```nu
ls | grep log | wc -l
```

Idiomatisch:

```nu
ls | where name =~ "log" | length
```

Du nutzt:

- `where` statt `grep`
    
- `length` statt `wc`
    
- `sort-by` statt `sort`
    
- `get` statt `cut`
    

---

## 🔹 4. Typen bewusst nutzen

Nushell kennt Datentypen:

- int
    
- float
    
- filesize
    
- datetime
    
- bool
    
- record
    
- list
    

Beispiel:

```nu
df | where used > 80%
```

`used` ist eine Zahl → kein Stringvergleich.

Das ist sehr „idiomatisch“.

---

## 🔹 5. Mit Records und Listen arbeiten

Beispiel:

```nu
let user = {name: "Fritz", age: 55}
$user.age
```

Oder:

```nu
let nums = [1 2 3 4]
$nums | each { |x| $x * 2 }
```

→ Nushell ist halb Shell, halb Programmiersprache.

---

## 🔹 6. Eigene Commands schreiben (statt Skript-Hacks)

Unidiomatisch:

```nu
# riesiges Einzeiler-Monster
```

Idiomatisch:

```nu
def cleanup [] {
  ls temp | where size > 10mb | rm
}
```

Dann:

```nu
cleanup
```

→ Kleine, klare Funktionen.

---

## 🔹 7. Beispiel: Bash-Denken vs Nushell-Denken

### ❌ Bash-Stil (nicht idiomatisch)

```nu
ps | grep firefox | awk '{print $1}'
```

### ✅ Nushell-Stil (idiomatisch)

```nu
ps | where name =~ "firefox" | get pid
```

---

## 🔹 8. Merksatz

Idiomatisches Nushell =

> ✅ Wenig Text  
> ✅ Viele Tabellen  
> ✅ Wenig externe Tools  
> ✅ Viel Struktur  
> ✅ Klare Pipelines

---

## 🧠 Zusammenfassung

Wenn jemand sagt:

> „Nutze Nushell idiomatisch“

meint er:

👉 Behandle deine Daten wie Tabellen und Objekte, nicht wie Textströme.

---

Wenn du willst, kann ich dir gern:

- typische Bash → Nushell-Übersetzungen machen
    
- oder deine eigenen Befehle „idiomatischer“ umbauen
    

Sag einfach Bescheid 👍