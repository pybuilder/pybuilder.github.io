# PyBuilder Documentation Site — Project Instructions

## Overview

This is the official documentation website for [PyBuilder](https://pybuilder.io),
hosted on GitHub Pages. It is a Jekyll static site. The source lives on the `source`
branch; the `master` branch contains only the built output deployed by CI.

Repository: `pybuilder/pybuilder.github.io` (origin, not a fork).

## Branch Model

- **`source`** — all development happens here. This is the default working branch.
- **`master`** — auto-deployed built site. Never edit or push to `master` directly.
- **`plugin_doc_gen`** — WIP branch for plugin documentation rework.
- **`bootstrap_4`** — stale Bootstrap 4 migration branch.

PRs target `source`. The CI deploys to `master` on push to `source`.

## Site Structure

```
_config.yml              — primary Jekyll configuration
_config-prod.yml         — production URL overlay (https://pybuilder.io)
Gemfile                  — Ruby dependencies (Jekyll 4.x, plugins, html-proofer)
build.sh                 — CI build script (build, validate, rebuild with prod config)
CNAME                    — custom domain (pybuilder.io)

_layouts/
  default.html           — base layout (header, container, footer)
  documentation.html     — two-column layout with auto-generated ToC sidebar
  post.html              — blog post layout with author metadata

_includes/layout/
  metaAndStyles.html     — Google Analytics, meta tags, CSS imports
  header.html            — navbar with navigation dropdowns
  footer.html            — links, scripts, JS imports

_plugins/
  pybuilder.rb           — custom Liquid filters (abs/rel canonical URL helpers)

_data/
  authors.yml            — author profiles referenced by blog posts

documentation/           — all documentation pages (layout: documentation)
  index.md               — documentation hub
  installation.md        — installation guide
  tutorial.md            — comprehensive tutorial (~590 lines, largest doc)
  manual.md              — usage manual
  plugins.md             — built-in plugin reference (~1100 lines)
  writing-plugins.md     — plugin development guide
  publishing-plugins.md  — how to publish plugins
  external-plugin-list.md — third-party plugins
  examples.md            — example projects
  ide.md                 — IDE integration
  developing-pybuilder.md — contributing to PyBuilder core

articles/                — Jekyll collections directory
  _posts/                — blog posts (layout: post, author: <key from authors.yml>)
  _release-notes/        — release notes collection (v0.10.x through v0.13.x)
  _migration-guides/     — migration guides collection

css/                     — custom stylesheets (styles.css, highlightjs.css, tabcontent.css)
js/                      — custom JS (highlight.pack.js, tabcontent.js, toc.js)
img/                     — logos, mascot, screenshots
```

## Building Locally

```bash
# Install Ruby dependencies
bundle install

# Start development server with live reload
bundle exec jekyll serve --watch
# Browse to http://localhost:4000

# Full CI-equivalent build (build + htmlproofer + prod rebuild)
./build.sh
```

## CI / Deployment

GitHub Actions workflow at `.github/workflows/pybuilder.github.io.yml`:
1. Triggers on PRs to `source` and pushes to `source`
2. Sets up Ruby 3.1, installs bundle dependencies
3. Runs `build.sh`:
   - `jekyll build` (dev config)
   - `htmlproofer` validates links, scripts, images, OpenGraph, favicon
   - `jekyll build -c _config.yml,_config-prod.yml` (prod config with real URL)
4. On push (not PR): deploys `_site/` to `master` branch

## Content Conventions

### Documentation Pages

- Layout: `documentation` (provides auto-ToC sidebar)
- Front matter: `layout: documentation`, `title: <Page Title>`
- Use `{% link documentation/filename.md %}` for cross-references
- Markdown with kramdown extensions (fenced code blocks, etc.)

### Blog Posts

- Location: `articles/_posts/YYYY-MM-DD-slug.md`
- Layout: `post`
- Front matter: `layout: post`, `title`, `author` (key from `_data/authors.yml`)
- Optional: `update_date` for showing last-updated

### Release Notes

- Location: `articles/_release-notes/vX.Y.x.md`
- One file per minor version series

### Migration Guides

- Location: `articles/_migration-guides/vX.Y.x-vA.B.C.md`

## Technology Stack

- Jekyll 4.x with kramdown (Markdown) and rouge (syntax highlighting)
- Bootstrap 3.4.1 (CSS framework)
- jQuery 3.4.1
- bootstrap-toc 0.4.1 (auto table of contents)
- highlight.js (code highlighting)
- lite-youtube 1.5.0 (lazy YouTube embeds)
- Plugins: jekyll-sitemap, jekyll-paginate, jekyll-last-modified-at,
  jekyll-redirect-from, jekyll-seo-tag, jekyll-feed, jemoji, and others

## Git Workflow

This is an origin repo (not a fork). All changes go through PRs to `source`.
Never push directly to `source` or `master`.

## Content Editing

- Keep documentation accurate with respect to the current PyBuilder release.
  Cross-reference the main PyBuilder repo at `../pybuilder/` for feature details.
- Preserve existing front matter fields exactly. Do not add or remove fields
  unless intentionally changing page behavior.
- Use the `{% link %}` Liquid tag for internal cross-references, never raw paths.
- Do not reformat or rewrap existing paragraphs that you are not changing.
  Minimize diff noise.

## Layouts and Includes

- Bootstrap 3, not 4 or 5. The `bootstrap_4` migration was never completed.
  Do not upgrade Bootstrap unless explicitly asked.
- Google Analytics tag is in `_includes/layout/metaAndStyles.html`. Do not
  modify or remove it.
- Navigation structure is in `_includes/layout/header.html`. When adding new
  documentation pages, add a corresponding nav entry there and in
  `documentation/index.md`.

## Adding New Documentation Pages

1. Create the `.md` file in `documentation/` with front matter:
   ```yaml
   ---
   layout: documentation
   title: Your Page Title
   ---
   ```
2. Add a link in `documentation/index.md` under the appropriate section
3. Add a navigation entry in `_includes/layout/header.html`

## Adding Blog Posts

1. Create `articles/_posts/YYYY-MM-DD-slug.md` with front matter:
   ```yaml
   ---
   layout: post
   title: "Post Title"
   author: arcivanov
   ---
   ```
2. Author key must exist in `_data/authors.yml`

## Adding Release Notes

1. If a file for the minor version series exists, append to it
2. Otherwise create `articles/_release-notes/vX.Y.x.md`
3. The release notes index auto-generates from the collection

## Testing Changes

- Always run `bundle exec jekyll build` to verify the site builds without errors
- For thorough validation, run `./build.sh` which also checks links and images
  via htmlproofer
- htmlproofer may fail on transient external link issues (429, timeouts). These
  are usually not your fault. Check if the link is actually broken before fixing.

## Things to Avoid

- Do not edit files on the `master` branch. It is auto-generated.
- Do not add `Gemfile.lock` to version control (it is gitignored).
- Do not modify vendored JS libraries (`highlight.pack.js`, jQuery, Bootstrap)
  unless upgrading them intentionally.
- Do not remove or alter the `CNAME` file.
- Do not change `_config.yml` pagination or permalink settings without
  understanding the URL impact on existing links and SEO.
