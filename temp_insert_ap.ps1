$chapFiles = Get-ChildItem -Path "H:\git\repositorio de Git hub\github-paso-a-paso\26-nivel-senior\*.md" -Include *.md | Where-Object { $_.Name -ne "README.md" }
$ap = @"
## Autopreguntas de cierre
Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:
1. ¿Cuál es la pregunta senior que guía el diseño de workflows y estrategias de ramas?
2. ¿Cómo se elige la estrategia de ramificación más apropiada para un equipo?
3. ¿Qué componentes forman el flujo completo desde el issue hasta el despliegue?
4. ¿Cómo se mide la calidad del flujo y qué se hace para mejorarla?
5. ¿Por qué es importante incluir el plan de vuelta (rollback) en el diseño del flujo?
6. ¿Cómo se evita caer en errores comunes como elegir una estrategia sin base real?
"@
foreach ($chap in $chapFiles) {
    $content = Get-Content -Path $chap.FullName -Raw
    if ($content -notmatch '(?s)^\s*##\s*Autopreguntas de cierre\s*') {
        # Insert before ## Próximo paso
        if ($content -match '(?s)^\s*##\s*Próximo paso\s*') {
            $new = $content -replace '(^\s*##\s*Próximo paso\s*)', ($ap + "`n`n` + $1)
            Set-Content -Path $chap.FullName -Value $new -Encoding UTF8
        } else {
            # Append at end
            $new = $content + "`n`n" + $ap
            Set-Content -Path $chap.FullName -Value $new -Encoding UTF8
        }
    }
}