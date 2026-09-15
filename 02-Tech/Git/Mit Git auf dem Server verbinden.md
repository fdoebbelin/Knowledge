---
title: Mit Git auf dem Server verbinden
updated: 2022-04-03 19:31:56Z
created: 2022-04-03 19:29:56Z
latitude: 52.16470000
longitude: 11.63730000
altitude: 0.0000
---

Einrichten leeres Repository auf dem Server
```
$ ssh ssh-w017ef42@w017ef42.kasserver.com
$ mkdir /www/htdocs/w017ef42/_git/vue-vuetify.git
$ git init --bare /www/htdocs/w017ef42/_git/vue-vuetify.git
```
 
Setzen des remote Servers
```
$ git remote add origin ssh-w017ef42@w017ef42.kasserver.com:/www/htdocs/w017ef42/_git/vue-vuetify.git
```

Test der URL
```
$ git config --get remote.origin.url
```

Setzen des globalen Git-SSH-Kommandos auf Bitvise sexec für Windows
```
$ git config --global core.sshCommand "sexec -git -keypairFile=C:/Users/fritz/.ssh/g1_rsa.bkp"
```

Komplettes Shell-Script
```
#!/bin/sh

REPOSITORY=$(basename `pwd`)

if [ -d ".git" ]; then
  echo "Connect to remote $REPOSITORY."

  /usr/bin/ssh freelancer "mkdir /www/htdocs/w017ef42/_git/${REPOSITORY}.git \
    && git init --bare /www/htdocs/w017ef42/_git/${REPOSITORY}.git" \
  && /usr/local/bin/git remote add origin \
    ssh-w017ef42@w017ef42.kasserver.com:/www/htdocs/w017ef42/_git/${REPOSITORY}.git \
  && /usr/local/bin/git config --get remote.origin.url \
  && sendEmail -o tls=yes -f admin@agrail.de -t frd@doebbelin.net \
     -s w017ef42.kasserver.com -xu admin@agrail.de -xp SxgoDV6ZhCs7S46v \
     -u "New Repository" \
     -m "ssh-w017ef42@w017ef42.kasserver.com:/www/htdocs/w017ef42/_git/${REPOSITORY}.git"
fi
```

