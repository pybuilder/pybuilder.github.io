---
layout: documentation
title: Developing PyBuilder
---

# Running a Full Build
PyBuilder is, [of course](http://en.wikipedia.org/wiki/Eating_your_own_dog_food), built with itself.

This is attained through self-bootstrapping with the `build.py` file, which lies in the toplevel sources.
This script behaves exactly as the PyBuilder program `pyb`.
You can use the `install_dependencies` task with `./build.py install_dependencies` to pull in all the required runtime and build dependencies.
Afterwards, running `./build.py` will do a full build including all tests, linting and packaging.

[The following screencast](https://asciinema.org/a/8811) shows how to get the sources and run a full build from scratch. Please note that you need [virtualenv](http://www.virtualenv.org/en/latest/) installed.
