param([string]$Destino = ".\sandbox-06")

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

Set-Content -Path "notas.txt" -Value "dia 1: aprendi status"
git add notas.txt
git commit -m "Agrega notas del dia 1" | Out-Null

Add-Content -Path "notas.txt" -Value "dia 2: aprendi add"
git add notas.txt
git commit -m "Agrega notas del dia 2" | Out-Null

# Estado de partida:
# - cambio SIN preparar
Add-Content -Path "notas.txt" -Value "dia 3: cambio sin preparar"
# - archivo NUEVO ya en staging
Set-Content -Path "borrador.txt" -Value "idea a commit"
git add borrador.txt

Set-Location ..
Write-Host ""
Write-Host "Sandbox 06 listo en: $Destino"
Write-Host "Practica: git status, git add, git diff, git commit, git log, git show"
