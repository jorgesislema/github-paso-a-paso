# Sandboxes de práctica

Entornos de práctica controlados: cada script genera, en segundos, un
repositorio con el estado exacto donde empieza la práctica de una sección.
Sirven para repetir la práctica las veces que haga falta — el sandbox se
genera, se destruye y se regenera sin consecuencia.

## Qué hay

| Sandbox | Sección | Estado que genera |
|---|---|---|
| [`06-ciclo-local`](06-ciclo-local.md) | 06 — Git desde cero | 2 commits + cambio sin preparar + archivo en staging |
| [`08-ramas`](08-ramas.md) | 08 — Ramas | `main` y `feature/resumen` divergentes, listas para fusionar |
| [`10-conflicto`](10-conflicto.md) | 10 — Conflictos | un conflicto real en `datos.txt` esperando su merge |
| [`11-reset`](11-reset.md) | 11 — Deshacer y recuperar | 5 commits + cambio suelto para practicar restore/reset/reflog |

## Uso

```powershell
# desde la raíz del curso:
.\recursos\sandboxes\06-ciclo-local.ps1
# → crea .\sandbox-06 y te deja listo para practicar

# en otra carpeta:
.\recursos\sandboxes\06-ciclo-local.ps1 -Destino "C:\practica\mi-sandbox"
```

Requisitos: Git instalado y en el PATH; PowerShell (Windows) o pwsh.

## Reglas

* **Destruible a propósito:** cada script borra su carpeta si existe. Nunca
  crees un sandbox dentro de un proyecto real.
* **Regenerable:** la práctica nunca «queda rota» — si algo sale mal,
  ejecutas el script otra vez.
* **Sin red:** los sandboxes no pushan nada a ningún remoto; todo es local.

## Limpieza

```powershell
Remove-Item -Recurse -Force .\sandbox-06, .\sandbox-08, .\sandbox-10, .\sandbox-11
```
