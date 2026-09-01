---
title: "Install - Drush"
source: "https://www.drush.org/13.x/install/"
author:
  - "[[Moshe Weitzman]]"
published:
created: 2025-04-12
description: "A command line shell and Unix scripting interface for Drupal"
tags:
  - "clippings"
---
[Skip to content](https://www.drush.org/13.x/install/#drupal-compatibility)

## Install

1. **Composer**. It is required that Drupal sites be built using Composer, with Drush listed as a dependency. See [recommended-project](https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies) (Drush must be added). If your Composer project doesn't yet depend on Drush, run `composer require drush/drush` to add it.
2. **Execution**. Change to the project root, and call Drush via `vendor/bin/drush`. To simplify things, add `./vendor/bin` to your `$PATH`, allowing you to call Drush via `drush` from the project root. If you have only one Drupal codebase on your system, you may put `/path/to/vendor/bin` in your `$PATH`; now you can call Drush from everywhere, without having to change to project root.
3. **Completion**. Optional. Append to.bashrc or equivalent for ZSH or [Fish shell](https://fishshell.com/). Run `drush completion --help` for more details.
4. **Multiple Codebases**. Optional. If using the bash shell, consider installing the [fd](https://github.com/g1a/fd) project, a small set of scripts that make it easier to switch between different project directories quickly, with type completion.