##  — if you’ve done this kind of thing before

[Set up in Desktop](https://desktop.github.com/)

**or**

SSH:
```
git@github.com:DozentBWSA/bare-repo.git
```

Get started by [creating a new file](https://github.com/DozentBWSA/bare-repo/new/main) or [uploading an existing file](https://github.com/DozentBWSA/bare-repo/upload). We recommend every repository include a [README](https://github.com/DozentBWSA/bare-repo/new/main?readme=1), [LICENSE](https://github.com/DozentBWSA/bare-repo/new/main?filename=LICENSE.md), and [.gitignore](https://github.com/DozentBWSA/bare-repo/new/main?filename=.gitignore).

### …or create a new repository on the command line

echo "# bare-repo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/DozentBWSA/bare-repo.git
git push -u origin main

### …or push an existing repository from the command line

git remote add origin https://github.com/DozentBWSA/bare-repo.git
git branch -M main
git push -u origin main