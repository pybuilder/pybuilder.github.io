---
layout: documentation
title: pybuilder - an extensible, easy to use continuous build tool for Python
---

# Release Notes

## Version 0.10.2
* Fixed a bug leading to the creation of strange files when dependencies with a version greater than x (`foo>=1.0`) were specified.

## Version 0.10.1
* Source and test directories are now correctly handed to the unittest's PYTHONPATH, thus it is no longer a pain to test a package which is also locally installed.

## Version 0.10.0
* Better reporting when unittests fail. Thanks [@esc](https://github.com/esc)!
* The parallel integration test progress bar now uses backspaces instead of carriage returns. This improves the experience on small width terminals.
* The deprecated module `pythonbuilder` has now been removed. Please replace `pythonbuilder` with `pybuilder` in your imports if that is not already the case.

## Version 0.9.25
* There is now a pacman in your integration tests!

## Version 0.9.24
* Integration test progress bar now works on Mac OS.

## Version 0.9.23
* Improved error messages when `integrationtest_additional_environment` is not a map.
* Improved resilience of the integration test plugin when running tests in parallel and there are errors in the plugin code itself.

## Version 0.9.22
* The [integrationtest plugin](/documentation/plugins.html#RunningPythonIntegrationTests) now displays a progress bar when tests are run in parallel. The bar indicates the amount of tests that are finished, running, and not started yet. In an automated CI build environment without TTY (Jenkins, Teamcity, …) text based output is used to avoid cluttering the logs with carriage returns.

## Version 0.9.21
* The unittest plugin is now able to provide useful error messages
  when unit tests have import errors.

## Version 0.9.20
* The pytddmon plugin now disables the color pulse for more focus.
* Added a command, `pyb --start-project`, to create a python project skeleton.
* The `flake8` plugin now complies with the project `verbose` property.
* Increased severity of the `pythonbuilder` module deprecation warning.

## Version 0.9.18
* Added a new plugin, `python.pycharm`, [which can generate PyCharm project files](/documentation/plugins.html#ProjectfilesforJetbrainsPyCharm).
* Added a new plugin, `python.pytddmon`, [which can be used to monitor unit tests](http://pybuilder.github.io/documentation/plugins.html#Visualfeedbackfortests)

## Version 0.9.17
* Allows the user to define a project variable "unittest_test_method_prefix" as a prefix for the unit test method names.

## Version 0.9.16
* The flake8 plugin no longer causes build errors when used on a project without unittests or integrationtests
  in conjunction with the property `flake8_include_test_sources`.

## Version 0.9.15

* The flake8 plugin is now able to also lint test sources.
  This behaviour is disabled by default but may be enabled by setting the
  property `flake8_include_test_sources` to True.

## Version 0.9.14

* The flake8 plugin now requires `prepare` to run first and thus no longer
  results in errors after `clean`.

## Version 0.9.13

* Fixed a compatibility issue on windows
* It is now possible to use external plugins.
  An external plugin should be an importable python package that exposes its tasks
  in the top-level (e.G. in `__init__.py`).
  The plugin can be used through the `use_plugin` directive without further ado
  but must currently be bootstrapped manually.


## Version 0.9.12

* The property `integrationtest_workers` was removed.
  Instead, you may now set `integrationtest_cpu_scaling_factor` to an integer n,
  which will use `n * cpu_count` workers to run the integration tests.

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
