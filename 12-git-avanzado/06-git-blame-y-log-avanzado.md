# git blame y log avanzado

## Introducción

Tres preguntas cubren casi toda investigación sobre código: ¿qué cambió (log), quién lo cambió (blame) y por qué (mensajes, tickets, rangos). Git responde a las tres con precisión, y manejar bien sus consultas ahorra horas de «¿quién escribió esto y cuándo?».

Este capítulo es tu kit de interrogatorio del historial: `git log` con filtros y formats, `git blame` y `git show`, más sus trampas habituales (reescritura, renombres, blames «injustos»).

En este capítulo aprenderás:

* `log` avanzado: rangos, autor, fecha, archivo, patrones, formats;
* `blame` línea a línea y sus opciones (`-C`, `-w`, rangos);
* `show` aplicado a commits, tags y rangos;
* qué NO te dice el blame (y cómo no culpar al equivocado);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((git blame y log avanzado))
    1. log: encontrar el QUÉ
      1.1. Navegación básica
      1.2. Filtros
      1.3. Formats
    2. blame: encontrar el QUIÉN
    3. show: el detalle de UNO
    4. Los límites de la atribución
    5. Errores comunes con diagnóstico completo
    6. Práctica guiada
    7. Nivel profesional + resumen

---
## 1. `log`: encontrar el QUÉ

### 1.1. Navegación básica

```bash
git log --oneline -n 10
git log --graph --oneline --decorate --all
git log HEAD~5..HEAD          # rangos
git log main..feature          # en feature y no en main
git log feature..main          # lo contrario
git log -p -n 3                # con parche
git log --follow -- archivo    # sigue renombres
```

### 1.2. Filtros

```bash
git log --author="ana" --oneline
git log --since="2026-09-01" --until="2026-10-01"
git log --since="2 weeks"
git log --grep="fix" --oneline        # en MENSAJES
git log -S "funcion_vieja" --oneline  # pickaxe: qué
                                       # commit añadió o
                                       # quitó ESTA cadena
git log -- archivo                   # toca este archivo
git log --no-merges --oneline         # sin merges
```

### 1.3. Formats

```bash
git log --pretty=format:"%h %an %ad %s" --date=short -n 5
git log --pretty=fuller               # autor + committer
git log --stat -n 3                   # archivos tocados
git log --name-only -n 3
```

```text
Atajos útiles:
    │
    ├── -S «texto» → «¿quién introdujo/quitó esto?»
    │
    ├── --follow → renombres no rompen la historia
    │
    └── main..rama → «qué lleva la rama» (= base del PR)
```

---

## 2. `blame`: encontrar el QUIÉN

```bash
git blame archivo.py
git blame -L 40,60 archivo.py        # solo líneas
git blame -w archivo.py              # ignora espacios
git blame -C archivo.py              # sigue líneas
                                      # MOVIDAS desde
                                      # otros archivos
git blame -C -C archivo.py           # más agresivo
git blame -L 1,10 -C HEAD^ archivo   # desde otro
                                      # commit (antes de
                                      # un push)
```

```text
Salida:
    (hash) (autor, fecha) (línea del contenido)
    a1b2c34 ana      2026-09-12  return total + iva
    d4e5f67 luis     2026-09-30  # TODO revisar
```

```text
Cómo leerlo:
    │
    ├── cada línea apunta al ÚLTIMO commit que la
    │   cambió (con esas opciones)
    │
    ├── blame sin -C/-w «inventa» autores cuando solo
    │   se movió código o cambió indentación
    │
    └── blame de una zona recién formateada → todos
        «culpables» del formateador (usa -w/-C)
```

---

## 3. `show`: el detalle de UNO

```bash
git show a1b2c34                 # commit completo
git show a1b2c34 --stat          # resumen
git show a1b2c34 -- archivo      # solo ese archivo
git show v2.1.0                  # tag anotado
git show HEAD^:archivo.py        # contenido ANTERIOR
git show :0:archivo.py           # staged actual
```

```text
Combina con lo anterior:
    │
    ├── log -p para rangos largos, show para uno
    │
    └── show HEAD^:ruta sirve también para comparar
        versiones de un archivo sin checkout
```

---

## 4. Los límites de la atribución

```text
Lo que blame NO dice:
    │
    ├── NO dice quién tuvo la IDEA (solo quién
    │   escribió la línea)
    │
    ├── NO sobrevive a reescritura de historial sin
    │   avisar (filter/rebase cambian hashes y a veces
    │   autoría percibida)
    │
    ├── NO distingue «copió de Stack Overflow»
    │
    └── NO es justo con reformatos: usa -w/-C o no
        culpes a nadie por estilo
```

```text
Uso profesional responsable:
    │
    ├── blame como PUNTO DE PARTIDA de una pregunta
    │   («quién sabe de este módulo»), no como veredicto
    │
    └── acompañar con git log del archivo y el ticket
        asociado antes de concluir
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: culpar al autor del reformato

**Qué ocurrió:** tras formatear 3000 líneas, blame muestra al formateador en todo el archivo.

**Por qué posibles:**
* blame sin `-w`/`-C`;
* formateo en commit propio.

**Cómo comprobarlo:** `git log --oneline -- archivo | head` (¿hay commit de estilo?).

**Opciones:** `git blame -w -C`; buscar el commit de formateo y saltar con `-L`/`--since` o usar `git blame <archivo> <commit>` previo.

**Riesgos:** señalar al equivocado en una investigación.

**Solución:** identificar commits de formato y excluírlos del análisis.

**Cómo se evita:** separar reformatos en commits propios (higiene de historia).

---

### Error 2: `log -- archivo` sin `--follow` pierde renombres

**Qué ocurrió:** la historia «empieza» en el renombrado; no aparecen los cambios antiguos.

**Por qué:** Git no sigue el nombre por defecto en este filtro.

**Cómo comprobarlo:** `git log --follow --oneline -- archivo` muestra más commits.

**Opciones:** usar `--follow` siempre que haya renombres.

**Riesgos:** investigación incompleta.

**Solución:** rutina: `log --follow -- archivo`.

**Cómo se evita:** renombrar con `git mv` y probar el `--follow` después.

---

### Error 3: rangos invertidos (`a..b` al revés)

**Qué ocurrió:** «no sale nada» o salen los commits que no interesaban.

**Por qué:** `A..B` = «en B pero no en A».

**Cómo comprobarlo:** probar `B..A` y comparar; `git log A...B --left-right` muestra lados.

**Opciones:** recalcular el rango; `--left-right` para no perderse.

**Riesgos:** revisión de PR con la lista equivocada.

**Solución:** plantilla mental: `desde..hasta`.

**Cómo se evita:** verificar con `--oneline` corto antes de filtrar más.

---

### Error 4: blame sobre archivo con detección de renombre ausente y copias masivas

**Qué ocurrió:** código copiado de otro archivo queda atribuido al «copista».

**Por qué:** sin `-C` no se sigue el origen de las líneas.

**Cómo comprobarlo:** comparar con `git blame -C -C` y ver autores anteriores.

**Opciones:** usar `-C -C` (o triple `-C`) en investigación seria.

**Riesgos:** atribución incorrecta.

**Solución:** `-C` en la rutina de diagnóstico.

**Cómo se evita:** copiar con `git mv`/historial honesto cuando se trata de mover código de verdad.

---

### Error 5: creer que `git log -S` encuentra «palabras» arbitrarias

**Qué ocurrió:** `-S` con regex o con texto que cambió de formato no devuelve resultados esperados.

**Por qué:** `-S` busca la CADENA literal (conteo de apariciones), no regex (para eso está `--grep` con `-E` o `-P` en mensajes, o `-G` en diffs).

**Cómo comprobarlo:** probar `-G"patrón"` (regex sobre el diff) en su lugar.

**Opciones:** elegir la herramienta: `-S` cadena, `-G` regex de contenido, `--grep` mensajes.

**Riesgos:** perder tiempo en un filtro que no puede encontrarlo.

**Solución:** recordar la tríada.

**Cómo se evita:** práctica guiada (paso 5).

---

### Error 6: interpretar el log con merges como lineal

**Qué ocurrió:** `--graph` con merges muestra estructura y alguien leyó la columna como «orden cronológico».

**Por qué:** el grafo no es una línea de tiempo estricto (fecha != posición).

**Cómo comprobarlo:** comparar con `--date-order` o `--author-date-order`.

**Opciones:** usar `--date-order` cuando importe el orden temporal.

**Riesgos:** concluir secuencias incorrectas (p. ej. en bisect manual).

**Solución:** distinguir estructura de tiempo.

**Cómo se evita:** en investigación temporal usar `--since/--until` además del grafo.

---

## 6. Práctica guiada

### Objetivo

Responder cinco preguntas reales sobre un repositorio con log, blame y show.

### Paso 1: prepara historia rica

```bash
git init forense && cd forense
echo "def total(a,b): return a+b" > calc.py
git add . && git commit -m "feat: total"
git switch -c fix
echo "def total(a,b): return a+b+iva" > calc.py
git add . && git commit -m "fix: añade iva"
git switch main && git merge --no-ff fix
git log --graph --oneline --decorate
```

### Paso 2: ¿qué lleva la rama? (rango)

```bash
git switch -c rama-nueva main
echo "# extra" >> calc.py && git commit -am "chore: extra"
git log --oneline main..rama-nueva
```

### Paso 3: ¿quién cambió la línea concreta?

```bash
git blame -L 1,1 calc.py
git blame -w -C calc.py
git show <hash del fix> --stat
```

### Paso 4: ¿quién introdujo una cadena?

```bash
git log --oneline -S "iva"
git log --oneline -G "iva"        # regex sobre diff
git log --grep "iva" --oneline    # solo mensajes
```

### Paso 5: formato y errores

```bash
git log --pretty=format:"%h|%an|%ad|%s" --date=short -n 5
git log --follow --oneline -- calc.py
git log main..rama-nueva --left-right --oneline
git show HEAD^:calc.py            # versión previa
```

### Resultado esperado

Cinco preguntas respondidas sin abrir la interfaz: rango, autor, origen de cadena, formato y versiones previas.

### Conclusión esperada

Log encuentra, blame atribuye y show detalla — y cada uno tiene opciones que evitan las conclusiones a medias.

---

## 7. Nivel profesional + resumen

### 7.1. Consultas de mantenimiento

```text
«¿Dónde se usa X?» (además de grep del árbol):
    │
    └── git log -S "X" --oneline   → cuándo nació y
        quién lo metió (luego blame de esas zonas)

«¿Qué cambió desde la última release?»:
    │
    └── git log v2.0.0..HEAD --oneline --no-merges

«¿Qué toca este PR?»:
    │
    └── git log --name-only main..feature

«Historial de un archivo con renombres»:
    │
    └── git log --follow -p -- archivo
```

### 7.2. Blame en revisiones e incidentes

```text
    │
    ├── incidente → bisect (cap. 05) → blame de la zona
    │   → contacto del contexto
    │
    ├── blame con -w -C en archivos formateados
    │
    └── en el equipo: blame como «quién puede
        explicar», nunca como «quién tiene la culpa»
```

### 7.3. Resumen

En este capítulo aprendiste que:

* `log` filtra por rango (`desde..hasta`), autor, fecha, archivo (`--follow`), mensaje (`--grep`) y contenido (`-S` cadena / `-G` regex), con formats a medida;
* `blame` atribuye línea a línea; `-L` acota, `-w` ignora espacios, `-C` sigue líneas movidas;
* `show` detalla commits, tags y contenidos por revisión (`HEAD^:archivo`);
* la atribución tiene límites: idea vs. escritura, reescritura de historial, formateos y copias;
* los errores típicos (culpa al formateador, renombres perdidos, rangos invertidos, copias sin -C, -S mal usado, grafo como cronología) se evitan con las opciones correctas;
* a nivel profesional: las consultas estándar (desde release, del PR, de la cadena) se dejan escritas en aliases o documentación de equipo.

La idea principal es:

> **El historial responde si preguntas bien: log para el qué, blame para el quién, show para el detalle — con opciones que evitan culpas y conclusiones a medias.**

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Qué opciones usarías con `git blame` para ignorar cambios de espacios y seguir líneas movidas desde otros archivos al investigar quién modificó una función específica?
2. ¿Cómo determinarías si un archivo ha sido renombrado en su historial usando `git log`, y qué opción es esencial para que el seguimiento funcione correctamente?
3. ¿Qué comando usarías para ver el contenido de un archivo en el commit anterior al actual sin hacer checkout?
4. ¿En qué situación sería apropiado usar `git log -S` en lugar de `git log -G`, y qué limita cada uno?
5. ¿Cómo evitarías atribuir erróneamente cambios a un desarrollador cuando el verdadero autor es un formateador automático de código?
6. ¿Qué información proporciona `git show v2.1.0` que no obtendrías de `git log --oneline v2.1.0`?
7. ¿Cómo usarías `git log --grep` y `git log --S` juntos para encontrar un commit que tanto menciona un error en su mensaje como introdujo una cadena específica en el código?
8. ¿Qué riesgo implica interpretar el output de `git log --graph` como una línea de tiempo estricta y cómo lo mitigarías?

---

## Ejercicio de transferencia

Tienes un archivo de configuración `settings.json` que ha sido modificado varias veces a lo largo del historial del proyecto. Necesitas determinar quién introdujo por última vez la clave `"timeout"` y cuándo lo hizo, considerando que el archivo pudo haber sido renombrado o movido. Describe los pasos que seguirías usando `git log --follow` para rastrear el historial del archivo, `git blame -w -C` para ignorar espacios y seguir líneas movidas, y `git show` para verificar el commit específico, asegurándote de que tu investigación sea precisa incluso si el archivo sufrió renombres o copias.

## Próximo paso

Ya interrogas al historial.

La siguiente herramienta amplía tu espacio de trabajo sin duplicar repositorios: `git worktree`.

Continúa con:

[`07-git-worktree.md`](07-git-worktree.md)