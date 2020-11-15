# Archived since Xenia now has some support for CMake using xb devenv

xenia.cmake
===================
[![Build Status](https://travis-ci.org/bwrsandman/xenia.cmake.svg?branch=master)](https://travis-ci.org/bwrsandman/xenia.cmake)

This repo contains a bunch of cmake files that can be used to build xenia with CMake.

Building
-------------

```
git clone https://github.com/bwrsandman/xenia.cmake.git
cd xenia.cmake
git submodule update --init --recursive
cmake -S . -B cmake-build-debug
```

Note
-------------
I try to maintain this repo when I can, but I have a full time job which makes
it a bit difficult. I will gladly accept any pull requests updating to the
latest xenia, fixing bugs, improving support, etc.

How To Use
-------------
This project is setup to be included a few different ways.
The project can be included in CMake-based IDEs such as clion.
The project can use system-installed third-party packages by
using `find_package` before including third-party scripts with targets of the
same name.


Features
-------------
* Tested on clion with clang 9 on linux.
* Option to compile libraries as shared or static.
* Compiles xenia, tests & apps.

Does this work with latest xenia?
-------------
Probably! This project needs to be updated if a dependency is added or the xenia
build system changes. The xenia repository is very active but these types of
changes are rare. New apps and tests have to be added manually as well, but not
doing so will merely result in those executables not showing up and won't break
anything else.

TODO
-------------
* Support GCC.
* Support MSVC.
* Support Windows.
* Support Xenia's Linux Branch.
