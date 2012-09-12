---
layout: default
title: Documentation
---

# Documentation

This page documents the usage of *pybuilder*.

**WIP WARNING: This page is work in progress.**

## Introduction

*pybuilder* is a software build tool. *pybuilder* can be used for a lot of purposes. Most
commonly it targets the "building" and management of software with a strong focus on Python.


### Building Python Projects

Among the capabilities that you can use out of the box when applying *pybuilder* to your project, you get: 
* Automatic execution of unit and integration tests on every build
* Automatic analysis of the code coverage
* Automatic execution of analysis tools, such as
  + pylint
  + pychecker
  + pymetrics
  + pep8
  + flake8
* Automatic generation of distutils script ```setup.py```

### Why Another Build Tool

When working on large scale software projects based on Java and Groovy I delved into the build process using tools
such as Apache Ant, Apache Maven or Gradle. Although non of these tools is perfect they all provide a powerful and
extensible way for build and testing software.

When focusing on Python I looked for a similar tool and got frustrated by the large number of tools that all match
some aspect of the build and test process. Unfortunately, all tools work mostly independent from each other and
there was no central point of entry.

I suddenly found myself writing "build scripts" in Python over and over again using the tools I found out to be
usefull.

*pybuilder* was born on the attempt to create a reusable tool that should 
* Make simple things simple
* Make hard things as simple as possible
* Let me use whatever tool I want to integrate
* Integrate these tools into a common view
* Let me use Python (which is really great) to write my build files


## Concepts

*pybuilder* executes build logic that is organized in tasks and actions.

Tasks are the main building blocks of the build logic. A task is an enclosed piece of build logic to be executed as
a single unit. Each task can name a set of other tasks that this task depends on. *pybuilder* ensures, that a
task gets executed only after all of its dependencies have been executed.

Tasks are plain Python functions. A decorator is used to label a function as a task. Thus, you can structure your
code the way you like if you provide a single point of entry to a build step.

Actions are smaller pieces of build logic then tasks. Actions are bound to the execution of task. Each action names
that it needs to be executed *before* or *after* a named task. Python Builder will execute the action if
and only if the named task is executed, either directly or as a dependency.

Actions as well as tasks are plain Python functions that are decorated to become an action.

Both task and action functions can accept parameters. *pybuilder* supports a set of parameters and knows which
one to pass to a function based on the parameter's name.


## Installation

### Pip and Easy Install

If you have pip or easy_install available on your machine, you may simply install *pybuilder* using a command such as: 
```$ sudo pip pybuilder```

Of course you can install pybuilder into a [virtual environment](http://pypi.python.org/pypi/virtualenv).


### Manual Installation

Please download the most recent version of *pybuilder* from the
[downloads page](https://github.com/pybuilder/pybuilder/downloads).

The *pybuilder* distribution ships with a standard [distutils](http://docs.python.org/distutils/index.html) ```setup.py```
script which can be used to perform a local installation. Just type ```$ python setup.py install```

Note that you need to have administrative permissions to perform the install to Python's standard directories
(Unix/Linux users may prefix the command with ```sudo``` if they have the appropriate permissions.


## Writing Tasks

Writing a task is easy. You just create a function and decorate with the ```@task``` decorator:

<pre>
  <code>
    from pythonbuilder.core import task

    @task
    def say_hello ():
        print "Hello, pybuilder"
  </code>
</pre>


### Dependency Injecting

*pybuilder* supports dependency injection for tasks based on parameters. The following parameters can be used to
receive components:
<dl>
  <dt>logger</dt>
  <dd>A logger instance which can be used to issue messages to the user.</dd>
  <dt>project</dt>
  <dd>An instance of the project that is currently being built.</dd>
</dl>


Thus we can rewrite the task above to use the logger:

<pre>
  <code>
    from pythonbuilder.core import task
    @task

    def say_hello (logger):
       logger.info("Hello, pybuilder")
  </code>
</pre>


### Project Attributes
### Project Properties

#### Setting Properties from tasks
#### Setting Properties from the command line

Properties can be set or overridden using command line switches. 
```$ pyb -P spam="spam message"```

This command sets/ overrides the property with the name ```spam``` with the value ```spam message```.

Notice that command line switches only allow properties to be set/ overridden using string values.


## Plugins

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
    <td>Directory where unittest modules are located</td>
  </tr>

  <tr>
    <td>unittest_file_suffix</td>
    <td>string</td>
    <td>_tests.py</td>
    <td>Suffix used to filter files that should be executed as tests,</td>
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
  <code>
    @init
    def initialize (project):
        project.set_property("dir_dist_scripts", 'scripts')

    ...
  </code>
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
    <td>Commands to execute using the generated ```setup.py``` script during ```publish```</td>
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

