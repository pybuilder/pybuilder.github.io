#!/bin/bash -eEux

bundle exec jekyll build

# openhub.net and coveralls.io answer htmlproofer with 403 from bot protection.
# Ignore those two hosts by URL rather than ignoring 403 globally, so a genuinely
# forbidden link anywhere else still fails the build.
bundle exec htmlproofer --allow-hash-href \
                        --ignore-status-codes=429,999,302 \
                        --ignore-urls='/^https://www\.openhub\.net//,/^https://coveralls\.io//' \
                        --no-check-internal-hash \
                        --no-check-external-hash \
                        --no-enforce-https \
                        --checks Links,Scripts,Images,OpenGraph,Favicon \
                        --typhoeus='{"followlocation": true, "connecttimeout": 20, "timeout": 60}' \
                        --hydra='{"max_concurrency": 3}' \
                        _site

bundle exec jekyll build -c _config.yml,_config-prod.yml
