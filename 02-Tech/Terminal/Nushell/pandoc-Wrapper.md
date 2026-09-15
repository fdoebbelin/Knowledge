
```nushell
export def md2docx [
    ...patterns: string
] {
    let target = $env.USERPROFILE | path join "Downloads/WORD"
  
    let files = $patterns
        | each {|p| glob $p }
        | flatten

    $files | each {|md|
        let stem = ($md | path parse).stem
        let doc  = $target | path join $"($stem).docx"
        print $"Konvertiere: ($stem).md"
        pandoc $md -o $doc --from markdown+tex_math_dollars --to docx
    } | ignore
}
```

Aufruf mit

```
md2docx M21*.md
```
