Runs mypy on Python code to provide type checking.

-   Runs on your entire workspace. (This is different from Microsoft's Python extension's mypy functionality which only lints each file separately, leading to incomplete type checking.)
    
-   Uses the [mypy daemon](https://mypy.readthedocs.io/en/latest/mypy_daemon.html) to keep the analysis state in memory so that only changed files are rechecked.
    
-   Respects the active Python interpreter (set in the Python extension) and the `mypy.ini` configuration file.
    
-   Supports multi-root workspaces: will launch a separate mypy daemon for each workspace folder.