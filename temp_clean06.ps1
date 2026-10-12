$file = "H:\git\repositorio de Git hub\github-paso-a-paso\24-devsecops\06-programa-de-seguridad-y-metricas.md"
$content = Get-Content -Path $file -Raw
# Split by lines to process
$lines = $content -split "`n"
$inAuto = $false
$autoLines = @()
$newLines = @()
foreach ($line in $lines) {
    if ($line -match '^\s*##\s*Autopreguntas de cierre\s*') {
        if (-not $inAuto) {
            $inAuto = $true
            $autoLines = @($line)
        } else {
            # skip duplicate block
            continue
        }
    } elseif ($inAuto) {
        if ($line -match '^\s*##\s' -and $line -notmatch '^\s*##\s*Autopreguntas de cierre') {
            # end of auto block
            $inAuto = $false
            $newLines += $line
        } else {
            # still inside auto block, collect
            $autoLines += $line
        }
    } else {
        $newLines += $line
    }
}
# If we were inside auto block at end, append it
if ($inAuto) {
    $newLines += $autoLines
}
# Join back
$newContent = $newLines -join "`n"
Set-Content -Path $file -Value $newContent -Encoding UTF8