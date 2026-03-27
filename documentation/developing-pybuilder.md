---
layout: documentation
title: Developing PyBuilder
redirect_from: /documentation/developing_pybuilder
---

# Running a Full Build
PyBuilder is, [of course](http://en.wikipedia.org/wiki/Eating_your_own_dog_food), built with itself.

This is attained through self-bootstrapping with the `build.py` file, which lies in the toplevel sources.
This script behaves exactly as the PyBuilder program `pyb`.
You can use the `install_dependencies` task with `./build.py install_dependencies` to pull in all the required runtime and build dependencies.
Afterwards, running `./build.py` will do a full build including all tests, linting and packaging.

PyBuilder requires Python 3.10 or later. We recommend using a
[virtual environment](https://docs.python.org/3/library/venv.html) for development:

```bash
git clone https://github.com/pybuilder/pybuilder
cd pybuilder
python3 -m venv venv
source venv/bin/activate
pip install pybuilder
./build.py
```
