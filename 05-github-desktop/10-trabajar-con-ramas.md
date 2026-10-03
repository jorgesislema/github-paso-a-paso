# Trabajar con ramas

## Introducción

Hasta ahora has trabajado en una sola línea: `main`. Cada commit iba detrás del anterior y el proyecto crecía en línea recta. Pero el desarrollo real es simultáneo: mientras alguien corrige un error, otro desarrolla una función nueva, y otro prepara la próxima versión. Si todos escribieran en la misma línea, se estorbarían constantemente.

La **rama** es la solución: una línea de desarrollo paralela que nace de `main`, vive su propia historia y se reincorpora cuando está lista. Trabajar con ramas es el hábito profesional fundamental: te permite probar, desarrollar y equivocarte sin tocar la línea principal.

En este capítulo aprenderás:

* qué es una rama y cómo se relaciona con `main`;
* cómo crear y cambiar de rama en GitHub Desktop;
* cómo llevar trabajo a una rama (commits en rama);
* cómo publicar la rama con push;
* cómo volver a `main` y mantener las ramas ordenadas;
* errores comunes, práctica guiada y nivel profesional (ramas efímeras, naming, flujo de trabajo).

---

## Mapa conceptual de este capítulo

```text
Trabajar con ramas
       │
       ├── 1. Qué es una rama
   │        ├── Definición (puntero)
   │        ├── main
   │        └── Por qué existen las ramas
   │
       ├── 2. Crear una rama (Desktop)
   │
       ├── 3. Cambiar de rama
   │        ├── Qué se lleva y qué se deja
   │        └── Estado limpio antes de cambiar
   │
       ├── 4. Trabajar en la rama
   │        ├── Commits en rama
   │        └── Push de la rama
   │
       ├── 5. Volver a main y ponerse al día
   │
       ├── 6. Ciclo completo de una rama
   │
       ├── 7. Errores comunes con diagnóstico completo
   │
       ├── 8. Práctica guiada
   │
       ├── 9. Nivel profesional
   │        ├── Ramas efímeras
   │        ├── Convenciones de nombres
   │        └── Hacia el Pull Request
   │
       └── 10. Resumen y siguiente paso
```

---

## 1. Qué es una rama

### 1.1. Definición (sin misterio)

Una rama es, en lo esencial, un **puntero con nombre que señala a un commit**. Al crear una rama, solo se crea el puntero; no se copia nada.

```text
Sin ramas (una sola línea):
   A ── B ── C ── D          (main apunta a D)

Al crear "feature" en D:
   A ── B ── C ── D
                      ╲
                       ● feature (puntero nuevo, apunta a D)
                      ╱
                    main (apunta a D)

No hay copia de archivos: hay DOS nombres apuntando
al mismo sitio. Al commitear en feature:
   A ── B ── C ── D ── E     (feature → E; main sigue en D)
```

### 1.2. main

```text
main
   │
   ├── la rama principal, estable, la que «es» el proyecto
   ├── normalmente la rama por defecto al clonar
   ├── en flujos con protección: no se escribe directo
   └── representa el estado oficial/terminado
```

### 1.3. Por qué existen las ramas

```text
Motivos
──────────────────────────────────────────────
1. AISLAMIENTO
   desarrollar sin romper main

2. SIMULTANEIDAD
   varios frentes de trabajo a la vez

3. REVISIÓN
   la rama se propone como Pull Request

4. ORDEN
   cada tema en su historia (error, feature, release)

5. SEGURIDAD
   si la rama sale mal, se descarta sin tocar main
```

### 1.4. Anatomía de un flujo con ramas

```text
main:     A ── B ── C ──────────────── M ── (futuro)
                      ╲              ╱
feature:               D ── E ── F ──

   · D nace de C
   · la rama crece con sus commits
   · M = fusión (merge) de feature en main
     (la sección 08 enseña a fusionar)
```

---

## 2. Crear una rama (Desktop)

### 2.1. Dónde

```text
GitHub Desktop
   │
   ├── menú lateral de rama (donde dice "Current branch:
   │   main" → clic → "New branch...")
   │
   └── menú: Branch → New branch...
```

### 2.2. El diálogo

```text
New branch
──────────────────────────────────────────────
Name: [ feature/saludo          ]

[ Create ]

   · nace en el commit actual de tu rama
   · y GitHub Desktop la deja ACTIVA automáticamente
```

### 2.3. Nombre de la rama

```text
Convenciones conocidas (elige con tu equipo)
──────────────────────────────────────────────
feature/login          · nueva función
fix/error-fechas       · corrección
docs/capitulo-5        · documentación
chore/actualizar-deps  · mantenimiento

Reglas prácticas:
   · en minúsculas y guiones (sin espacios)
   · descriptiva del propósito
   · corta
   · a veces con prefijo de tipo (feature:, fix:...)
```

> **Consejo:** el nombre de la rama se ve en GitHub y en los Pull Requests; es el título de tu trabajo. Que diga algo.

---

## 3. Cambiar de rama

### 3.1. Cómo

```text
Cambiar de rama en Desktop
   │
   ├── menú de rama → lista de ramas → seleccionas
   │   ("Switch branch to...")
   │
   └── o al crear una rama, ya quedas en ella
```

### 3.2. Qué pasa al cambiar

```text
Al cambiar de main a feature (y al revés)
   │
   ├── Git actualiza tu carpeta de trabajo:
   │   los archivos pasan a como estaban en el commit
   │   al que apunta la rama destino
   │
   ├── tu historial (History) muestra la rama destino
   │
   └── y OJO: cambios sin commitear
```

### 3.3. Estado limpio antes de cambiar

```text
Regla
──────────────────────────────────────────────
Si tienes cambios SIN commit y cambias de rama:
   │
   ├── la herramienta te avisará
   ├── puede llevárselos (si no entran en conflicto)
   ├── o pedirte que los resuelvas/commitees
   └── y si entran en conflicto: bloqueo/decisión

Hábito profesional: COMMITEAR (o descartar con criterio)
ANTES de cambiar de rama. Así cambias con las manos limpias.
```

---

## 4. Trabajar en la rama

### 4.1. Commits en rama

```text
Trabajo normal, con la rama activa
──────────────────────────────────────────────
1. Editas (con tus herramientas)
2. Revisas cambios
3. Commit  →  entra en LA RAMA ACTIVA (feature)
4. Repites

main NO se entera: su puntero no se mueve.
```

### 4.2. Push de la rama

```text
Publicar la rama por primera vez
──────────────────────────────────────────────
Push origin
   │
   ├── la rama NO existe en el remoto
   ├── el primer push la crea allí con el mismo nombre
   └── a partir de ahí, tus commits viajan a "su" rama

En GitHub verás la rama nueva en el selector de ramas.
```

### 4.3. Trabajo aislado

```text
Mientras trabajas en feature:
   │
   ├── main intacta en local y remoto
   ├── puedes experimentar con libertad
   ├── si todo sale mal: descartas la rama
   │   (su trabajo se pierde solo si no lo exportaste)
   └── los demás no ven tu progreso (hasta push)
```

---

## 5. Volver a main y ponerse al día

### 5.1. Volver

```text
1. Asegúrate de tener la rama "feature" con sus commits
   (y push si quieres conservarlos en el remoto)
2. Menú de rama → main
3. Tu carpeta vuelve al estado de main
```

### 5.2. Actualizar main

```text
main local puede estar desactualizada respecto al remoto
   │
   └── en main: Fetch → Pull (capítulo 09)
       para traer lo que otros (o tu rama fusionada)
       hayan puesto allí
```

### 5.3. La fusión (adelanto)

```text
Para que el trabajo de feature llegue a main:
   │
   ├── flujo profesional: abrir un PULL REQUEST
   │   (sección 17): proponer la fusión, revisión,
   │   aprobación y merge
   │
   └── en flujos personales/simples: fusión directa
       (sección 08: git merge / interfaz de merge)

En este capítulo te quedas en: «la rama existe,
está publicada y main espera por ella».
```

---

## 6. Ciclo completo de una rama

```text
CICLO DE VIDA DE UNA RAMA (visión completa)
──────────────────────────────────────────────
1. Crear           (desde main actualizado)
2. Trabajar        (commits en la rama)
3. Push            (publicar la rama)
4. Pull Request    (proponer fusión)  ← sección 17
5. Revisión        (comentarios, ajustes)
6. Fusión (merge)  (a main)           ← sección 08
7. Limpiar         (borrar la rama local
                    y remota ya fusionada)
```

Cada pieza de este ciclo tiene su sección; aquí la ves entera para entender dónde estás parado.

---

## 7. Errores comunes con diagnóstico completo

### Error 1: Commitear en main sin querer

**Qué ocurrió:** el cambio quedó en la línea principal.

**Por qué:** se trabajó con main activa (la rama por defecto).

**Cómo comprobarlo:** History de main en Desktop/GitHub.

**Opciones:**
* si no se publicó: crear rama y trasladar el trabajo (o revertir en main y rehacer en rama);
* si se publicó en repo personal: valorar revert o asumir;
* en equipo con protección: habría sido bloqueado (por eso existe).

**Riesgos:** contaminar la línea estable.

**Solución:** traslado o reversión según contexto.

**Cómo se evita:** crear la rama ANTES de tocar nada (primer paso de toda tarea).

---

### Error 2: Cambiar de rama con cambios sin guardar/commitear

**Qué ocurrió:** aviso de la herramienta, opciones confusas, posible pérdida o mezcla.

**Por qué:** no se cerró el bloque con commit.

**Cómo comprobarlo:** el aviso al cambiar; la lista de cambios.

**Opciones:**
* commitear y volver a intentar;
* si la herramienta llevó los cambios y no hay conflicto: verificar que están donde deben.

**Riesgos:** cambios perdidos o en la rama equivocada.

**Solución:** estado limpio antes de cambiar.

**Cómo se evita:** hábito: commit → cambiar.

---

### Error 3: Creer que la rama se subió al crearla

**Qué ocurrió:** se creó la rama y se fue a GitHub: no aparece.

**Por qué:** crear rama es local; falta push.

**Cómo comprobarlo:** selector de ramas de GitHub.

**Opciones:** push de la rama.

**Riesgos:** «se perdió mi rama» (no: está en local).

**Solución:** publicar.

**Cómo se evita:** recordar local vs. remoto (otra vez).

---

### Error 4: Nombres de rama malos

**Qué ocurrió:** `test123`, `rama-nueva`, `jsdfhk` conviven con ramas serias.

**Por qué:** prisa y sin convención.

**Cómo comprobarlo:** lista de ramas.

**Opciones:** renombrar local/remoto (posible con herramientas/terminal) o limpiar al fusionar.

**Riesgos:** nadie entiende el estado del repositorio.

**Solución:** convención de nombres y limpieza.

**Cómo se evita:** convención escrita en el equipo (y respetada en lo personal desde el día uno).

---

### Error 5: Acumular decenas de ramas abandonadas

**Qué ocurrió:** el repositorio tiene 20 ramas y nadie sabe cuáles viven.

**Por qué:** se crean ramas «por si acaso» y no se limpian.

**Cómo comprobarlo:** lista de ramas (local y remota).

**Opciones:**
* borrar las fusionadas (con cuidado);
* borrar las abandonadas si su trabajo ya no interesa (si no se fusionó, su trabajo se pierde al borrar: verificar antes);
* documento de estado («viva: X, Y»).

**Riesgos:** confusión colectiva; ramas viejas que «parecen pendientes».

**Solución:** limpieza tras cada fusión.

**Cómo se evita:** disciplina de cierre: fusionada ⇒ borrada.

---

### Error 6: Trabajar en la rama «equivocada» por costumbre

**Qué ocurrió:** se siguió tocando `feature-antigua` para un tema nuevo.

**Por qué:** no se miró la rama activa.

**Cómo comprobarlo:** nombre de rama activa en Desktop; History.

**Opciones:** si no se publicó: mover los commits a rama nueva; si se publicó: hablar con el equipo o convivir y explicar.

**Riesgos:** mezcla de temas en una misma historia.

**Solución:** traslado o comunicación.

**Cómo se evita:** mirar la rama activa al empezar a trabajar (cada mañana, cada sesión).

---

## 8. Práctica guiada

### Objetivo

Vivir el ciclo básico de una rama: crear, trabajar, publicar y volver.

### Paso 1: main al día

1. En tu repositorio de práctica, con `main` activa, haz Fetch/Pull si hay novedades.

### Paso 2: crear la rama

1. Menú de rama → **New branch**.
2. Nombre: `feature/agrega-resumen`.
3. Crea y comprueba: la rama activa cambió.

### Paso 3: trabajar

1. Edita `README.md` añadiendo un resumen.
2. Revisa el diff.
3. Commit: `Añade resumen al README (rama feature)`.

### Paso 4: publicar

1. **Push origin**: la rama se crea en el remoto.
2. Ve a GitHub: en el selector de ramas aparece `feature/agrega-resumen`.

### Paso 5: volver a main

1. Cambia a `main`.
2. Observa: el README vuelve a su estado sin resumen (¡no se perdió nada! está en la otra rama).
3. Fetch/Pull en main (si procede).

### Paso 6: verificar el aislamiento

1. Cambia otra vez a `feature/agrega-resumen`: el resumen reaparece.
2. Comprueba en History: main y feature tienen sus respectivas historias.

### Paso 7: pensar la fusión

1. Busca en la interfaz la forma de proponer la fusión (Pull Request o merge).
2. Si te atreves: ábrelo y ciérralo o fúnelo (si es tu repo de práctica). Si no: déjalo anotado para la sección 17.

### Resultado esperado

Una rama publicada, main intacta y dominada la sensación de «cambiar de línea».

### Conclusión esperada

Las ramas no duplican el proyecto: dividen su historia. Cambiar de rama es cambiar de perspectiva, y tu trabajo se mantiene ordenado en cada línea.

---

## 9. Nivel profesional

### 9.1. Ramas efímeras (trunk-based)

```text
Dos filosofías de uso
   │
   ├── ramas largas (feature viva semanas)
   │      →  más conflicto al fusionar
   │
   └── ramas efímeras (vida de horas/día, fusión rápida)
          →  menos conflicto, entrega continua
          →  tendencia profesional actual
          →  requiere main estable y buenas pruebas
```

Conclusión: la rama se crea, se termina, se fusiona y se borra. Cuanto más viva, más caro es fusionarla.

### 9.2. Convenciones y protección

```text
Políticas típicas en equipo
   │
   ├── nombres con prefijo (feature/, fix/, docs/)
   ├── main protegida: nadie escribe directo
   ├── fusión solo vía Pull Request
   ├── ramas personales limpias al fusionar
   └── (a veces) prefijos de usuario: juan/fix-x
```

### 9.3. Hacia el Pull Request

```text
La rama publicada es el 90% de un PR:
   │
   ├── push de la rama
   ├── en GitHub: "Compare & pull request"
   ├── título + descripción (¡el mensaje de commit
   │   extendido!)
   ├── revisión de pares
   └── fusión (merge) con opciones
       (sección 17 lo cubre completo)
```

### 9.4. Ramas y versiones

```text
Además de trabajo en curso, las ramas sirven para:
   │
   ├── mantenimiento de versiones antiguas
   │      (release/1.0 → se parchea sin llevar features)
   └── entornos (algunos equipos mantienen ramas por
       entorno; otros usan tags y despliegues — el tema
       de release/entorno se ve en la sección 16)
```

---

## 10. Resumen

En este capítulo aprendiste que:

* una rama es un puntero con nombre a un commit; crearla es instantáneo y no copia el proyecto;
* `main` es la línea principal; las ramas de trabajo nacen de ella y crecen con sus propios commits;
* se crean desde el menú de rama de GitHub Desktop, con nombres descriptivos y en minúsculas;
* al cambiar de rama, tu carpeta de trabajo toma el estado de la rama destino: conviene llegar con cambios commiteados;
* el trabajo en rama es aislado: main no se entera hasta que la fusión ocurra;
* el primer push crea la rama en el remoto: crear rama es local, publicar es push;
* el ciclo completo es: crear → trabajar → push → Pull Request → fusión → limpieza (cada paso con su sección);
* los errores típicos (commitear en main, cambiar con trabajo sucio, ramas sin publicar, nombres malos, ramas abandonadas) se diagnostican mirando la rama activa y las listas de ramas;
* a nivel profesional, las ramas cortas y protegidas mantienen los repositorios sanos.

La idea principal es:

> **Las ramas dividen la historia para que puedas trabajar sin miedo: cada tarea en su línea, main protegida y la fusión como momento de integración.**

---

## Próximo paso

Has completado la sección «GitHub Desktop»: clonaste, editaste, revisaste, commiteaste, hiciste push y pull, y trabajaste con ramas.

Continúa con el índice de la sección:

[`README.md`](README.md)
