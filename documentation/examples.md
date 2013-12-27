---
layout: documentation
title: Projects using PyBuilder
---

# Projects using PyBuilder

Of course *PyBuilder* is built using *PyBuilder*.
See [build.py](https://github.com/pybuilder/pybuilder/blob/master/build.py)

## [committer](https://github.com/aelgru/committer)

Committer is a unified command line interface for git, mercurial and subversion.

See [build.py](https://github.com/aelgru/committer/blob/master/build.py)


## [yadtshell](https://github.com/yadt/yadtshell)

[YADT - an Augmented Deployment Tool - The Shell Part](http://www.yadt-project.org/)

This project uses a [custom task](/documentation/manual.html#WritingTasks) to generate manpages and several *PyBuilder* features to deliver them.
See [build.py](https://github.com/yadt/yadtshell/blob/master/build.py)


## [livestatus-service](https://github.com/ImmobilienScout24/livestatus_service)

livestatus-service exposes MK livestatus to the network over HTTP.
This project leverages several *PyBuilder* features to deliver apache configuration files, include html templates, and keep the configuration DRY.

See [build.py](https://github.com/ImmobilienScout24/livestatus_service/blob/master/build.py).
