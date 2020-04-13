#!/bin/bash -eEu

bundle exec jekyll build

bundle exec htmlproofer --allow-hash-href \
                        --http-status-ignore=429,999 \
                        --check-html \
                        --check-opengraph \
                        --check-favicon \
                        --assume-extension \
                        ./_site

bundle exec jekyll build -c _config.yml,_config-prod.yml
