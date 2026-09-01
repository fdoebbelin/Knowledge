---
title: 'Cheatsheet: Branching mit Git'
updated: 2022-04-03 19:42:55Z
created: 2022-04-03 19:42:21Z
latitude: 52.16470000
longitude: 11.63730000
altitude: 0.0000
---

Noch so eine Liste mit Git Befehlen? Jain. In diesem Beitrag geht es in erster Linie um Git Befehle, die ich (teilweise) nicht jeden Tag nutze und immer wieder nachschauen müsste. Daher habe ich die Befehle hier einmal zusammengeschieben:

Git Konfiguration
Aliase anlegen
1	$ git config --global alias.branches "branch --all --verbose"
2	$ git config --global alias.tree "log --graph --oneline --decorate --all"
	• git branches zeigt nun alle Branches (auch remote) inkl. letzem Commit-Hash und Commit-Kommentar an
	• git tree zeigt nun die einzelnen Branches bunt und strukturiert an (also git log in „schön“)
 
Merge und Push anpassen
1	git config --global merge.ff false
2	git config --global pull.ff only
	• git merge verwendet nun kein „Fast-forward“ mehr (es sei denn, der --ff Parameter wird explizit übergeben) ohne dass jedesmal --no-ff angegeben werden muss
	• git pull kann nur noch verwendet werden, wenn ein „Fast-forward“ möglich ist

 
Git Branches
Genereller Arbeitsablauf
Generell arbeite ich mit master und develop als Hauptbranches. Der master Branch ist das Produktionssystem und sollte immer sauber gehalten werden. Alle Entwicklungen werden auf dem develop Branch durchgeführt oder auf einem vom develop Branch abgehenden featureXYZ Branch.
1	## go to branch "develop" we want to work on
2	git checkout develop
3	 
4	## make sure develop branch is up-to-date (no merge here!)
5	git rebase master
6	 
7	## add fancy stuff now and commit as often as you wish
8	git commit
9	 
10	## push changes to remote "develop" (if you wish and available)
11	git push
12	 
13	## when finished go back to "master" branch
14	git checkout master
15	 
16	## add changes in "develop" branch to "master" branch via merge (with --no-ff as default)
17	git merge develop
18	 
19	## push changes to remote "master" (if you wish and available)
20	git push
21	 
22	## add and push tag (if you wish)
23	git tag 1.2.0
24	git push origin 1.2.0
 
Branch umbenennen (Lokal)
1	## variant 1
2	git branch -m old-name new-name
3	 
4	## variant 2
5	git checkout old-name
6	git branch -m new-name
Statt git branch -m (Kurzform) kann auch git branch --move (Langform) geschrieben werden.
 
Branch umbenennen (Remote)
1	## variant 1
2	git push origin origin/<old_name>:refs/heads/<new_name> :<old-name>
3	 
4	## variant 2
5	git push origin :<old_name>
6	git push origin <new_name>:refs/heads/<new_name>
 
Push Konflikte beheben
Bei Fehlermeldungen a la error: „Aktualisierungen wurden zurückgewiesen, weil die Spitze Ihres aktuellen Branches hinter seinem externen Gegenstück zurückgefallen ist. Führen Sie die externen Änderungen zusammen“ einfach mit dem Remote Branch rebasen:
Shell
1	## rebase local repo with origin
2	git pull --rebase origin master
3	 
4	## push local changes back to origin
5	git push origin master
 
Änderungen rückgängig machen
Manchmal hat man was falsches committed. Mit git reset (siehe Git-Seite) kann man einfach zu einem früheren Commit zurück springen:
Shell
1	git reset --hard <commit-id>
Wenn ein Commit bereits (zu Github) gepushed wurde, kann man das so wieder korrigieren:
Shell
1	## undo local commit
2	git reset --soft HEAD^
3	 
4	## make changes or fix typos
5	 
6	## commit again
7	git commit
8	 
9	## push again (and force to overwrite old commit)
10	git push --force origin master

 
Git Tracking
Tracking Branch hinzufügen (Remote Branch)
Shell
1	## add "origin" remote to repo
2	git remote add origin git@github.com:<user>/<repo>
3	git push -u origin master
 
Tracking Informationen anzeigen
Shell
1	## show remote config for "origin"
2	git remote show origin
3	 
4	## show remotes
5	git remote -v
 
Push & Track
Branch develop an origin/develop pushen und gleichzeitig origin/develop als Tracking Branch eintragen:
Shell
1	git checkout develop
2	git push -u origin develop
Statt git push -u (Kurzform) kann auch git push --set-upstream (Langform) geschrieben werden
 
Tracking manuell setzen
Shell
1	## set single remote tracking branch "origin/master" for current repository
2	git remote set-branches origin master
3	 
4	## remove remote branch "origin/bla" from current repo without deleting remote branch itself
5	git branch -rd origin/bla
6	 
7	## set tracking branch "origin/master" for specific local branch "master" of this repo
8	git branch -u origin/master [master]
Statt git branch -rd (Kurzform) kann auch git branch --remotes --delete (Langform) geschrieben werden
Statt git branch -u (Kurzform) kann auch git branch --set-upstream-to (Langform) geschrieben werden

 
Git Klonen
Lokales Repo klonen
Shell
1	## clone local repo to another local repo
2	git clone --single-branch --local /path/to/orig /path/to/copy
3	 
4	## switch to old repo
5	cd /path/to/orig
6	 
7	## add single
8	git remote add origin --track master /path/to/new
 
Remote Fork (Github) auf Stand bringen
Shell
1	# clone your fork
2	git clone git@github.com:<fork_user>/<fork_repo>.git <path>
3	cd <path>
4	git checkout master
5	 
6	# add original repo as remote "upstream"
7	git remote add upstream git@github.com:<original_user>/<original_repo>.git
8	 
9	# merge your repo with original repo
10	git fetch upstream 
11	git merge --ff-only upstream/master
12	 
13	# push back changes to your remote repo
14	git push

 
Git Änderungen prüfen
Alle geänderten PHP Dateien vor dem Commit auf Syntaxfehler prüfen
Shell
1	# check modified php files
2	find $(git ls-files -m) -name "*.php" -exec php -l {} \; 1>/dev/null

 
Git Links
Weiterführende Links:
	• Git Branching Workflow
	• Git Rebase Workflow
	• Git Forking Workflow
	• Git Squash Workflow
