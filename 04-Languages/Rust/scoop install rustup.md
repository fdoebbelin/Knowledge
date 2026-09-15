Rust is installed now. Great!

To get started you need Cargo's bin directory (C:\Users\f.doebbelin.BWSA\scoop
\persist\rustup\.cargo\bin) in your PATH
environment variable. This has not been done automatically.
done.
Linking ~\scoop\apps\rustup\current => ~\scoop\apps\rustup\1.28.1
Adding ~\scoop\apps\rustup\current\.cargo\bin to your path.
Persisting .cargo
Persisting .rustup
'rustup' (1.28.1) was installed successfully!
Notes
-----
This package defaults to using the MSVC toolchain in new installs; use "rustup set default-host" to configure it
(existing installs may be using the GNU toolchain by default)
According to https://doc.rust-lang.org/book/ch01-01-installation.html#installing-rustup-on-windows
Microsoft C++ Build Tools is needed and can be downloaded here:
https://visualstudio.microsoft.com/visual-cpp-build-tools/
When installing build tools, these two components should be selected:
- MSVC - VS C++ x64/x86 build tools
- Windows SDK