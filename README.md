# Simple Dev Docker

A pre-built docker image of Ubuntu 20.04, with basic daily tools shipped with usual distributions

## Exact things included

- Minimized Ubuntu 20.04 Server, with curl / wget / vim, without boot/X11/systemd stuffs

- Oh-My-ZSH & Misty Shell Environment (a modular zsh configurations) (https://github.com/NyaMisty/.misty_envconf_pub)

- Basic build environment: GNU suite: gcc/make/flex/bison/autoconf & LLVM suite: clang/cmake/ninja

- Python managed by Pyenv (2.7.13, 3.9.5)

## Caveat

- Build: Not including gcc-multilib

- Python: No Tkinter support, No xmlsec support

