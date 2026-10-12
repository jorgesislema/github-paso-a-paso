$path = "H:\git\repositorio de Git hub\github-paso-a-paso\11-git-deshacer-y-recuperar\README.md"
$content = Get-Content -Raw -Path $path
$lines = $content -split "`r`n"
$q4Line = $lines[85] # "4. �Perdiste� un commit con un reset: �d�nde est� y c�mo lo recuperas?"
$q5 = "5. ¿Cuándo es apropiado usar `git reset --soft` en lugar de `--mixed` o `--hard`?"
$q6 = "6. ¿Cómo puedes recuperar un stash eliminado accidentalmente con `git stash drop`?"
$questionsBlock = $q5 + "`r`n" + $q6 + "`r`n`r`n"
$newString = $q4Line + "`r`n" + $questionsBlock + "`r`n---`r`n
"
$oldString = $q4Line + "`r`n`r`n---`r`n
"
$newContent = $content -replace [regex]::Escape($oldString), $newString
Set-Content -Path $path -Value $newContent -Encoding UTF8