---
soure: https://www.mypy-lang.org/
---
- Mypy is an optional static type checker for Python that aims to combine the benefits of dynamic (or "duck") typing and static typing. 
- Mypy combines the expressive power and convenience of Python with a powerful type system and compile-time type checking. 
- Mypy type checks standard Python programs; run them using any Python VM with basically no runtime overhead.

## Installing and running mypy

Mypy requires Python 3.7 or later to run. You can install mypy using pip:


```sh
python3 -m pip install mypy
```

Once mypy is installed, run it by using the `mypy` tool:


```sh
mypy program.py
```

This command makes mypy _type check_ your `program.py` file and print out any errors it finds. Mypy will type check your code _statically_: this means that it will check for errors without ever running your code, just like a linter.

This also means that you are always free to ignore the errors mypy reports, if you so wish. You can always use the Python interpreter to run your code, even if mypy reports errors.

However, if you try directly running mypy on your existing Python code, it will most likely report little to no errors. This is a feature! It makes it easy to adopt mypy incrementally.

In order to get useful diagnostics from mypy, you must add _type annotations_ to your code. See the section below for details.