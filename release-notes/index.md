---
layout: documentation
title: Release Notes
---

# Release Notes

{% assign items = site["release-notes"] | reverse %}
{% for item in items %}
## [{{item.list_title}} {% if items[0] == item %}(Current){%endif%}]({{item.url | rel_canonical_url}})
{% endfor %}
