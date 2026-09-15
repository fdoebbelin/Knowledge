Um Python-Module in einem Rust-Programm zu verwenden, gibt es mehrere Ansätze. Hier sind einige gängige Methoden:

1. **PyO3**: Dies ist eine der beliebtesten Bibliotheken, um Python in Rust zu integrieren. PyO3 ermöglicht es, Python-Code aus Rust heraus aufzurufen und umgekehrt. Es bietet eine sichere und ergonomische API, um Python-Funktionalitäten in Rust zu nutzen.
2. **Rust-CPython**: Eine weitere Bibliothek, die die Integration von Python in Rust ermöglicht. Sie bietet eine niedrigere Ebene der Integration im Vergleich zu PyO3, was mehr Kontrolle, aber auch mehr Komplexität bedeutet.
3. **FFI (Foreign Function Interface)**: Sie können die C-API von Python verwenden, um Python-Code aus Rust heraus aufzurufen. Dies erfordert jedoch ein tieferes Verständnis der Python C-API und ist in der Regel komplexer als die Verwendung von PyO3 oder Rust-CPython.
4. **Subprocess**: Eine einfache Methode besteht darin, Python-Skripte als Subprozesse aus Rust heraus aufzurufen. Dies ist weniger effizient und bietet keine direkte Interaktion zwischen Rust und Python, kann aber für einfache Aufgaben ausreichen.
## PyO3
To embed Python into a Rust binary, you need to ensure that your Python installation contains a shared library. 
The following steps demonstrate how to ensure this (for Ubuntu), and then give some example code which runs an embedded Python interpreter.

To install the Python shared library on Ubuntu:

```
sudo apt install python3-dev
```

Start a new project with `cargo new` and add `pyo3` to the `Cargo.toml` like this:

```
[dependencies.pyo3]
version = "0.24.2"
# this is necessary to automatically initialize the Python interpreter
features = ["auto-initialize"]
```

Example program displaying the value of `sys.version` and the current user name:

```rust
use pyo3::prelude::*;
use pyo3::types::IntoPyDict;
use pyo3::ffi::c_str;

fn main() -> PyResult<()> {
    Python::with_gil(|py| {
        let sys = py.import("sys")?;
        let version: String = sys.getattr("version")?.extract()?;

        let locals = [("os", py.import("os")?)].into_py_dict(py)?;
        let code = c_str!("os.getenv('USER') or os.getenv('USERNAME') or 'Unknown'");
        let user: String = py.eval(code, None, Some(&locals))?.extract()?;

        println!("Hello {}, I'm Python {}", user, version);
        Ok(())
    })
}
```

The guide has [a section](https://pyo3.rs/v0.24.2/python-from-rust.html "Calling Python from Rust - PyO3 user guide") with lots of examples about this topic.

### Other Examples

The PyO3 [README](https://github.com/PyO3/pyo3#readme) contains quick-start examples for both using [Rust from Python](https://github.com/PyO3/pyo3#using-rust-from-python) and [Python from Rust](https://github.com/PyO3/pyo3#using-python-from-rust).

The PyO3 repository’s [examples subdirectory](https://github.com/PyO3/pyo3/tree/main/examples) contains some basic packages to demonstrate usage of PyO3.

There are many projects using PyO3 - see a list of some at [https://github.com/PyO3/pyo3#examples](https://github.com/PyO3/pyo3#examples).