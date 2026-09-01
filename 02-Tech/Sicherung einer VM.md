
```
sudo mkdir /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup
sudo chown fritz:fritz /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup
```


# 1. Definition

```
virsh dumpxml win11 > /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup/win11.xml
```


# 2. Disk (Pfad aus: virsh domblklist win11)

```
sudo cp --reflink=auto /var/lib/libvirt/images/win11.qcow2 /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup/

```

# 3. NVRAM (Pfad aus dumpxml)

```
sudo cp /var/lib/libvirt/qemu/nvram/'Windows 11 Pro_VARS.fd' /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup/
```
Falls in der `dumpxml`-Ausgabe ein `<tpm>`-Block mit einem State-Pfad stand, den swtpm-Ordner mitnehmen:

```
sudo cp -r /var/lib/libvirt/swtpm/bd5edc1b-5c7a-45b1-a7f5-3e28c75156e1 /run/media/fritz/707a5a2b-f93e-485e-a1ae-2416ac830075/@home/fritz/vmbackup/swtpm-state
```

(Bei Windows 11 ist der TPM oft als „emulated" ohne persistente Datei konfiguriert – dann brauchst du hier nichts. Ob relevant, siehst du am `<tpm>`-Block.)

## 4. Restore auf dem neuen System

1. **Dateien an die Zielorte kopieren.** Am saubersten dieselben Standardpfade nutzen, dann musst du in der XML weniger anpassen:

```
sudo cp win11.qcow2 /var/lib/libvirt/images/
sudo cp win11_VARS.fd /var/lib/libvirt/qemu/nvram/
```

2. **Besitzer/Rechte setzen** – das ist der Schritt, der bei System-libvirt am häufigsten vergessen wird und dann „permission denied" beim Start verursacht:

```
sudo chown root:root /var/lib/libvirt/images/win11.qcow2
sudo chmod 600 /var/lib/libvirt/images/win11.qcow2
```

(Auf manchen Systemen gehört das Image `qemu:qemu` – falls der Start scheitert, das statt `root:root` probieren.)

3. **In der `win11.xml` die Pfade prüfen.** Wenn du dieselben Standardpfade verwendet hast, stimmen `<source file=…>` (Disk) und `<nvram>` schon. Sonst dort auf den neuen Ort ändern.
4. **GPU-Passthrough anpassen** – der kritische Punkt. Auf dem neuen Rechner haben die PCI-Adressen andere Werte. Zwei Wege:
    - **Zum ersten Start rausnehmen:** Die `<hostdev>`-Blöcke (die mit `type='pci'` und `managed='yes'`) aus der XML löschen. Windows bootet dann über die virtuelle GPU – so kannst du erstmal prüfen, dass die VM überhaupt läuft.
    - **Danach neu einrichten:** GPU-Adressen des neuen Systems mit `lspci -nn | grep -i nvidia` ermitteln und die Passthrough-Config passend zum neuen Rechner neu aufsetzen (IOMMU-Gruppen, vfio-Bindung etc. sind ohnehin host-spezifisch).
5. **Definieren:**

```
sudo virsh define win11.xml
```

Danach ist die VM im virt-manager. Erst ohne Passthrough starten und Windows hochkommen lassen, dann die GPU nachrüsten.

**Ein Windows-spezifischer Hinweis noch:** Wenn sich die virtuelle Hardware auf dem neuen System stark ändert (anderes CPU-Modell in der XML, GPU rein/raus), kann Windows das als „neue Hardware" werten und eine Reaktivierung verlangen. Bei einer digitalen Lizenz, die an dein Microsoft-Konto gebunden ist, meist unproblematisch – gut, das vorher zu wissen, falls beim ersten Start eine Aktivierungsmeldung kommt.

Sag mir gern, was `virsh domblklist win11` und der `<tpm>`/`<nvram>`-Teil aus `dumpxml` ausgeben – dann fülle ich dir die Befehle mit deinen echten Pfaden aus, damit nichts geraten ist.