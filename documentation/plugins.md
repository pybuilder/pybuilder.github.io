---
layout: documentation
title: Pybuilder Usage Documentation
---

# Plugins

This page documents the plugins that ship with the pybuilder distribution.

## Python

### Python core
The python core plugin deals with sources and distributions. It copies the sources
into the distribution directory.

#### Properties
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
    <td>None <em>(results in $dir_dist)</em></td>
    <td>Directory where scripts are copied to <em>(relative to distribution directory)</em>.</td>
  </tr>
</table>

### Running Python Unittests

*pybuilder* ships with a plugin to execute unittests written using [Python's unittest module](http://docs.python.org/library/unittest.html)
during the build. Use the ```python.unittest``` plugin to enable unittest support.

The plugin executes all test cases found in modules ending with ```_tests.py``` in the directory
```src/unittest/python```.


#### Properties
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>dir_source_unittest_python</td>
    <td>string</td>
    <td>src/unittest/python</td>
    <td>Directory where unittest modules are located.</td>
  </tr>

  <tr>
    <td>unittest_file_suffix</td>
    <td>string</td>
    <td>_tests.py</td>
    <td>Suffix used to filter files that should be executed as tests.</td>
  </tr>
</table>


### Measuring unittest coverage

*pybuilder* adds support to measure the coverage of your unittest using the ```coverage``` module.
Use the ```python.coverage``` module to activate coverage.


#### Properties
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


### Running Python Integration Tests

*pybuilder* ships with a plugin to run integration tests written in Python. The plugin is named
```python.integrationtest```. It executes all python modules named ```*_tests.py``` in the
```src/integrationtest/python``` directory.

Every module is executed as a Python module. The Python path contains the integration test directory as well as
the production source directory.


#### Properties
<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default Value</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>dir_source_integrationtest_python</td>
    <td>string</td>
    <td>src/integrationtest/python</td>
    <td>Directory where integration test modules are located</td>
  </tr>

  <tr>
    <td>integrationtest_file_suffix</td>
    <td>string</td>
    <td>_tests.py</td>
    <td>Suffix used to filter files that should be executed as tests,</td>
  </tr>

  <tr>
    <td>integrationtest_additional_environment</td>
    <td>map</td>
    <td>empty</td>
    <td>Map containing additional environment variables used when executing the integration tests.</td>
  </tr>

  <tr>
    <td>integrationtest_inherit_environment</td>
    <td>boolean</td>
    <td>False</td>
    <td>Inherit the current environment to integration tests.</td>
  </tr>
</table>


### Building a Python Egg

*pybuilder* ships a plugin that generates and executes setup.py files using with distutils or setuptools (distribute will
be supported in future releases). In order to generate a ```setup.py``` file use the ```python.distutils```
plugin.

The distutils plugin will consider a lot of the project's attributes, i.e.
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

<pre>
@init
def initialize (project):
    project.set_property("dir_dist_scripts", 'scripts')

...
</pre>


#### Properties
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
    <td>distutils_use_setuptools</td>
    <td>boolean</td>
    <td>True</td>
    <td>Use setuptools instead of distutils</td>
  </tr>
</table>

