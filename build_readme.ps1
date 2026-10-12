$head = Get-Content -Raw -Path "$env:TEMP\head.txt"
$tail = Get-Content -Raw -Path "$env:TEMP\tail.txt"
$checkpoint = @"
## Checkpoint 11 — Comprobación obligatoria
1. Usa `git restore --staged <file>` para desechar cambios en el índice sin tocar el working directory.
2. Ejecuta `git revert <commit>` para crear un commit que revierta un commit compartido.
3. Utiliza `git reset --soft HEAD~1` para mover la rama manteniendo los cambios en el índice.
4. Guarda trabajo a medias con `git stash push -m "mensaje"` y récupelo con `git stash pop`.
5. Recupera un commit "perdido" usando `git reflog` y `git reset --hard <hash>`.
6. Si puedes hacerlo **sin mirar instrucciones**, el checkpoint está cerrado.

"@
$autopreg = @"
## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. Cometiste un error en una rama compartida: ¿qué comando usas y por qué no `reset`?
2. ¿Qué diferencia hay entre `reset --hard` y `restore`?
3. Tienes trabajo a medias y necesitas cambiar de rama: ¿qué haces?
4. “Perdiste” un commit con un reset: ¿dónde está y cómo lo recuperas?
5. ¿Cuándo es apropiado usar `git reset --soft` en lugar de `--mixed` o `--hard`?
6. ¿Cómo puedes recuperar un stash eliminado accidentalmente con `git stash drop`?

"@
$newContent = $head + $checkpoint + $autopreg + $tail
Set-Content -Path "H:\git\repositorio de Git hub\github-paso-a-paso\11-git-deshacer-y-recuperar\README.md" -Value $newContent -Encoding UTF8