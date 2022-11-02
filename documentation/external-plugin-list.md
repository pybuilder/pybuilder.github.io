---
layout: documentation
title: External Plugin List
redirect_from: /documentation/external_plugin_list
---

# {{ page.title }}

## Plugins Available on PyPI

In general you can activate a plugin by using `use_plugin` from `pybuilder.core`:

{% highlight python %}
from pybuilder.core import use_plugin

use_plugin("pypi:<< plugin name goes here >>")
{% endhighlight %}
Please read the documentation of each plugin to get more information on plugin tasks and configuration properties.

* [pybuilder_header_plugin](https://github.com/cowst/pybuilder_header_plugin) - ensure all your source files have the expected file header
* [pybuilder_smart_copy_resources](https://github.com/margru/pybuilder-smart-copy-resources) - copy additional files into various destinations
* [pybuilder_pytest](https://github.com/AlexeySanko/pybuilder_pytest) - use pytest Python module for running unittests
* [pybuilder_pytest_coverage](https://github.com/AlexeySanko/pybuilder_pytest_coverage) - adds pytest-cov for coverage measure for pybuilder_pytest plugin
* [pybuilder_read_profile_properties](https://github.com/AlexeySanko/pybuilder_read_profile_properties) - provides possibility to read project properties from YAML file according profile
* [pybuilder_cram_console_scripts](https://github.com/AlexeySanko/pybuilder_cram_console_scripts) - extends PyBuilder Cram plugin with console scripts based on distutils plugin properties
* [pybuilder_pypi_server](https://github.com/AlexeySanko/pybuilder_pypi_server) - provides project property pypi_server for pypi repository name from .pipyrc file and uses this property for assignment distutils_upload_repository and install_dependencies_index_url properties
* [pybuilder_semver_git_tag](https://github.com/AlexeySanko/pybuilder_semver_git_tag) - provides dynamic project version based on SemVer git tag
* [pybuilder_aws_plugin](https://github.com/immobilienscout24/pybuilder_aws_plugin) - handle AWS functionality
* [pybuilder_pylint_extended](https://github.com/AlexeySanko/pybuilder_pylint_extended) - provides Pylint tool usage with extended properties (has behaviour as flake8 plugin)
* [pybuilder_pycharm_workspace](https://github.com/yeuk0/pybuilder-pycharm-workspace) - generates PyCharm metadata files to include running profiles, project interpreter config, etc. (recommended with pybuilder_archetype_base)
* [pybuilder_archetype_base](https://github.com/yeuk0/pybuilder-archetype-base) - builds an easy project structure with some examples ready to go
* [pybuilder_archetype_api](https://github.com/yeuk0/pybuilder-archetype-api) - adds new packages and files' examples from base structure built with pybuilder_archetype_base for a project based on web services
* [pybuilder_stubs_package](https://github.com/chylek/pybuilder-stubs-package) - creates type-hinting stubs (\*.pyi files) as a separate package. This stubs-only package is named with the -stubs suffix following PEP 561.


## Pybuilder external plugin demo

### Activation
{% highlight python %}
use_plugin("pypi:pybuilder_external_plugin_demo")
{% endhighlight %}
