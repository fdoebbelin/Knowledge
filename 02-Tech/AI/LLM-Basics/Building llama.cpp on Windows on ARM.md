I finally managed to build llama.cpp on Windows on ARM running on a Surface Pro X with the Qualcomm 8cx chip. Why bother with this instead of running it under WSL? It lets you run the largest models that can fit into system RAM without WSL Hyper-V overhead.

I didn't notice any speed difference but the extra available RAM means I can use 7B Q5_K_M GGUF models now instead of Q3. Typical output speeds are 4 t/s to 5 t/s.

# Steps

## Install MSYS2

The installer package has x64 and ARM64 binaries included.

## Run clangarm64

When you're in the shell, run these commands to install the required build packages:

pacman -Suy  
pacman -S --needed base-devel  
pacman -S mingw-w64-clang-aarch64-clang  
pacman -S mingw-w64-clang-aarch64-cmake mingw-w64-clang-aarch64-extra-cmake-modules  
pacman -S make  
pacman -S git  
pacman -S mingw-w64-clang-aarch64-openblas  
pacman -S mingw-w64-clang-aarch64-openblas64  
pacman -S mingw-w64-clang-aarch64-gcc-compat  
pacman -S mingw-w64-clang-aarch64-pkgconf  
pacman -S mingw-w64-clang-aarch64-ccache

## Clone git repo and set up build environment

- git clone <llama.cpp repo>
    
- cd llama.cpp
    
- mkdir build
    
- cd build
    

## Build llama.cpp

- cmake ..
    
- cmake --build . --config Release
    
- You can also build it using OpenBlas, check the llama.cpp docs on how to do this.
    

## Run main

- bin/main.exe

There should be a way to get NPU-accelerated model runs using the Qualcomm QNN SDK, Microsoft's ONNX runtime and ONNX models but I got stuck in dependency hell in Visual Studio 2022. I'm not a Windows developer and trying to combine x86, x64 and ARM64 compilers and python binaries is way beyond me.

