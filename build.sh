#!/bin/bash -eEux

bundle exec jekyll build

bundle exec htmlproofer --allow-hash-href \
                        --ignore-status-codes=429,999,302 \
                        --no-check-internal-hash \
                        --no-check-external-hash \
                        --no-enforce-https \
                        --checks Links,Scripts,Images,OpenGraph,Favicon \
                        --typhoeus='{"followlocation": true, "connecttimeout": 20, "timeout": 60}' \
                        --hydra='{"max_concurrency": 3}' \
                        _site

bundle exec jekyll build -c _config.yml,_config-prod.yml
