# 11 — Deshacer y recuperar

Sandbox para la sección 11 (`11-git-deshacer-y-recuperar`): un historial corto
para practicar `restore`, `revert`, `reset` y `reflog` sin miedo.

## Uso

```powershell
.\recursos\sandboxes\11-reset.ps1
```

Crea `sandbox-11` (configurable con `-Destino`).

## Qué encontrarás

* `main` con 5 commits pequeños (un «capítulo» cada uno en `historia.txt`);
* un archivo modificado sin commitear, para practicar `git restore`;
* el reflog ya contiene material suficiente para practicar `git reflog` y la
  recuperación de commits «perdidos».

Práctica sugerida (todas reversibles — y si algo se rompe, `git reflog` te
salva; o regeneras el sandbox):

1. `git restore` el archivo modificado (¿y con `--staged`?).
2. `git reset --mixed HEAD~1` / `--soft` / `--hard`: compara los tres estados
   con `git status` después de cada uno.
3. «Pierde» el último commit con `--hard` y recuéralo desde el reflog.
4. `git revert` sobre un commit del medio y lee el historial resultante.

## Limpieza

```powershell
Remove-Item -Recurse -Force .\sandbox-11
```
