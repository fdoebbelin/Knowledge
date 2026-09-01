
```nushell
let vm_name = "Garuda_hyprland"

# Zielverzeichnis korrekt bauen
let target_dir = [$env.HOME "VMs"] | path join

mkdir $target_dir

# Diskpfad holen
let disk_path = (
  sudo virsh domblklist $vm_name
  | complete
  | get stdout
  | from ssv
  | where Ziel == "vda"
  | get Quelle
  | first
)

if ($disk_path | is-empty) {
  error make { msg: $"Keine vda-Disk für VM ($vm_name) gefunden!" }
}

# Kopieren
sudo cp -v $disk_path $target_dir

# Dateiname
let file_name = ($disk_path | path basename)

# Besitzer ändern
sudo chown fritz:fritz ([$target_dir $file_name] | path join)
```

Benutzer:Gruppe anzeigen


```nushell
ls --long | select name user group
```
