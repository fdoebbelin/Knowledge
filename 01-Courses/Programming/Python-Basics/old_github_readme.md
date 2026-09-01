# MyAwesomeProject

A simple web application for managing tasks.

## Getting the Code

### Option 1: HTTP Clone (Recommended for beginners)
```bash
git clone https://github.com/username/MyAwesomeProject.git
cd MyAwesomeProject
```

### Option 2: SSH Clone (For users with SSH keys set up)
```bash
git clone git@github.com:username/MyAwesomeProject.git
cd MyAwesomeProject
```

### Option 3: Download ZIP
If you don't have Git installed, you can download the project as a ZIP file:
1. Click the "Download ZIP" button on the GitHub page
2. Extract the archive to your desired location

## Setting up Git (First time users)

If you haven't used Git before, you'll need to configure it:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Working with the Repository

### Getting Updates
To get the latest changes from the repository:
```bash
git pull origin master
```

### Making Changes
1. Create a new branch for your feature:
   ```bash
   git checkout -b my-new-feature
   ```

2. Make your changes and commit them:
   ```bash
   git add .
   git commit -m "Add my new feature"
   ```

3. Push your branch to GitHub:
   ```bash
   git push origin my-new-feature
   ```

4. Create a Pull Request on GitHub

### Submitting Patches
If you want to contribute but don't have write access:

1. Fork this repository on GitHub
2. Clone your fork: `git clone https://github.com/YOURUSERNAME/MyAwesomeProject.git`
3. Create a feature branch: `git checkout -b my-feature`
4. Make your changes and commit: `git commit -am 'Add some feature'`
5. Push to the branch: `git push origin my-feature`
6. Submit a pull request through GitHub's web interface

## Alternative Access Methods

### Using GitHub for Windows/Mac
1. Install GitHub Desktop application
2. Click "Clone in Desktop" button on the repository page
3. Choose your local directory

### Using Eclipse/NetBeans
Most IDEs now support Git integration. Look for:
- Eclipse: EGit plugin
- NetBeans: Built-in Git support
- IntelliJ: Built-in VCS integration

## Troubleshooting Access Issues

**Problem: Permission denied (publickey)**
- Make sure you have added your SSH key to your GitHub account
- See: https://help.github.com/articles/generating-ssh-keys

**Problem: SSL certificate problem**
```bash
git config --global http.sslverify false
```
(Not recommended for production use)

**Problem: Can't push changes**
- Make sure you have write access to the repository
- Check if you're pushing to the correct remote: `git remote -v`

## Installation

After cloning, run:
```bash
npm install
```

## Usage

Start the application:
```bash
npm start
```

## License

MIT License - see LICENSE file for details.