# PythonQt 

## **Another cmake fork**

https://github.com/commontk/PythonQt/tree/patched-10 - solution is deprecated currently. 

At this moment, there are no cmake files for tests and generator. + Only working with python3. Feel free to open issues or contribute if you find this solution helpful.

[![License](https://img.shields.io/github/license/mevislab/pythonqt.svg?color=blue)](LICENSE)

PythonQt is a dynamic [Python](https://www.python.org) binding for [Qt](https://www.qt.io).
It offers an easy way to embed the Python scripting language into
your Qt applications.

# Documentation

API documentation is available at: https://mevislab.github.io/pythonqt

# Licensing

PythonQt is distributed under the `LGPL 2.1` license.

# Building

To build PythonQt, you need to install Python and Qt5/6 to your system and add it to the PATH for find_package
  
```
cmake -B <path-to-build-dir> -S <path-to-source-dir>
cd <path-to-build-dir>
make  # based on chosen generator
make install #based on chosen generator
```
