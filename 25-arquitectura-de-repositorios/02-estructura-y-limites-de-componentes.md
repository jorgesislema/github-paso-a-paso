# Estructura y límites de componentes

## Introducción

Dentro del repositorio — monorepo o no — aparece la misma pregunta en miniatura: **¿dónde empieza y acaba cada componente?** La estructura del árbol y los límites entre partes determinan cómo se revisa, se prueba, se despliega y se protege cada pieza. Este capítulo trata la estructura como contrato: carpetas con significado, interfaces explícitas entre componentes y mecanismos (en Git y en el lenguaje) que hacen cumplir el límite.

---

## Mapa conceptual de este capítulo

```text
Estructura y límites de componentes
       │
       ├── 1. Estructura que se lee sola
       ├── 2. Límites: por qué duele cruzarlos
       │   ├── 3. Interfaces y contratos entre partes
       │   ├── 4. Mecanismos que hacen cumplir el límite
       │   └── 5. Estructura heredada (cuando ya existe)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Estructura que se lee sola

```text
PRINCIPIOS:
   │
   ├── carpetas por ROL en el sistema: src · tests ·
   │   docs · scripts · config (sección 02/21)
   │
   ├── nombres que no mienten (carpeta "utils" que
   │   crece para siempre es deuda — Error 1)
   │
   ├── la raíz responde: ¿qué es esto? ¿cómo se
   │   ejecuta? ¿dónde están las piezas? (README —
   │   sección 14 cap. 02)
   │
   └── profundidad acotada: si para abrir un archivo
       necesitas 7 niveles, la estructura es un laberinto
```

```text
EN MONOREPO (árbol de componentes):
   │
   ├── apps/        → desplegables
   ├── packages/    → librerías compartidas
   ├── services/    → servicios (si aplica)
   └── infra/       → descriptores de entorno
       (sección 23 cap. 04)
```

```text
   │
   └── el árbol es el PRIMER DOCUMENTO: quien lo
       entiende entiende el sistema sin leer código
       (sección 25 cap. 01 — Error 2 si la estructura
       no refleja la arquitectura)
```

---

## 2. Límites: por qué duele cruzarlos

```text
QUÉ ES UN LÍMITE:
   │
   └── la frontera entre componentes: lo que PUEDE
       importarse, llamarse o tocarse entre partes
```

```text
CÓMO SE PAGA SU AUSENCIA:
   │
   ├── el componente A importa internidades de B →
   │   B ya no puede cambiar sin romper A (acoplamiento
   │   fantasma — Error 2)
   │
   └── en multirepo: la dependencia interna sin
       contrato se vuelve versión rota (sección 01
       cap. 03 Error 5)
```

```text
SEÑALES DE LÍMITE DIFUNTO:
   │
   ├── imports que atraviesan «carpetas privadas»
   │
   ├── cambios que SIEMPRE tocan 3 componentes
   │
   └── tests de A que dependen de internals de B
```

```text
   │
   └── el límite no es burocracia: es lo que permite
       cambiar una pieza sin mirar todas (Error 4 si
       se prohíbe «cualquier cosa» — el límite protege
       la libertad de cada lado, no la bloquea)
```

---

## 3. Interfaces y contratos entre partes

```text
QUÉ ES LA INTERFAZ (aquí):
   │
   ├── lo que un componente EXPONE a los demás: API,
   │   tipos, eventos, CLI, archivo de config
   │
   └── lo que NO expone es interno — y el límite lo
       defiende
```

```text
CONTRATOS QUE EVITAN LOS ERRORES CRUZADOS:
   │
   ├── versionado de lo compartido (semver — sección
   │   17 cap. 05)
   │
   ├── cambios compatibles primero (expand/contract —
   │   sección 22 cap. 06)
   │
   ├── pruebas de contrato (sección 22 cap. 03 punto
   │   8.1): «si doy esto, espero aquello»
   │
   └── documentación mínima de la interfaz: quién la
       usa, qué garantiza, qué NO garantiza
```

```text
   │
   └── «interfaz pública» es una DEUDA documentada:
       cambiarla tiene costo (migración de sus
       consumidores) — y eso se dice al cambiarla
       (Error 5)
```

---

## 4. Mecanismos que hacen cumplir el límite

```text
EN EL LENGUAJE/HERRAMIENTA (los más usados):
   │
   ├── módulos con visibilidad (público/privado)
   │
   ├── análisis de dependencias/importos (linters o
   │   herramientas que prohíben cruces — categoría)
   │
   └── en monorepo: reglas por ruta/área («apps no
       importa internals de otro app»)
```

```text
EN GIT/GITHUB:
   │
   ├── CODEOWNERS por área: el límite SOCIAL — quien
   │   es dueño de la zona que se toca (sección 16
   │   cap. 06)
   │
   ├── paths de CI: los tests del componente afectado
   │   (sección 04 de esta sección)
   │
   └── protection por rama/ruta donde aplique (sección
       20 cap. 06 — rulesets)
```

```text
   │
   └── el mejor límite es AUTOMÁTICO: el que el PR
       sin dueño correcto ni test no pasa solo
       (Error 6 si el límite es solo «acordamos
       no…»)
```

---

## 5. Estructura heredada (cuando ya existe)

```text
REGLA PRIMERA: no se reestructura por estética
   │
   ├── reestructurar = tocar TODOS los imports → PR
   │   gigante, riesgo real (sección 08: operación
   │   delicada)
   │
   └── se reestructura cuando el DOLOR (Error 1/2
       anteriores) es mayor que el PR
```

```text
CÓMO EVOLUCIONAR SIN DRAMA:
   │
   ├── convenciones nuevas SOLO en código nuevo (zona
   │   limpia primero)
   │
   ├── migrar por partes (carpeta a carpeta, con tests
   │   verdes)
   │
   └── documentar el «estado actual vs. deseado» para
       que nadie añada nuevo en el estilo viejo por
       costumbre
```

```text
   │
   └── la estructura es CÓDIGO compartido: se propone
       como PR con el mismo proceso (punto 3/4 de la
       sección 01 DevOps)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: carpetas que significan «lo demás»

**Qué ocurrió:** `misc/`, `temp/`, `utils/` con 200 archivos sin relación.

**Por qué:** crecimiento sin diseño (punto 1).

**Cómo comprobarlo:** listar esas carpetas: ¿nadie sabe qué llevarían?

**Opciones:** reubicar con PRs pequeños y tests verdes; definir criterio de entrada.

**Riesgos:** el vertedero que nadie auditó.

**Solución:** nombres con rol (punto 1).

**Cómo se evita:** revisión de estructura en PRs grandes (sección 15).

---

### Error 2: imports cruzando límites privados

**Qué ocurrió:** A importaba helpers internos de B; un refactor de B rompió 3 componentes.

**Por qué:** sin mecanismo que lo impida (punto 2/4).

**Cómo comprobarlo:** análisis de dependencias o búsqueda de imports prohibidos.

**Opciones:** exponer interfaz mínima; regla automática de cruces; revisar en PR.

**Riesgos:** acoplamiento que crece en silencio.

**Solución:** límite automático (punto 4).

**Cómo se evita:** empezar con la regla antes de que duela.

---

### Error 3: interfaz pública sin definir

**Qué ocurrió:** «lo público» era todo: cualquier consumidor usaba cualquier cosa; nadie podía cambiar nada.

**Por qué:** no se dibujó la interfaz (punto 3).

**Cómo comprobarlo:** ¿hay lista de «lo que exponemos»? ¿documentación mínima?

**Opciones:** definir la superficie pública; migrar consumidores al uso correcto por partes.

**Riesgos:** parálisis evolutiva.

**Solución:** interfaz explícita (punto 3).

**Cómo se evita:** checklist al añadir componente nuevo.

---

### Error 4: límite como muro absoluto

**Qué ocurrió:** regla «nadie toca nada de nadie» → los cambios legítimos se volvieron trámites imposibles.

**Por qué:** se confundió proteger con impedir (punto 2).

**Cómo comprobarlo:** PRs estancados esperando permiso de otra área.

**Opciones:** redibujar: qué cruces son legítimos (vía interfaz) y cómo se aprueban (dueños).

**Riesgos:** burocracia y bypass.

**Solución:** límite con pasarela (punto 3/4).

**Cómo se evita:** revisar la regla cuando fricciona más de lo que protege.

---

### Error 5: cambiar interfaz pública como si fuera interna

**Qué ocurrió:** un rename «inocente» rompió a todos los consumidores a la vez.

**Por qué:** sin costo de versión/migración (punto 3).

**Cómo comprobarlo:** ¿los cambios de interfaz tienen versión y comunicado?

**Opciones:** semver + deprecación con plazo (sección 17 cap. 05) + migración compat primero.

**Riesgos:** rotura en cadena.

**Solución:** contrato con costo explícito (punto 3).

**Cómo se evita:** revisador de interfaz en el PR (dueño del componente).

---

### Error 6: límite que es solo una conversación

**Qué ocurrió:** «acordamos que apps no toca packages» — y un PR lo rompió sin que nadie lo notara.

**Por qué:** regla sin guardia (punto 4).

**Cómo comprobarlo:** ¿hay check automático o dueño que lo verifique?

**Opciones:** automatizar la regla (lint/análisis o review por CODEOWNERS de la zona).

**Riesgos:** acuerdo que se olvida en la primera prisa.

**Solución:** mecanismo, no acuerdo (punto 4).

**Cómo se evita:** plantilla de repo con las reglas aplicadas.

---

## 7. Práctica guiada

### Objetivo

Auditar la estructura y dibujar los límites de tu proyecto.

### Paso 1: árbol leíble

```text
1. Dibuja tu árbol real (ls / explorador)
2. ¿Un recién llegado entiende la raíz en 2 minutos?
   (README + carpetas con rol claro)
3. Lista carpetas «sin rol» (Error 1)
```

### Paso 2: mapa de dependencias

```text
Componente → ¿qué importa de otros?
   │
   ├── ¿imports cruzando privados?
   └── ¿cambios que siempre tocan N piezas?
```

1. Señala los cruces y clasifica: legítimo (interfaz) o problema (acoplamiento).

### Paso 3: la interfaz

1. Para el componente más tocado: escribe su superficie pública (qué expone y qué NO).
2. Añade la nota de compatibilidad: «cambiar esto cuesta migración».

### Paso 4: guardia

1. Elige el mecanismo disponible a tu alcance: regla de lint/análisis de imports, o CODEOWNERS por área + revisador.
2. Aplícalo a la regla más importante (punto 4).

### Paso 5: camino de la estructura heredada

1. Si hay caos: escribe «actual → deseado» y el PR 1 que reduce dolor sin reescribir todo (punto 5 — zona limpia primero).

### Paso 6: documenta

```markdown
## Estructura y límites
- Árbol y significado: [diagrama]
- Superficie pública de [componente]: [lista]
- Cruces permitidos: [cuáles y por dónde]
- Regla automática: [cuál está activa]
```

### Resultado esperado

Árbol leído, cruces clasificados, una interfaz definida y una guardia activa.

### Conclusión esperada

La estructura es el primer contrato del repo: si las carpetas se leen, las interfaces se nombran y los límites se verifican solos, el sistema puede crecer sin volverse una pelota de ratoneras.

---

## 8. Nivel profesional + resumen

### 8.1. Límites a escala

```text
   │
   ├── OWNERS/CODEOWNERS por área como mapa vivo de
   │   responsabilidad (sección 16 cap. 06)
   │
   ├── reglas de dependencias automatizadas (áreas
   │   permitidas/prohibidas) en la plantilla del repo
   │
   ├── versionado de interfaces internas con
   │   deprecaciones gestionadas (sección 17 cap. 05)
   │
   ├── revisión de arquitectura cuando los cruces
   │   aumentan (sección 26 — decisión técnica)
   │
   └── métrica: cruces por cambio, PRs que tocan > N
       componentes, interfaces públicas con dueño
```

### 8.2. Resumen

En este capítulo aprendiste que:

* la estructura se lee sola: carpetas por rol, nombres honestos, raíz explicada;
* los límites protegen la libertad de cambiar una pieza; su ausencia se paga en acoplamiento fantasma;
* interfaces explícitas con contrato (versión, compatibilidad, pruebas) — cambiarlas tiene precio documentado;
* los mecanismos (visibilidad, análisis de imports, CODEOWNERS, paths de CI) convierten el límite en cosa automática;
* la estructura heredada se evoluciona con zonas limpias y PRs pequeños, no por estética;
* los errores típicos (carpetas cajón, cruces, interfaz indefinida, muro, interfaz que se rompe, regla sin guardia) se previenen con diseño y automatización;
* a nivel profesional: mapa vivo de responsabilidad y métricas de acoplamiento.

La idea principal es:

> **Los buenos límites no impiden trabajar: hacen que trabajar dentro de cada pieza sea predecible — y los que valen son los que el PR no puede saltarse sin que alguien legítimo lo note.**

---

## Próximo paso

Ya conoces estructura y límites.

Ahora la capa que gobierna todo: permisos, políticas y estándares a escala.

Continúa con:

[`03-permisos-y-gobernanza.md`](03-permisos-y-gobernanza.md)
