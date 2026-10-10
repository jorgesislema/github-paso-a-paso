# Estructura de un repositorio profesional

## IntroducciÃ³n

Un repositorio profesional se reconoce antes de leer una lÃ­nea de cÃ³digo: estÃ¡ ordenado, tiene su documentaciÃ³n en el sitio esperado, sus automatizaciones donde las busca la plataforma y sus archivos de gobernanza en la raÃ­z. La estructura no es estÃ©tica â€” es el contrato que permite a un reciÃ©n llegado encontrar, ejecutar y contribuir sin guÃ­a.

Este capÃ­tulo diseÃ±a la estructura completa de un repo de producciÃ³n: raÃ­z, `src`, `tests`, `docs`, `.github`, scripts y los archivos de contrato (README, LICENSE, CONTRIBUTING, SECURITY).

---

## Mapa conceptual de este capÃ­tulo

```mermaid
mindmap
  root((Estructura de un repositorio profesional))
    01 Principios de la estructura
    02 Mapa de carpetas modelo
    03 Archivos de contrato en la raÃ­z
    04 .github/ el directorio del equipo
    05 Errores comunes con diagnÃ³stico completo
    06 PrÃ¡ctica guiada
    07 Nivel profesional + resumen
```

---

## 1. Principios de la estructura

```text
PRINCIPIOS
â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
1. convenciÃ³n sobre invenciÃ³n: los estÃ¡ndares del
   lenguaje/ecosistema (secciÃ³n 21) primero
2. separaciÃ³n por propÃ³sito: fuente, pruebas, docs,
   automatizaciÃ³n, scripts
3. la raÃ­z es un Ã­ndice: 5-7 entradas, no un cajÃ³n
4. todo lo que el equipo necesita repetir vive en
   el repo (scripts, configs)
5. lo que la plataforma busca en sitios conocidos
   (.github/, LICENSE, SECURITY.md)
```

```text
   â”‚
   â”œâ”€â”€ un reciÃ©n llegado debe poder, en 10 minutos:
   â”‚   encontrar el cÃ³digo, ejecutar las pruebas y
   â”‚   saber cÃ³mo contribuir
   â”‚
   â””â”€â”€ si algo no encaja en ninguna carpeta y se
       repite â†’ merece carpeta propia (decisiÃ³n
       escrita)
```

---

## 2. Mapa de carpetas modelo

```text
repositorio/
â”œâ”€â”€ README.md            â† puerta (secciÃ³n 14)
â”œâ”€â”€ LICENSE
â”œâ”€â”€ CONTRIBUTING.md
â”œâ”€â”€ CODE_OF_CONDUCT.md
â”œâ”€â”€ SECURITY.md          â† canal de reportes (secciÃ³n 20)
â”œâ”€â”€ CHANGELOG.md
â”œâ”€â”€ .gitignore
â”œâ”€â”€ .gitattributes       (si aplica â€” secciÃ³n 13)
â”‚
â”œâ”€â”€ src/  (o el paquete/raÃ­z del cÃ³digo)
â”‚   â””â”€â”€ â€¦
â”œâ”€â”€ tests/ (o *.test.* junto al cÃ³digo: convenciÃ³n
â”‚           del ecosistema)
â”œâ”€â”€ docs/
â”‚   â”œâ”€â”€ README.md        â† Ã­ndice
â”‚   â”œâ”€â”€ guias/
â”‚   â”œâ”€â”€ arquitectura/
â”‚   â””â”€â”€ decisiones/      (ADRs â€” secciÃ³n 14)
â”œâ”€â”€ scripts/             â† operaciÃ³n repetible
â”œâ”€â”€ config/  (si aplica)
â”‚
â”œâ”€â”€ .github/
â”‚   â”œâ”€â”€ CODEOWNERS
â”‚   â”œâ”€â”€ PULL_REQUEST_TEMPLATE.md
â”‚   â”œâ”€â”€ ISSUE_TEMPLATE/
â”‚   â”œâ”€â”€ workflows/       (Actions â€” secciÃ³n 19)
â”‚   â””â”€â”€ dependabot.yml   (secciÃ³n 20)
â”‚
â””â”€â”€ (monorepo: paquetes/ o apps/ â€” menciÃ³n)
```

```text
VARIANTES HONESTAS POR ECOSISTEMA (secciÃ³n 21):
   â”‚
   â”œâ”€â”€ Python: src/ o raÃ­z del paquete + pyproject.toml
   â”œâ”€â”€ JavaScript: src/ + package.json en raÃ­z
   â”œâ”€â”€ datos/IA: data/ (Â¡sin datos sensibles en el
   â”‚   repo!) + notebooks/ + entornos documentados
   â””â”€â”€ lo IMPORTANTE: el equipo lo reconoce al
       instante
```

---

## 3. Archivos de contrato en la raÃ­z

```text
ARCHIVO              RESPONDE A
â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
README.md            Â¿quÃ© es y cÃ³mo empiezo?
LICENSE              Â¿puedo usarlo?
CONTRIBUTING.md      Â¿cÃ³mo contribuyo?
CODE_OF_CONDUCT.md   Â¿cÃ³mo convivimos?
SECURITY.md          Â¿envejezco un fallo de seguridad?
CHANGELOG.md         Â¿quÃ© cambiÃ³ por versiÃ³n?
SUPPORT.md (opc.)    Â¿dÃ³nde pido ayuda?
```

```text
   â”‚
   â”œâ”€â”€ CONTRACTOS VIVOS: se revisan cuando cambia el
   â”‚   proceso (secciÃ³n 14/15)
   â”‚
   â”œâ”€â”€ SECURITY.md en repo pÃºblico es asunto serio:
   â”‚   canal privado + tiempo de respuesta (secciÃ³n
   â”‚   20)
   â”‚
   â””â”€â”€ TODO fichero de raÃ­z debe enlazar a los
       otros (README â†’ CONTRIBUTING â†’ SECURITY): la
       red de enlaces es la navegaciÃ³n
```

---

## 4. `.github/`: el directorio del equipo

```text
.github/
â”œâ”€â”€ workflows/          â† Actions (secciÃ³n 19)
â”œâ”€â”€ ISSUE_TEMPLATE/     â† formularios (secciÃ³n 14)
â”œâ”€â”€ PULL_REQUEST_TEMPLATE.md
â”œâ”€â”€ CODEOWNERS          â† dueÃ±os (secciÃ³n 16)
â”œâ”€â”€ dependabot.yml      â† actualizaciones (secciÃ³n 20)
â”œâ”€â”€ FUNDING.yml (opc.)
â””â”€â”€ config.yml          â† enlaces del formulario de
                          issues
```

```text
POR QUÃ‰ AQUÃ:
   â”‚
   â”œâ”€â”€ la plataforma lo reconoce sin configuraciÃ³n
   â”œâ”€â”€ vive con el cÃ³digo â†’ se revisa en PR
   â””â”€â”€ en organizaciÃ³n: se CLONA de plantillas
       (cap. 02) â†’ consistencia entre repos
```

```text
   â”‚
   â””â”€â”€ regla: si un equipo necesita repetirlo en
       todos los repos â†’ `.github/` de plantilla de
       la org (cap. 02)
```

---

## 5. Errores comunes con diagnÃ³stico completo

### Error 1: la raÃ­z es un cajÃ³n de sastre

**QuÃ© ocurriÃ³:** 40 archivos sueltos (notas, backups, `test2.py`, `nuevo-final.zip`).

**Por quÃ© posibles:**
* crecimiento sin reglas;
* merges de archivos no versionados.

**CÃ³mo comprobarlo:** listar la raÃ­z; contar entradas.

**Opciones:** mover a carpetas por propÃ³sito; eliminar basura; `.gitignore` para lo local (secciÃ³n 13).

**Riesgos:** nadie encuentra nada; el repo parece abandono.

**SoluciÃ³n:** Ã­ndice de raÃ­z (punto 2) + regla de entrada.

**CÃ³mo se evita:** revisiÃ³n de estructura en PRs grandes.

---

### Error 2: documentaciÃ³n fuera del repo (o en el wiki solo)

**QuÃ© ocurriÃ³:** docs importantes viven en un wiki externo que se desincronizÃ³; el repo no las enlaza.

**Por quÃ© posibles:**
* costumbre de plataforma;
* miedo a engordar el repo.

**CÃ³mo comprobarlo:** buscar Â«documentaciÃ³n oficialÂ» y ver si estÃ¡ versionada.

**Opciones:** migrar lo crÃ­tico a `docs/` (secciÃ³n 14); dejar el wiki como borrador o eliminarlo.

**Riesgos:** doc sin historia ni revisiÃ³n.

**SoluciÃ³n:** docs-as-code en el repo; wiki solo si el equipo lo mantiene.

**CÃ³mo se evita:** Ã­ndice en README hacia `docs/`.

---

### Error 3: tests enterrados o ausentes

**QuÃ© ocurriÃ³:** pruebas en `misc/pruebas-ana/` o en una rama antigua; el CI no las encuentra.

**Por quÃ©:** sin convenciÃ³n de ubicaciÃ³n (secciÃ³n 21).

**CÃ³mo comprobarlo:** ejecutar la suite documentada; Â¿cubre lo crÃ­tico?

**Opciones:** mover a la convenciÃ³n del ecosistema; aÃ±adir ejecuciÃ³n al CI (secciÃ³n 19).

**Riesgos:** Â«tenemos testsÂ» que nadie ejecuta.

**SoluciÃ³n:** convenciÃ³n + runner obligatorio en PR.

**CÃ³mo se evita:** checklist de PR: Â«tests afectados actualizadosÂ».

---

### Error 4: archivos de contrato copiados sin adaptar

**QuÃ© ocurriÃ³:** CONTRIBUTING habla de comandos que no existen aquÃ­; SECURITY.md con correo de otra empresa.

**Por quÃ©:** se copiÃ³ plantilla sin revisar.

**CÃ³mo comprobarlo:** ejecutar los comandos del CONTRIBUTING; leer el SECURITY.

**Opciones:** personalizar; o empezar mÃ­nimo y crecer.

**Riesgos:** contratos que mienten (peor que no tener).

**SoluciÃ³n:** plantillas + revisiÃ³n de contenido (secciÃ³n 14 cap. 05).

**CÃ³mo se evita:** al clonar plantilla, checklist Â«adaptarÂ».

---

### Error 5: `.github/` incompleto o roto

**QuÃ© ocurriÃ³:** workflows con rutas que no existen, plantillas mal formadas, CODEOWNERS obsoleto.

**Por quÃ©:** se fue aÃ±adiendo sin pruebas.

**CÃ³mo comprobarlo:** ejecutar workflows; abrir la pestaÃ±a de issues/PR y ver las plantillas; revisar dueÃ±os.

**Opciones:** corregir; probar cada pieza al aÃ±adirla (secciÃ³n 19/16).

**Riesgos:** automatizaciÃ³n fantasma (nadie sabe si funciona).

**SoluciÃ³n:** `.github/` se prueba como cÃ³digo.

**CÃ³mo se evita:** revisiÃ³n de platform-config en PR.

---

### Error 6: estructura que no evoluciona (o evoluciona sin avisar)

**QuÃ© ocurriÃ³:** el proyecto creciÃ³ a monorepo/de paquete y la estructura vieja quedÃ³ mitad vacÃ­a; o alguien reorganizÃ³ en un PR gigante y todos perdieron referencias.

**Por quÃ© posibles:**
* crecimiento sin rediseÃ±o;
* reorganizaciÃ³n sin coordinaciÃ³n.

**CÃ³mo comprobarlo:** carpetas vacÃ­as, docs apuntando a rutas viejas, enlaces rotos.

**Opciones:** rediseÃ±o en PR dedicado con enlaces actualizados y aviso (secciÃ³n 14 cap. 01).

**Riesgos:** enlaces rotos por doquier.

**SoluciÃ³n:** mudanzas anunciadas y verificadas (linter de enlaces).

**CÃ³mo se evita:** revisiÃ³n de estructura cuando cambia la fase (secciÃ³n 25).

---

## 6. PrÃ¡ctica guiada

### Objetivo

Transformar un repositorio desordenado en la estructura modelo.

### Paso 1: diagnÃ³stico

```text
Lista la raÃ­z actual y clasifica:
   â”‚
   â”œâ”€â”€ contrato (README, LICENSEâ€¦)
   â”œâ”€â”€ cÃ³digo fuente
   â”œâ”€â”€ pruebas
   â”œâ”€â”€ docs
   â”œâ”€â”€ scripts/configs
   â”œâ”€â”€ automatizaciÃ³n (.github)
   â””â”€â”€ basura/local (Â¿por quÃ© estÃ¡ versionado?)
```

### Paso 2: crea el esqueleto

```bash
mkdir -p src tests docs/guias docs/arquitectura docs/decisiones scripts .github/workflows
```

### Paso 3: mueve con git mv

```bash
git mv archivo.md docs/
git mv pruebas/ tests/
git add -A && git commit -m "chore: reorganiza estructura del repo"
# usa git mv (no mover en el explorador) para
# conservar historia
```

### Paso 4: contratos

1. RaÃ­z: README (enlaces), LICENSE, CONTRIBUTING, SECURITY, CHANGELOG (secciÃ³n 14).
2. `.github/`: CODEOWNERS, plantillas de issue/PR (secciÃ³n 14/16).

### Paso 5: verifica enlaces

```text
Recorre README y docs/:
   â”‚
   â”œâ”€â”€ Â¿todos los enlaces relativos resuelven?
   â”œâ”€â”€ Â¿los comandos del CONTRIBUTING funcionan?
   â””â”€â”€ Â¿SECURITY.md tiene canal real?
```

### Paso 6: escribe la convenciÃ³n

1. AÃ±ade al CONTRIBUTING un bloque Â«Estructura del repoÂ» con el mapa (punto 2) y la regla de entrada de archivos.

### Resultado esperado

RaÃ­z con 6-7 entradas, carpetas por propÃ³sito, `.github/` completo y convenciÃ³n escrita.

### ConclusiÃ³n esperada

La estructura es el primer documento que lee un colaborador â” y se mantiene como se mantiene el cÃ³digo.
La estructura es el primer documento que lee un colaborador — y se mantiene como se mantiene el código.
### Ejercicio de transferencia

Aplica la estructura de repositorio profesional a un repositorio de solo documentación (por ejemplo, un blog con Markdown). Crea las carpetas `docs/`, `scripts/`, `.github/` y los archivos de contrato (README, LICENSE, CONTRIBUTING).
Entrega una captura del árbol de carpetas o un archivo `ESTRUCTURA.md` que liste la estructura creada.
---

## 7. Nivel profesional + resumen

### 7.1. Repos como producto

```text
   â”‚
   â”œâ”€â”€ plantilla de organizaciÃ³n: estructura +
   â”‚   `.github/` + contratos clonables (cap. 02)
   â”‚
   â”œâ”€â”€ linter de enlaces y docs en CI (secciÃ³n 19)
   â”‚
   â”œâ”€â”€ revisiÃ³n periÃ³dica: enlaces, contratos,
   â”‚   obsolescencia
   â”‚
   â”œâ”€â”€ monorepos: raÃ­z con paquetes/apps claros +
   â”‚   filtros de CI por path (secciÃ³n 19/25)
   â”‚
   â””â”€â”€ mÃ©trica informal: Â«tiempo de onboarding de un
       repo nuevoÂ» (secciÃ³n 26)
```

### 7.2. Resumen

En este capÃ­tulo aprendiste que:

* la estructura se diseÃ±a por propÃ³sito con convenciÃ³n de ecosistema: raÃ­z como Ã­ndice, `src`/`tests`/`docs`/`scripts`/`.github`;
* la raÃ­z contiene los contratos (README, LICENSE, CONTRIBUTING, COC, SECURITY, CHANGELOG) enlazados entre sÃ­;
* `.github/` es el directorio del equipo: workflows, plantillas, CODEOWNERS, dependabot â€” clonable desde plantillas de org;
* los errores tÃ­picos (raÃ­z caÃ³tica, docs fuera, tests enterrados, contratos sin adaptar, `.github/` roto, mudanzas sin avisar) se previenen con convenciÃ³n y verificaciÃ³n;
* a nivel profesional: plantillas de org, linter de enlaces y mÃ©trica de onboarding.

La idea principal es:

> **Un repo profesional se entiende de pie: raÃ­z como Ã­ndice, cada cosa en su propÃ³sito y los contratos donde la plataforma â€” y las personas â€” los buscan.**

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruÃ©balo con este capÃ­tulo:

1. Â¿Por quÃ© es importante que la raÃ­z de un repositorio profesional tenga solo 5-7 entradas claramente definidas?
2. Â¿QuÃ© problemas pueden surgir si los archivos de contrato (README, LICENSE, etc.) se encuentran fuera de la raÃ­z del repositorio?
3. Â¿CÃ³mo afecta la separaciÃ³n por propÃ³sito (src, tests, docs, .github) a la escalabilidad de un proyecto a medida que crece?
4. Â¿QuÃ© consecuencias tiene mantener documentaciÃ³n externa (como en un wiki) en lugar de dentro del repositorio bajo docs/?
5. Â¿Por quÃ© es necesario probar los workflows de .github/ como cÃ³digo antes de fusionarlos en la rama principal?
6. Â¿CÃ³mo influye una estructura de repositorio bien definida en el tiempo de incorporaciÃ³n de un nuevo colaborador?
7. Â¿QuÃ© riesgos existen al copiar plantillas de contrato sin adaptarlas al contexto especÃ­fico del proyecto?

## PrÃ³ximo paso

Ya tienes el mapa del repositorio.

El siguiente paso: convertir ese mapa en plantilla reutilizable para todo el equipo.

ContinÃºa con:

[`02-plantillas-de-repositorio-y-starter-workflows.md`](02-plantillas-de-repositorio-y-starter-workflows.md)

