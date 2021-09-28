---
layout: post
title: "PyBuilder GitHub Action Released!"
categories: [news, 3rd-party]
tags: [Github Action, CI/CD, release]
author: arcivanov
excerpt_separator: <!--more-->
---
The first version of [GitHub Action for PyBuilder](https://github.com/marketplace/actions/pybuilder-action) has been 
released!

<!--more-->

This is a one-shot Python build GitHub action for PyBuilder. It drives PyBuilder's own multi-OS build system and 
serves as a shortcut for the following build chain steps:

1. Checkout code 
2. Setup Python Environment (optionally via Homebrew)
3. Create a VirtualEnv 
4. Install PyBuilder
5. Run the build

Each step can be skipped or omitted or parameterized.
