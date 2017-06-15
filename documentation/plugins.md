---
layout: documentation
title: PyBuilder Usage Documentation
---

# Plugins

This page documents the plugins that ship with the PyBuilder distribution.

## QA plugins

### Running Python Unittests

*PyBuilder* ships with a plugin to execute unittests written using [Python's unittest module](http://docs.python.org/library/unittest.html)
during the build. Use the `python.unittest` plugin to enable unittest support.

The plugin executes all test cases found in modules ending with `_tests.py` in the directory
`src/unittest/python`.


#### Python unittest properties

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

    <tr>
    <td>teamcity_output</td>
    <td>bool</td>
    <td>False</td>
    <td>Output teamcity service messages with test names and errors</td>
  </tr>

  <tr>
    <td>dir_source_unittest_python</td>
    <td>string</td>
    <td>src/unittest/python</td>
    <td>Directory where unittest modules are located.</td>
  </tr>

  <tr>
    <td>unittest_module_glob</td>
    <td>string</td>
    <td>*_tests</td>
    <td>Pattern used to filter Python modules that should be imported by the unittest runner.</td>
  </tr>

  <tr>
    <td>unittest_test_method_prefix</td>
    <td>string</td>
    <td>None</td>
    <td>This allows you to define how the module unittest identifies tests.
        The plugin sets defaultTestLoader.testMethodPrefix to the given value.
        When set to None the plugin will not set the value at all.</td>
  </tr>

  <tr>
    <td>unittest_file_suffix</td>
    <td>string</td>
    <td>None</td>
    <td>Suffix used to filter files that should be executed as tests.<br>
        <b>Deprecated:</b> This exists for backwards compatibility with existing
        build.py files.  If it is set to a non-None value, it will override
        unittest_module_glob with an appropriate glob pattern by prefixing the
        value with an asterisk (*) and removing the ".py" extension.</td>
  </tr>
</table>

### Measuring unittest coverage

*PyBuilder* adds support to measure the coverage of your unittest using the ```coverage``` module.
Use the ```python.coverage``` module to activate coverage.


#### Coverage properties

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>coverage_threshold_warn</td>
    <td>integer</td>
    <td>70</td>
    <td>Warn if the overall coverage drops below this threshold.</td>
  </tr>

  <tr>
    <td>coverage_break_build</td>
    <td>bool</td>
    <td>True</td>
    <td>Break the build (i.e. fail it) if the coverage is below the given threshold.</td>
  </tr>

  <tr>
    <td>coverage_reload_modules</td>
    <td>bool</td>
    <td>True</td>
    <td>Reload modules during coverage to also count definition lines.</td>
  </tr>

  <tr>
    <td>coverage_fork</td>
    <td>bool</td>
    <td>False</td>
    <td>Run coverage in a different process.</td>
  </tr>

  <tr>
    <td>coverage_exceptions</td>
    <td>list of strings</td>
    <td>empty</td>
    <td>List of package names to exclude from coverage analyzation.</td>
  </tr>
</table>

### SonarQube integration

Using the plugin `python.sonarqube` will add the task `run_sonar_analysis` to your project. This task has a run-time dependency to the `sonar-runner` program and will submit your project to [sonarqube](http://www.sonarqube.org/) for analysis.

#### Sonarqube configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>sonarqube_project_key</td>
    <td>string</td>
    <td>`project.name`</td>
    <td>The SonarQube project key to use for analysis.</td>
  </tr>

  <tr>
    <td>sonarqube_project_name</td>
    <td>string</td>
    <td>`project.name`</td>
    <td>The SonarQube project name to use for analysis.</td>
  </tr>
</table>


### Linting python sources

#### Frosted plugin

Frosted is a fork of pyflakes (originally created by Phil Frost) that aims at more open contribution from the outside public, a smaller more maintainable code base, and a better Python checker for all.


##### Frosted configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>frosted_break_build</td>
    <td>boolean</td>
    <td>False</td>
    <td>Break the build if warnings are found</td>
  </tr>

  <tr>
    <td>frosted_include_test_sources</td>
    <td>boolean</td>
    <td>False</td>
    <td>Also run frosted on integrationtest and unittest sources</td>
  </tr>

  <tr>
    <td>frosted_include_scripts</td>
    <td>boolean</td>
    <td>False</td>
    <td>Also run the frosted linter on all files in $dir_source_main_scripts</td>
  </tr>

  <tr>
    <td>frosted_ignore</td>
    <td>List of strings</td>
    <td>[ ]</td>
    <td>List of warnings to exclude<br/>
        Example: <code>["E205", "W101"]</code>.<br/>
        See <a href="https://github.com/timothycrosley/frosted">here</a>, section <em>Frosted error codes</em>, for reference (or use frosted --verbose to check).</td>
  </tr>

</table>

#### Flake8 plugin

*PyBuilder* can lint your files and verify (or enforce) compliance with
PEP8 and PyFlakes through the flake8 module.
Use the ```python.flake8``` module to activate linting.


##### Flake8 configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>flake8_break_build</td>
    <td>boolean</td>
    <td>False</td>
    <td>Break the build if warnings are found</td>
  </tr>

  <tr>
    <td>flake8_ignore</td>
    <td>string</td>
    <td>None</td>
    <td>Comma separated list of error messages to ignore<br/>
        Example: <code>"F403,W404,W801"</code></td>
  </tr>

  <tr>
    <td>flake8_include_scripts</td>
    <td>boolean</td>
    <td>False</td>
    <td>Also run the flake8 linter on all files in $dir_source_main_scripts</td>
  </tr>

  <tr>
    <td>flake8_include_test_sources</td>
    <td>boolean</td>
    <td>False</td>
    <td>Also run flake8 on integrationtest and unittest sources</td>
  </tr>

  <tr>
    <td>flake8_max_line_length</td>
    <td>integer</td>
    <td>120</td>
    <td>Maximum allowed line length</td>
  </tr>

  <tr>
    <td>flake8_exclude_patterns</td>
    <td>string</td>
    <td>None, but flake8 comes with the default:<br/>
        .svn,CVS,.bzr,.hg,.git,__pycache__</td>
    <td>Comma separated list of file patterns to exclude<br/>
        Example: <code>".git,__pycache__"</code></td>
  </tr>

  <tr>
    <td>flake8_verbose_output</td>
    <td>boolean</td>
    <td>False</td>
    <td>Display flake8 warnings and errors in command line output.</td>
  </tr>


</table>

#### Pychecker plugin

Using the plugin `python.pychecker` will let pychecker run on python source modules.

##### Pychecker configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>pychecker_break_build</td>
    <td>boolean</td>
    <td>True</td>
    <td>Break the build if warnings are found.</td>
  </tr>

  <tr>
    <td>pychecker_break_build_threshold</td>
    <td>integer</td>
    <td>0</td>
    <td>Threshold to break the build. A threshold of `n` means: "break the build if more than `x` warnings are found".</td>
  </tr>
</table>

#### Pylint plugin

Using the plugin `python.pylint` will let pylint run on python source modules.

##### Pylint configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>pylint_options</td>
    <td>list of strings</td>
    <td>`["--max-line-length=100", "--no-docstring-rgx=.*"]`</td>
    <td>Options to be passed to pylint</td>
  </tr>
</table>

#### Pep8 plugin

Using the plugin `python.pep8` will let pep8 run on python sources.
There is no configuration possible currently, consider using the flake8 plugin instead.

#### Pymetrics plugin

Using the plugin `python.pymetrics` will let pymetrics run on all python source files.
There is no configuration possible currently, consider using the flake8 plugin instead.


### Running Python Integration Tests

*PyBuilder* ships with a plugin to run integration tests written in Python. The plugin is named
```python.integrationtest```. It executes all python modules named ```*_tests.py``` in the
```src/integrationtest/python``` directory.

However, the default ```run_integration_tests``` job is just a stub per default
, which won't run your integration tests. In order to use integration tests,
you will have to enable the module by specifying
```use_plugin('python.integrationtest')```. If you don't specify this,
your integration tests will not be run.

Every module is executed as a Python module. The Python path contains the integration test directory as well as
the production source directory.


#### Integration test properties
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

    <tr>
    <td>teamcity_output</td>
    <td>bool</td>
    <td>False</td>
    <td>Output teamcity service messages with test names and errors</td>
  </tr>

  <tr>
    <td>dir_source_integrationtest_python</td>
    <td>string</td>
    <td>src/integrationtest/python</td>
    <td>Directory where integration test modules are located</td>
  </tr>

  <tr>
    <td>integrationtest_file_glob</td>
    <td>string</td>
    <td>*_tests.py</td>
    <td>Pattern used to filter files that should be executed as tests.</td>
  </tr>

  <tr>
    <td>integrationtest_additional_environment</td>
    <td>map</td>
    <td>empty</td>
    <td>Map containing additional environment variables used when executing the integration tests.</td>
  </tr>

  <tr>
    <td>integrationtest_additional_commandline</td>
    <td>string</td>
    <td>Not set</td>
    <td>Additional command line arguments/commands to pass to the integration test call</td>
  </tr>

  <tr>
    <td>integrationtest_inherit_environment</td>
    <td>boolean</td>
    <td>False</td>
    <td>Inherit the current environment to integration tests.</td>
  </tr>

  <tr>
    <td>integrationtest_parallel</td>
    <td>boolean</td>
    <td>False</td>
    <td>Run integration tests in parallel.</td>
  </tr>

  <tr>
    <td>integrationtest_cpu_scaling_factor</td>
    <td>integer</td>
    <td>4</td>
    <td>The amount of workers to use per cpu for integration test parallelization</td>
  </tr>

  <tr>
    <td>integrationtest_file_suffix</td>
    <td>string</td>
    <td>None</td>
    <td>Suffix used to filter files that should be executed as tests.<br>
        <b>Deprecated:</b> This exists for backwards compatibility with existing
        build.py files.  If it is set to a non-None value, it will override
        integrationtest_file_glob with an appropriate glob pattern by prefixing the
        value with an asterisk (*).</td>
  </tr>
</table>


<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4>Travis CI warning</h4>
If you use PyBuilder with <a href="http://travis-ci.org">Travis CI</a> and run integration
tests in parallel, you will need a workaround due to a travis issue with POSIX semaphores.
Please refer to <a href="https://github.com/travis-ci/travis-cookbooks/issues/155">the related travis issue</a>.
</div>
<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4>Python 3.2 warning</h4>
We have experienced strange problems (EOFErrors) on python 3.2. This seems to be due to a bug with pickling randomly raising EOFError. We recomment updating to python 3.3 or 3.4, where it works fine.
</div>

### Running Cram tests
[Cram is a functional testing framework for command line applications based on Mercurial's unified test format.](https://pypi.python.org/pypi/cram)

The plugin `python.cram` can be used to run tests written for cram. Cram tests run during `run_integration_tests` but there is also a separate task available (`run_cram_tests`).

<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4>Python 3.2.3 warning</h4>
Cram crashes on python 3.2.3 : <a href="https://bitbucket.org/brodie/cram/issue/28/crash-on-323">see the relevant bitbucket issue</a>. An easy workaround is to not use the plugin on python 3.2 :
<br/>
<pre>
<code>
if not sys.version_info[0:2] == (3,2):
    use_plugin("python.cram")
</code>
</pre>
</div>

#### Cram properties

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>dir_source_cmdlinetest</td>
    <td>string</td>
    <td>src/cmdlinetest</td>
    <td>Directory where cram test files are located.</td>
  </tr>
  <tr>
    <td>cram_test_file_glob</td>
    <td>string</td>
    <td>*.t</td>
    <td>Glob matching the cram test files</td>
  </tr>
  <tr>
    <td>cram_fail_if_no_tests</td>
    <td>boolean</td>
    <td>True</td>
    <td>Fail if there are no cram tests</td>
  </tr>
  <tr>
    <td>cram_run_test_from_target</td>
    <td>boolean</td>
    <td>True</td>
    <td>Run tests from the <code>target</code> or <code>src</code> directory.</td>
  </tr>
</table>

## Python deployment

### Python core
The python core plugin deals with sources and distributions. It copies the sources
into the distribution directory.

#### Python core properties
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>dir_source_main_python</td>
    <td>string</td>
    <td>src/main/python</td>
    <td>Directory where python modules are located.</td>
  </tr>

  <tr>
    <td>dir_source_main_scripts</td>
    <td>string</td>
    <td>src/main/scripts</td>
    <td>Directory where runnable scripts are located.</td>
  </tr>

  <tr>
    <td>dir_dist</td>
    <td>string</td>
    <td>$dir_target/dist/$name-$version</td>
    <td>Directory where distributions are built.</td>
  </tr>

  <tr>
    <td>dir_dist_scripts</td>
    <td>string</td>
    <td>scripts (starting with 0.10.40, before that scripts are simply copied to the dir_dist by default)</em></td>
    <td>Directory where scripts are copied to <em>(relative to distribution directory)</em>.</td>
  </tr>
</table>

### Installing dependencies

*PyBuilder* manages build and runtime dependencies for you.
Use the ```python.install_dependencies``` module to activate dependency management.
This will make the following tasks available:

<table class="table table-striped">
  <tr>
    <th>Task</th>
    <th>Effect</th>
  </tr>

  <tr>
    <td>install_build_dependencies</td>
    <td>Installs build dependencies only</td>
  </tr>

  <tr>
    <td>install_runtime_dependencies</td>
    <td>Installs runtime dependencies only</td>
  </tr>

  <tr>
    <td>install_dependencies</td>
    <td>Installs all dependencies (build and runtime)</td>
  </tr>
</table>

#### Declaring dependencies
The project object exposes the following methods for declaring dependencies

##### Requirements file :
<pre><code>project.depends_on_requirements("requirements.txt")</code></pre>
<pre><code>project.build_depends_on_requirements("requirements-dev.txt")</code></pre>

##### Runtime dependencies :
<pre><code>project.depends_on("awesome-library")</code></pre>

##### Build dependencies :
<pre><code>project.build_depends_on("awesome-library")</code></pre>

Note that the `*_depends_on` methods accept the following arguments :

<table class="table table-striped">
  <tr>
    <th>Argument</th>
    <th>Effect</th>
  </tr>

  <tr>
    <td>name</td>
    <td>Required positional argument. It's the name of the dependency on PyPI.</td>
  </tr>

  <tr>
    <td>version</td>
    <td>Optional keyword argument (<code>None</code> default). Set it to a version string (example <code>"==1.5.4"</code> or <code>">=0.10"</code> if necessary.</td>
  </tr>

  <tr>
    <td>url</td>
    <td>Optional keyword argument (<code>None</code> default). Set it to an editable URL where the dependency should be downloaded from.</td>
  </tr>
</table>

The logic of version goes as follows:

* If you don't specify any version, you don't care about the version and any version will do, so PyB will get whatever version if one doesn't exist and then don't bother ever updating.
* If you specify an exact version once it is obtained there is no point in updating it.
* If you specify a fuzzy version, you want the latest and greatest that satisfies the expression specified. This aids rapid incompatibility detection, as PyBuilder tracks the latest version that always satisfies the version specifier.

#### Install dependencies configuration
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>dir_install_logs</td>
    <td>string</td>
    <td>$dir_logs/install_dependencies</td>
    <td>Where installation logs should be saved.</td>
  </tr>

  <tr>
    <td>install_dependencies_index_url</td>
    <td>string</td>
    <td>None</td>
    <td>Index URL to use with pip (None means use the pip default).</td>
  </tr>

  <tr>
    <td>install_dependencies_extra_index_url</td>
    <td>string</td>
    <td>None</td>
    <td>Extra index url to use with pip.</td>
  </tr>

  <tr>
    <td>install_dependencies_use_mirrors</td>
    <td>boolean</td>
    <td>True</td>
    <td>Enables the use of PyPI mirros for pip operations.</td>
  </tr>

  <tr>
    <td>install_dependencies_upgrade</td>
    <td>boolean</td>
    <td>False</td>
    <td>If dependencies are already available, try to upgrade them instead.</td>
  </tr>

  <tr>
    <td>install_dependencies_insecure_installation</td>
    <td>List of strings</td>
    <td><code>[ ]</code></td>
    <td>Tell newer versions of pip that it's OK to install those dependencies insecurely (externally hosted, potentially unverified)</td>
  </tr>
</table>

### Creating a source distribution

*PyBuilder* can build a source distribution of your code with the plugin `source_distribution`. Activating this plugin will expose a task, `build_source_distribution`.

#### Source distribution configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>dir_source_dist</td>
    <td>string</td>
    <td>$dir_target/dist/$(project.name)-$(project.version)-src</td>
    <td>Where the source distribution should be created.</td>
  </tr>
  <tr>
    <td>source_dist_ignore_patterns</td>
    <td>list of strings</td>
    <td>["*.pyc", ".hg*", ".svn", ".CVS"]</td>
    <td>Patterns to ignore when copying sources for the source distribution.</td>
  </tr>
</table>

### Building a Python package

*PyBuilder* ships a plugin that generates and executes setup.py files using with distutils or setuptools (distribute will
be supported in future releases). In order to generate a ```setup.py``` file use the ```python.distutils```
plugin.

The distutils plugin will consider many of the project's attributes, i.e.
* name
* version
* summary
* description
* author
* license
* url


#### Moving scripts to a nested directory

By default, executable scripts are located at the egg's root. The ```setup.py``` contains the bare script names.
Sometimes though you may want to move the scripts inside a directory to avoid naming collisions (i.e. with
packages).

The ```python.core``` and ```python.distutils``` plugins support the property ```dir_dist_scripts``` that
can name a directory to contain scripts inside the egg. This property is empty by default. Set it to the local name
of the directory you want the scripts to be moved to:

<pre><code>@init
def initialize (project):
    project.set_property("dir_dist_scripts", 'scripts')

...
</code></pre>


#### Distutils properties
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>distutils_commands</td>
    <td>list of strings</td>
    <td>sdist, bdist_dump</td>
    <td>Commands to execute using the generated <code>setup.py</code> script during <code>publish</code></td>
  </tr>

  <tr>
    <td>distutils_classifiers</td>
    <td>list of strings</td>
    <td>Development Status :: 3 - Alpha<br>
        Programming Language :: Python</td>
    <td>Classifiers describing the project; see <a href="http://pypi.python.org/pypi?%3Aaction=list_classifiers">http://pypi.python.org/pypi?%3Aaction=list_classifiers</a></td>
  </tr>

  <tr>
    <td>distutils_upload_repository</td>
    <td>string</td>
    <td>None</td>
    <td>The PyPI repository to upload the package to</td>
  </tr>
  
  <tr>
    <td>distutils_upload_sign</td>
    <td>boolean</td>
    <td>False</td>
    <td>Sign each uploaded file using GPG (GNU Privacy Guard)</td>
  </tr>

  <tr>
    <td>distutils_upload_sign_identity</td>
    <td>string</td>
    <td>None</td>
    <td>The identity to sign each file with, when distutils_upload_sign is True</td>
  </tr>

  <tr>
    <td>distutils_use_setuptools</td>
    <td>boolean</td>
    <td>True</td>
    <td>Use setuptools instead of distutils</td>
  </tr>

  <tr>
    <td>distutils_issue8876_workaround_enabled</td>
    <td>boolean</td>
    <td>False</td>
    <td>Deny distutils the use of hardlinks for creating binary distributions</td>
  </tr>
</table>

<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4>VirtualBox pitfall with binary dists</h4>
If you build your project on a shared filesystem (e.G. with vagrant/Virtualbox virtualization) then distutils is unable to build a binary distribution <a href="http://bugs.python.org/issue8876">due to a python stdlib bug</a>.
Setting the property <code>distutils_issue8876_workaround_enabled</code> to True (off by default) will work around this for you.
</div>

### Copying resources into a distribution

In some cases you want to include non-source files in a distribution. An example is adding a `setup.cfg` to your project. It is not a source file, but it needs to be in the distribution to work (beneath the `setup.py` file).
The `copy_resources` plugin will do this for you at build-time.

#### Copy resources configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>copy_resources_target</td>
    <td>string</td>
    <td>$dir_target</td>
    <td>Where resources should be copied to.</td>
  </tr>

  <tr>
    <td>copy_resources_glob</td>
    <td>list of strings</td>
    <td>[]</td>
    <td>A list of globs matching files that should be copied to <code>$copy_resources_target</code>.</td>
  </tr>
</table>

### Filtering files

With the `filter_resources` plugin, it is possible to replace placeholder values of type `${version}` with actual values at build-time.
The actual values are attributes of the `project` object, so `${version}` will be replaced with the value of `project.version`.
In order to make resource filtering explicit, all files that go through filtering need to be specified with a glob.

#### Filter resources configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>filter_resources_target</td>
    <td>string</td>
    <td>$dir_target</td>
    <td>Toplevel directory containing the resources to be filtered.</td>
  </tr>

  <tr>
    <td>filter_resources_glob</td>
    <td>list of strings</td>
    <td>[]</td>
    <td>A list of globs matching files that should be filtered.</td>
  </tr>
</table>

#### Filter resources example

A common use case is keeping a `__version__` attribute in your main module.
But you don't want to specify the version both in `build.py` and in `__init__.py` because `build.py` should be the single point of truth.

So just use `__version__ = '${version}'` in `__init__.py`.

We can tell the plugin to filter this file by adding `['**/YOUR-PACKAGE-NAME/__init__.py']` to the `filter_resources_glob`.
The correct version will be patched in at run-time since the version is defined in `project.version`.
For filtering other attributes like `${myattribute}`, just add a `project.myattribute = "foobar"` in `build.py`'s initializer.

### Creating documentation with sphinx

The plugin `python.sphinx` will expose the task `sphinx_generate_documentation` which will generate the project documentation.

#### Sphinx plugin configuration

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>sphinx_builder</td>
    <td>string</td>
    <td>html</td>
    <td>The sphinx builder to use</td>
  </tr>

  <tr>
    <td>sphinx_config_path</td>
    <td>string</td>
    <td>""</td>
    <td>The path to the sphinx configuration</td>
  </tr>

  <tr>
    <td>sphinx_source_dir</td>
    <td>string</td>
    <td>""</td>
    <td>The path to the sphinx sources</td>
  </tr>

  <tr>
    <td>sphinx_output_dir</td>
    <td>string</td>
    <td>"_build/"</td>
    <td>The path to the sphinx output directory where the documentation will be generated</td>
  </tr>
</table>

## Generic build plugins

### Executing shell commands
*PyBuilder* ships with a plugin that allows you to incorporate arbitrary shell
commands in the build process.

This plugin can be activated using `use_plugin("exec")` and is configured through
the project properties.

#### Adding a shell command to the build process
Adding commands is done by setting properties and is discrete towards the
project lifecycles, thus you may have only one shell command for the analyze
lifecycle for example.

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
  </tr>

  <tr>
    <td>run_unit_tests_command</td>
    <td>string</td>
    <td>Run a shell command during run_unit_tests</td>
  </tr>
  <tr>
    <td>run_integration_tests_command</td>
    <td>string</td>
    <td>Run a shell command during run_integration_tests</td>
  </tr>
  <tr>
    <td>analyze_command</td>
    <td>string</td>
    <td>Run a shell command during analyze</td>
  </tr>
  <tr>
    <td>package_command</td>
    <td>string</td>
    <td>Run a shell command during package</td>
  </tr>
  <tr>
    <td>publish_command</td>
    <td>string</td>
    <td>Run a shell command during publish</td>
  </tr>
</table>

The output of the plugin can also be customized by using the properties
`$PHASE_propagate_stdout` and `$PHASE_propagate_stderr`.


See the properties for the phase `run_unit_tests` for example:

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>run_unit_tests_propagate_stdout</td>
    <td>string</td>
    <td>False</td>
    <td>Propagate the stdout of the command to the PyBuilder output</td>
  </tr>
  <tr>
    <td>run_unit_tests_propagate_stderr</td>
    <td>string</td>
    <td>False</td>
    <td>Propagate the stdout of the command to the PyBuilder output</td>
  </tr>
</table>

## IDE integration

### Project files for Eclipse PyDev

If the plugin `python.pydev` is used, PyBuilder provides the task `pydev_generate`.
This task can be used to generate PyDev project files in the project root directory. The project can then be imported easily.

### Project files for Jetbrains PyCharm
If the plugin `python.pycharm` is used, PyBuilder provides the task `pycharm_generate`.
This task can be used to generate a PyCharm project files in the project root directory. The project can then be imported easily through the `Open...` command.

## Developer tools

### Visual feedback for tests
The `python.pytddmon` plugin provides the task `pytddmon` which will start a graphical application that gives real-time feedback about passing or failing unit tests.
Please [see the pytddmon page](http://pytddmon.org/) for more information about pytddmon.

## Additional project structure

### Splitting up your `build.py` with bldsup

Maybe you want to have project specific plugins and support code while keeping your build.py file small, while avoiding to clutter your project's root directory.
This can be done by activating bldsup support :

```
from pybuilder.core import use_bldsup
use_bldsup(build_support_dir="bldsup")
```

 If it's not called in a project's build.py, then no "bldsup" directory is searched. If it is called, then it confirms that the build_support_dir directory exists and that includes a `__init__.py` file so imports will work. It just needs to be called before you try to `import`/`use_plugin()` any modules from the `build_support_dir`.
