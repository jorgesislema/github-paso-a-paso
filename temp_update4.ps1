$path = "H:\git\repositorio de Git hub\github-paso-a-paso\11-git-deshacer-y-recuperar\README.md"
$content = Get-Content -Raw -Path $path
$questions5 = "5. ¿Cuándo es apropiado usar `git reset --soft` en lugar de `--mixed` o `--hard`?"
$questions6 = "6. ¿Cómo puedes recuperar un stash eliminado accidentalmente con `git stash drop`?"
$questionsBlock = $questions5 + "`r`n" + $questions6 + "`r`n`r`n"
$oldString = "`r`n---`r`n`r`n## Pr≤ximo paso"
$newString = $questionsBlock + $oldString
$newContent = $content -replace [regex]::Escape($oldString), $newString
Set-Content -Path $path -Value $newContent -Encoding UTF8