mit Composer installierte Programme verfügbar machen
```sh
echo 'export PATH="./vendor/bin":$PATH' >> /www/htdocs/${USER##*\-}/.user_bashrc
source ~/.bashrc
```
