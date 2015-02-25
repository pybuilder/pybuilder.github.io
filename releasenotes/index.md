---
layout: documentation
title: pybuilder - an extensible, easy to use continuous build tool for Python
---

# Release Notes

## Version 0.10.47
* Sonarqube plugin: Should now correctly report coverage.

## Version 0.10.46
* Sonarqube plugin: Fixed source path setting.

## Version 0.10.45
* Coverage plugin: now writes a cobertura compatible XML report to the reports directory.
* New plugin: [sonarqube plugin](/documentation/plugins.html#SonarQubeintegration), which can be used to run sonar analysis.

## Version 0.10.44
* Coverage plugin: Should now work with coveralls without further adjustements since a coverage data file is written.

## Version 0.10.43
* Coverage plugin: Try really hard to work well with coveralls
    
    The coverage configuration is used to tell coverage to avoid covering the python
    stdlib if possible, and also specifies the source root to cover.
    Additionally a .coverage file is written in the coverage root, so that
    it can be consumed by coveralls.


## Version 0.10.42
* detect teamcity environment automatically

    If the environment variable TEAMCITY_VERSION is set, teamcity output will be
    generated automatically. It can still be forced with the project
    property "teamcity_output", and setting both the property and the
    environment variable will also result in teamcity specific output being
    generated.


## Version 0.10.41
* Default project version (when no version is given in the `build.py` is now 1.0.dev0 instead of 1.0-SNAPSHOT, as per PEP 440. Pull request by [@zroadhouse-wsm](https://github.com/zroadhouse-wsm), thanks!

## Version 0.10.40
* Improved error messages when the setup commands from `python.distutils` fail.
* Naming a script (`src/main/scripts/foo`) like a package
  (`src/main/python/foo/__init__.py`) now works without any specific configuration.
  Technical detail: the property `dir_dist_scripts` is now set to `"scripts"` by
  default instead of `None`.

## Version 0.10.39
* Resolved problems with the python core plugin on windows. Packages with leading backslashes were leading to problems with the setup script. Thanks to [@SzeMengTan](https://github.com/SzeMengTan) for reporting.

## Version 0.10.38
* Initial version of a sphinx plugin. Pull request by [@tjpnz](https://github.com/tjpnz), thanks!.

## Version 0.10.37
*  Fix using the `dir_dist_scripts` property in python3 which was breaking the setup script.
   Thanks to [@raphiz](https://github.com/raphiz) for the pull request!

## Version 0.10.36
* Coverage plugin: ignored modules will no longer contribute to the
  overall coverage calculation [(referring to the modules or packages
  in `coverage_exceptions`)](/documentation/plugins.html#Measuringunittestcoverage).
  Thanks to [@MirkoRossini](https://github.com/MirkoRossini) for the pull
  request!

## Version 0.10.35
* The generated setup.py is now correct even if the `$dir_source_main_python` contains a trailing slash.
  See [issue 110](https://github.com/pybuilder/pybuilder/issues/110) for more details.
  Thanks @MirkoRossini for reporting!
* The `pyb -Qt` line format is now `$task_name:$task_description`.
  This allows for better completions by also exposing the task names.

## Version 0.10.34
* The jedi linter has been externalized, please use `pypi:pybuilder_jedi_plugin` now.
* The task list (-t) in very quiet mode (-Q) will now output space separated task data.


## Version 0.10.33
* The `filter_resources` plugin will now warn and skip keys that can not be replaced. This allows the use of `string.Template` in source files that go through the `filter_resources` plugin.

## Version 0.10.32
* implement using requirements files as dependencies

## Version 0.10.31
* Improved output of the jedi plugin

## Version 0.10.30
* Resolved some problems with the bundled jedi plugin

## Version 0.10.29
* Added plugin `jedi_linter` (EXPERIMENTAL)

## Version 0.10.28
* Resolved a python 3 compatibility problem with the `exec` plugin.

## Version 0.10.27
* Added another pybuilder command `pyb_`. which is a binary (`.exe`) on windows installations of PyBuilder.
  This should be used instead of the `pyb` script on windows installations.

## Version 0.10.26
* install_dependencies should now work as intended on windows.

## Version 0.10.25
* Fixed a problem when the installed pip had no __version__ which is the case of old installations.

## Version 0.10.24
* Fixed a problem with the distutils plugin. Using slashes in `distutils_commands` resulted in problems as it was interpreted as a path. This is now resolved.

## Version 0.10.23
* It is now possible to use the `distutils_commands` property for an automated upload, since
  the distutils_plugin will now do the right thing when presented with a command with spaces,
  like [`sdist upload`]

## Version 0.10.22
* Unit tests names will now be logged to DEBUG as they run. Thanks [@aelgru](https://github.com/aelgru)!
* Introduced a new property for the [`install_dependencies` plugin](/documentation/plugins.html#Installingdependencies),
`install_dependencies_insecure_installation`.

## Version 0.10.21
* Maintenance release (updated trove classifiers for PyPI)

## Version 0.10.20
* The `--start-project` (to get started with a new project) now suggests the default scripts directory and creates it. Files in this folder will automatically be shipped as scripts (as in the setup.py `scripts` kwarg) which might be `/usr/bin` or `/usr/local/bin` or so, depending on your system.

## Version 0.10.19
* The frosted and flake8 linter now consider the property `frosted|flake8_include_scripts`. If this is set to True (default False) then all scripts in `$dir_source_main_scripts` will be linted too.
* The integrationtest plugin may now pass arbitrary additional command line parts to the integrationtest call. The property `integrationtest_additional_commandline` can be used for that purpose.

## Version 0.10.18
* Python files in `$dir_source_main_python` (`src/main/python` by default) are now treated as standalone python modules. Previously, it was only possible to package python files by putting them in a package.

## Version 0.10.17
* The `frosted_property` now works as intended.

## Version 0.10.16
* The pycharm plugin now ignores the `target` directory by default.

## Version 0.10.15
* Fixed a minor rendering issue in integrationtest_parallel

## Version 0.10.14
* External plugin support : It is now finally possible to use plugins
  published to PyPI. See [the manual](/documentation/external_plugins.html) for more information.

## Version 0.10.13
* Cram support : The [`python.cram`](/documentation/plugins.html#RunningCramtests) plugin can be used to run [cram](https://pypi.python.org/pypi/cram) tests. Kudos go to [@esc](https://github.com/esc) for the implementation.

## Version 0.10.12
* [Bldsup support](/documentation/plugins.html#Splittingupyourbuild.pywithbldsup) : custom tasks and per-project specifics can be stored in a separate directory (default: `bldsup`). Kudos go to [@markmevans](https://github.com/markmevans) for implementing this.

## Version 0.10.11
* New plugin : [python.frosted](/documentation/plugins.html#Frostedplugin)
* New API to write plugins that wrap a console command that is run on source files
* Flake8 error handling improved

## Version 0.10.10
* It should no longer occur that CI servers count unit tests twice when coverage is used.
* TeamCity service messages for unit test failures are now well-formed

## Version 0.10.8
* The property "teamcity_output" can be set to True so that teamcity messages are produced by the `python.unittest` and `python.integrationtest` plugin.
Please note that the coverage plugin also runs unit tests and might lead to teamcity counting the amount of unit tests twice.

## Version 0.10.6
* `pyb --start-project` now activates the plugin `python.install_dependencies` by default.

## Version 0.10.5
* `pyb --start-project` will now suggest a few plugins.

## Version 0.10.4
* `pyb --start-project` now always generates an initializer so that plugin can be configured more easily.
* There is now a workaround for [a distutils bug](http://bugs.python.org/issue8876) available through the distutils plugin. See [the GitHub issue](https://github.com/pybuilder/pybuilder/issues/56) or [the documentation](http://pybuilder.github.io/documentation/plugins.html#VirtualBoxpitfallwithbinarydists).

## Version 0.10.3
* The unittest, pyfix and integrationtest plugins now find modules (or files, for the integrationtest plugin) using globs.
Kudos to [markmevans](https://github.com/markmevans) for this feature!

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
