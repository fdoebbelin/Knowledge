---
title: "Helix - Dash Cheat Sheets"
source: "https://kapeli.com/cheat_sheets/Helix.docset/Contents/Resources/Documents/index"
author:
  - "[[Kapeli]]"
published:
created: 2026-03-05
description: "Helix editor keyboard shortcuts and commands reference including movement, selection, editing, and search operations. Essential shortcuts for the modern terminal-based text editor. Download Dash for macOS to access this and other cheat sheets offline."
tags:
  - "clippings"
---
## Movement

| `h`  `Left` | Move left |
| --- | --- |
| `j`  `Down` | Move down |
| `k`  `Up` | Move up |
| `l`  `Right` | Move right |
| `w` | Move next word start |
| `b` | Move previous word start |
| `W` | Move next WORD start |
| `B` | Move previous WORD start |
| `E` | Move next WORD end |
| `t` | Find 'till next char |
| `f` | Find next char |
| `T` | Find 'till previous char |
| `F` | Find previous char |
| `G` | Go to line number `<n>` |
| `G` | Go to line number `<n>` |
| `Alt-.` | Repeat last motion (f, t or m) |
| `Home` | Move to the start of the line |
| `End` | Move to the end of the line |
| `Ctrl-b`  `PageUp` | Move page up |
| `Ctrl-f`  `PageDown` | Move page down |
| `Ctrl-u` | Move half page up |
| `Ctrl-d` | Move half page down |
| `Ctrl-i` | Jump forward on the jumplist |
| `Ctrl-o` | Jump backward on the jumplist |
| `Ctrl-s` | Save the current selection to the jumplist |

## Changes

| `r` | Replace with a character |
| --- | --- |
| `R` | Replace with yanked text |
| `~` | Switch case of the selected text |
| `` ` `` | Set the selected text to lower case |
| `` Alt-` `` | Set the selected text to upper case |
| `i` | Insert before selection |
| `a` | Insert after selection (append) |
| `I` | Insert at the start of the line |
| `A` | Insert at the end of the line |
| `o` | Open new line below selection |
| `O` | Open new line above selection |
| `.` | Repeat last insert |
| `u` | Undo change |
| `U` | Redo change |
| `Alt-u` | Move backward in history |
| `Alt-U` | Move forward in history |
| `y` | Yank selection |
| `p` | Paste after selection |
| `P` | Paste before selection |
| `>` | Indent selection |
| `<` | Unindent selection |
| `=` | Format selection (currently nonfunctional/disabled) (LSP) |
| `d` | Delete selection |
| `Alt-d` | Delete selection, without yanking |
| `c` | Change selection (delete and enter insert mode) |
| `Alt-c` | Change selection (delete and enter insert mode, without yanking) |
| `Ctrl-a` | Increment object (number) under cursor |
| `Ctrl-x` | Decrement object (number) under cursor |

## Shell

| `\|` | Pipe each selection through shell command, replacing with output |
| --- | --- | --- |
| `Alt-\|` | Pipe each selection into shell command, ignoring output |
| `!` | Run shell command, inserting output before each selection |
| `Alt-!` | Run shell command, appending output after each selection |
| `$` | Pipe each selection into shell command, keep selections where command returned 0 |

## Selection manipulation

| `s` | Select all regex matches inside selections |
| --- | --- |
| `S` | Split selection into sub selections on regex matches |
| `Alt-s` | Split selection on newlines |
| `Alt-_` | Merge consecutive selections |
| `&` | Align selection in columns |
| `_` | Trim whitespace from the selection |
| `;` | Collapse selection onto a single cursor |
| `Alt-;` | Flip selection cursor and anchor |
| `Alt-:` | Ensures the selection is in forward direction |
| `,` | Keep only the primary selection |
| `Alt-,` | Remove the primary selection |
| `C` | Copy selection onto the next line (Add cursor below) |
| `Alt-C` | Copy selection onto the previous line (Add cursor above) |
| `(` | Rotate main selection backward |
| `)` | Rotate main selection forward |
| `Alt-(` | Rotate selection contents backward |
| `Alt-)` | Rotate selection contents forward |
| `%` | Select entire file |
| `x` | Select current line, if already selected, extend to next line |
| `X` | Extend selection to line bounds (line-wise selection) |
| `Alt-x` | Shrink selection to line bounds (line-wise selection) |
| `J` | Join lines inside selection |
| `Alt-J` | Join lines inside selection and select the inserted space |
| `K` | Keep selections matching the regex |
| `Alt-K` | Remove selections matching the regex |
| `Ctrl-c` | Comment/uncomment the selections |
| `Alt-o`  `Alt-up` | Expand selection to parent syntax node (TS) |
| `Alt-i`  `Alt-down` | Shrink syntax tree object selection (TS) |
| `Alt-p`  `Alt-left` | Select previous sibling node in syntax tree (TS) |
| `Alt-n`  `Alt-right` | Select next sibling node in syntax tree (TS) |

## Search

## Minor modes

| `v` | Enter select (extend) mode |
| --- | --- |
| `g` | Enter goto mode |
| `m` | Enter match mode |
| `:` | Enter command mode |
| `z` | Enter view mode |
| `Z` | Enter sticky view mode |
| `Ctrl-w` | Enter window mode |
| `Space` | Enter space mode |

## View Mode

| `z`  `c` | Vertically center the line |
| --- | --- |
| `t` | Align the line to the top of the screen |
| `b` | Align the line to the bottom of the screen |
| `m` | Align the line to the middle of the screen (horizontally) |
| `j`  `down` | Scroll the view downwards |
| `k`  `up` | Scroll the view upwards |
| `Ctrl-f`  `PageDown` | Move page down |
| `Ctrl-b`  `PageUp` | Move page up |
| `Ctrl-d` | Move half page down |
| `Ctrl-u` | Move half page up |

## Goto mode

| `g` | Go to line number else start of file |
| --- | --- |
| `e` | Go to the end of the file |
| `f` | Go to files in the selection |
| `h` | Go to the start of the line |
| `l` | Go to the end of the line |
| `s` | Go to first non-whitespace character of the line |
| `t` | Go to the top of the screen |
| `c` | Go to the middle of the screen |
| `b` | Go to the bottom of the screen |
| `d` | Go to definition (LSP) |
| `y` | Go to type definition (LSP) |
| `r` | Go to references (LSP) |
| `i` | Go to implementation (LSP) |
| `a` | Go to the last accessed/alternate file |
| `m` | Go to the last modified/alternate file |
| `n` | Go to next buffer |
| `p` | Go to previous buffer |
| `.` | Go to last modification in current file |
| `j` | Move down textual (instead of visual) line |
| `k` | Move up textual (instead of visual) line |

## Match mode

| `m` | Goto matching bracket (TS) |
| --- | --- |
| `s <char>` | Surround current selection with |
| `r <from><to>` | Replace surround character with |
| `d <char>` | Delete surround character |
| `a <object>` | Select around textobject |
| `i <object>` | Select inside textobject |

## Window mode

| `w`  `Ctrl-w` | Switch to next window |
| --- | --- |
| `v`  `Ctrl-v` | Vertical right split |
| `s`  `Ctrl-s` | Horizontal bottom split |
| `f` | Go to files in the selection in horizontal splits |
| `F` | Go to files in the selection in vertical splits |
| `h`  `Ctrl-h`  `Left` | Move to left split |
| `j`  `Ctrl-j`  `Down` | Move to split below |
| `k`  `Ctrl-k`  `Up` | Move to split above |
| `l`  `Ctrl-l`  `Right` | Move to right split |
| `q`  `Ctrl-q` | Close current window |
| `o`  `Ctrl-o` | Only keep the current window, closing all the others |
| `H` | Swap window to the left |
| `J` | Swap window downwards |
| `K` | Swap window upwards |
| `L` | Swap window to the right |

## Space mode

| `f` | Open file picker |
| --- | --- |
| `F` | Open file picker at current working directory |
| `b` | Open buffer picker |
| `j` | Open jumplist picker |
| `g` | Debug (experimental) |
| `k` | Show documentation for item under cursor in a popup (LSP) |
| `s` | Open document symbol picker (LSP) |
| `S` | Open workspace symbol picker (LSP) |
| `d` | Open document diagnostics picker (LSP) |
| `D` | Open workspace diagnostics picker (LSP) |
| `r` | Rename symbol (LSP) |
| `a` | Apply code action (LSP) |
| `h` | Select symbol references (LSP) |
| `'` | Open last fuzzy picker |
| `w` | Enter window mode |
| `p` | Paste system clipboard after selections |
| `P` | Paste system clipboard before selections |
| `y` | Join and yank selections to clipboard |
| `Y` | Yank main selection to clipboard |
| `R` | Replace selections by clipboard contents |
| `/` | Global search in workspace folder |
| `?` | Open command palette |

## Popup

| `Ctrl-u` | Scroll up |
| --- | --- |
| `Ctrl-d` | Scroll down |

## Unimpaired

| `]d` | Go to next diagnostic (LSP) |
| --- | --- |
| `[d` | Go to previous diagnostic (LSP) |
| `]D` | Go to last diagnostic in document (LSP) |
| `[D` | Go to first diagnostic in document (LSP) |
| `]f` | Go to next function (TS) |
| `[f` | Go to previous function (TS) |
| `]t` | Go to next type definition (TS) |
| `[t` | Go to previous type definition (TS) |
| `]a` | Go to next argument/parameter (TS) |
| `[a` | Go to previous argument/parameter (TS) |
| `]c` | Go to next comment (TS) |
| `[c` | Go to previous comment (TS) |
| `]T` | Go to next test (TS) |
| `[T` | Go to previous test (TS) |
| `]p` | Go to next paragraph |
| `[p` | Go to previous paragraph |
| `]g` | Go to next change |
| `[g` | Go to previous change |
| `]G` | Go to last change |
| `[G` | Go to first change |
| `]Space` | Add newline below |
| `[Space` | Add newline above |

## Insert mode

| `Escape` | Switch to normal mode |
| --- | --- |
| `Ctrl-s` | Commit undo checkpoint |
| `Ctrl-x` | Autocomplete |
| `Ctrl-w`  `Alt-Backspace` | Delete previous word |
| `Alt-d`  `Alt-Delete` | Delete next word |
| `Ctrl-u` | Delete to start of line |
| `Ctrl-k` | Delete to end of line |
| `Ctrl-h`  `Backspace`  `Shift-Backspace` | Delete previous char |
| `Ctrl-d`  `Delete` | Delete next char |
| `Ctrl-j`  `Enter` | Insert new line |
| `Up` | Move to previous line |
| `Down` | Move to next line |
| `Left` | Backward a char |
| `Right` | Forward a char |
| `PageUp` | Move one page up |
| `PageDown` | Move one page down |
| `Home` | Move to line start |
| `End` | Move to line end |

## Picker

| `Shift-Tab`  `Up`  `Ctrl-p` | Previous entry |
| --- | --- |
| `Tab`  `Down`  `Ctrl-n` | Next entry |
| `PageUp`  `Ctrl-u` | Page up |
| `PageDown`  `Ctrl-d` | Page down |
| `Home` | Go to first entry |
| `End` | Go to last entry |
| `Enter` | Open selected |
| `Ctrl-s` | Open horizontally |
| `Ctrl-v` | Open vertically |
| `Ctrl-t` | Toggle preview |
| `Escape`  `Ctrl-c` | Close picker |

## Prompt

| `Escape`  `Ctrl-c` | Close prompt |
| --- | --- |
| `Alt-b`  `Ctrl-Left` | Backward a word |
| `Ctrl-b`  `Left` | Backward a char |
| `Alt-f`  `Ctrl-Right` | Forward a word |
| `Ctrl-f`  `Right` | Forward a char |
| `Ctrl-e`  `End` | Move prompt end |
| `Ctrl-a`  `Home` | Move prompt start |
| `Ctrl-w`  `Alt-Backspace`  `Ctrl-Backspace` | Delete previous word |
| `Alt-d`  `Alt-Delete`  `Ctrl-Delete` | Delete next word |
| `Ctrl-u` | Delete to start of line |
| `Ctrl-k` | Delete to end of line |
| `Backspace`  `Ctrl-h`  `Shift-Backspace` | Delete previous char |
| `Delete`  `Ctrl-d` | Delete next char |
| `Ctrl-s` | Insert a word under doc cursor, may be changed to Ctrl-r Ctrl-w later |
| `Ctrl-p`  `Up` | Select previous history |
| `Ctrl-n`  `Down` | Select next history |
| `Tab` | Select next completion item |
| `BackTab` | Select previous completion item |
| `Enter` | Open selected |

## Commands

| `:quit`  `:q` | Close the current view. |
| --- | --- |
| `:quit!`  `:q!` | Force close the current view, ignoring unsaved changes. |
| `:open`  `:o` | Open a file from disk into the current view. |
| `:buffer-close`  `:bc`  `:bclose` | Close the current buffer. |
| `:buffer-close!`  `:bc!`  `:bclose!` | Close the current buffer forcefully, ignoring unsaved changes. |
| `:buffer-close-others`  `:bco`  `:bcloseother` | Close all buffers but the currently focused one. |
| `:buffer-close-others!`  `:bco!`  `:bcloseother!` | Force close all buffers but the currently focused one. |
| `:buffer-close-all`  `:bca`  `:bcloseall` | Close all buffers without quitting. |
| `:buffer-close-all!`  `:bca!`  `:bcloseall!` | Force close all buffers ignoring unsaved changes without quitting. |
| `:buffer-next`  `:bn`  `:bnext` | Goto next buffer. |
| `:buffer-previous`  `:bp`  `:bprev` | Goto previous buffer. |
| `:write`  `:w` | Write changes to disk. Accepts an optional path (:write some/path.txt) |
| `:write!`  `:w!` | Force write changes to disk creating necessary subdirectories. Accepts an optional path (:write! some/path.txt) |
| `:write-buffer-close`  `:wbc` | Write changes to disk and closes the buffer. Accepts an optional path (:write-buffer-close some/path.txt) |
| `:write-buffer-close!`  `:wbc!` | Force write changes to disk creating necessary subdirectories and closes the buffer. Accepts an optional path (:write-buffer-close! some/path.txt) |
| `:new`  `:n` | Create a new scratch buffer. |
| `:format`  `:fmt` | Format the file using the LSP formatter. |
| `:indent-style` | Set the indentation style for editing. ('t' for tabs or 1-8 for number of spaces.) |
| `:line-ending` | Set the document's default line ending. Options: crlf, lf. |
| `:earlier`  `:ear` | Jump back to an earlier point in edit history. Accepts a number of steps or a time span. |
| `:later`  `:lat` | Jump to a later point in edit history. Accepts a number of steps or a time span. |
| `:write-quit`  `:wq`  `:x` | Write changes to disk and close the current view. Accepts an optional path (:wq some/path.txt) |
| `:write-quit!`  `:wq!`  `:x!` | Write changes to disk and close the current view forcefully. Accepts an optional path (:wq! some/path.txt) |
| `:write-all`  `:wa` | Write changes from all buffers to disk. |
| `:write-quit-all`  `:wqa`  `:xa` | Write changes from all buffers to disk and close all views. |
| `:write-quit-all!`  `:wqa!`  `:xa!` | Write changes from all buffers to disk and close all views forcefully (ignoring unsaved changes). |
| `:quit-all`  `:qa` | Close all views. |
| `:quit-all!`  `:qa!` | Force close all views ignoring unsaved changes. |
| `:cquit`  `:cq` | Quit with exit code (default 1). Accepts an optional integer exit code (:cq 2). |
| `:cquit!`  `:cq!` | Force quit with exit code (default 1) ignoring unsaved changes. Accepts an optional integer exit code (:cq! 2). |
| `:theme` | Change the editor theme (show current theme if no name specified). |
| `:clipboard-yank` | Yank main selection into system clipboard. |
| `:clipboard-yank-join` | Yank joined selections into system clipboard. A separator can be provided as first argument. Default value is newline. |
| `:primary-clipboard-yank` | Yank main selection into system primary clipboard. |
| `:primary-clipboard-yank-join` | Yank joined selections into system primary clipboard. A separator can be provided as first argument. Default value is newline. |
| `:clipboard-paste-after` | Paste system clipboard after selections. |
| `:clipboard-paste-before` | Paste system clipboard before selections. |
| `:clipboard-paste-replace` | Replace selections with content of system clipboard. |
| `:primary-clipboard-paste-after` | Paste primary clipboard after selections. |
| `:primary-clipboard-paste-before` | Paste primary clipboard before selections. |
| `:primary-clipboard-paste-replace` | Replace selections with content of system primary clipboard. |
| `:show-clipboard-provider` | Show clipboard provider name in status bar. |
| `:change-current-directory`  `:cd` | Change the current working directory. |
| `:show-directory`  `:pwd` | Show the current working directory. |
| `:encoding` | Set encoding. Based on [https://encoding.spec.whatwg.org](https://encoding.spec.whatwg.org/). |
| `:character-info`  `:char` | Get info about the character under the primary cursor. |
| `:reload` | Discard changes and reload from the source file. |
| `:reload-all` | Discard changes and reload all documents from the source files. |
| `:update`  `:u` | Write changes only if the file has been modified. |
| `:lsp-workspace-command` | Open workspace command picker |
| `:lsp-restart` | Restarts the Language Server that is in use by the current doc |
| `:lsp-stop` | Stops the Language Server that is in use by the current doc |
| `:tree-sitter-scopes` | Display tree sitter scopes, primarily for theming and development. |
| `:debug-start`  `:dbg` | Start a debug session from a given template with given parameters. |
| `:debug-remote`  `:dbg-tcp` | Connect to a debug adapter by TCP address and start a debugging session from a given template with given parameters. |
| `:debug-eval` | Evaluate expression in current debug context. |
| `:vsplit`  `:vs` | Open the file in a vertical split. |
| `:vsplit-new`  `:vnew` | Open a scratch buffer in a vertical split. |
| `:hsplit`  `:hs`  `:sp` | Open the file in a horizontal split. |
| `:hsplit-new`  `:hnew` | Open a scratch buffer in a horizontal split. |
| `:tutor` | Open the tutorial. |
| `:goto`  `:g` | Goto line number. |
| `:set-language`  `:lang` | Set the language of current buffer (show current language if no value specified). |
| `:set-option`  `:set` | Set a config option at runtime. For example to disable smart case search, use:set search.smart-case false. |
| `:toggle-option`  `:toggle` | Toggle a boolean config option at runtime. For example to toggle smart case search, use:toggle search.smart-case. |
| `:get-option`  `:get` | Get the current value of a config option. |
| `:sort` | Sort ranges in selection. |
| `:rsort` | Sort ranges in selection in reverse order. |
| `:reflow` | Hard-wrap the current selection of lines to a given width. |
| `:tree-sitter-subtree`  `:ts-subtree` | Display tree sitter subtree under cursor, primarily for debugging queries. |
| `:config-reload` | Refresh user config. |
| `:config-open` | Open the user config.toml file. |
| `:config-open-workspace` | Open the workspace config.toml file. |
| `:log-open` | Open the helix log file. |
| `:insert-output` | Run shell command, inserting output before each selection. |
| `:append-output` | Run shell command, appending output after each selection. |
| `:pipe` | Pipe each selection to the shell command. |
| `:pipe-to` | Pipe each selection to the shell command, ignoring output. |
| `:run-shell-command`  `:sh` | Run a shell command |
| `:reset-diff-change, :diffget, :diffg` | Reset the diff change at the cursor position. |

## Notes

***References***

- [https://docs.helix-editor.com/keymap.html](https://docs.helix-editor.com/keymap.html)
- [https://docs.helix-editor.com/commands.html](https://docs.helix-editor.com/commands.html)