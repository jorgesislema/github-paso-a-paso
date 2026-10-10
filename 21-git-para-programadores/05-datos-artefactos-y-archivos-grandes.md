# Datos, artefactos y archivos grandes

## Introducción

Git está diseñado para texto: rastrear, diferenciar y comprimir código. Cuando le pones un video de 800 MB, un dataset o un binario de entrenamiento, no obtienes un repositorio mejor — obtienes uno que nadie puede clonar, cuyo historial crece sin control y que tarde o temprano chocará con los límites de la plataforma. Este capítulo decide, con criterios concretos, qué archivos grandes sí pueden entrar (y cómo), qué alternativas existen y cómo sanear un repo que ya los acumuló.

---

## Mapa conceptual de este capítulo

```text
Datos, artefactos y archivos grandes
       │
       ├── 1. Por qué Git odia los binarios grandes
       │   ├── 2. Criterio de decisión: ¿entra o no?
       │   ├── 3. Opciones cuando sí hay que versionar
       │   ├── 4. Alternativas al Git para lo pesado
       │   └── 5. Saneo: el repo ya está inflado
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Por qué Git odia los binarios grandes

```text
CÓMO TRABAJA GIT CON UN ARCHIVO:
   │
   ├── guarda versiones comprimidas por commit
   │
   └── un binario NO se diferencia: cada cambio = copia
       nueva completa en el historial
```

```text
CONSECUENCIAS:
   │
   ├── clon lento (el historial entero se baja)
   │
   ├── push que excede límites (por objeto o por repo)
   │
   ├── cachés/forks duplican el peso
   │
   └── los diffs y los PRs dejan de servir (no se
       puede leer qué cambió)
```

```text
   │
   └── la pregunta no es «¿puedo subirlo?» sino «¿debe
       vivir en la HISTORIA del proyecto?»
```

---

## 2. Criterio de decisión: ¿entra o no?

```text
TEST DE TRES PREGUNTAS:
   │
   ├── 1. ¿Es texto/pequeño y estable? → git normal
   │
   ├── 2. ¿Es derivable (se regenera del código) y
   │       grande? → NO entra; se regenera en CI
   │
   └── 3. ¿Es dato/binario pesado e imprescindible?
           → NO entra en git; entra al almacén con
             referencia (URL+checksum) — p. ej.
             cap. 03/04 de esta sección
```

```text
EJEMPLOS RÁPIDOS:
──────────────────────────────────────────────────────
SÍ        código, configs, docs, fixtures pequeños,
          imágenes ligeras de la UI (kiB–pocos MB)
DEPENDEN  assets grandes de juego/multimedia pequeños
          (revisar; quizá LFS — punto 3)
NO        datasets, checkpoints, videos, ISOs, .zip de
          datos, builds completos
```

```text
   │
   └── «pequeño» es relativo: un repo educativo puede
       convivir con imágenes de ~1 MB; un dataset de
       100 MB no es «pequeño» en ningún proyecto
```

---

## 3. Opciones cuando sí hay que versionar

```text
OPCIÓN A — Git LFS (Large File Storage):
   │
   ├── guarda punteros en git y los objetos grandes en
   │   un servidor aparte
   │
   ├── sirve para binarios ESTABLES que cambian poco
   │   (fuentes, assets fijos)
   │
   ├── límites de banda/almacenamiento por plan —
   │   revisar antes de depender
   │
   └── NO es solución para checkpoints que cambian
       cada entrenamiento (punto 4)
```

```text
OPCIÓN B — referencia con checksum (misma idea que
cap. 03):
   │
   ├── el archivo vive en almacén; el repo guarda
   │   nombre, versión, URL y digest
   │
   └── reproducible y barato para git
```

```text
OPCIÓN C — herramientas de versionado de datos (DVC y
similares):
   │
   ├── versionan metadatos del dato en git y los
   │   objetos en almacén
   │
   └── útiles cuando el flujo data es constante
       (mención de categoría)
```

```text
   │
   └── regla de oro: NUNCA se corrige un binario
       dentro del historial «porque esta vez es
       pequeño» — el hábito es lo que estalla después
```

---

## 4. Alternativas al Git para lo pesado

```text
SEGÚN EL TIPO:
   │
   ├── datasets         → almacén de objetos/registries
   │                      de datos + referencia
   ├── modelos/ckpt     → registro de modelos /
   │                      almacén (cap. 04 IA)
   ├── artefactos de    → artefactos de CI / releases
   │   build                 (sección 18 cap. 04)
   └── multimedia de    → CDN/almacén + referencia en
       producto             docs
```

```text
PATRÓN DE ACCESO:
   │
   ├── descarga explícita (script `get-data` con
   │   checksum)
   │
   ├── caché local del desarrollador (una vez, no en
   │   git)
   │
   └── CI descarga con credencial del almacén si hace
       falta (sección 19/20)
```

```text
   │
   └── el README siempre dice: qué se baja, desde
       dónde y cómo verificar — sin eso, «fuera del
       repo» = «fuera del alcance» (Error 3)
```

---

## 5. Saneo: el repo ya está inflado

```text
SÍNTOMAS:
   │
   ├── `git clone` lentísimo; panel de almacenamiento
   │   alto; pushes rechazados
   │
   └── `git ls-files` muestra binarios «de hace
       tiempo»
```

```text
PLAN (en este orden — la purga reescribe historia):
   │
   ├── 1. cortar ENTRADAS nuevas: .gitignore + LFS
   │   tracking si aplica + checklist de equipo
   │
   ├── 2. quitar del índice lo vivo: git rm --cached
   │   (no borra el historial — solo deja de
   │   versionar)
   │
   ├── 3. evaluar purga de historial (herramientas de
   │   filter-repo — sección 13 cap. 02): SOLO con
   │   coordinación (rama compartida → todos re-clonan;
   │   avisos, coordinación de la sección 16)
   │
   └── 4. verificar: tamaño, clon limpio, CI verde;
       post-mortem (¿por qué entró? ¿qué control
           falta?)
```

```text
   │
   └── advertencia: reescribir historia afecta a TODO
       el equipo — es una operación de la clase de
       reset --hard: se coordina, se avisa y se
       documenta (sección 08: comandos peligrosos)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: dataset/binario «una vez» en el historial

**Qué ocurrió:** un archivo de 200 MB entró en un commit y el repo quedó inflado aunque después se borrara.

**Por qué:** Git guarda el historial completo (punto 1).

**Cómo comprobarlo:** `git count-objects -vH` o el panel de almacenamiento.

**Opciones:** si no se puede convivir: purga consciente (punto 5); si se convive: dejar de añadir más.

**Riesgos:** cada clon lo paga para siempre.

**Solución:** criterio desde el primer commit (punto 2).

**Cómo se evita:** checklist y revisión de PR (sección 15).

---

### Error 2: LFS usado como vertedero

**Qué ocurció:** checkpoints diarios por LFS → límite de transferencia alcanzado en semanas.

**Por qué:** LFS ≠ almacén de experimentos (punto 3).

**Cómo comprobarlo:** tasa de subida de LFS; nº de objetos por corrida.

**Opciones:** mover checkpoints al almacén/registro; LFS solo para assets estables.

**Riesgos:** coste y bloqueo de CI.

**Solución:** cada tipo a su sitio (punto 4).

**Cómo se evita:** política escrita (cap. 04 de esta sección).

---

### Error 3: archivo «fuera del repo» sin cómo obtenerlo

**Qué ocurrió:** el README decía «los datos se descargan aparte» sin URL, versión ni checksum; nadie reprodujo nada.

**Por qué:** la referencia quedó en la cabeza de quien lo tenía.

**Cómo comprobarlo:** sigue la receta en una máquina limpia: ¿puedes obtener los datos?

**Opciones:** script de descarga con checksum + registro de versión del dataset.

**Riesgos:** irreproducibilidad (sección 21 cap. 03).

**Solución:** referencia completa (punto 4).

**Cómo se evita:** plantilla de README de datos.

---

### Error 4: purga sin coordinación

**Qué ocurrió:** alguien reescribió la historia un viernes; el lunes el equipo tenía ramas irreconciliables.

**Por qué:** sin aviso ni ventana (punto 5).

**Cómo comprobarlo:** historial de eventos; en qué estado quedaron las ramas.

**Opciones:** reconstrucción asistida de ramas; regla: purgas con aviso + ventana + re-clon documentado.

**Riesgos:** pérdida aparente de trabajo (y algo de real si hubo malentendidos).

**Solución:** operación coordinada (punto 5).

**Cómo se evita:** incluir purgas en la lista de operaciones peligrosas del equipo (sección 16).

---

### Error 5: builds versionados

**Qué ocurrió:** `dist/` de cada release quedó en el historial; los diffs eran binarios.

**Por qué:** publicación desde git en vez de desde CI (sección 21 cap. 02 Error 4).

**Cómo comprobarlo:** `git ls-files | grep -E "(dist|build)"`.

**Opciones:** quitar del índice + ignorar; artefactos por CI/releases.

**Riesgos:** crecimiento sin control.

**Solución:** salida en CI (punto 4).

**Cómo se evita:** plantilla .gitignore.

---

### Error 6: límite de plataforma descubierto en producción

**Qué ocurrió:** un push crítico falló por límite de tamaño el día del release.

**Por qué:** nadie vigiló el crecimiento ni el tamaño de los objetos (punto 5 síntomas).

**Cómo comprobarlo:** panel de almacenamiento + `git count-objects -vH`; política de límites.

**Opciones:** saneo inmediato + política previa + monitoreo periódico.

**Riesgos:** bloqueo en el peor momento.

**Solución:** vigilancia y criterio (punto 5).

**Cómo se evita:** revisión trimestral de tamaño (gobernanza — sección 18).

---

## 7. Práctica guiada

### Objetivo

Auditar un repositorio de práctica contra el criterio de archivos grandes y sanearlo.

### Paso 1: diagnóstico

```bash
git count-objects -vH
git ls-files | grep -iE "\.(zip|csv|mp4|pt|pth|pkl|h5|iso)$" | head
du -sh .   # tamaño del directorio de trabajo
```

1. Anota: ¿hay binarios versionados? ¿cuánto pesa?

### Paso 2: el test de tres preguntas

1. Para cada hallazgo: ¿texto pequeño? ¿regenerable? ¿imprescindible y pesado?
2. Clasifica: sigue / sale al almacén con referencia / se regenera en CI.

### Paso 3: cortar entradas

```gitignore
# añade lo que aplique (p. ej.):
data/
*.zip
outputs/
```

### Paso 4: sacar lo vivo del índice

```bash
git rm -r --cached ruta/al/archivo
git commit -m "docs: archivo grande pasa a referencia"
```

1. Si aplica: crea `data/README.md` con URL + checksum (paso de referencia).

### Paso 5: decisión de purga (simulación)

```text
Preguntas del equipo:
   │
   ├── ¿el peso impide trabajar? → purga (coordinada)
   └── ¿solo «molesta»? → cortar entradas y vivir con
       el historial (documentar la deuda)
```

1. Escribe el plan (aviso, ventana, re-clon) SIN ejecutarlo — es un ejercicio.

### Paso 6: política

```markdown
## Archivos grandes
### Ejercicio de transferencia
Aplica lo aprendido en este capítulo a un proyecto personal de tu elección. Por ejemplo, si el capítulo trata sobre ramas en Git, crea una nueva rama para una característica que hayas estado pensando y haz un commit inicial. Entregable: captura de pantalla del comando git branch mostrando tu nueva rama.
## Archivos grandes
- Git: texto y pequeño; binarios estables: LFS
  (decisión explícita)
- Datos/pesos: almacén + referencia (URL+checksum)
- Builds: solo CI
- Revisión trimestral de tamaño del repo
```

### Resultado esperado

Diagnóstico hecho, índice limpio, referencia escrita y política publicada.

### Conclusión esperada

Los archivos grandes no se discuten en el commit: se deciden en la política — el repo guarda la historia del texto, no el almacén de la compañía.

---

## 8. Nivel profesional + resumen

### 8.1. Gestión de artefactos a escala

```text
   │
   ├── política org de límites: qué entra en git, qué
   │   en LFS, qué en almacén (documentada y revisada)
   │
   ├── monitoreo: tamaño de repos y avisos de límite
   │   (antes del día del push)
   │
   ├── purgas: procedimiento estándar con coordinación
   │   y verificación (punto 5)
   │
   ├── data/modelos con versionado y acceso
   │   controlado (sección 16/20)
   │
   └── métrica: tamaño mediano de repos, nº de
       purgas/año (idealmente cero sorpresas)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* Git guarda texto: los binarios grandes multiplican el historial y rompen el flujo;
* criterio de tres preguntas: texto pequeño entra; regenerable se regenera; pesado imprescindible vive fuera con referencia;
* LFS para estables, almacén para pesados, DVC cuando el flujo de datos lo pide;
* saneo: cortar entradas, limpiar índice, purga coordinada con aviso;
* los errores típicos (binario histórico, LFS vertedero, referencia incompleta, purga sin coordinar, builds versionados, límite sorpresa) se previenen con política y revisión;
* a nivel profesional: límites gobernados y monitoreados.

La idea principal es:

> **El tamaño del repo es deuda que arrastran todos los clones futuros: lo que no es historia del texto se paga en almacén ajeno, con una referencia verificable en el repo.**

---

## Próximo paso
## Autopreguntas de cierre
1. ¿Cómo explicarías con tus propias palabras el concepto de Introducción?
1. ¿Cuál es la relación entre Mapa conceptual de este capítulo y 1. Por qué Git odia los binarios grandes?
1. ¿Qué pasos seguirías para aplicar 1. Por qué Git odia los binarios grandes en un escenario real?
1. ¿Qué errores comunes debes evitar al trabajar con 2. Criterio de decisión: ¿entra o no??
1. ¿Cómo medirías el éxito al implementar 3. Opciones cuando sí hay que versionar?
1. ¿Qué herramientas o comandos mencionados en el capítulo son esenciales para 4. Alternativas al Git para lo pesado?
1. ¿Cómo adaptarías el proceso descrito en 5. Saneo: el repo ya está inflado si tuvieran que trabajar en un entorno distribuido?
1. ¿Qué principio subyace detrás de la recomendación de 6. Errores comunes con diagnóstico completo?
## Próximo paso

Ya tienes criterio para lo que pesa.

Ahora la lista definitiva de la otra mitad: lo que jamás debe entrar — secretos y datos sensibles.

Continúa con:

[`06-que-no-debe-entrar-al-repo.md`](06-que-no-debe-entrar-al-repo.md)
