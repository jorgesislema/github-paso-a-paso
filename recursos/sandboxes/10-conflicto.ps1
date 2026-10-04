param([string]$Destino = ".\sandbox-10")

if (Test-Path -LiteralPath $Destino) {
    Write-Host "Borrando sandbox previo: $Destino"
    Remove-Item -Recurse -Force -LiteralPath $Destino
}
New-Item -ItemType Directory -Force -Path $Destino | Out-Null
Set-Location $Destino

git init | Out-Null
git branch -M main
git config user.name "Sandbox"
git config user.email "sandbox@curso.local"

Set-Content -Path "datos.txt" -Value "linea: version base"
git add datos.txt
git commit -m "Agrega datos base" | Out-Null

git switch -c feature/cambio 2>&1 | Out-Null
Set-Content -Path "datos.txt" -Value "linea: version feature"
git add datos.txt
git commit -m "Cambia la linea desde feature" | Out-Null

git switch main 2>&1 | Out-Null
Set-Content -Path "datos.txt" -Value "linea: version principal"
git add datos.txt
git commit -m "Cambia la linea desde main" | Out-Null

git switch feature/cambio 2>&1 | Out-Null

Set-Location ..
Write-Host ""
Write-Host "Sandbox 10 listo en: $Destino (estás en feature/cambio)"
Write-Host "Genera el conflicto:  git merge main"
