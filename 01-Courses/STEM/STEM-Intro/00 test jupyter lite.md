
```
git clone https://github.com/fdoebbelin/jupyterlite.git
cd .\jupyterlite\
uv venv
.venv\Scripts\Activate.ps1
uv init
uv sync
uv pip install jupyterlite-core
jupyter lite build --contents content --output-dir dist
jupyter lite serve --output-dir dist
```
