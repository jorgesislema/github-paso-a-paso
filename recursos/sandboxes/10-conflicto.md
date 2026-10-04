# 10 — Conflicto listo para resolver

Sandbox para la sección 10 (`10-git-conflictos`): un conflicto real y seguro,
generado a propósito, esperando que lo resuelvas.

## Uso

```powershell
.\recursos\sandboxes\10-conflicto.ps1
```

Crea `sandbox-10` (configurable con `-Destino`).

## Qué encontrarás

* `main` y `feature/cambio` divergieron editando la **misma línea** de
  `datos.txt`;
* estás en `feature/cambio`, con su commit hecho;
* te falta ejecutar el merge: `git merge main`.

Cuando el conflicto aparezca, practica la secuencia completa: leer los
marcadores, decidir, limpiar, `git add`, `git commit`, y verificar con
`git log --oneline` que el merge quedó.

## Limpieza

```powershell
Remove-Item -Recurse -Force .\sandbox-10
```
