---
source: https://github.com/python/typeshed
---
## About

Typeshed contains external type annotations for the Python standard library and Python builtins, as well as third party packages as contributed by people external to those projects.

This data can e.g. be used for static analysis, type checking or type inference.

For information on how to use `typeshed`, read below. Information for contributors can be found in [CONTRIBUTING.md](https://github.com/python/typeshed/blob/main/CONTRIBUTING.md). **Please read it before submitting pull requests; do not report issues with annotations to the project the stubs are for, but instead report them here to typeshed.**

Further documentation on stub files, typeshed, and Python's typing system in general, can also be found at [https://typing.readthedocs.io/en/latest/](https://typing.readthedocs.io/en/latest/).

Typeshed supports Python versions 3.7 and up.

## [](https://github.com/python/typeshed#using)

## Using

If you're just using a type checker ([mypy](https://github.com/python/mypy/), [pyright](https://github.com/microsoft/pyright), [pytype](https://github.com/google/pytype/), PyCharm, ...), as opposed to developing it, you don't need to interact with the typeshed repo at all: a copy of standard library part of typeshed is bundled with type checkers. And type stubs for third party packages and modules you are using can be installed from PyPI. For example, if you are using `six` and `requests`, you can install the type stubs using

$ pip install types-six types-requests

These PyPI packages follow [PEP 561](http://www.python.org/dev/peps/pep-0561/) and are automatically released (multiple times a day, when needed) by [typeshed internal machinery](https://github.com/typeshed-internal/stub_uploader).

Type checkers should be able to use these stub packages when installed. For more details, see the documentation for your type checker.

### [](https://github.com/python/typeshed#the-_typeshed-package)