# .gitattributes

## Introducción

Si `.gitignore` decide QUÉ archivos entran, `.gitattributes` decide CÓMO se tratan los que ya entraron: finales de línea, diff binario, merge por defecto, filtros de smudge/clean y más.

Es el archivo que evita la pesadilla de «cambios en todo el archivo porque alguien usa Windows» y el que permite decir a Git «este fichero es binario, no lo intentes fusionar como texto».

---

## Mapa conceptual de este capítulo

```text
.gitattributes
       │
       ├── 1. Para qué sirve (y por qué no basta config)
       ├── 2. Sintaxis
       ├── 3. El caso de los finales de línea
       ├── 4. Diffs y merges: binary, merge drivers
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Para qué sirve

```text
   │
   ├── config (autocrlf) es PERSONAL/por máquina
   │
   └── .gitattributes es del PROYECTO: aplica a todos
       los que clonen, con independencia de su config
```

```text
Atributos frecuentes:
   │
   ├── text / eol     → normalización de finales
   ├── binary         → no tratar como texto
   ├── diff           → cómo se difumina (texto/ binario/
   │                    un filtro concreto)
   ├── merge          → estrategia (ours, theirs,
   │                    union...)
   └── export-ignore  → no incluir en exportaciones
```

---

## 2. Sintaxis

```text
patrón    atributo[=valor] [atributo...]

# ejemplos:
*           text=auto eol=lf
*.md        text
*.png       binary
*.csv       -text          (no tratar como texto)
docs/**     export-ignore
Makefile    merge=ours
```

```text
   │
   ├── mismo concepto de patrones que .gitignore
   │
   ├── -atributo → desactiva el atributo
   │
   └── «text=auto» → Git decide por contenido (buen
       default moderno)
```

```bash
# comprobar qué aplica a un archivo:
git check-attr text diff merge -- archivo.md
git check-attr -a -- archivo.md        # todos
```

---

## 3. Finales de línea: el escenario clásico

```text
El problema:
   │
   ├── Windows: CRLF (↵ al final con retorno)
   ├── Unix/macOS: LF (solo salto)
   └── si cada uno guarda como su SO → diffs de todo
       el archivo y conflictos absurdos
```

```text
Solución recomendada (proyecto):
   │
   ├── .gitattributes con:
   │       * text=auto eol=lf
   │
   ├── → en el REPO todo vive en LF; al clonar, el SO
   │   recibe LF (o CRLF si tú lo decides con eol)
   │
   └── más .editorconfig para que los editores
       cooperen
```

```text
Combinación con core.autocrlf (coexistencia):
   │
   ├── autocrlf=true (Windows): clona convirtiendo,
   │   commitea a LF — OK si el equipo lo respeta
   │
   ├── pero si hay dudas: el gitattributes del
   │   proyecto manda sobre ambigüedades
   │
   └── regla práctica: UN criterio escrito; no tres
       mezclados
```

```bash
# ¿qué está pasando realmente?
git ls-files --eol            # eol de índice/working
git diff --stat               # ¿cambios fantasma?
git add --renormalize .       # re-normalizar todo
                              # (cambio puntual grande)
```

---

## 4. Binarios, diffs y merges

```text
Binarios:
   │
   ├── *.png  *.zip  *.pdf → binary (o -text)
   │
   └── sin esto, Git puede intentar merge/diff de
       contenido binario y corromper o ensuciar
```

```text
Merge drivers por atributo:
   │
   ├── merge=ours   → siempre la versión de esta rama
   │                  (útil p. ej. para archivos
   │                  generados que «gana» local)
   │
   ├── merge=union  → uniones de líneas sin marcas
   │                  (aproximado, casos especiales)
   │
   └── drivers propios: .gitattributes declara
       «merge=mi-driver» y git config en el equipo
       define cmd/path/recursive (uso avanzado; solo
       con documentación)
```

```text
Diffs:
   │
   ├── *.csv  diff=csv   → difuminador propio (config
   │   del equipo)
   │
   └── -diff / binary → «esto no se difumina como
       texto»
```

```text
export-ignore:
   │
   └── docs/** export-ignore → si el proyecto se
       exporta (git archive / release), esos archivos
       no viajan
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: aplicar .gitattributes a un proyecto YA existente con líneas mezcladas

**Qué ocurrió:** al añadir `* text=auto eol=lf`, miles de archivos aparecen modificados (o no cambian hasta `add`).

**Por qué posibles:**
* el contenido almacenado aún tiene CRLF;
* solo se manifiesta al re-normalizar.

**Cómo comprobarlo:** `git ls-files --eol` (índice con `i/crlf`); `git diff` tras `git add --renormalize .`.

**Opciones:**
* commit dedicado «chore: normaliza finales de línea» (revisión enorme, avisar);
* o hacerlo por fases (archivos de texto primero).

**Riesgos:** PR gigante que tapa cambios; blame desplazado (usa `ignore-revs-file` de Git para no marcar esas líneas en blame — atributo `blame.ignoreRevsFile`).

**Solución:** normalizar con commit propio y registrar ese archivo para blame.

**Cómo se evita:** decidirlo al CREAR el repositorio.

---

### Error 2: confundir autocrlf con gitattributes (o pelearse)

**Qué ocurrió:** dos personas con autocrlf distintos y sin gitattributes → diffs constantes.

**Por qué:** criterios personales sin fuente de verdad del proyecto.

**Cómo comprobarlo:** `git ls-files --eol` en dos clones; `check-attr`.

**Opciones:** añadir gitattributes con eol fijo; alinear autocrlf (cap. 01).

**Riesgos:** «Git rompe mis archivos» (no: es un criterio ausente).

**Solución:** el proyecto declara; la persona obedece.

**Cómo se evita:** checklist de creación de repo.

---

### Error 3: tratar binarios como texto (archivos corruptos)

**Qué ocurrió:** un `.zip` o `.png` se fusionó y quedó dañado (o el diff es ruido).

**Por qué:** sin atributo binary/-text.

**Cómo comprobarlo:** `check-attr text -- archivo`; intento de merge anterior.

**Opciones:** añadir patrón binary; para el daño: restaurar una versión buena (`checkout` de una rama, cap. 11) y rehacer el cambio sin merge del binario.

**Riesgos:** corrupción silenciosa.

**Solución:** declarar binarios en origen.

**Cómo se evita:** revisar `check-attr -a` en el PR que añade archivos nuevos.

---

### Error 4: merge drivers exóticos sin documentación

**Qué ocurrió:** `merge=ours` declarado y nadie sabe por qué ese archivo «no se fusiona».

**Por qué:** atributo copiado de un tutorial sin contexto.

**Cómo comprobarlo:** `check-attr merge -- archivo`; historial del gitattributes.

**Opciones:** documentar cada driver en CONTRIBUTING o retirarlo.

**Riesgos:** resoluciones inesperadas en momentos críticos.

**Solución:** todo atributo especial, justificado por escrito.

**Cómo se evita:** revisión de cambios en `.gitattributes` como cambios de comportamiento (lo son).

---

### Error 5: olvidar que .gitattributes también afecta a exportaciones y arhivos

**Qué ocurrió:** `git archive` / release incluyó archivos que debían excluirse (o viceversa).

**Por qué:** no se usó export-ignore.

**Cómo comprobarlo:** inspeccionar el tarball/archivo generado.

**Opciones:** añadir export-ignore a docs/tests/etc. según política.

**Riesgos:** releases con peso o contenido inesperado.

**Solución:** revisar el contenido exportado como parte del checklist de release.

**Cómo se evita:** plantilla con la política del equipo.

---

### Error 6: tratar .gitignore como sustituto de atributos

**Qué ocurrió:** se intentó con gitignore «forzar eol» o tratar binarios (imposible: ignore solo excluye).

**Por qué:** no se distinguen los dos archivos.

**Cómo comprobarlo:** sintaxis y resultados de check-ignore vs. check-attr.

**Opciones:** usar cada uno para su caso (cap. 02 vs. este).

**Riesgos:** fricción y soluciones inventadas.

**Solución:** modelos mentales separados.

**Cómo se evita:** este capítulo + repaso del 02.

---

## 6. Práctica guiada

### Objetivo

Declarar eol y binarios, comprobar con `check-attr` y normalizar un repo sucio.

### Paso 1: repo con líneas sucias

```bash
git init attrdemo && cd attrdemo
# crea un archivo con CRLF (en Windows: escribe con
# salto de línea Windows) o simula:
printf "linea1\r\nlinea2\r\n" > doc.txt
git add . && git commit -m "base con CRLF"
git ls-files --eol
```

### Paso 2: declarar atributos

```powershell
@'
* text=auto eol=lf
*.png binary
docs/** export-ignore
'@ | Set-Content .gitattributes
```

```bash
git check-attr text eol -- doc.txt
git check-attr text -- algo.png
git check-attr export-ignore -- docs/notas.md
```

### Paso 3: renormalizar

```bash
git add --renormalize .
git status                 # doc.txt «modificado»
git ls-files --eol         # índice ahora LF
git commit -m "chore: normaliza finales a LF"
```

### Paso 4: simular binario

```bash
echo "binario" > logo.png
git add . && git commit -m "logo"
git check-attr binary text -- logo.png
git diff HEAD~1 -- logo.png   # sin diff de texto útil
```

### Paso 5: eol en el clone

```bash
git clone . ../copia-attr
cd ../copia-attr
git ls-files --eol         # working tree según tu SO
git config core.autocrlf   # relación con config
```

### Resultado esperado

Proyecto con atributos declarados, verificados con check-attr y contenido renormalizado en un commit propio.

### Conclusión esperada

El proyecto declara cómo se tratan sus archivos; la config personal solo pinta donde el proyecto no dice nada.

---

## 7. Nivel profesional + resumen

### 7.1. Setup recomendado (resumen)

```text
   │
   ├── .gitattributes: * text=auto eol=lf + binarios
   │   + export-ignore según política
   │
   ├── .editorconfig: editores cooperen (indent, eol)
   │
   ├── autocrlf de equipo alineado (o irrelevante
   │   gracias al atributo)
   │
   └── blame.ignoreRevsFile ← para sobrevivir a la
       normalización masiva (y a los formateadores)
```

```bash
# ejemplos de comprobación en CI (revisión temprana):
git diff --check              # whitespace issues
git ls-files --eol            # eol inesperados
```

### 7.2. Resumen

En este capítulo aprendiste que:

* `.gitattributes` es la política del PROYECTO (config = política personal);
* sintaxis de patrones como gitignore; `check-attr` diagnostica qué aplica;
* `text=auto eol=lf` + renormalización con commit propio resuelve el CRLF mixto;
* `binary`/`-text`, `merge=` y `export-ignore` protegen binarios, dirigen fusiones y limpian exportaciones;
* los errores típicos (proyecto viejo sin normalizar, criterios mezclados, binarios como texto, drivers sin documentar, exports y confusión con ignore) se previenen con check-attr y decisiones escritas;
* a nivel profesional: gitattributes + editorconfig + ignoreRevsFile como tríada de higiene.

La idea principal es:

> **Quien clona tu proyecto no debe adivinar: el .gitattributes es la declaración de cómo se lee, se difumina y se fusiona cada archivo — para todos, sin depender de su configuración.**

---

## Próximo paso

Ya controlas formato y comportamiento.

El capítulo siguiente trata el tema crítico: por qué `.gitignore` NO protege secretos ya publicados (y qué hacer si pasó).

Continúa con:

[`05-secretos-y-gitignore.md`](05-secretos-y-gitignore.md)
