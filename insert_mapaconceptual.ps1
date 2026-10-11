 = Get-Content -Path 'H:\git\repositorio de Git hub\github-paso-a-paso\20-github-security\README.md'
 = ( | Select-String '^---$').LineNumber - 1
 = @()
for ( = 0;  -lt .Length; ++) {
     += []
    if ( -eq ) {
         += ''
         += '## Mapa conceptual'
         += ''
         += '`mermaid'
         += 'mindmap'
         += '  root((20 · GitHub Security))'
         += '    01 Secretos y credenciales'
         += '      concepto 1'
         += '      concepto 2'
         += '    02 Secret scanning y push protection'
         += '      concepto 1'
         += '      concepto 2'
         += '    03 Dependabot y dependencias'
         += '      concepto 1'
         += '      concepto 2'
         += '    04 Code scanning y CodeQL'
         += '      concepto 1'
         += '      concepto 2'
         += '    05 Cadena de suministro y SBOM'
         += '      concepto 1'
         += '      concepto 2'
         += '    06 Permisos, accesos y protección de ramas'
         += '      concepto 1'
         += '      concepto 2'
         += '    07 Seguridad de GitHub Actions'
         += '      concepto 1'
         += '      concepto 2'
         += '`'
    }
}
Set-Content -Path 'H:\git\repositorio de Git hub\github-paso-a-paso\20-github-security\README.md' -Value 
