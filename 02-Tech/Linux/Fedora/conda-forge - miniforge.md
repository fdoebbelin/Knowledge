---
source: https://github.com/conda-forge/miniforge
---
## Install

From a terminal window, download the installer appropriate for your computer's architecture using curl or wget or your favorite program.

For example:

```shell
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

or

```shell
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

Run the script with:

```shell
bash Miniforge3-$(uname)-$(uname -m).sh
```

The interactive installation will prompt you to initialize conda with your shell. This is typically with recommended workflow.