---
title: "NuShell: the shell where traditional Unix meets  modern development, written in Rust"
source: "https://medium.com/this-is-not-a-monad-tutorial/nushell-the-shell-where-traditional-unix-meets-modern-development-written-in-rust-caf92c2c7c98"
author:
  - "[[Federico Carrone]]"
published: 2020-05-14
created: 2025-11-27
description: "Shells have been around forever and, for better or for worse, haven’t changed much since their inception. Until NuShell, written in Rust, appeared to reinvent shells and defy our muscle memory. We interviewed both of its creators."
tags:
  - "clippings"
---
[Sitemap](https://medium.com/sitemap/sitemap.xml)## [This is not a Monad tutorial](https://medium.com/this-is-not-a-monad-tutorial?source=post_page---publication_nav-e1e48303bf07-caf92c2c7c98---------------------------------------)

[![](_resources/b272a9c8f857f0b2ca1ff7f87029c9f8_MD5%201.png)](https://medium.com/this-is-not-a-monad-tutorial?source=post_page---post_publication_sidebar-e1e48303bf07-caf92c2c7c98---------------------------------------)

Writings, reviews and interviews about programming languages, operating systems, network protocols, artificial intelligence and machine learning

Shells have been around forever and, for better or for worse, haven’t changed much since their inception. Until [NuShell](https://www.nushell.sh/) appeared to reinvent shells and defy our muscle memory. It brought some big changes, which include rethinking how pipelines work, structured input/output, and plugins.

We wanted to learn more about NuShell so we interviewed both of its creators: [Jonathan Turner](https://twitter.com/jntrnr) and [Yehuda Katz](https://twitter.com/wycats).

Join the Not a Monad Tutorial Telegram [group](https://t.me/notamonadtutorial) or [channel](https://t.me/channel_notamonadtutorial) to talk about programming, computer science and papers. See you there!

*If you are looking for good engineers send me an email to mail@fcarrone.com or you can also reach me via twitter at* [*@federicocarrone*](https://twitter.com/federicocarrone)*.*

### Why create NuShell? Is it me or does it have a next-level AWK vibe?

**Jonathan Turner**: Sometimes the simplest ideas are the ones that hook you the most:). When Yehuda and I first started discussing how shells could be improved, we settled on the idea of using structured data rather than just text between applications (for example stdin/stdout). He had just been experimenting with PowerShell and saw how adding some structure to the data opened up a lot of possibilities.

The basic idea is pretty simple: Nu opens everything into a table you can work with. Files, streams, commands like ls and ps all output this one table format. Then you have a set of commands that work with these tables, to help you get the data you want, change it, view it, etc.

Funny that you mention “awk”. In a way, Nu is a way of saying “what if we didn’t need tools like awk so often?” Since you’re working with structured data, as we add more support for file types, it’s less often you need to reach for “awk”, “jq”, “grep”, and the array of other tools to open and work with common file types.

In a way, it’s taking the original spirit of Unix — where you use pipelines to combine a set of tools — and imagining how that original spirit would work today, with what we know about programming languages and tools. And, being crossplatform, it’s nice to learn this approach and then be able to easily switch operating systems and use the same techniques.

![](_resources/ba508c801f1ada3bc934fcbf58c53cb5_MD5%201.webp)

NuShell screen capture

### Why use Rust? How much experience did you have beforehand?

**Jonathan**: Yehuda and I have been writing Rust for at least 4 years. He was one of the first people to deploy Rust into production, long before it hit 1.0.

Rust also just made sense. It naturally is crossplatform, it’s easy to optimize, it’s easy to harden against memory and threading issues, and after the initial learning curve it’s also quite a lot of fun to write. When you’re doing things in your free time, having something you’re looking forward to hacking on after work makes it a lot easier to do so day after day.

### Did using Rust present a challenge in some aspect?

**Yehuda Katz**: Quite the opposite! Rust and its ecosystem has two properties that are a really good fit for what we’re trying to do:

1. Cross-platform: There is a version of almost every basic crate that works on Windows, macOS, and Linux.
2. Rigorous: Rust doesn’t really have exceptions. Instead, Rust’s library ecosystem surfaces edge-cases as Results. When writing something like a shell, this saved us from all kinds of problems as we evolved.

Rust also has a great package manager (Cargo), which means that gluing together fast, cross-platform, and rigorous packages from the ecosystem is really easy.

### How do you go about making software cross-platform in Rust? Is it as much work as one would think?

**Yehuda**: Not really. What you do is look for crates on [crates.io](https://crates.io/) that support Windows. Most of the time, crates that claim to care about Windows support Windows, as well as other platforms.

**Jonathan**: Rust is definitely my preferred tool for crossplatform development these days. Like Yehuda mentions, most crates work across Windows, macOS, and Linux. We’ll also likely explore making Nu work in the browser in the future, which would mean WASM support, and Rust is probably the best language for that as well.

### Why did you decide to ignore POSIX-compliance?

**Yehuda**: This question is a little bit misleading in my opinion. When people say that a shell is “POSIX compliant”, they’re talking about a tiny subset of the syntax and features that people come to rely on in a shell. If you want to run a POSIX shell script in nu, you can just run it with bash or sh. On the other hand, trying to make our syntax perfectly compliant with the POSIX standard would introduce all kinds of weird decades-old cruft and constrain the ergonomics of our syntax.

**Jonathan**: When people ask for POSIX-compliance, I think different people mean different things. Generally, I think they mean “don’t break my muscle memory”. That’s fair, it’s annoying to unlearn habits. That said, what it means to be compatible has changed a lot from the original ideas. I saw this tweet the other day which I thought sums it up pretty well:

![](_resources/855a88e9bb746a3260f0b682fd5fe1b2_MD5%201.webp)

Source: Dan Luu

### Where does NuShell stand compared to others like zsh or fish? As of today, can I set it as my default shell?

**Jonathan**: we’re quickly approaching when you’ll be able to use Nu as your default shell. In fact, some of Nu’s users already use it as their daily driver happily. In 0.13, we added the ability to create your own aliases, which dramatically improves how well Nu works as a shell, as it’s now easy to configure your own set of shortcuts for things you do regularly.

### How did you decide on that sort of “hard” division of commands: streamers, filters, and consumers? I didn’t see any official names for these concepts, but I think this conveys the idea

**Yehuda**: The distinctions arose organically, and make sense. When you think about streams, there are really three parts: the first part, the middle parts, and the last part. The last part is the most special one, because it takes a stream of data and turns it into something you can see, which requires looking at the inbound stream. For example, the outputted table needs to look at some rows to see what headers to use.

### Why make a plugin system? What are the benefits of using JSON-RPC for internal communication?

**Yehuda**: The main difference between plugins and builtins is that built-in commands have access to the shell internals. We wanted to build as many commands as possible on top of a more well-defined interface. This also meant that you could build custom commands in Python, Ruby or JavaScript pretty early in the project.

The benefit of JSON-RPC is that it’s pretty easy to work with JSON-RPC in virtually all programming languages, so it’s possible to build a plugin in any language without major assistance from the nushell team.

### Why would I choose to make a plugin? Why not just make a binary that works on all shells and let the parsing of my output to users of NuShell?

**Yehuda**: The major benefit of building a plugin is the ability to work directly with structured data. This means that all of the “good stuff” that nushell gives you out of the box, like sorting and filtering, will just work without your user having to parse string output into a new structured format.

The Nushell plugin API also allows you to specify the types of your arguments, which will give you error messages, syntax highlighting and some amount of context-sensitive completion out of the box. The more information you give Nushell, the more we can give Nushell users useful information as they interact with your command.

Also, the Nushell plugin API is also built for streaming out of the box, so if you use the plugin API in the normal way, you can idiomatically interact with streams of structured data in a way that will scale up to huge amounts of input without “breaking the stream”.

### What’s next for NuShell?

**Jonathan**: Nu, as both a shell and a language, is still very much young and growing. We’re planning on adding functions, a rich auto-completion system, better Jupyter integration for working with data, per-directory environments, and much more. In short, we want it to grow to be the best tool for working with your system, files, and data we can make.

[![](_resources/9a9bbd7507cd73d1ab7c39a6a76c9ce0_MD5%201.png)](https://medium.com/this-is-not-a-monad-tutorial?source=post_page---post_publication_info--caf92c2c7c98---------------------------------------)

[![](_resources/f37b9cd1dd5dff87519e8a579a76c721_MD5%201.png)](https://medium.com/this-is-not-a-monad-tutorial?source=post_page---post_publication_info--caf92c2c7c98---------------------------------------)

[Last published Mar 19, 2021](https://medium.com/this-is-not-a-monad-tutorial/how-we-wrote-a-hands-on-bayesian-data-science-book-in-6-months-a97c73a510b5?source=post_page---post_publication_info--caf92c2c7c98---------------------------------------)

Writings, reviews and interviews about programming languages, operating systems, network protocols, artificial intelligence and machine learning

A happy member of The Erlang, Rust/ML and Lisp Evangelism Strikeforce. Network Protocol’s RFC fanatic. Big Data and Machine Learning

## Responses (2)

Write a response[What are your thoughts?](https://medium.com/m/signin?operation=register&redirect=https%3A%2F%2Fmedium.com%2Fthis-is-not-a-monad-tutorial%2Fnushell-the-shell-where-traditional-unix-meets-modern-development-written-in-rust-caf92c2c7c98&source=---post_responses--caf92c2c7c98---------------------respond_sidebar------------------)

```ts
Marcel is another modern shell, based on the idea of piping structured data. Very different approach to nushell, however. Marcel is based in Python, which avoides the need to invent language features. More information here: https://marceltheshell.org.
```

1

```ts
Nu shell is fantastic.its hard to look for correct options and filtering results for a command, nu shell does it good.Nu shell is following same command names as bash/zsh, difference i could see is output.More and More i think, it co-relates to idea of powershell (filtering options).
```

## More from Federico Carrone and This is not a Monad tutorial

## Recommended from Medium

[

See more recommendations

](https://medium.com/?source=post_page---read_next_recirc--caf92c2c7c98---------------------------------------)