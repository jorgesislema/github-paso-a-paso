# Análisis dinámico (DAST)

## Introducción

**DAST** (Dynamic Application Security Testing) prueba el sistema ya desplegado: le manda peticiones por la red y observa respuestas — como un atacante automático de bajo nivel, pero en tu entorno controlado. Es el complemento del SAST: uno lee el código, el otro lo provoca corriendo. Este capítulo explica qué ve y qué no ve el DAST, dónde vive en tu flujo (staging), cómo manejar autenticación y alcance, y por qué sin humo y entornos saneados el DAST es inútil.

---

## Mapa conceptual de este capítulo

```text
Análisis dinámico (DAST)
       │
       ├── 1. Qué prueba un DAST (y qué no puede ver)
       ├── 2. Dónde vive en el flujo (staging)
       │   ├── 3. Alcance, autenticación y cuidados
       │   ├── 4. DAST y API (mención)
       │   └── 5. Complementariedad: SAST + DAST + humo
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Qué prueba un DAST (y qué no puede ver)

```text
LO QUE PROVOCA (sin conocer tu código):
   │
   ├── entradas maliciosas a forms, parámetros, cabeceras
   ├── escaneo de rutas expuestas
   ├── versiones conocidas de componentes expuestos
   └── configuraciones inseguras visibles por red
       (TLS, cabeceras, cookies)
```

```text
LO QUE NO VE (límites claros):
   │
   ├── la lógica interna: un problema en una rama de
   │   código que no provoca su herramienta
   │
   ├── secretos en el código o en el historial
   │   (SAST/secretos — sección 20 cap. 02/04)
   │
   ├── dependencias no expuestas por la red
   │   (sección 20 cap. 03)
   │
   └── «lo que no está desplegado»: solo prueba lo
       vivo (Error 1 si se pide lo contrario)
```

```text
   │
   └── DAST es una SONDA, no una prueba de todo: su
       valor es lo que encuentra en lo que SÍ corre
       (Error 1)
```

---

## 2. Dónde vive en el flujo (staging)

```text
POR QUÉ NO EN PRODUCCIÓN (con conclusiones):
   │
   ├── el escaneo genera carga y entradas rarísimas —
   │   en prod molesta o asusta (Error 2)
   │
   └── el lugar natural: STAGING con el artefacto real
       (sección 22 cap. 04 — entornos gemelos)
```

```text
CADENA CORRECTA:
──────────────────────────────────────────────────────
PR      → SAST + secretos + deps (rápidos)
main    → build del artefacto
staging → despliegue + humo + DAST (profundo)
release → gate con resultados
```

```text
CADENCIA:
   │
   ├── en cambios: DAST acotado del camino nuevo
   │   (si el tiempo lo permite)
   │
   ├── en main/schedule: barrido completo
   │
   └── siempre: resultado del escaneo = input del gate
       (bloqueante por severidad — política del cap.
       02 punto 2)
```

```text
   │
   └── sin staging fiel, el DAST miente: prueba una
       sombra de lo real (Error 3)
```

---

## 3. Alcance, autenticación y cuidados

```text
ALCANCE (lo primero que se define):
   │
   ├── SOLO tus hosts/entornos de prueba (nada de
   │   terceros «de paso» — Error 4)
   │
   ├── qué rutas/roles cubre (el escaneo ciego se
   │   pierde tu lógica protegida)
   │
   └── ventana: cuándo corre (para no pisar pruebas
       del equipo)
```

```text
AUTENTICACIÓN:
   │
   ├── muchas vulnerabilidades viven DETRÁS del login
   │   → el escaneo necesita sesión de prueba
   │
   ├── usar cuentas DEDICADAS de staging (nunca datos
   │   reales — sección 21 cap. 06)
   │
   └── credenciales de la cuenta de prueba en
       secretos del pipeline (sección 19 cap. 04)
```

```text
CUIDADOS:
   │
   ├── datos de prueba sintéticos en staging (sección
   │   21 cap. 03/06)
   │
   ├── resultados: tratarlos como información sensible
   │   (los hallazgos describen cómo atacarte —
   │   compartir con cuidado)
   │
   └── integración: correr en CI/CD con gate (cap. 02
       punto 2), no como evento «heroico» manual
```

```text
   │
   └── un DAST sin cuentas ni alcance definido corre y
       no encuentra lo importante (Error 5)
```

---

## 4. DAST y API (mención)

```text
APIS (superficie típica hoy):
   │
   ├── el DAST clásico de páginas no entiende bien
   │   APIs: se usan escáneres con soporte de API
   │   (OpenAPI/contractos — mención de categoría)
   │
   ├── pruebas específicas: autenticación/autorización
   │   (¿el endpoint 5 me deja ver datos del usuario
   │   4?), validación de esquema, límites de tasa
   │
   └── aquí las PRUEBAS DE CONTRATO (sección 22 cap.
       03 punto 8.1) también son seguridad: «otro
       rol no puede» se automatiza como test
```

```text
   │
   └── en API, un test automatizado de permisos suele
       encontrar más que un barrido genérico — combina
       ambas (Error 6 relacionado: solo barrido)
```

---

## 5. Complementariedad: SAST + DAST + humo

```text
CADA UNO RESUELVE UN AGUJERO DISTINTO:
   │
   ├── SAST      → errores en el código fuente
   ├── secretos  → credenciales en historial/config
   ├── deps      → bibliotecas vulnerables
   ├── DAST      → lo expuesto corriendo (red)
   └── humo     → ¿sirve? (salud, caminos — sección
       22 cap. 04)
```

```text
EJEMPLO DE COLABORACIÓN:
   │
   ├── SAST encuentra un XSS potencial (código)
   │
   ├── DAST lo confirma provocándolo en staging (o
   │   encuentra uno que SAST no entendió)
   │
   └── el humo sigue pasando (el sistema sigue
       sirviendo mientras se arregla)
```

```text
   │
   └── el programa (cap. 01/06) decide cuánto de cada
       uno según riesgo — no existe la herramienta
       única que lo cubra todo (Error 1)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: pedirle al DAST «cubre mi código entero»

**Qué ocurrió:** expectativa de cobertura total; decepción y abandono de la herramienta.

**Por qué:** no se entendieron sus límites (punto 1).

**Cómo comprobarlo:** ¿alguien sabe qué NO ve el escaneo?

**Opciones:** formación de una página: qué ve/no ve; complementar con SAST y tests de contrato.

**Riesgos:** herramienta mal usada desacreditada.

**Solución:** complementariedad (punto 5).

**Cómo se evita:** documento de controles (sección 01 Paso 5).

---

### Error 2: escaneo contra producción

**Qué ocurrió:** el barrido generó picos de carga y una alarma que despertó al equipo (o peor).

**Por qué:** no había staging, o se corrió «para probar» (punto 2).

**Cómo comprobarlo:** destinos históricos del escáner.

**Opciones:** solo entornos de prueba con ventana; si no hay staging, empezar por él (sección 22 cap. 04).

**Riesgos:** autoincapacitación o daño.

**Solución:** staging y alcance (punto 2/3).

**Cómo se evita:** política escrita de dónde corre el DAST.

---

### Error 3: staging desactualizado (el DAST prueba mentiras)

**Qué ocurrió:** el escaneo pasaba verde sobre la versión N-1 mientras producción corría la N.

**Por qué:** entornos divergentes (sección 22 cap. 04 Error 3).

**Cómo comprobarlo:** versiones: ¿staging = último main?

**Opciones:** despliegue automático a staging en cada main + registro de versiones (sección 22 cap. 05).

**Riesgos:** verde irrelevante.

**Solución:** entorno fiel (punto 2).

**Cómo se evita:** el carril de la sección 22 como base (Error 3).

---

### Error 4: alcance sin definir (o demasiado amplio)

**Qué ocurrió:** el escáner tocó servicios que no eran del ejercicio o descubrió URLs que tocaban terceros.

**Por qué:** sin lista de alcance (punto 3).

**Cómo comprobarlo:** ¿dónde está definido el alcance? ¿quién lo aprobó?

**Opciones:** whitelist explícita de hosts/rutas; revisión del alcance en cada cambio de arquitectura.

**Riesgos:** daño colateral y hallazgos irrelevantes.

**Solución:** alcance cerrado (punto 3).

**Cómo se evita:** configuración versionada del escáner.

---

### Error 5: sin sesión (el escáner solo ve el lobby)

**Qué ocurrió:** hallazgos siempre de login y páginas públicas; el 80% protegido sin cubrir.

**Por qué:** no se configuró autenticación (punto 3).

**Cómo comprobarlo:** ¿qué rutas cubre el reporte? ¿las del usuario?

**Opciones:** cuenta de prueba dedicada + sesión en el escáner; pruebas por rol (punto 4).

**Riesgos:** cobertura de fachada.

**Solución:** autenticación y roles (punto 3/4).

**Cómo se evita:** parte de la plantilla del escaneo.

---

### Error 6: solo barrido genérico en API

**Qué ocurrió:** las APIs pasaban el barrido pero fallaban en autorización (IDs enumerables).

**Por qué:** el barrido no prueba lógica de negocio (punto 4).

**Cómo comprobarlo:** ¿hay tests de permisos en la suite?

**Opciones:** tests de contrato/autorización automatizados + escáner con soporte de API.

**Riesgos:** el agujero más común de API invisible.

**Solución:** combinar barrido y contratos (punto 4).

**Cómo se evita:** sección 09 (tests) + 22 cap. 03 (contrato).

---

## 7. Práctica guiada

### Objetivo

Montar el primer escaneo dinámico en staging con alcance y gate.

### Paso 1: entorno

```text
Requisitos previos:
   │
   ├── staging desplegado desde el carril (versión
   │   registrada — sección 22)
   ├── datos sintéticos
   └── cuenta de prueba de staging (secretos)
```

### Paso 2: elige herramienta y alcance

1. Escoge un escáner de tu plataforma/ecosistema (DAST open source o el servicio de tu plan).
2. Define whitelist: hosts de staging, rutas a cubrir, ventana de ejecución.

### Paso 3: sesión

1. Configura autenticación con la cuenta de prueba (los detalles según la herramienta).

### Paso 4: primer barrido

```text
Corre en staging:
   │
   ├── revisa el reporte: ¿encuentra algo? ¿de qué
   │   severidad?
   └── valida manualmente UN hallazgo (¿real? — como
       el triage del cap. 02)
```

### Paso 5: gate

1. Integra el escaneo en el pipeline de staging/main con política: crítico bloquea, resto a backlog (cap. 02 punto 2).

### Paso 6: política y medición

```markdown
## DAST
- Dónde: solo staging (nunca producción)
- Alcance: [hosts/rutas] + ventana [cuándo]
- Sesión: cuenta de prueba dedicada (secretos)
- Gate: críticos bloquean release; resto → backlog
- Cadencia: barrido en main + acotado en cambios
```

1. Anota línea base: hallazgos por barrido y duración.

### Resultado esperado

Primer barrido en staging con alcance y sesión, un hallazgo triado y gate con política.

### Conclusión esperada

DAST es la sonda de tu sistema vivo: funciona cuando el entorno es fiel, el alcance es tuyo y su informe entra en el mismo proceso de decisión que todo lo demás.

---

## 8. Nivel profesional + resumen

### 8.1. DAST a escala

```text
   │
   ├── escaneo como parte del carril de staging con
   │   gate y registro (sección 22/24)
   │
   ├── alcance y ventanas gobernados por equipo
   │   (evitar tormentas de escáneres)
   │
   ├── API: escáner con contrato + tests de
   │   autorización (punto 4)
   │
   ├── resultados con dueño y SLA (cap. 06)
   │
   ├── complemento: pentest humano periódico para lo
   │   que las máquinas no imaginan (mención: servicio
   │   externo cuando el riesgo lo justifica)
   │
   └── métrica: hallazgos por barrido, tiempo de
       corrección por severidad, cobertura de rutas
       autenticadas
```

### 8.2. Resumen

En este capítulo aprendiste que:

* DAST prueba lo corriendo: ve lo expuesto por red; no ve el código, secretos ni lo no desplegado;
* vive en staging fiel, con alcance cerrado, cuentas dedicadas y ventana — jamás improvisado en producción;
* las APIs piden contrato y tests de autorización, no solo barrido;
* SAST + secretos + deps + DAST + humo son capas con agujeros distintos que se solapan;
* los errores típicos (expectativa total, prod como objetivo, staging viejo, alcance difuso, sin sesión, solo barrido) se previenen con diseño y política;
* a nivel profesional: gate integrado y métricas de corrección.

La idea principal es:

> **Probar en vivo solo vale si el vivo es fiel: staging actualizado, alcance tuyo y cuentas de mentira — el resto del valor está en meter su informe en el mismo gate que decide el release.**

---

## Próximo paso

Ya tienes las dos puntas del análisis.

Ahora la infraestructura que ejecuta todo el flujo: la seguridad de los pipelines y despliegues.

Continúa con:

[`04-seguridad-de-pipelines-y-despliegues.md`](04-seguridad-de-pipelines-y-despliegues.md)
