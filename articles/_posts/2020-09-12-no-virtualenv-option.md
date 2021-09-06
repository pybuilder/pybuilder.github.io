---
layout: post
title: "No Virtual Environments Feature in 0.12.9"
categories: news
tags: [v0.12.x, release]
excerpt_separator: <!--more-->
author: arcivanov
---
Due to requests of Anaconda environment users PyBuilder version 0.12.9+ introduced a `--no-venvs`
option. This option turns off all Python virtual environment management implemented in 0.12.x
for those users who prefer (or must) manage their own virtual environments.

<!--more-->

This feature essentially reverts PyBuilder v0.12.x to v0.11.x behavior.

As in v0.11.x such behavior comes with very serious repercussions that include:
* Pollution of Python environment with PyBuilder plugin dependencies potentially leading to unexpected and 
unreproducible failures both in PyBuilder and in your project.
* Pollution of Python environment with project artifacts, resulting in problems debugging and running tests.
* Potentially inconsistent Coverage results arising from coverage tracked for files installed in the virtual
environment rather than the source tree.

If you decide to use `--no-venvs` option, please understand there are significant and potentially severe 
consequences to code quality.

Enjoy!