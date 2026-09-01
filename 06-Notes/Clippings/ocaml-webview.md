---
title: "GitHub - apatil/ocaml-webview: Pop open a webview from OCaml"
source: "https://github.com/apatil/ocaml-webview"
author:
  - "[[GitHub]]"
published:
created: 2025-03-13
description: "Pop open a webview from OCaml. Contribute to apatil/ocaml-webview development by creating an account on GitHub."
tags:
  - "clippings"
---
A cross-platform wrapper of [webview](https://github.com/zserge/webview) for OCaml. Allows you to pop open a webview from OCaml code, then to programmatically close it or cause it to execute JavaScript.

## Usage

```
(webview, thread) = Webview.run "https://github.com/zserge/webview"
```

Status: **pre-release**. Expect breaking changes, build failures and segfaults.