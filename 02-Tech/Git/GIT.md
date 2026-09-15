---
title: GIT
updated: 2019-12-26 05:39:16Z
created: 2019-12-26 05:38:58Z
latitude: 50.03920000
longitude: 12.00340000
altitude: 0.0000
---

```
$ git remote rename origin genesis

$ git config --global --list

user.name=Fritz-Rainer Doebbelin
user.email=frd@doebbelin.net
alias.co=checkout
alias.ctags=!.git/hooks/ctags

core.editor=mvim
core.excludesfile=/Users/fritz/.gitignore_global
core.autocrlf=input
init.templatedir=~/.git_template
mergetool.keepbackup=true
filter.media.clean=git-media-clean %f
filter.media.smudge=git-media-smudge %f
difftool.sourcetree.cmd=opendiff "$LOCAL" "$REMOTE"
difftool.sourcetree.path=
mergetool.sourcetree.cmd=/Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED"
mergetool.sourcetree.trustexitcode=true
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
commit.template=/Users/fritz/.stCommitMsg

$ git config --list
remote.genesis.url=ssh://ssh-w01928d1@w0182b98.kasserver.com:/www/htdocs/w01928d1/_git/BookOnDemand.git
remote.genesis.fetch=+refs/heads/*:refs/remotes/genesis/*
branch.master.remote=genesis
branch.master.merge=refs/heads/master


remote.genesis.url=ssh://ssh-w01928d1@w0182b98.kasserver.com:/www/htdocs/w01928d1/_git/oldham.git


$ git config --global user.name "MetaRow Software UG"
$ git config --global user.email frd@metarow.com

host = '192.168.2.62'
# host = '127.0.0.1'
port = '3306'
user = 'westarp-vs_de'
# user = 'root'
pw = 'gt86E&a@3&!c+pj$SRm_'
```