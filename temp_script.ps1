$filePath = "H:\git\repositorio de Git hub\github-paso-a-paso\11-git-deshacer-y-recuperar\README.md"
$lines = Get-Content -Path $filePath
$insertAt = 9
$conceptualMapLines = @(
    "",
    "## Mapa conceptual de este capítulo",
    "```mermaid",
    "mindmap",
    "  root((11 - Git: deshacer y recuperar))",
    "    Restaurar y descartar cambios",
    "      Working directory",
    "      Index",
    "      git restore",
    "    Deshacer commits compartidos",
    "      git revert",
    "      Shared history",
    "    Mover rama y reset",
    "      git reset",
    "      Reflog",
    "      Reset limits",
    "    Tres modos de reset",
    "      --soft",
    "      --mixed",
    "      --hard",
    "      When to use each",
    "    Git stash",
    "      Stack",
    "      Apply/pop",
    "      Options",
    "      Rescue",
    "```"
)
$top = $lines[0..($insertAt-2)]
$bottom = $lines[($insertAt-1)..$lines.Length-1]
$newContent = $top + $conceptualMapLines + $bottom
Set-Content -Path $filePath -Value $newContent -Encoding UTF8
