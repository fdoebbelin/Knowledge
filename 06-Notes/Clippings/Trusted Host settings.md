---
title: "Trusted Host settings"
source: "https://www.drupal.org/docs/getting-started/installing-drupal/trusted-host-settings"
author:
  - "[[Drupal.org]]"
published: 2013-05-10
created: 2025-04-11
description: "Protecting against HTTP HOST Header attacks"
tags:
  - "clippings"
---
## Protecting against HTTP HOST Header attacks

### Protecting in Drupal 8 and later

Drupal 8 and later versions can be configured to use Symfony's trusted host mechanism to prevent HTTP Host header spoofing. To enable the trusted host mechanism, you enable the allowed hosts setting `$settings['trusted_host_patterns']` in the *settings.php* file (the *sites/default/settings.php* file inside the *webroot* directory). This should be an array of regular expression patterns, without delimiters, representing the hosts you would like to allow. If the Host header of the HTTP request does not match the defined patterns, Drupal will respond with HTTP 400 with a message *The provided host name is not valid for this server.*

In the example below, the site is only allowed to run from [www.example.com](http://www.example.com/).

```
$settings['trusted_host_patterns'] = [
  '^www\.example\.com$',
];
```