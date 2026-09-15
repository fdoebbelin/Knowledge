---
title: ssh config
updated: 2022-12-05 17:22:08Z
created: 2022-12-05 17:20:40Z
latitude: 52.12053330
longitude: 11.62762370
altitude: 0.0000
---

```
$ code ~/.ssh/config
Host *
  TCPKeepAlive yes
  ServerAliveInterval 120

Host freelancer
  HostName w017ef42.kasserver.com
  User ssh-w017ef42
  IdentityFile ~/.ssh/id_rsa
  
Host synology.local
  HostName synology.local
  User fritz
  Port 1958
```