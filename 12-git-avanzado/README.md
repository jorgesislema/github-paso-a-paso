# 12 — Git avanzado

## Bienvenido a esta sección

Con los fundamentos consolidados, esta sección reúne las herramientas que Git reserva para situaciones reales de mantenimiento: cambiar historia con criterio, portar cambios, fijar versiones, localizar culpables, interrogar registros, ampliar tu espacio de trabajo, conectar repositorios y automatizar reglas.

Son herramientas de precisión: cada una ahorra horas cuando se usa en su sitio — y causa problemas cuando se aplica sin su modelo mental. Por eso cada capítulo empieza por el «por qué».

## En esta sección estudiarás

* cuándo y cómo reescribir historial (amend, reset, rebase, filtrado);
* el rebase interactivo como plan de limpieza de series;
* cherry-pick para portar commits concretos con `-x`;
* tags, etiquetas anotadas y convenciones de versionado (SemVer);
* bisect para encontrar el commit culpable (manual y automático);
* blame y log avanzado para investigar el «quién y qué»;
* worktree para varias ramas vivas sin duplicar clon;
* submódulos: modelo, flujo y alternativas;
* hooks: validación automática en cliente y servidor.

## Objetivos de aprendizaje

Al terminar esta sección serás capaz de:

* reescribir historial local con criterio (`amend`, rebase interactivo) y conocer el límite de lo compartido;
* portar commits concretos con `git cherry-pick -x`;
* crear tags anotadas y aplicar versionado SemVer;
* localizar el commit culpable de un fallo con `git bisect` (manual y automático);
* investigar el «quién y qué» con `git blame` y `git log` avanzado;
* explicar cuándo conviene `worktree`, submódulos y hooks.

## Mapa conceptual

```mermaid
mindmap
  root((12 · Git avanzado))
    01 Reescritura del historial
      amend
      reset
      rebase
      filtrado
    02 Rebase interactivo
      plan de limpieza
      pick
      fixup
    03 Cherry-pick
      cherry-pick
      -x
      portar commits
    04 Tags y versionado
      tags anotadas
      SemVer
      convenciones de versionado
    05 Git bisect
      bisect manual
      bisect automático
      búsqueda binaria
    06 Blame y log avanzado
      blame
      log avanzado
      quién y qué
    07 Git worktree
      worktree
      varias ramas
      sin clon duplicado
    08 Git submodules
      submódulos
      modelo
      flujo
      alternativas
    09 Git hooks
      hooks
      validación automática
      cliente
      servidor

## Checkpoint 12 — Comprobación obligatoria

Antes de avanzar a `<siguiente bloque>/`, demuestra que puedes (en un repositorio de práctica real):

1. **Utilizar** `git commit --amend` para modificar el último commit manteniendo los cambios preparados.
2. **Ejecutar** `git rebase -i HEAD~3` para reordenar, combinar o editar los últimos tres commits.
3. **Crear** una tag anotada con `git tag -a v1.0.0 -m "Versión 1.0.0"` y empujarla con `git push origin v1.0.0`.
4. **Ejecutar** `git bisect start` para comenzar una búsqueda binaria y localizar un commit que introdujo un error.
5. **Utilizar** `git worktree add ../hotfix develop` para crear un nuevo árbol de trabajo vinculado a la rama develop.
6. **Configurar** un hook de pre-commit que ejecute `npm test` antes de cada commit.

Si puedes hacerlo **sin mirar instrucciones**, el checkpoint está cerrado.

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. ¿Cuándo es aceptable reescribir un commit con `amend` y cuándo está prohibido?
2. Un fallo existe en v2.3 y no en v2.2: ¿cómo localizas el commit culpable sin leer 200 commits?
3. ¿Qué añade `cherry-pick -x` respecto a un cherry-pick normal?
4. ¿Qué diferencia hay entre una tag liviana y una anotada?
5. ¿Por qué es peligroso usar `git reset --hard` en una rama que ya se ha compartido con otros, y cómo puedes recuperarte si lo haces por accidente?
6. ¿En qué situaciones preferirías usar `git worktree` en lugar de crear una nueva rama o hacer stash de tus cambios?

## ¿Qué aprenderás en esta sección?

1. [`01-reescritura-del-historial.md`](01-reescritura-del-historial.md) — la regla local/compartido, amend, reset y filtrado.
2. [`02-rebase-interactivo.md`](02-rebase-interactivo.md) — planes de historia: pick, fixup, edit, exec y autosquash.
3. [`03-cherry-pick.md`](03-cherry-pick.md) — portar commits entre ramas y releases con `-x`.
4. [`04-tags-y-versionado.md`](04-tags-y-versionado.md) — tags anotados, SemVer e inmutabilidad.
5. [`05-git-bisect.md`](05-git-bisect.md) — búsqueda binaria del culpable con script `--run`.
6. [`06-git-blame-y-log-avanzado.md`](06-git-blame-y-log-avanzado.md) — log con filtros, blame con -L/-C/-w, show.
7. [`07-git-worktree.md`](07-git-worktree.md) — varias carpetas sobre un mismo repositorio.
8. [`08-git-submodules.md`](08-git-submodules.md) — gitlink, flujos y alternativas.
9. [`09-git-hooks.md`](09-git-hooks.md) — pre-commit, commit-msg, pre-push y distribución.

## Cómo estudiar esta sección

Practica cada herramienta en tu repositorio de laboratorio antes de tocar uno real. Los capítulos 01-02 y 04-05 se repiten con frecuencia en el día a día; 08-09 requieren contexto de equipo. Si algo sale mal, el reflog y la sección 11 son tu red de seguridad.

## Referencias

* Chacon, S. y Straub, B. — *Pro Git* (cap. 4: Git Tools).
* Semantic Versioning (semver.org).
* Git — Documentación oficial: «git bisect», «git blame», «git worktree», «git submodule».

## Próximo paso

Cuando termines los nueve capítulos, continúa con la siguiente sección:

[`../13-configuracion-e-ignorados/`](../13-configuracion-e-ignorados/)
