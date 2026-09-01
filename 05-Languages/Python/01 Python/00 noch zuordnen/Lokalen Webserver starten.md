Statt eine Datei direkt mit `file://` zu öffnen, kann über Python ein kleiner lokaler Webserver gestartet werden.  
Dadurch läuft alles unter `http://localhost`, und der Browser blockiert nichts (**Laden von Scripts** aus `file://`-URLs wegen der **CORS-Policy (Cross-Origin Resource Sharing)**.

```sh
cd $WEBROOT
python -m http.server 8000
```

Danach aufrufen: [http://localhost:8000/](http://localhost:8000/)
