---
title: "SilasMarvin/lsp-ai: LSP-AI is an open-source language server that serves as a backend for AI-powered functionality, designed to assist and empower software engineers, not replace them."
source: "https://github.com/SilasMarvin/lsp-ai"
author:
  - "[[SilasMarvin]]"
published:
created: 2025-09-14
description: "LSP-AI is an open-source language server that serves as a backend for AI-powered functionality, designed to assist and empower software engineers, not replace them. - SilasMarvin/lsp-ai"
tags:
  - "clippings"
---
LSP-AI is an open-source language server that serves as a backend for AI-powered functionality, designed to assist and empower software engineers, not replace them.

[MIT license](https://github.com/SilasMarvin/lsp-ai/blob/main/LICENSE)

![Logo](https://github.com/SilasMarvin/lsp-ai/raw/main)

**Empowering not replacing programmers.**

| [**Documentation**](https://github.com/SilasMarvin/lsp-ai/wiki) | [**Blog**](https://silasmarvin.dev/) | [**Discord**](https://discord.gg/vKxfuAxA6Z) |

---

LSP-AI is an open source [language server](https://microsoft.github.io/language-server-protocol/) that serves as a backend for AI-powered functionality in your favorite code editors. It offers features like in-editor chatting with LLMs and code completions. Because it is a language server, it works with any editor that has LSP support.

**The goal of LSP-AI is to assist and empower software engineers by integrating with the tools they already know and love, not replace software engineers.**

A short list of a few of the editors it works with:

- VS Code
- NeoVim
- Emacs
- Helix
- Sublime

It works with many many many more editors.

**NOTE: This project is currently used daily by many users and has reached a stage where it has all the features I want for it. Development is not necessarily done, but no new features are currently being developed for it.**

## Features

## In-Editor Chatting

Chat directly in your codebase with your favorite local or hosted models.

![in-editor-chatting](https://private-user-images.githubusercontent.com/19626586/355301452-c69a9dc0-c0ac-4786-b24b-f5b5d19ffd3a.gif?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTYwMzMxNjQsIm5iZiI6MTc1NjAzMjg2NCwicGF0aCI6Ii8xOTYyNjU4Ni8zNTUzMDE0NTItYzY5YTlkYzAtYzBhYy00Nzg2LWIyNGItZjViNWQxOWZmZDNhLmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA4MjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwODI0VDEwNTQyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWI5N2I0OWE3NzhjZWE2NzMyMzViZjkxYzRkYjVlODNlNjBmYTZmOTcwMTQ1ZDY1MjYzMzRhN2ZkMjU3ZDY1OTYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.74uTbVmxt6l2AQwROhi0EGGUClKcFAuaBkFUJ3MQu4Q)

in-editor-chatting

*Chatting with Claude Sonnet in Helix*

## Custom Actions

Create custom actions to do code refactoring, code completions and more!

![custom-actions](https://private-user-images.githubusercontent.com/19626586/361489514-6522dced-d5ee-43bc-8b64-f4313bcc82f2.gif?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTYwMzMxNjQsIm5iZiI6MTc1NjAzMjg2NCwicGF0aCI6Ii8xOTYyNjU4Ni8zNjE0ODk1MTQtNjUyMmRjZWQtZDVlZS00M2JjLThiNjQtZjQzMTNiY2M4MmYyLmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA4MjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwODI0VDEwNTQyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTliZjA2ODE4MmI4NTFjYjgwYmI5YzQzN2VkNjY1MmE2NGI5NzQ4MzNlNDdhMjA5ZWE5MWYxOGRiNDc2MGZkNjgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.6qAKOIHJnOUEY7RWBP-8jWrFtu0eMedep2qtspukf3c)

custom-actions

*Using Claude Sonnet to perform refactoring with chain of thought prompting in Helix*

## Code Completions

LSP-AI can work as an alternative to Github Copilot.

LSP-AI.VS-Code.and.Helix.Demo.mp4<video src="https://private-user-images.githubusercontent.com/19626586/335907364-59430558-da23-4991-939d-57495061c21b.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTYwMzMxNjQsIm5iZiI6MTc1NjAzMjg2NCwicGF0aCI6Ii8xOTYyNjU4Ni8zMzU5MDczNjQtNTk0MzA1NTgtZGEyMy00OTkxLTkzOWQtNTc0OTUwNjFjMjFiLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA4MjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwODI0VDEwNTQyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTFkMzU0OTA3MzFiNDI1YWZiZmI1ZjZhZmU1NGVkODY0NTcxMDMyMzMzYzQ1OWFlZjgyYzcyZjdhN2VmZWE3NzAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.uG_yGjQU7pNZtVXTzcmHEp54PKmN7gGxPJopLkIMqsk" controls="controls"></video>

*On the left: VS Code using Mistral Codestral. On the right: Helix using stabilityai/stable-code-3b*

**Note that speed for completions is entirely dependent on the backend being used. For the fastest completions we recommend using either a small local model or Groq.**

## Documentation

See the wiki for instructions on:

- [Getting Started](https://github.com/SilasMarvin/lsp-ai/wiki)
- [Installation](https://github.com/SilasMarvin/lsp-ai/wiki/Installation)
- [Configuration](https://github.com/SilasMarvin/lsp-ai/wiki/Configuration)
- [In-Editor Chatting](https://github.com/SilasMarvin/lsp-ai/wiki/In%E2%80%90Editor-Chatting)
- [Plugins](https://github.com/SilasMarvin/lsp-ai/wiki/Plugins)
- [Server Capabilities](https://github.com/SilasMarvin/lsp-ai/wiki/Server-Capabilities-and-Functions)
- [and more](https://github.com/SilasMarvin/lsp-ai/wiki)

**tl;dr LSP-AI abstracts complex implementation details from editor specific plugin authors, centralizing open-source development work into one shareable backend.**

Editor integrated AI-powered assistants are here to stay. They are not perfect, but are only improving and [early research is already showing the benefits](https://arxiv.org/pdf/2206.15331). While several companies have released advanced AI-powered editors like [Cursor](https://cursor.sh/), the open-source community lacks a direct competitor.

LSP-AI aims to fill this gap by providing a language server that integrates AI-powered functionality into the editors we know and love. Here’s why we believe LSP-AI is necessary and beneficial:

1. **Unified AI Features**:
	- By centralizing AI features into a single backend, LSP-AI allows supported editors to benefit from these advancements without redundant development efforts.
2. **Simplified Plugin Development**:
	- LSP-AI abstracts away the complexities of setting up LLM backends, building complex prompts and soon much more. Plugin developers can focus on enhancing the specific editor they are working on, rather than dealing with backend intricacies.
3. **Enhanced Collaboration**:
	- Offering a shared backend creates a collaborative platform where open-source developers can come together to add new functionalities. This unified effort fosters innovation and reduces duplicated work.
4. **Broad Compatibility**:
	- LSP-AI supports any editor that adheres to the Language Server Protocol (LSP), ensuring that a wide range of editors can leverage the AI capabilities provided by LSP-AI.
5. **Flexible LLM Backend Support**:
	- Currently, LSP-AI supports llama.cpp, Ollama, OpenAI-compatible APIs, Anthropic-compatible APIs, Gemini-compatible APIs and Mistral AI FIM-compatible APIs, giving developers the flexibility to choose their preferred backend. This list will soon grow.
6. **Future-Ready**:
	- LSP-AI is committed to staying updated with the latest advancements in LLM-driven software development.

## Roadmap

There is so much to do for this project and incredible new research and tools coming out everyday. Below is a list of some ideas for what we want to add next, but we welcome any contributions and discussion around prioritizing new features.

- Implement semantic search-powered context building (This could be incredibly cool and powerful). Planning to use [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) to chunk code correctly.
- Support for additional backends
- Exploration of agent-based systems

## Releases 12

[\+ 11 releases](https://github.com/SilasMarvin/lsp-ai/releases)

## Languages

- [Rust 97.6%](https://github.com/SilasMarvin/lsp-ai/search?l=rust)
- [TypeScript 2.4%](https://github.com/SilasMarvin/lsp-ai/search?l=typescript)