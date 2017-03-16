---
layout: documentation
title: pybuilder - an extensible, easy to use continuous build tool for Python
---

# Release Notes

## Version 0.11.10

* Allow obsoleting packages with "obsoletes" [#456](https://github.com/pybuilder/pybuilder/issues/456)
* PyBuilder needs to depend on modern setuptools [#452](https://github.com/pybuilder/pybuilder/issues/452)
* Allow specifying python version constraint [#450](https://github.com/pybuilder/pybuilder/issues/450)
* Add Python 3.6 support [#446](https://github.com/pybuilder/pybuilder/issues/446)
* Copy resource doesn't include the `LICENSE` file in the distro [#443](https://github.com/pybuilder/pybuilder/issues/443)
* Coverage plugin fails when fails to load covered module [#441](https://github.com/pybuilder/pybuilder/issues/441)
* Increasing test coverage on vcs_tests.py [#439](https://github.com/pybuilder/pybuilder/issues/439)
* Allow modifying default targets similar to manner of adding them in #412 [#438](https://github.com/pybuilder/pybuilder/issues/438)
* Fix PyPI documentation [#435](https://github.com/pybuilder/pybuilder/issues/435)
* PyBuilder's `setup.py` broken when `pandoc>=1.18` is installed with `pypandoc~=1.2.0` [#429](https://github.com/pybuilder/pybuilder/issues/429)
* python.distutils plugin: `setup.py` keywords [#424](https://github.com/pybuilder/pybuilder/issues/424)
* Flake8 3.2.0 broke the build [#420](https://github.com/pybuilder/pybuilder/issues/420)
* Uptake new PIP upgrade features [#416](https://github.com/pybuilder/pybuilder/issues/416)
* Allow to append build targets to default from command line [#413](https://github.com/pybuilder/pybuilder/issues/413)
* Generate package summary and description based on a `README.md` [#408](https://github.com/pybuilder/pybuilder/issues/408)
* Wrong dependency version error formatting [#405](https://github.com/pybuilder/pybuilder/issues/405)
* Fix paths in the Sphinx PyB quickstart and runtime configuration [#403](https://github.com/pybuilder/pybuilder/issues/403)
* Wrong logging level for `sphinx_generate_documentation` [#401](https://github.com/pybuilder/pybuilder/issues/401)
* Sphinx configuration should share PyB at runtime #398 [#399](https://github.com/pybuilder/pybuilder/issues/399)
* Color escape sequence not properly terminated [#390](https://github.com/pybuilder/pybuilder/issues/390)
* Harden `expand_path` for Windows and `safe_log_file_name` [#393](https://github.com/pybuilder/pybuilder/issues/393)
* Pathing issues on pypi upload on Windows [#391](https://github.com/pybuilder/pybuilder/issues/391)
* `python.distutils` plugin doesn't support `namespace_packages` [#385](https://github.com/pybuilder/pybuilder/issues/385)
* Coverage should be setup to cover multiprocessing and forks [#384](https://github.com/pybuilder/pybuilder/issues/384)
* Recursive dependency upgrades should be subject to global version constraints [#380](https://github.com/pybuilder/pybuilder/issues/380)
* Coverage for missing modules should cause a failure [#377](https://github.com/pybuilder/pybuilder/issues/377)

## Version 0.11.9

* adding `count_travis` [#372](https://github.com/pybuilder/pybuilder/issues/372)
* Fix path separators and protect log file names on Windows [#371](https://github.com/pybuilder/pybuilder/issues/371)
* `include_directory` fix for manifest and `setup.py` [#367](https://github.com/pybuilder/pybuilder/issues/367)
* use `shutil.rmtree` instead of `os.removedirs` [#365](https://github.com/pybuilder/pybuilder/issues/365)
* implement `get_git_hash` [#363](https://github.com/pybuilder/pybuilder/issues/363)
* Entry-points should handle a single entry correctly [#359](https://github.com/pybuilder/pybuilder/issues/359)
* Add a proper pdoc plugin [#353](https://github.com/pybuilder/pybuilder/issues/353)
* `@dependents` ignores customized task name [#357](https://github.com/pybuilder/pybuilder/issues/357)
* `@dependents` does not inject dependencies from plugin if task is already defined earlier [#355](https://github.com/pybuilder/pybuilder/issues/355)
* PyBuilder `install_dependencies` behavior should mirror #340 [#347](https://github.com/pybuilder/pybuilder/issues/347)
* Sphinx indicates failure with -v but not without it [#350](https://github.com/pybuilder/pybuilder/issues/350)

## Version 0.11.8

* Support for pip trusted hosts [#341](https://github.com/pybuilder/pybuilder/issues/341)
* Add possibility to specify plugin versions [#340](https://github.com/pybuilder/pybuilder/issues/340)
* Fix issue in generated `setup.py` [#332](https://github.com/pybuilder/pybuilder/pull/332)

## Version 0.11.7

* Pin `unittest-xml-reporting` dependency to maintain py2.6 support [#333](https://github.com/pybuilder/pybuilder/pull/333) (thanks @snordhausen)
* Distutils upload signing [#325](https://github.com/pybuilder/pybuilder/issues/325)
* Ability to customize packaging options ad nauseam [#331](https://github.com/pybuilder/pybuilder/pull/331)
* Success message after generating `setup.py` in `--start-project`
* Windows fixes (thanks @Lucas-C and @guillermooo).

## Version 0.11.6

* Cram plugin can now run cram from the `target` directory and does so by default [#318](https://github.com/pybuilder/pybuilder/pull/318)

## Version 0.11.5

* Update cram plugin to use the 'outside' environment [#316](https://github.com/pybuilder/pybuilder/pull/316)
* Honor `pylint` options [#315](https://github.com/pybuilder/pybuilder/pull/315)

## Version 0.11.4

* `install_dependencies_(extra_)index_url` should affect all PIP operations [#313](https://github.com/pybuilder/pybuilder/pull/313)
* Task `install_dependencies` doesn't work in version 0.11.3 [#311](https://github.com/pybuilder/pybuilder/pull/311)
* Allow dynamic discovery `entry_points` configuration [#309](https://github.com/pybuilder/pybuilder/pull/309)


## Version 0.11.3
* Coverage plugin now excludes namespaces (not backed by an actual source file) [#301](https://github.com/pybuilder/pybuilder/issues/301)
* Installing dependencies with use of an HTTPS proxy is now possible [#299](https://github.com/pybuilder/pybuilder/issues/299)
* Python 3.5 issue resolved [#287](https://github.com/pybuilder/pybuilder/issues/287)
* External tool dependencies for plugins are now properly updated [#272](https://github.com/pybuilder/pybuilder/issues/272)
* `pyb install` now forces the reinstallation [#282](https://github.com/pybuilder/pybuilder/issues/282)
* Cram now handles the case where there are no tests [#280](https://github.com/pybuilder/pybuilder/issues/280)
* Plugins can be installed via VCS [#276](https://github.com/pybuilder/pybuilder/issues/276)
* PyBuilder projects can be installed via URL-based install [#200](https://github.com/pybuilder/pybuilder/issues/200)
* Plugins can now find out if a task is in the current execution plan [#275](https://github.com/pybuilder/pybuilder/issues/275)
* Handling system exits gracefully [#255](https://github.com/pybuilder/pybuilder/issues/255)
* Plugin-specified constraints for PyBuilder API version [#257](https://github.com/pybuilder/pybuilder/issues/257)
* `pyb -o` now properly excludes all optional tasks [#263](https://github.com/pybuilder/pybuilder/issues/263)
* Fixed missing `xmlrunner` dependency [#267](https://github.com/pybuilder/pybuilder/issues/267)
* `pyb -T` shows build plan [#262](https://github.com/pybuilder/pybuilder/issues/262)
* Possibility to inject tasks as dependent [#188](https://github.com/pybuilder/pybuilder/issues/188)
* Fixed egg/wheel shebangs [#168](https://github.com/pybuilder/pybuilder/issues/168)
* Optional automatic version augmentation based on `.dev` releases [#209](https://github.com/pybuilder/pybuilder/issues/209)
* Upload repository for distutils upload task now works [#243](https://github.com/pybuilder/pybuilder/issues/243)
* Fixed issue with `@task` decorator
* New tasks for printing module and script directory path [#208](https://github.com/pybuilder/pybuilder/issues/208)
* Support for setuptools pre- and post-install logic [#227](https://github.com/pybuilder/pybuilder/issues/227)
* Flake8 plugin now checks for directory existence before including it [#230](https://github.com/pybuilder/pybuilder/issues/230)
* Helpful error message when `pyb -t` is not called in the project root directory [#226](https://github.com/pybuilder/pybuilder/issues/226)

## Version 0.11.2
* Added `project.include_directory` functionality [#223](https://github.com/pybuilder/pybuilder/issues/223). Pull request by [@glujan](https://github.com/glujan)
* Coverage plugin will not reset modules per default (only if `coverage_reset_modules` is set to `True`) [#211](https://github.com/pybuilder/pybuilder/issues/211).
* Coverage forking disabled for windows OS [#184](https://github.com/pybuilder/pybuilder/issues/184)
* Coverage / branch coverage discrepancy fix [#203](https://github.com/pybuilder/pybuilder/issues/203)
* Resolved flake8 plugin filtering issue [#202](https://github.com/pybuilder/pybuilder/issues/202)
* New plugin for debian packaging by @locolupo [#190](https://github.com/pybuilder/pybuilder/issues/190)
* The distutils plugin can now upload distributions [#187](https://github.com/pybuilder/pybuilder/issues/187)
* Resolved issue with `install_dependencies` on windows OS [#185](https://github.com/pybuilder/pybuilder/issues/185).

## Version 0.11.1
* The `0.11.0` metadata claimed to support python 3.2. This has been fixed.

## Version 0.11.0
* Nearly this entire release is courtesy of [arcivanov](https://github.com/arcivanov). Thanks!!!
* Introduced `reactor.execute_task_shortest_plan` API.
* Fixed an issue where a forked coverage measurement would not properly failed the build.
* unit test and coverage measurement are now library functions in an API sense.
* `pyb install` now works and acts like `setup.py install` (distutils plugin).
* PyBuilder can now be installed with `pip install git://github.com/pybuilder/pybuilder.git@<branch>`
* Forked processes (like coverage measurements) now correctly report back their errors.
* Huge improvements to coverage accuracy when building PyBuilder itself / libraries which use part of their own code in order to build, e.G. if you run library code in `build.py`.
* Branch coverage and html reports have been added to the `python.coverage` plugin.
* The `python.coverage` process will now always fork when measuring coverage, disregarding the `coverage_fork` setting. The `coverage_fork` setting is now deprecated.
* The `python.unittest` plugin will now always fork.
* Module reloading has been removed. It is no longer useful since coverage and unit tests run in separate forks.
* `unittest_runner` must now accept a positional argument which is a filelike object. Writing to this filelike object is preferred rather than using stdout/stderr.
* Introduced [teardown actions](https://github.com/pybuilder/pybuilder/issues/169). Also action ordering is now stable/guaranteed.
* Introduced optional task dependencies (as opposed to required task dependencies). With the command line switch `-x task_name` a set of optional tasks can be skipped (repeat if required). With the command line switch `--force-exclude` this can be expanded to exclude required dependencies as well (but might lead to build consistency problems).
* **Python 3.2 support has been dropped**, please upgrade to 3.3 or 3.4
* The `python.unittest` plugin now generates nUnit-style XML reports by default (these can be parsed by jenkins).

## Version 0.10.63
* Fixed a regression introduced in `0.10.62` where the unit test reports generated by the `python.unittest` plugin would always be empty.

## Version 0.10.62
* Allow to specify a custom unittest runner. See [PR](https://github.com/pybuilder/pybuilder/pull/140) for more information (pull request by [arcivanov](https://github.com/arcivanov).

## Version 0.10.61
* pycharm plugin: Generate entries for unit and integration test directories (if respective plugins are activated) and mark them as test sources (pull request by [arcivanov](https://github.com/arcivanov))

## Version 0.10.60
* sphinx plugin:  you can now configure sphinx_doc_author, sphinx_doc_builder, sphinx_project_name, sphinx_project_version via project.set_property in your build.py (pull request by @locolupo)
* sphinx plugin: pyb --start-project now asking for a documentation folder (pull request by @locolupo)
* sphinx plugin: new task, `sphinx_quickstart` (pull request by @locolupo)
* install dependencies plugin: Setting the property `install_dependencies_local_mapping` to a dictionary
   allows to specify where the dependencies are to be installed locally.
   The dictionary should map dependency names to paths where the dependencies should be installed.

## Version 0.10.59
* integrationtest plugin: The property `integrationtest_always_verbose` can now be used to always display the integration test output, even when the tests are green. Pull request by [@snordhausen](https://github.com/snordhausen)

## Version 0.10.58
* Fixed python3 incompatibility introduced in 0.10.57

## Version 0.10.57
* Using editable URLs in a `requirements.txt` file now works - integrating the requirements into PyBuilder with `project.depends_on_requirements("requirements.txt")` was not generating the correct setup script.

## Version 0.10.56
* Resolved problems where the python unittest plugin would cause a crash when a test failed with an exception containing non-ascii text. 

## Version 0.10.55
* Resolved python3 compatibility issue introduced with `0.10.54`

## Version 0.10.54
* Improved the cyclic dependency detection algorithm used to resolve task dependencies
* Added possibility for tasks to introspect their dependencies (see [#122](https://github.com/pybuilder/pybuilder/issues/122))

## Version 0.10.53:
*  Fix autoversioning for older git version like found on RHEL6.

   Pull request by [@schlomo](https://github.com/schlomo), thanks!

## Version 0.10.52:
* Ignore errors while trying to save coverage data
  This fixes #119. In cases where there is no coverage data at all, saving
  leads to an error, which would crash the build even if
  `coverage_break_build` was set to False.

## Version 0.10.51:
* The snakefood plugin will now pull in the snakefood dependency as intended.

## Version 0.10.50:
* The snakefood plugin will now generate external and internal project reports (external dependencies and internal dependencies, respectively).

## Version 0.10.49:
* Added API functionality to automatically version the project based on the version control system.

## Version 0.10.48
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
