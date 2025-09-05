---
title: "a useful CLI printing tool"
description: print documents within scripts
permalink: posts/{{ title | slugify }}/index.html
date: '2025-09-05'
tags: [tidbits, printers]
---
We have some automations which take documents from a folder, print them, and then delete them.
Very old fashioned I know, but this is an old company, cut me some slack...

In case you find yourself in this predicament, you might want to consider 2printer: https://www.cmd2printer.com/
It will even expand globs for you!

Here's how we're calling it from PS:
```powershell
# Anonymised slightly
$printInfo = [PSCustomObject]@{
    Query    = "D:\..\..\..\*.pdf"
    Printers = @(
    "Prt1",
    "Prt2",
    "Prt3"
    )
}

$2p = "C:\Program Files (x86)\2printer\2printer.exe" 

$printInfo.Printers | ForEach-Object {
    $printer = $_
    & $2p -s "$($printInfo.Query)" -prn $printer -silent
}
```