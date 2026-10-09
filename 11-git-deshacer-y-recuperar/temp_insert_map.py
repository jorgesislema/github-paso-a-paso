content = ''' + # 11 — Git: deshacer y recuperar

## Bienvenido a esta sección

Git es un sistema de control de versiones: casi nada se pierde del todo. Esta sección enseña a corregir en cada nivel — archivo sin commitear, commit local, commit compartido — y a guardar trabajo a medias con `stash`.

Cada herramienta tiene su ámbito: usar mal `reset` donde toca `revert` (o al revés) es uno de los errores más costosos. Aquí aprendes a elegir con criterio.

## En esta sección estudiarás

* restaurar contenido entre las áreas de Git sin tocar historial (`git restore`);
* deshacer commits compartidos añadiendo cambios nuevos (`git revert`);
* mover el apuntador de la rama con `git reset` y sus tres modos;
* la diferencia profunda entre `--soft`, `--mixed` y `--hard`;
* guardar y recuperar trabajo temporal con `git stash`;
* el reflog como red de seguridad de todas las operaciones locales.

## Objetivos de aprendizaje

Al terminar esta sección serás capaz de:

* elegir la herramienta según el nivel: `restore` (archivos), `revert` (historial compartido), `reset` (historial local);
* explicar la diferencia entre `--soft`, `--mixed` y `--hard`;
* deshacer un commit compartido con `revert` sin reescribir el historial;
* guardar y recuperar trabajo a medias con `git stash`;
* localizar commits «perdidos» con `git reflog`.

---

## ¿Qué aprenderás en esta sección?

1. [`01-git-restore.md`](01-git-restore.md) — restaurar y descartar cambios en working directory e índice.
2. [`02-git-revert.md`](02-git-revert.md) — deshacer commits con seguridad cuando el historial es compartido.
3. [`03-git-reset.md`](03-git-reset.md) — mover la rama, el reflog y los límites del reset.
4. [`04-soft-mixed-hard.md`](04-soft-mixed-hard.md) — los tres modos en profundidad, cuándo usar cada uno.
5. [`05-git-stash.md`](05-git-stash.md) — guardar trabajo a medias: pila, apply/pop, opciones y rescate.

## Cómo estudiar esta sección

Primero el terreno común (01: las áreas de Git y `restore`), luego la corrección de historial en sus dos filosofías (02 revert para compartir, 03-04 reset para local), y cierra con 05 (`stash`) como herramienta de diario. Practica cada comando en un repositorio de prueba antes de usarlo en uno real — el sandbox de la sección ([`recursos/sandboxes/11-reset.md`](../recursos/sandboxes/11-reset.md)) lo genera en segundos.

## Referencias

* Chacon, S. y Straub, B. — *Pro Git* (cap. 2: Undoing Things; cap. 3).
* Git — Documentación oficial: «git restore», «git reset», «git revert», «git reflog».
* Stack Overflow — pregunta canónica: «difference between git checkout, git restore, git reset and git revert».

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. Cometiste un error en una rama compartida: ¿qué comando usas y por qué no `reset`?
2. ¿Qué diferencia hay entre `reset --hard` y `restore`?
3. Tienes trabajo a medias y necesitas cambiar de rama: ¿qué haces?
4. «Perdiste» un commit con un reset: ¿dónde está y cómo lo recuperas?

---

## Próximo paso

Cuando termines los cinco capítulos, continúa con la siguiente sección:

[`../12-git-avanzado/`](../12-git-avanzado/)

TEST LINE

TEST LINE FROM SCRIPT
 + '''
# Find where to insert: before "## En esta secci�n estudiar�s"
lines = content.split('\n')
insert_at = -1
for i, line in enumerate(lines):
    if "En esta secci" in line:
        insert_at = i
        break
if insert_at >= 0:
    # Build conceptual map
    conceptual_map_lines = [
        "",
        "## Mapa conceptual de este capítulo",
        "`mermaid",
        "mindmap",
        "  root((11 - Git: deshacer y recuperar))",
        "    Restaurar y descartar cambios",
        "      Working directory",
        "      Index",
        "      git restore",
        "    Deshacer commits compartidos",
        "      git revert",
        "      Shared history",
        "    Mover rama y reset",
        "      git reset",
        "      Reflog",
        "      Reset limits",
        "    Tres modos de reset",
        "      --soft",
        "      --mixed",
        "      --hard",
        "      When to use each",
        "    Git stash",
        "      Stack",
        "      Apply/pop",
        "      Options",
        "      Rescue",
        "`"
    ]
    # Insert the map
    top = lines[:insert_at]
    bottom = lines[insert_at:]
    new_lines = top + conceptual_map_lines + bottom
    new_content = '\n'.join(new_lines)
else:
    new_content = content
print(new_content, end='')
