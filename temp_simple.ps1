param([string]$filePath)

# Read the file
$lines = Get-Content $filePath

# Helper function to find line index of a pattern (starting with)
function Find-LineStart {
    param([string[]]$content, [string]$pattern)
    for ($i = 0; $i -lt $content.Length; $i++) {
        if ($content[$i].TrimStart().StartsWith($pattern)) {
            return $i
        }
    }
    return -1
}

# Helper function to find the next level 2 header after a given index
function Find-NextLevel2Header {
    param([string[]]$content, [int]$startIndex)
    for ($i = $startIndex + 1; $i -lt $content.Length; $i++) {
        if ($content[$i].TrimStart().StartsWith('## ')) {
            return $i
        }
    }
    return $content.Length
}

# Step 1: Autopreguntas de cierre
$autoevalIndex = Find-LineStart $lines "## Autoevaluación"
if ($autoevalIndex -lt 0) {
    $autoevalIndex = Find-LineStart $lines "## Autopreguntas de cierre"
}
$questionsCount = 0
if ($autoevalIndex -ge 0) {
    # Count the number of questions in this section (until next level 2 header)
    $sectionEndIndex = Find-NextLevel2Header $lines $autoevalIndex
    $questionLines = $lines[$autoevalIndex+1..($sectionEndIndex-1)]
    foreach ($line in $questionLines) {
        if ($line -match '^\s*\d+\.|^\s*[-*]\s+') {
            $questionsCount++
        }
    }
}
if ($questionsCount -ge 5) {
    # Rename the section to ## Autopreguntas de cierre
    if ($lines[$autoevalIndex] -eq '## Autoevaluación') {
        $lines[$autoevalIndex] = '## Autopreguntas de cierre'
    }
} else {
    # We need to add or replace the section
    # Look for "## Próximo paso" to insert before it
    $nextStepIndex = Find-LineStart $lines "## Próximo paso"
    $insertIndex = $nextStepIndex
    if ($insertIndex -lt 0) {
        $insertIndex = $lines.Length
    }
    
    # Remove the existing autoevaluation section if it exists (and has <5 questions)
    if ($autoevalIndex -ge 0) {
        $sectionEndIndex = Find-NextLevel2Header $lines $autoevalIndex
        # Remove from $autoevalIndex to $sectionEndIndex-1
        $lines = $lines[0..($autoevalIndex-1)] + $lines[$sectionEndIndex..($lines.Length-1)]
        # Adjust insertIndex if we removed something before it
        if ($autoevalIndex -lt $insertIndex) {
            $insertIndex -= ($sectionEndIndex - $autoevalIndex)
        }
    }
    
    # Generate 5-8 questions based on sections
    $sections = @()
    for ($i = 0; $i -lt $lines.Length; $i++) {
        if ($lines[$i].TrimStart().StartsWith('## ')) {
            $sectionText = $lines[$i].TrimStart('## ').Trim()
            $sections += $sectionText
        }
    }
    
    $questions = @()
    if ($sections.Count -ge 2) {
        for ($j = 0; $j -lt 8; $j++) {
            $idx1 = $j % $sections.Count
            $idx2 = ($j+1) % $sections.Count
            switch ($j) {
                0 { $q = "¿Cómo explicarías con tus propias palabras el concepto de $($sections[$idx1])?" }
                1 { $q = "¿Cuál es la relación entre $($sections[$idx1]) y $($sections[$idx2])?" }
                2 { $q = "¿Qué pasos seguirías para aplicar $($sections[$idx1]) en un escenario real?" }
                3 { $q = "¿Qué errores comunes debes evitar al trabajar con $($sections[$idx1])?" }
                4 { $q = "¿Cómo medirías el éxito al implementar $($sections[$idx1])?" }
                5 { $q = "¿Qué herramientas o comandos mencionados en el capítulo son esenciales para $($sections[$idx1])?" }
                6 { $q = "¿Cómo adaptarías el proceso descrito en $($sections[$idx1]) si tuvieran que trabajar en un entorno distribuido?" }
                7 { $q = "¿Qué principio subyace detrás de la recomendación de $($sections[$idx1])?" }
            }
            $questions += $q
        }
    } else {
        # Fallback generic questions
        $questions = @(
            "¿Cuál es el objetivo principal de este capítulo?",
            "¿Qué concepto te resultó más desafiante y por qué?",
            "¿Cómo aplicarías lo aprendido en un proyecto real?",
            "¿Qué errores comunes debes evitar al usar estas técnicas?",
            "¿Cómo te ayudaría este conocimiento en tu desarrollo profesional?",
            "¿Qué relación existe entre este capítulo y los capítulos anteriores?",
            "¿Qué recurso adicional te gustaría explorar para profundizar en este tema?",
            "¿Cómo explicarías este tema a un compañero que no lo conoce?"
        )
    }
    # Take 5 to 8 questions
    if ($questions.Count -gt 8) {
        $questions = $questions[0..7]
    }
    if ($questions.Count -lt 5) {
        $questions = $questions[0..4]
    }
    
    # Insert the new section
    $newLines = @()
    $newLines += $lines[0..$insertIndex]
    $newLines += "## Autopreguntas de cierre"
    foreach ($q in $questions) {
        $newLines += "1. $q"
    }
    $newLines += $lines[$insertIndex..($lines.Length-1)]
    $lines = $newLines
}

# Step 2: Riesgo en comandos destructivos
# We'll traverse the lines and look for ```bash blocks that contain destructive commands
$destructivePatterns = @(
    'git reset --hard',
    'git push --force',
    'git push -f',
    'git branch -D',
    'git clean -fd',
    'git stash drop',
    'git stash clear',
    'git filter-repo',
    'rm -rf'
)
$i = 0
while ($i -lt $lines.Length) {
    if ($lines[$i].TrimStart() -eq '```bash') {
        # Find the end of the code block
        $codeEndIndex = -1
        for ($j = $i + 1; $j -lt $lines.Length; $j++) {
            if ($lines[$j].TrimStart() -eq '```') {
                $codeEndIndex = $j
                break
            }
        }
        if ($codeEndIndex -ge 0) {
            # Check the content for destructive commands
            $codeContent = $lines[$($i+1)..($codeEndIndex-1)] -join "`n"
            $isDestructive = $false
            $matchedPattern = $null
            foreach ($pattern in $destructivePatterns) {
                if ($codeContent -like "*$pattern*") {
                    $isDestructive = $true
                    $matchedPattern = $pattern
                    break
                }
            }
            if ($isDestructive) {
                # Determine the risk message
                $riskMessage = ""
                switch ($matchedPattern) {
                    'git reset --hard' {
                        $riskMessage = "Se pierde todo el trabajo no commitado desde el último commit. No es recuperable si no se tiene un respaldo."
                    }
                    'git push --force' {
                        $riskMessage = "Se sobrescribe el historial remoto, lo que puede causar la pérdida de commits de otros colaboradores. Solo es recuperable si el repositorio remoto tiene una copia de seguridad o si se tiene el historial local."
                    }
                    'git push -f' {
                        $riskMessage = "Se sobrescribe el historial remoto, lo que puede causar la pérdida de commits de otros colaboradores. Solo es recuperable si el repositorio remoto tiene una copia de seguridad o si se tiene el historial local."
                    }
                    'git branch -D' {
                        $riskMessage = "Se elimina definitivamente la rama local. No es recuperable a menos que se tenga el hash del último commit de la rama (mediante reflog) o una copia de seguridad."
                    }
                    'git clean -fd' {
                        $riskMessage = "Se eliminan permanentemente los archivos no rastreados y los directorios. No es recuperable sin un respaldo."
                    }
                    'git stash drop' {
                        $riskMessage = "Se elimina el stash especificado. No es recuperable a menos que se haya anotado el hash antes de eliminarlo."
                    }
                    'git stash clear' {
                        $riskMessage = "Se elimina todos los stashes. No es recuperable a menos que se haya anotado el hash antes de eliminarlos."
                    }
                    'git filter-repo' {
                        $riskMessage = "Reescribe el historial del repositorio, lo que puede eliminar archivos o datos permanentemente. No es recuperable sin un respaldo del repositorio antes de la operación."
                    }
                    'rm -rf' {
                        $riskMessage = "Elimina archivos y directorios de forma permanente. No es recuperable sin un respaldo."
                    }
                }
                # Insert the warning line right before the ```bash line
                $lines = $lines[0..($i-1)] + @("⚠️ **RIESGO:** $riskMessage") + $lines[$i..($lines.Length-1)]
                # Adjust index because we inserted a line
                $i++
            }
        }
    }
    $i++
}

# Write the file
$outContent = $lines -join "`n"
Set-Content -Path $filePath -Value $outContent