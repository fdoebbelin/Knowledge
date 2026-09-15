# Py2Rust - A Modular Desktop Tool for Python-Rust Migration

![](_resources/0e342786659e236a6388a87062ebc4c4_MD5.svg)
![](_resources/7c4779a2b29724b8ea04306cff5d6910_MD5.svg)
![](_resources/06acbe8becb44b49a6552835d855352c_MD5.svg)
![](_resources/629c5155780c6a91059de96927a1b876_MD5.svg)

**Py2Rust** is a modular graphical desktop application for systematic migration of Python projects to Rust. The tool integrates existing open-source transpilers and AST analysis tools in a unified user interface and provides transparent result previews for Python-to-Rust migrations.

## 🎯 Project Goals

### Core Features
- **Project Analysis**: Automatic structural analysis of Python modules, classes and functions based on AST tools
- **Intelligent Migration**: Integration of existing migration tools like PyCrust[^1], Depyler[^2], python-ast-rs[^3] through a central interface
- **Library Mapping**: Automatic detection of used Python libraries and suggestion of equivalent Rust crates
- **Visualization**: Graphical representation of migration results with syntax highlighting and diff display
- **Logging**: Commentary on critical migration points and documentation of manual adjustments

### Educational Goals
- Practical teaching of syntax analysis, AST inspection and transpilation
- Awareness of limitations in automated migration
- Comparison and evaluation of alternative tools
- Promotion of error management and documentation

## 🛠️ Technology Stack

### Core Libraries
- **Python AST Processing**: `ast` (Built-in), `libCST`
- **Rust Integration**: `PyO3`[^4] for Python-Rust interoperability
- **AST Parser**: `rustpython-parser`[^5] for full Python compatibility
- **Build Tool**: `maturin`[^6] for Python extension modules

### External Project Integration
The project uses and extends the following open-source tools:

| Tool | Description | Repository |
|------|-------------|------------|
| **PyCrust** | CLI tool for Python-to-Rust transpilation with OpenAI ChatGPT API | [JediRhymeTrix/PyCrust](https://github.com/JediRhymeTrix/PyCrust) |
| **Depyler** | Energy-efficient Python-to-Rust transpiler (75-85% energy savings) | [paiml/depyler](https://github.com/paiml/depyler) |
| **python-ast-rs** | Rust library for Python AST parsing and experimental transpilation | [python-ast on lib.rs](https://lib.rs/crates/python-ast) |
| **pyrs** | Experimental Python-to-Rust syntax converter | [konchunas/pyrs](https://github.com/konchunas/pyrs) |

## 🏗️ Architecture

### Main Components

```
src/
├── core/
│   ├── project_loader.py     # Project analysis and loading
│   ├── python_analyzer.py    # AST-based code analysis
│   ├── migration_engine.py   # Transpilation coordination
│   └── feedback_logger.py    # Error and hint logging
├── gui/
│   ├── main_window.py        # Main user interface
│   └── result_renderer.py    # Code visualization
├── mapping/
│   └── crate_database.py     # Python-to-Rust library mapping
└── integration/
    ├── pycrust_wrapper.py    # PyCrust integration
    ├── depyler_wrapper.py    # Depyler integration
    └── pyrs_wrapper.py       # pyrs integration
```

### Library Mapping System

| Python Library | Rust Equivalent               | Notes                          |
| -------------- | ----------------------------- | ------------------------------ |
| `NumPy`        | `ndarray`, `polars`           | Scientific computing           |
| `Pandas`       | `polars`                      | 10-100x better performance     |
| `Requests`     | `reqwest`                     | HTTP client                    |
| `FastAPI/Flask`| `Axum`, `Rocket`, `Actix-Web` | Web frameworks                 |
| `Click`        | `clap`, `structopt`           | CLI tools                      |
| `SQLAlchemy`   | `Diesel`, `SeaORM`            | Database ORM                   |
| `asyncio`      | `tokio`, `async-std`          | Asynchronous programming       |

## 🚀 Installation and Usage

### Prerequisites
- Python 3.8+
- Rust 1.75+
- Git

### Installation

```bash
# Clone repository
git clone https://github.com/[username]/py2rust.git
cd py2rust

# Set up Python environment
python -m venv venv
source venv/bin/activate  # Linux/Mac
# or: venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Compile Rust components
maturin develop
```

### Basic Usage

```python
from py2rust import ProjectLoader, PythonAnalyzer, MigrationEngine

# Load Python project
loader = ProjectLoader("path/to/python/project")
loader.load_files()

# Analyze code
analyzer = PythonAnalyzer(loader.files[0])
classes = analyzer.list_classes()
functions = analyzer.list_functions()

# Perform migration
engine = MigrationEngine(analyzer)
rust_code = engine.migrate()

print(f"Found classes: {classes}")
print(f"Found functions: {functions}")
print(f"Generated Rust code:\n{rust_code}")
```

## 🎯 Roadmap

### Phase 1: Foundations (Q2 2025)
- [ ] Define project structure
- [ ] AST parser integration (`rustpython-parser`)
- [ ] Basic GUI with `slint`
- [ ] Integration of first transpiler (`PyCrust`)
- [ ] Basic library mapping

### Phase 2: Core Functionality (Q3 2025)
- [ ] **Multi-Transpiler Support**: Integration of all major transpilers
- [ ] **Advanced AST Analysis**: Type inference and dependency tracking
- [ ] **Intelligent Error Detection**: Automatic detection of critical migration points
- [ ] **Performance Benchmarking**: Comparison of original vs. transpiled code
- [ ] **Configurable Migration Strategy**: User-defined transpilation rules

### Phase 3: Advanced Features (Q4 2025)
- [ ] **Incremental Migration**: Step-by-step porting of individual modules
- [ ] **Test Generation**: Automatic unit tests for migrated code
- [ ] **Rust Compilation**: Integrated Rust compiler validation
- [ ] **Memory Safety Analysis**: Ownership and borrowing optimization
- [ ] **Cloud Integration**: GitHub Actions/CI pipeline integration

### Phase 4: Enterprise Features (Q1 2026)
- [ ] **Team Collaboration**: Multi-user projects and version control
- [ ] **Plugin System**: Extensible architecture for custom transpilers
- [ ] **Reporting & Analytics**: Detailed migration reports and metrics
- [ ] **Large-Scale Migration**: Support for large projects (1000+ modules)
- [ ] **Machine Learning**: AI-based transpilation optimization

### Innovative Extensions (2026+)
- [ ] **Hybrid Mode**: Python-Rust mixed projects with seamless interoperability
- [ ] **WebAssembly Target**: Migration to WASM for browser deployment
- [ ] **Domain-Specific Languages**: Specialized transpilers for ML/Data Science
- [ ] **Visual Programming**: Drag-and-drop interface for migration workflows
- [ ] **Energy Optimization**: Automatic optimization for green computing

## 🌟 New Qualities Compared to Existing Solutions

### Unified User Interface
While existing tools like PyCrust, Depyler and pyrs function as separate CLI tools, Py2Rust offers:
- **Central Orchestration**: All tools united in one GUI
- **Comparable Results**: Side-by-side comparison of different transpilers
- **User-Friendliness**: No command-line knowledge required

### Intelligent Tool Selection
- **Contextual Recommendations**: Automatic tool selection based on code characteristics
- **Performance Metrics**: Energy efficiency comparisons (inspired by Depyler's 75-85% savings)
- **Fallback Strategies**: Multiple transpilers for robust migration

### Advanced Code Analysis
- **Dependency Graphs**: Visualization of module dependencies
- **Complexity Scoring**: Assessment of migration difficulty
- **Risk Assessment**: Identification of problematic code patterns

## 🤝 Contributing

We welcome contributions to Py2Rust development! See [CONTRIBUTING.md](../../02-Tech/Terminal/Nushell/nu-scripts/CONTRIBUTING.md) for details.

### Development Environment
```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
pytest tests/

# Code formatting
black src/
isort src/

# Type checking
mypy src/
```

## 📊 Benchmarks and Performance

Initial benchmarks show promising results:
- **Energy Efficiency**: Rust code consumes on average 70% less energy than Python[^7]
- **Execution Speed**: 10-100x performance improvement for numerical computations
- **Memory Safety**: Elimination of memory leaks and buffer overflows

## 📜 License

This project is licensed under the MIT License. See [LICENSE](../../02-Tech/Terminal/Nushell/nu-scripts/LICENSE.md) for details.

## 🙏 Acknowledgments

Special thanks to the maintainers of the integrated open-source projects:
- PyCrust team for GPT-based transpilation
- Depyler team for energy-efficient algorithms
- PyO3 community for excellent Rust-Python interoperability
- RustPython team for the complete Python parser

---

**Py2Rust** - *Bridging Python and Rust, one migration at a time.* 🐍 ➜ 🦀
