$files = @('README.md','01-github-flow-y-feature-branching.md','02-git-flow.md','03-trunk-based-development.md','04-flujo-de-ramas-y-sincronizacion.md','05-versionado-semantico-y-release-branches.md','06-comparativa-y-cuando-elegir.md')
foreach ($f in $files) {
    $content = Get-Content $f -Raw
    $mermaid = ([regex]::Matches($content, '```mermaid')).Count
    $autopreg = ([regex]::Matches($content, '## Autopreguntas de cierre')).Count
    $riesgo = ([regex]::Matches($content, '?? \*\*RIESGO:\*\*')).Count
    $transfer = ([regex]::Matches($content, '### Ejercicio de transferencia')).Count
    $checkpoint = 0
    if ($f -eq 'README.md') {
        $checkpoint = ([regex]::Matches($content, '## Checkpoint')).Count
    }
    $lines = ($content -split "`n").Length
    $maptext = 0
    $matches = [regex]::Matches($content, '```text.*?```', 'Singleline')
    foreach ($m in $matches) {
        if ($m.Value -match 'Mapa conceptual') { $maptext++ }
    }
    [pscustomobject]@{
        File=$f
        Mermaid=$mermaid
        Autopreg=$autopreg
        Riesgo=$riesgo
        Transfer=$transfer
        Checkpoint=$checkpoint
        Lines=$lines
        Maptext=$maptext
    }
}
