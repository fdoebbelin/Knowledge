```nushell
curlftpfs ftp://w017ef42:YpEWnEyT9T!1hMHKqxxs@all-inkl.com ~/allinkl-ftp
curl -v ftp://all-inkl.com --user w017ef42:YpEWnEyT9T!1hMHKqxxs
git:/all-inkl.com/www/htdocs/w017ef42/git/NoctaRow.git
```


```
To get started with GitHub CLI, please run:  gh auth login
Alternatively, populate the GH_TOKEN environment variable with a GitHub API authentication token.
fritz@fedora:~/Projekte$ gh auth login
? Where do you use GitHub? GitHub.com
? What is your preferred protocol for Git operations on this host? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 11BA-78AA
Press Enter to open https://github.com/login/device in your browser... 
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as metarow
fritz@fedora:~/Projekte$ gh repo clone metarow/NoctaRow
```
