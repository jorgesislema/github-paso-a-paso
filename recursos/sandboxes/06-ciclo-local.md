# 06 — Ciclo local (status → add → commit → log/diff)

Sandbox para la sección 06 (`06-git-desde-cero`): deja un repositorio en el
estado exacto donde empieza la práctica del ciclo local.

## Uso

```powershell
# desde la raíz del curso (o cualquier carpeta):
.\recursos\sandboxes\06-ciclo-local.ps1
```

Crea la carpeta `sandbox-06` junto a donde se ejecuta (puedes cambiarla con
`-Destino "otra\carpeta"`). Si ya existe, se borra y se recrea: **no hay nada
valioso que perder**.

## Qué encontrarás

* un repositorio `main` con dos commits de historial;
* un cambio SIN preparar (archivo modificado sin `git add`);
* un archivo NUEVO ya preparado (en staging, esperando commit).

Con ese estado puedes practicar: `git status`, `git add`, `git diff`,
`git diff --staged`, `git commit`, `git log`, `git show` — y repetir todo
cuantas veces quieras, porque el sandbox se puede regenerar.

## Limpieza

```powershell
Remove-Item -Recurse -Force .\sandbox-06
```
