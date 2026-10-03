# git bisect

## Introducción

«Antes funcionaba, ahora no» — y entre medias hay doscientos commits. Recorrerlos uno a uno es agotador; `git bisect` lo convierte en una búsqueda binaria: pruebas ~8 pasos en vez de 200, y Git te dice en qué commit entró el fallo.

Bisect es la herramienta de diagnóstico por excelencia del historial, y admite automatización total con un script de prueba.

En este capítulo aprenderás:

* la idea de búsqueda binaria aplicada al historial;
* el flujo manual: `start`, `good`, `bad`, `reset`;
* bisect con script automático (`--run`);
* bisect sobre rangos y con `visualize`;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
git bisect
       │
       ├── 1. La idea (búsqueda binaria)
       ├── 2. Flujo manual (start/good/bad)
       ├── 3. Automatización (--run, script)
       ├── 4. Herramientas de apoyo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. La idea

```text
Historial:
  ... f1  f2  f3  f4  f5  f6  f7  f8 ...
        ▲ buenos          malos ▲

bisect elige el PUNTO MEDIO y te lo prueba:
   │
   ├── ¿bueno? → el culpable está a la derecha
   ├── ¿malo?  → a la izquierda (o es él)
   └── repite: log₂(n) pasos
```

```bash
# escenario: main está roto AHORA, todo correcto en
# la versión v1.0.0
git bisect start
git bisect bad                 # HEAD actual: malo
git bisect good v1.0.0         # punto conocido bueno
# Git te lleva al commit medio → pruebas → decides
```

```text
Resultado al final:
   │
   └── "the first bad commit is a1b2c34 ..."
       → el culpable exacto, con mensaje y autor
```

---

## 2. Flujo manual

```bash
git bisect start HEAD v1.0.0    # malo=bueno en uno
# o paso a paso:
git bisect start
git bisect bad
git bisect good v1.0.0

git bisect good                # este commit pasa
git bisect bad                 # este commit falla
git bisect skip                # este no se puede
                               # probar (roto por otra
                               # causa, build imposible)

git bisect visualize            # qué queda por probar
git bisect reset               # VOLVER a donde estabas
                               # (imprescindible)
```

```text
Estados a recordar:
   │
   ├── durante bisect, HEAD está «viajando» por la
   │   historia (detached): no trabajes en paralelo
   │
   ├── bisect reset restaura tu rama/estado original
   │
   └── sin reset, la próxima operación se confunde
```

---

## 3. Automatización (`--run`)

```bash
# 1. script que salga 0=good, 1..124=bad, 125=skip
git bisect start HEAD v1.0.0
git bisect run ./test.sh
```

```bash
# ejemplo de test.sh (bash):
#!/bin/sh
npm test > /dev/null 2>&1    # o pytest, make test...
```

```text
   │
   ├── Git ejecuta el script en cada punto medio y
   │   decide SOLO
   │
   ├── códigos: 0 good · 1-124 bad · 125 skip ·
   │   otros → bisect se detiene con error
   │
   └── al final: el commit culpable sin tocar nada
```

```text
Condiciones del script:
   │
   ├── determinista (mismo resultado para mismo
   │   código)
   │
   ├── rápido (corre decenas de veces)
   │
   └── sin efectos secundarios (no publiques nada)
```

---

## 4. Herramientas de apoyo

```bash
git bisect visualize            # log de lo pendiente
git bisect log > archivo.txt    # reproducir sesión
git bisect view                 # con visor de diffs
                                # (si está configurado)
git bisect bad <hash>           # acotar: este ya es
                                # malo (útil si sabes
                                # algo)
git bisect good <hash>          # y este bueno
```

```bash
# reanudar una sesión guardada:
git bisect start
git bisect replay archivo.txt
```

```text
Acotar acelera:
   │
   ├── si sabes «en la rama X ya estaba malo»:
   │   marcar esos extremos reduce pasos
   │
   └── rangos: git bisect start <malo> <bueno>
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: olvidar `bisect reset`

**Qué ocurrió:** tras encontrar el culpable, HEAD sigue en detached y las siguientes operaciones actúan «en el sitio equivocado».

**Por qué:** el paso final del flujo se saltó.

**Cómo comprobarlo:** `git status` (HEAD detached en commit antiguo).

**Opciones:** `git switch <tu-rama>` o `git bisect reset` si aún estás en sesión.

**Riesgos:** commits accidentales en detached; confusión.

**Solución:** reset siempre, aunque encuentres el culpable a la primera.

**Cómo se evita:** checklist de cuatro líneas (start/good-bad/reset).

---

### Error 2: extremos mal marcados

**Qué ocurrió:** bisect da un «culpable» imposible (o el mismo mensaje de siempre).

**Por qué posibles:**
* el «bueno» ya estaba roto para otra causa;
* el «malo» es anterior al fallo real;
* se marcaron rangos invertidos (bueno más nuevo que malo).

**Cómo comprobarlo:** ejecutar el test en los extremos manualmente; `git log --oneline <bueno>..<malo> | measure`.

**Opciones:** `bisect reset`, re-marcado correcto y reinicio; o `bisect bad/bueno` adicionales para acotar.

**Riesgos:** concluir con el commit equivocado y «arreglar» lo que no estaba roto.

**Solución:** verificar los extremos ANTES de empezar (ejecutar el test ahí).

**Cómo se evita:** elegir extremos que tú hayas comprobado hoy.

---

### Error 3: script de bisect no determinista o que depende de red

**Qué ocurrió:** bisect da resultados contradictorios (a veces good, a veces bad en el mismo commit).

**Por qué:** el test usa servicios externos, aleatoriedad o estado sucio.

**Cómo comprobarlo:** ejecutar el script dos veces en el mismo commit.

**Opciones:** aislar el test (offline, datos fijos); `--skip` en puntos indeterminables.

**Riesgos:** culpable falso.

**Solución:** condiciones del punto 3.

**Cómo se evita:** preferir el test más pequeño posible (unitario) sobre el E2E para bisect.

---

### Error 4: bisect durante conflicto/operación en curso

**Qué ocurrió:** se inició bisect con un rebase/merge sin terminar → estados mezclados.

**Por qué:** no se identificó el estado previo (sección 03 de la sección 10).

**Cómo comprobarlo:** `git status` (¿operación en curso?).

**Opciones:** terminar o abortar la operación; después bisect.

**Riesgos:** perder la operación o la sesión de bisect.

**Solución:** carpeta y operación limpias antes de `bisect start`.

**Cómo se evita:** una tarea de diagnóstico a la vez.

---

### Error 5: buscar en un historial que fue reescrito

**Qué ocurrió:** los hashes «buenos» referenciados (de tickets antiguos) ya no existen tras un rebase/filtro.

**Por qué:** reescritura masiva (cap. 01) sin actualizar referencias.

**Cómo comprobarlo:** `git cat-file -t <hash>` → no encontrado (o distinto).

**Opciones:** usar nombres estables (tags, ramas) como extremos; reflog si aún existe.

**Riesgos:** extensión de la investigación.

**Solución:** marcar extremos con tags (cap. 04).

**Cómo se evita:** la regla de no documentar hashes sueltos.

---

### Error 6: no usar bisect «porque hay pocas opciones»

**Qué ocurrió:** horas de bisect manual (revisar commits a ojo) cuando `--run` lo resolvía en minutos.

**Por qué:** desconocimiento de la automatización.

**Cómo comprobarlo:** la tarea repetitiva de probar y probar.

**Opciones:** escribir el script de una función que ya sirve para reproducir (muchas veces ya existe un test que falla).

**Riesgos:** desgaste.

**Solución:** punto 3.

**Cómo se evita:** regla: si pruebas más de 5 veces lo mismo, automatízalo.

---

## 6. Práctica guiada

### Objetivo

Encontrar el commit culpable con bisect manual y con script `--run`.

### Paso 1: montar la historia

```bash
git init bisecho && cd bisecho
for i in 1 2 3 4 5 6 7 8; do
  echo "$i" >> dato.txt
  git add . && git commit -m "paso $i"
done
git log --oneline
# ahora rompe UN commit concreto (p. ej. el 5):
# edita dato.txt añadiendo una línea "ROTO" y commitea
echo "ROTO" >> dato.txt && git add . && git commit -m "paso 6 (rompe)"
for i in 7 8; do echo "$i" >> dato.txt; git add .; git commit -m "paso $i"; done
```

### Paso 2: script de prueba

```bash
# test.sh (PowerShell en Windows o sh en Unix)
# criterio: el archivo NO debe contener la línea ROTO
# bash:
#!/bin/sh
grep -q "ROTO" dato.txt && exit 1 || exit 0
# Windows (PowerShell):
# if (Select-String -Path dato.txt -Pattern "ROTO") { exit 1 } else { exit 0 }
```

### Paso 3: bisect manual

```bash
git bisect start
git bisect bad
git bisect good <hash del "paso 1">
# sigue las instrucciones: good/bad según grep
git bisect visualize
# al terminar: culpable identificado
git bisect reset
git log --oneline -n 1   # confirmar
```

### Paso 4: bisect automático

```bash
git bisect start HEAD <hash del "paso 1">
git bisect run ./test.sh     # (o el intérprete
                             # adecuado)
# salida final: first bad commit = ...
git bisect reset
```

### Paso 5: acotar y skip

```bash
# si un commit no compila:
git bisect skip
# si sabes que cierto hash ya era malo:
git bisect bad <hash>
git bisect reset
```

### Resultado esperado

Culpable encontrado en pocos pasos, manual y automáticamente, y estado original restaurado.

### Conclusión esperada

Bisect convierte la historia en un algoritmo: marcas extremos verificados, pruebas decides o automatizas, y siempre cierras con reset.

---

## 7. Nivel profesional + resumen

### 7.1. Bisect en equipo

```text
   │
   ├── el test automatizado del CI es el mismo que
   │   puede servir de script de bisect
   │
   ├── si el culpable es de otro autor, el mensaje y
   │   la fecha del commit dicen el contexto (blame
   │   del capítulo siguiente)
   │
   └── en incidentes: bisect + changelog = respuesta
       rápida a «¿en qué versión entró?»
```

```bash
# ¿en qué RELEASE entró? combina con tags:
git bisect start HEAD v2.0.0
git bisect run ./test.sh
# → versión exacta afectada para comunicar
```

### 7.2. Límites conocidos

```text
   │
   ├── bisect es binario: 1 bad/1 good por punto (no
   │   sirve para fallos probabilísticos raros)
   │
   ├── migraciones de base de datos o dependencias
   │   externas complican el script (skip frecuente)
   │
   └── historiales con merges complejos: funciona, pero
       el script debe ser independiente de la rama
```

### 7.3. Resumen

En este capítulo aprendiste que:

* bisect aplica búsqueda binaria al historial: ~log₂(n) pruebas para localizar el primer commit malo;
* flujo manual: `start` → marcar `bad`/`good` en extremos verificados → probar cada punto → `reset`;
* `--run <script>` automatiza todo (0=good, 1-124=bad, 125=skip);
* `visualize`, `log`/`replay` y marcas adicionales (`bad <hash>`) acotan la sesión;
* los errores típicos (sin reset, extremos malos, tests no deterministas, estados mezclados, hashes reescritos, no automatizar) se previenen con verificación de extremos y scripts pequeños;
* a nivel profesional: bisect + tags responde «¿en qué versión entró el bug?» y el test de CI puede ser el script de bisect.

La idea principal es:

> **No revises la historia a mano: declara un bueno, un malo y un test — bisect devuelve el culpable, y el equipo recupera el tiempo.**

---

## Próximo paso

Ya localizas culpables por fecha.

La siguiente herramienta explica QUIÉN y POR QUÉ tocó cada línea: blame y log avanzado.

Continúa con:

[`06-git-blame-y-log-avanzado.md`](06-git-blame-y-log-avanzado.md)
