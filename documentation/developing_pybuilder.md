---
layout: documentation
title: PyBuilder Usage Documentation
---

# Running a full build
PyBuilder is, [of course](http://en.wikipedia.org/wiki/Eating_your_own_dog_food), built with itself.

This is attained through the [bootstrap script](https://github.com/pybuilder/pybuilder/blob/master/bootstrap), which lies in the toplevel sources.
This script behaves exactly as the PyBuilder program `pyb`.
You can use the `install_dependencies` task with `./bootstrap install_dependencies` to pull in all the required runtime and build dependencies.
Afterwards, running `./bootstrap` will do a full build including all tests, linting and packaging.

[The following screencast](https://asciinema.org/a/7528) shows how to get the sources and run a full build from scratch. Please note that you need [virtualenv](http://www.virtualenv.org/en/latest/) installed.
