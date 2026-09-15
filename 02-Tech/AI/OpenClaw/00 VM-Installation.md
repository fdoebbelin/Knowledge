## 1. Installation von KVM, QEMU und libvirt


```nushell
sudo pacman -S --noconfirm qemu libvirt edk2-ovmf virt-manager
sudo systemctl enable --now libvirtd
```


---

## 2. Download einer Linux-Distribution (z.B. Cachyos)
Download der ISO (Beispiel: Cachyos)

```nushell
mkdir $"($env.HOME)/vm/images"
mkdir $"($env.HOME)/vm/iso"
let iso_url = "https://cdn77.cachyos.org/ISO/desktop/260124/cachyos-desktop-linux-260124.iso"
let iso_path = $"($env.HOME)/vm/iso/cachyos-desktop-linux.iso"
http get $iso_url | save --force $iso_path
```


---

### **3. Erstellen einer virtuellen Maschine mit `virt-install`**


```nushell
let vm_name = "openclaw-vm"
let ram_size = 4096
let cpu_cores = 2
let disk_size = 20

let disk_path = $"($env.HOME)/vm/images/openclaw-vm.qcow2"
let iso_path  = $"($env.HOME)/vm/iso/cachyos-desktop-linux.iso"

(
  ^virt-install
    --connect qemu:///session
    --name $vm_name
    --memory $ram_size
    --vcpus $cpu_cores
    --disk $"path=($disk_path),size=($disk_size),format=qcow2"
    --os-variant archlinux
    --network user
    --graphics spice
    --cdrom $iso_path
    --boot "cdrom,menu=on"
    --noautoconsole
    --check all=of
)
```

---

### **4. Integration in `virt-manager`**

`# Starten von virt-manager (GUI) virt-manager`

---

### **5. Konfiguration der VM (optional über CLI)**

`# Autostart der VM aktivieren virsh autostart $vm_name # VM starten virsh start $vm_name`

---

### **6. Überprüfung der VM**

`# Status der VM abfragen virsh list --all # Details der VM anzeigen virsh dominfo $vm_name`

---

Diese Befehle richten eine KVM/QEMU-VM mit Cachyos ein und integrieren sie in `virt-manager`. Sie können die Parameter wie RAM, CPU-Kerne und Festplattenspeicher an Ihre Anforderungen anpassen. Wenn Sie weitere Unterstützung benötigen, lassen Sie es mich wissen!