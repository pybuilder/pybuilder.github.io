---
layout: documentation
title: pybuilder - an extensible, easy to use continuous build tool for Python
---

# Release Notes

## Version 0.9.11

* The integrationtest plugin can now run test in parallel.
  This behaviour can be enabled with `project.set_property("integrationtest_parallel", True)`.

  The degree of parallelization defaults to four times the amount of cores but may be
  overridden with `project.set_property("integrationtest_workers", 42)`.

## Version 0.9.10

* It can no longer occur that the `ronn_manpage` plugin fails due to the reports directory not existing.

## Version 0.9.9

* New plugin ronn_manpage to generate manpages from markdown sources
* The -t option no longer causes an error on python3

## Version 0.9.8

* option "-t" list of tasks: improved layout
* django plugin: task djang_run_server is now ready for django 1.5
* django plugin bug fix: import django only when executing task

## Version 0.9.7

* the project itself now has a property "verbose". It's possible to set the project verbose by default via: project.set_property("verbose", True)
* install_dependencies plugin has verbose output now

## Version 0.9.6

* integrationtest plugin: prints output and error files if verbose option enabled

## Version 0.9.5

* pep8 and flake8 define their own dependencies

## Version 0.9.4

* `pybuilder.VERSION` is now `pybuilder.__version__`

## Version 0.9.3

* created -v/--verbose option for "pyb"
* flake8 plugin offers verbose option

## Version 0.9.2

* Verbose output for report generating plugins. Pull request by [Vanuan](https://github.com/Vanuan).

## Version 0.9.1

* Added several new options for the `install_dependencies` plugin to customize the `pip` behaviour.
* `coverage` and `pyfix` plugins define their dependencies.
* Added `very-quiet` command line option.
* Bug fix: `copy_resources` plugin uses correct target.


## Version 0.8.3

* Added `pyfix_unittest` plugin that executes unittests written using [pyfix](https://github.com/pyclectic/pyfix).

## Version 0.8.2

* Bug fix: Fixed version "operator" when handling dependencies in distutils.

## Version 0.8.1

* Bug fix: Reading default tasks after initializers have been executed.

## Version 0.8.0

* Initial release of environments.

## Version 0.7.6

* Added two properties that allow the customization of the environment used for integration tests.

## Version 0.7.5

* Added validation step that validates the integrity of dependencies.

## Version 0.7.4

* Distutils plugin supports URLs for dependencies and adds a ```dependency_links``` parameter to ```setup()```.

## Version 0.7.3

* Bugfix release for ```install_dependencies``` plugin.
* Dependencies take an optional URL which is used for installation.

## Version 0.7.2

* Added install_dependencies plugin which provides capabilities to install build and runtime dependencies for Python projects.

## Version 0.7.1

* pybuilder is now compatible with Python 3.
* Snakefood plugin has been discontinued because snakefood seems rather unmaintained and is not compatible to Python 3.

## Version 0.6.5

* Introduced build dependencies that do not get added as install_requires to setup.py files

## Version 0.6.4

* Added flake8 plugin. Added support for installing files.
