---
title: "Introducing Nushell: A Modern Command Line Experience"
source: "https://dev.to/hamedi/introducing-nushell-a-modern-command-line-experience-3e9l"
author:
  - "[[Abdul Saboor]]"
published: 2024-11-23
created: 2025-11-27
description: "Installation  In this post, I want to introduce you to #nushell, a tool that connects simple commands... Tagged with terminal, nushell, cli."
tags:
  - "clippings"
---
[Installation](https://www.nushell.sh/book/installation.html)

In this post, I want to introduce you to #nushell, a tool that connects simple commands using pipes and brings a modern style to development. Nushell is not just a shell or a programming language; it bridges the gap between the two by integrating a rich programming language with a full-featured shell into one cohesive package.

Nushell takes inspiration from various familiar tools: traditional shells like Bash, object-based shells like PowerShell, gradually typed languages like TypeScript, functional programming, systems programming, and more. However, rather than trying to be a jack of all trades, Nushell focuses on excelling in a few key areas:

- Providing a flexible, cross-platform shell with a modern feel.
- Solving problems as a modern programming language that works with the structure of your data.
- Offering clear error messages and clean IDE support.

### Why I Love Nushell

Nushell is one of my favorite command-line interfaces (CLI) because it is convenient and flexible. While there are many CLIs out there, Nushell stands out to me for several reasons:

1. **Free to Use**: Nushell is completely free, which is always a plus.
2. **Amazing Auto-completion**: The auto-completion feature is impressive. It remembers previous commands and suggests them, making the workflow smoother and faster.

### Some Useful Nushell Commands

Here are some commands that I find particularly useful:

- **Finding the Configuration Path**: To get the full path to the Nushell configuration, use the following command:
```
$nu.config-path
```

[![[02-Tech/DevTools/Nushell/_resources/f4762ae12a81ed3d8b68a57fe83c3299_MD5.webp]]

### Disclaimer

I am using Windows 10, so all the commands and examples provided here are based on that environment. However, Nushell should work similarly on Mac and Linux.  
`uname`  
[![[02-Tech/DevTools/Nushell/_resources/9b8cc4040001f555ed0cf238b46e55ab_MD5.jpg]]

### Detailed Nushell Commands

Let's dive into some specific Nushell commands and explore their functionalities:

#### 1\. Navigating Directories

To navigate through directories, you can use the familiar `cd` command. For example:  

```
cd documents
```

This command will change the current directory to the `documents` folder.

#### 2\. Listing Directory Contents

To list the contents of a directory, you can use the `ls` command:  

```
ls
```

This command will display all files and folders in the current directory in a neatly formatted table.

#### 3\. Viewing File Content

To view the contents of a file, use the `open` command followed by the file name:  

```
start mytext.txt
```

This command reads the content of `myfile.txt` and displays it in the shell.

#### 4\. Filtering Data

Nushell shines with its ability to filter data using pipes. For instance, to filter files by a specific pattern, you can use the `where` command:  

```
ls | where name == "myfile.txt"
```

This command lists all files named `myfile.txt` in the current directory.

#### 5\. Sorting Data

You can easily sort data using the `sort-by` command. For example, to sort files by size:  

```
ls | sort-by size
```

This command lists all files in the current directory, sorted by their size.

#### 6\. Getting Help

To get help with any command, use the `help` command followed by the command name:  

```
help ls
```

This command provides detailed information about how to use the `ls` command.

#### 7\. Custom Aliases

You can create custom aliases for commands to save time. For example, to create an alias for listing directory contents, you can use:  

```
alias ll = "ls -l"
```

Now, using `ll` will execute `ls -l`.

#### 8\. Running Scripts

Nushell supports running scripts. To execute a script file, use the following command:  

```
source myscript.nu
```

This command runs the `myscript.nu` script within the Nushell environment.

#### 9\. Command History

Nushell keeps track of your command history. To view your recent commands, you can use:  

```
history
```

This command displays a list of recently executed commands, allowing you to reuse or modify them as needed.

These are just a few examples of the powerful commands available in Nushell. By exploring and utilizing these commands, you can enhance your productivity and streamline your workflow. Give them a try and see how Nushell can transform your command-line experience!

#### Conclusion

In conclusion, Nushell is a powerful and modern CLI that combines the best aspects of traditional shells and modern programming languages. Give it a try and see how it can enhance your development workflow.