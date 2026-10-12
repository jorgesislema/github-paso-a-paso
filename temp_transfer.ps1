param([string]$filePath)

# Read the file
$lines = Get-Content $filePath

# Helper function to find line index of a line that contains a pattern (case insensitive) and starts with '## '
function Find-SectionHeader {
    param([string[]]$content, [string]$pattern)
    for ($i = 0; $i -lt $content.Length; $i++) {
        $trimmed = $content[$i].TrimStart()
        if ($trimmed.StartsWith('## ') -and $trimmed.ToLower().Contains($pattern.ToLower())) {
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

# Find the practice section: either containing "práctica guiada" or "resultado esperado"
$practiceIndex = Find-SectionHeader $lines "práctica guiada"
if ($practiceIndex -lt 0) {
    $practiceIndex = Find-SectionHeader $lines "resultado esperado"
}
if ($practiceIndex -ge 0) {
    # Find the end of the practice section (next level 2 header or end of file)
    $practiceEndIndex = Find-NextLevel2Header $lines $practiceIndex
    
    # Create the transfer exercise lines
    $transferLines = @()
    $transferLines += "### Ejercicio de transferencia"
    $transferLines += "Aplica lo aprendido en este capítulo a un proyecto personal de tu elección. Por ejemplo, si el capítulo trata sobre ramas en Git, crea una nueva rama para una característica que hayas estado pensando y haz un commit inicial. Entregable: captura de pantalla del comando `git branch` mostrando tu nueva rama."
    
    # Insert after the practice section
    $newLines = @()
    $newLines += $lines[0..$practiceEndIndex]
    $newLines += $transferLines
    $newLines += $lines[$practiceEndIndex..($lines.Length-1)]
    $lines = $newLines
}

# Write the file
$outContent = $lines -join "`n"
Set-Content -Path $filePath -Value $outContent