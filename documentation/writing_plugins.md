---
layout: documentation
title: PyBuilder Usage Documentation
---

# Writing a plugin
## Task basics
An essential part of a plugin are the tasks that come with it. The tasks are the blocks of build logic that a plugin can use to act during the build process. We shall start with simple task declarations and then move on to the additions necessary to a plugin.

### A simple task
Begin by creating a new folder with a `build.py` descriptor in it.
Defining tasks is done with the `task` decorator.

Our simple task might look like so:

```
from __future__ import print_function
from pybuilder.core import task

@task
def hello():
    print("hello")
```

We can now list the available tasks using the `-t` option:

```
$ pyb -t
Tasks found for project "task-demo":
    hello - < no description available >
```

As you can see *PyBuilder* has picked up our task using the function name.
Note that task names should be unique! We can control the tasks' name by adding it as an argument to the decorator. Let us rename the task into "foo" without changing the function name.

```
from __future__ import print_function
from pybuilder.core import task

@task("foo")
def hello():
    print("hello")
```
```
$ pyb -t
Tasks found for project "test":
    foo - < no description available >
```

### Descriptions
As you can see above, our task has no description currently. We can change that by adding one through the description decorator :

```
from __future__ import print_function
from pybuilder.core import task, description

@task("foo")
@description("Greets people")
def hello():
    print("hello")
```
Listing tasks will now yield a description of our task :
```
$ pyb -t
Tasks found for project "test":
    foo - Greets people
```

### Dependencies
Dependencies between tasks is easy. You can use the `depends` decorator to express that a task requires another one to run.
In the following example we create a task *foo*, that depends on another task, *bar*, to run.

```
from pybuilder.core import task, depends

@task
@depends("bar")
def foo():
    pass

@task
def bar():
    pass
```

Now everytime the task *foo* is run, *PyBuilder* will ensure that *bar* will have run first.
Dependencies on more than one task are expressed by increasing the arity of the depends decorator like so :

```
from pybuilder.core import task, depends

@task
@depends("bar", "baz")
def foo():
    pass

@task
def bar():
    pass

@task
def baz():
    pass
```

### Assuming control
If a task wishes to show output to the user, it can request the use of the *PyBuilder* logger by accepting a `logger` argument :

```
@task
def mytask(logger):
    logger.info("Hello user, how are you today?!")
```

Most decisions a task can take (e.G. configuration) require the knowledge of the project. A task can be made aware of the project by accepting a `project` argument. Since those are named arguments, nothing is stopping us from accepting both a logger and a project (the order does not matter) :

```
@task
def mytask(project, logger):
    logger.info("I am building {0} in version {1}!".format(project.name, project.version))
```

## Anatomy of a plugin
A plugin can be broken down in essentially two parts :
 * Initialization of the plugin
 * Tasks the plugin provides

### Initialization
The initialization of a plugin involves setting default configuration and ensuring that the plugin can run. 
It is done from within an [*initializer*](/documentation/manual.html#Initializers)

#### Setting defaults
The initializer can use the project object to set [property](/documentation/manual.html#ProjectProperties) values.
This is suitable for defaults because the initializer of the plugin will run before any user-provided initializers in `build.py`. Thus you can set a property (the *default*) which can then be overridden by the user.

Setting properties is done through the `set_property` method of project :

```
from pybuilder.core import init

@init
def initialize_my_plugin(project):
    project.set_property("property_for_my_plugin", 42)
```

We can then use this property in our tasks through the project object :
```
from pybuilder.core import task

@task
def mytask(project, logger):
    my_property = project.get_property("property_for_my_plugin")
    logger.info("The property for my plugin is {0}".format(my_property))
```
Properties can be of any type (usually strings, integers, booleans or lists).
If a property is mandatory and there is no default, then `project.get_mandatory_property` is more suitable since it also raises an error in case the property is unset.

#### Requiring external libraries
If the plugin requires external libraries installable through pip, the project object can be used to add this as a dependency :

```
from pybuilder.core import init

@init
def init_my_plugin(project):
    project.build_depends_on("py.test")
```

#### Ensuring that programs are installed
If the plugin relies on an external program like *pylint* then you should ensure that the program is available through the `assert_can_execute` function. The aim is to provide quick feedback to users why the plugin is not working.

```
from pybuilder.utils import assert_can_execute
from pybuilder.core import task

@task
def my_plugin_task():
    assert_can_execute(["committer", "--version"], prerequisite="committer by @aelgru", caller="my_plugin")
```

### Tasks
The tasks section of a plugin is the declaration of one or possibly more tasks. When a plugin is activated, its tasks are made available.
There are three ways to get a task to run :

 * direct invocation
 * indirect invocation through a dependency
 * indirect invocation through naming

#### Direct invocation
This is the most common approach. The user will use `pyb my_task` which will run the task.

#### Indirect invocation through a dependency
When there is a dependency chain between tasks, for example *foo* requires *bar* to run first.
If the user executes `pyb foo` then this will run *bar* and *foo* in that order.

#### Indirect invocation through naming
As we saw before, tasks are identified by their name. When there are more than one task with the same name, then all those tasks will run.

For example the [*core plugin*](https://github.com/pybuilder/pybuilder/blob/master/src/main/python/pybuilder/plugins/core_plugin.py) defines many generic tasks like `verify` and `package` that are actually empty.
Plugins that want to run during verification can then simply use `verify` as a task name.

## Examples
See the plugins that ship with *PyBuilder*. A very nice example is the [flake8 plugin](https://github.com/pybuilder/pybuilder/blob/master/src/main/python/pybuilder/plugins/python/flake8_plugin.py).
