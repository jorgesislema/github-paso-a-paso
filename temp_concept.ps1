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

# Step: Conceptual map - replace ```text block with mermaid mindmap if exists
$conceptIndex = Find-LineStart $lines "## Mapa conceptual de este capítulo"
if ($conceptIndex -ge 0) {
    # Find the ```text block after this header
    $codeStartIndex = -1
    for ($i = $conceptIndex + 1; $i -lt $lines.Length; $i++) {
        if ($lines[$i].TrimStart() -eq '```text') {
            $codeStartIndex = $i
            break
        }
    }
    if ($codeStartIndex -ge 0) {
        # Find the end of the code block
        $codeEndIndex = -1
        for ($i = $codeStartIndex + 1; $i -lt $lines.Length; $i++) {
            if ($lines[$i].TrimStart() -eq '```') {
                $codeEndIndex = $i
                break
            }
        }
        if ($codeEndIndex -ge 0) {
            # Extract the ASCII tree content (between the code fences)
            $asciiLines = @()
            for ($i = $codeStartIndex + 1; $i -lt $codeEndIndex; $i++) {
                $asciiLines += $lines[$i]
            }
            $asciiContent = $asciiLines -join "`n"
            
            # Get the chapter title: first level 1 header or filename
            $chapterTitle = ""
            $h1Index = Find-LineStart $lines "# "
            if ($h1Index -ge 0) {
                $chapterTitle = $lines[$h1Index].TrimStart('# ').Trim()
            } else {
                # Use filename without extension
                $chapterTitle = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
            }
            
            # Get all level 2 headers
            $sections = @()
            for ($i = 0; $i -lt $lines.Length; $i++) {
                if ($lines[$i].TrimStart().StartsWith('## ')) {
                    $sectionText = $lines[$i].TrimStart('## ').Trim()
                    $sections += $sectionText
                }
            }
            
            # Build mermaid mindmap
            $mermaidLines = @()
            $mermaidLines += "```mermaid"
            $mermaidLines += "mindmap"
            $mermaidLines += "  root(($chapterTitle))"
            foreach ($section in $sections) {
                $mermaidLines += "    $section"
            }
            $mermaidLines += "```"
            
            # Replace the ```text ... ``` block with the mermaid block
            $newLines = @()
            $newLines += $lines[0..$codeStartIndex]
            $newLines += $mermaidLines
            $newLines += $lines[$codeEndIndex..($lines.Length-1)]
            $lines = $newLines
        }
    }
}

# Write the file
$outContent = $lines -join "`n"
Set-Content -Path $filePath -Value $outContent