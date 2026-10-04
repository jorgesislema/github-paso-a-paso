# 08 — Ramas: crear, moverse y fusionar

Sandbox para la sección 08 (`08-git-ramas`): un historial con dos líneas de
trabajo que están a punto de encontrarse.

## Uso

```powershell
.\recursos\sandboxes\08-ramas.ps1
```

Crea `sandbox-08` (configurable con `-Destino`). Se regenera desde cero: es
destruible a propósito.

## Qué encontrarás

* rama `main` con 3 commits;
* rama `feature/resumen` creada desde el commit 2, con 2 commits propios;
* estás parado en `main` (el punto de partida del ejercicio de merge).

Práctica sugerida: `git branch -a`, `git switch`, `git log --oneline --all`,
`git merge` desde main hacia la feature (y luego el camino de vuelta), y
`git branch -d` al terminar.

## Limpieza

```powershell
Remove-Item -Recurse -Force .\sandbox-08
```
