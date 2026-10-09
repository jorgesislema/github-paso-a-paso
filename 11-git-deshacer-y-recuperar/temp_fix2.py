# Read the file with proper encoding
with open('H:\\git\\repositorio de Git hub\\github-paso-a-paso\\11-git-deshacer-y-recuperar\\README.md', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find where to insert the conceptual map: before "## En esta secci�n estudiar�s"
insert_at = -1
for i, line in enumerate(lines):
    if "En esta secci" in line:
        insert_at = i
        break

if insert_at >= 0:
    # Build the backticks string
    backtick3 = chr(96) * 3  # Three backticks
    
    # Build conceptual map lines with proper mermaid syntax
    conceptual_map_lines = [
        '\n',
        '## Mapa conceptual de este capítulo\n',
        backtick3 + 'mermaid\n',
        'mindmap\n',
        '  root((11 - Git: deshacer y recuperar))\n',
        '    Restaurar y descartar cambios\n',
        '      Working directory\n',
        '      Index\n',
        '      git restore\n',
        '    Deshacer commits compartidos\n',
        '      git revert\n',
        '      Shared history\n',
        '    Mover rama y reset\n',
        '      git reset\n',
        '      Reflog\n',
        '      Reset limits\n',
        '    Tres modos de reset\n',
        '      --soft\n',
        '      --mixed\n',
        '      --hard\n',
        '      When to use each\n',
        '    Git stash\n',
        '      Stack\n',
        '      Apply/pop\n',
        '      Options\n',
        '      Rescue\n',
        backtick3 + '\n'
    ]
    
    # Insert the map
    # But first, let's trim any extra blank lines at the end of the file
    # Find the last non-empty line
    last_non_empty = len(lines) - 1
    while last_non_empty >= 0 and lines[last_non_empty].strip() == '':
        last_non_empty -= 1
    
    # Keep everything up to and including the last non-empty line
    lines = lines[:last_non_empty+1]
    
    # Now insert the conceptual map
    result = lines[:insert_at] + conceptual_map_lines + lines[insert_at:]
    
    # Write back the file
    with open('H:\\git\\repositorio de Git hub\\github-paso-a-paso\\11-git-deshacer-y-recuperar\\README.md', 'w', encoding='utf-8') as f:
        f.writelines(result)
