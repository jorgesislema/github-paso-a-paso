param([string]$Destino = ".\sandbox-08")

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

Set-Content -Path "leer.txt" -Value "capitulo 1"
git add leer.txt
git commit -m "Agrega capitulo 1" | Out-Null

Add-Content -Path "leer.txt" -Value "capitulo 2"
git add leer.txt
git commit -m "Agrega capitulo 2" | Out-Null

# feature desde el commit 2
git switch -c feature/resumen 2>&1 | Out-Null
Add-Content -Path "resumen.md" -Value "resumen del capitulo 1"
git add resumen.md
git commit -m "Agrega resumen del capitulo 1" | Out-Null
Add-Content -Path "resumen.md" -Value "resumen del capitulo 2"
git add resumen.md
git commit -m "Agrega resumen del capitulo 2" | Out-Null

# main avanza por su cuenta
git switch main 2>&1 | Out-Null
Add-Content -Path "leer.txt" -Value "capitulo 3"
git add leer.txt
git commit -m "Agrega capitulo 3" | Out-Null

Set-Location ..
Write-Host ""
Write-Host "Sandbox 08 listo en: $Destino (estás en main)"
Write-Host "Practica: git branch -a, git switch, git log --oneline --all, git merge, git branch -d"
