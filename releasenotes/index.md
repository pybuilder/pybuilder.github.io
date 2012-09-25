---
layout: documentation
title: pybuilder - an extensible, easy to use continuous build tool for Python
---

# Release Notes


## Version 0.8.3

Added `pyfix_unittest` plugin that executes unittests written using [pyfix](https://github.com/pyclectic/pyfix).

## Version 0.8.2

Bug fix: Fixed version "operator" when handling dependencies in distutils.

## Version 0.8.1

Bug fix: Reading default tasks after initializers have been executed.

## Version 0.8.0

Initial release of environments.


## Version 0.7.6

Added two properties that allow the customization of the environment used for integration tests.


## Version 0.7.5

Added validation step that validates the integrity of dependencies.


## Version 0.7.4

Distutils plugin supports URLs for dependencies and adds a ```dependency_links``` parameter to ```setup()```.


## Version 0.7.3

Bugfix release for ```install_dependencies``` plugin.

Dependencies take an optional URL which is used for installation.


## Version 0.7.2

Added install_dependencies plugin which provides capabilities to install build and runtime dependencies for Python projects.


## Version 0.7.1

pybuilder is now compatible with Python 3.

Snakefood plugin has been discontinued because snakefood seems rather unmaintained and is not compatible to Python 3.


## Version 0.6.5

Introduced build dependencies that do not get added as install_requires to setup.py files


## Version 0.6.4

Added flake8 plugin. Added support for installing files.

