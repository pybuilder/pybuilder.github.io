---
layout: documentation
title: Projects using PyBuilder
---

# Projects using PyBuilder

Of course *PyBuilder* is built using *PyBuilder*.
See [build.py](https://github.com/pybuilder/pybuilder/blob/master/build.py)

## [livestatus-service](https://github.com/ImmobilienScout24/livestatus_service)

livestatus-service exposes MK livestatus to the network over HTTP.
This project leverages several *PyBuilder* features to deliver apache configuration files, include html templates, and keep the configuration DRY.

See [build.py](https://github.com/ImmobilienScout24/livestatus_service/blob/master/build.py).

## [pyassert](https://github.com/pyclectic/pyassert)

Readable assertions framework for Python

See [build.py](https://github.com/pyclectic/pyassert/blob/master/build.py)

## [pyfix](https://github.com/pyclectic/pyfix)

A framework for writing automated tests focussing on fixtures (non xUnit based)

See [build.py](https://github.com/pyclectic/pyfix/blob/master/build.py)

## [yadtshell](https://github.com/yadt/yadtshell)

[YADT - an Augmented Deployment Tool - The Shell Part](http://www.yadt-project.org/)

This project uses a [custom task](/documentation/manual.html#WritingTasks) to generate manpages and several *PyBuilder* features to deliver them.
See [build.py](https://github.com/yadt/yadtshell/blob/master/build.py)


# Example Applications

## [Flask Example](https://github.com/pyclectic/flask-example)

This is a simple flask example application which demonstrates usage pyclectic frameworks: unit and integration tests using pyfix and pyassert.

See [build.py](https://github.com/pyclectic/flask-example/blob/master/build.py)
