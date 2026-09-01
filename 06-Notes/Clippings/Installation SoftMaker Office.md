### Installation über das SoftMaker-Repository

Wenn Sie das SoftMaker-Repository verwenden, können Sie SoftMaker Office sehr einfach installieren und aktuell halten.

Öffnen Sie eine Shell oder ein Terminal-Fenster und geben Sie diese Befehle ein, um das Repository einzurichten:


```sh
sudo zypper addrepo -f https://shop.softmaker.com/repo/rpm SoftMaker  
sudo zypper --gpg-auto-import-keys ref
```


Sie müssen diese Befehle durch Eingabe Ihres Root-Passwords bestätigen.

Geben Sie anschließend diesen Befehl ein, um SoftMaker Office zu installieren:


```sh
sudo -E zypper install softmaker-office-nx
```


Sofern Sie in Ihrem System **automatische Updates** eingerichtet haben, hält Ihr Linux-Paketmanager SoftMaker Office automatisch aktuell.

Wenn Sie in Ihrem System **keine automatischen Updates** verwenden, aktualisieren Sie SoftMaker Office mit diesen Befehlen auf die neueste verfügbare Revision:

– Wenn Sie **zypper** verwenden:

```sh
sudo -E zypper update
```
