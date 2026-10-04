param([string]$Destino = ".\sandbox-11")

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

$capitulos = @("comienzo", "la base", "la primera rama", "el primer merge", "la revision final")
for ($i = 0; $i -lt $capitulos.Count; $i++) {
    Add-Content -Path "historia.txt" -Value "capitulo $($i + 1): $($capitulos[$i])"
    git add historia.txt
    git commit -m "Agrega capitulo $($i + 1): $($capitulos[$i])" | Out-Null
}

# material sin commitear para practicar restore
Add-Content -Path "historia.txt" -Value "cambio sin commitear (para restore)"

Set-Location ..
Write-Host ""
Write-Host "Sandbox 11 listo en: $Destino"
Write-Host "Practica: git restore, git reset --soft/--mixed/--hard, git reflog, git revert"
