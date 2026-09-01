## 1. Live-System booten 
- Von einem **CatchyOS-Live-Medium** (USB-Stick) starten. 
## 2. Root-Partition mounten 
### Standard-Partition: 
```
bash sudo mount /dev/sdXY /mnt
```
- Ersetze `sdXY` mit deiner Root-Partition (z. B. `sda2`).
### BTRFS-Subvolume (z. B. `@`):

`sudo mount -o subvol=@ /dev/sdXY /mnt`

## 3. Passwort zurücksetzen
```bash
sudo arch-chroot /mnt
passwd <benutzername>
```

- Ersetze `<benutzername>` mit dem Zielbenutzer.
## 4. System neu starten

```bash
exit
sudo umount /mnt reboot
```