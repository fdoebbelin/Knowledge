
```powershell
$md = '.\M03c Lösungen.md'; $doc = [System.IO.Path]::ChangeExtension($md, 'docx'); pandoc $md -o $doc
```


```powershell
param(
    [string]$Pattern = "M00*.md"
)

$downloads = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path

Get-ChildItem -Path . -Filter $Pattern | ForEach-Object {
    $md = $_.FullName
    $doc = Join-Path $downloads ([System.IO.Path]::GetFileNameWithoutExtension($md) + '.docx')
    pandoc $md -o $doc
}

```
