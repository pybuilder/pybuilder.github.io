---
layout: documentation
title: Pybuilder Usage Documentation
---

# Pybuilder Usage Documentation

**WIP WARNING: This page is work in progress.**


## Introduction

*pybuilder* is a software build tool. *pybuilder* can be used for a lot of purposes. Most
commonly it targets the "building" and management of software with a strong focus on Python.


### Building Python Projects

Among the capabilities which can be used out of the box when applying *pybuilder* to your project, you get: 
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


## Writing Tasks

Writing a task is easy. You just create a function and decorate with the ```@task``` decorator:

<pre>
from pythonbuilder.core import task

@task
def say_hello ():
    print "Hello, pybuilder"
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
from pythonbuilder.core import task

@task
def say_hello (logger):
   logger.info("Hello, pybuilder")
</pre>


### Project Attributes
### Project Properties

#### Setting Properties from tasks
#### Setting Properties from the command line

Properties can be set or overridden using command line switches. 

<pre>$ pyb -P spam="spam message"</pre>

This command sets/ overrides the property with the name ```spam``` with the value ```spam message```.

Notice that command line switches only allow properties to be set/ overridden using string values.
