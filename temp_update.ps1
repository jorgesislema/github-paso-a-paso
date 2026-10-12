$path = "H:\git\repositorio de Git hub\github-paso-a-paso\11-git-deshacer-y-recuperar\README.md"
$content = Get-Content -Raw -Path $path
$lines = $content -split "`r`n"
# line numbers are zero-index
$q4Line = $lines[83] # "1. Cometiste un error en una rama compartida: �qu� comando usas y por qu� no `reset`?"
$questions5_6 = @"
5. ¿Cuándo es apropiado usar `git reset --soft` en lugar de `--mixed` o `--hard`?
6. ¿Cómo puedes recuperar un stash eliminado accidentalmente con `git stash drop`?
"@
# Build new block: keep q4 line, then newline, then original blank line replaced with questions 5-6 and a blank line
$newBlock = $q4Line + "`r`n" + $questions5_6 + "`r`n`r`n---`r`n"
# Replace pattern: q4Line + "`r`n`r`n---`r`n"
$oldPattern = $q4Line + "`r`n`r`n---`r`n"
$newContent = $content -replace [regex]::Escape($oldPattern), $newBlock
Set-Content -Path $path -Value $newContent -Encoding UTF8