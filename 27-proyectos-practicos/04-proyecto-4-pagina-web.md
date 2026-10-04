# Proyecto 4: página web

## Introducción

El Proyecto 4 convierte el sitio en un proyecto de ingeniería: una **página web real** con estructura de código, herramientas de calidad automatizadas y un pipeline formal. Aquí se incorpora lo estudiado en las secciones 19 (GitHub Actions) y 20 (seguridad básica): checks que se ejecutan solos, dependencias vigiladas y un despliegue que ya no es un script personal sino un workflow verificable.

---

## Mapa conceptual de este capítulo

```text
Proyecto 4: página web
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. Requisitos del proyecto
       │   ├── 3. El pipeline mínimo de calidad
       │   └── 4. Despliegue como workflow
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO:
   │
   ├── sitio web (estático o con build: HTML/CSS/JS,
   │   o framework ligero de tu elección) con varias
   │   páginas, estilos y contenido propio
   │
   └── la diferencia con el Proyecto 3: el VALOR está
       en el pipeline COMPLETO (build + calidad +
       despliegue) — el sitio debe pasar pruebas
       solas antes de publicarse
```

```text
CONCEPTOS NUEVOS (secciones 19/20/22):
   │
   ├── workflow con jobs, steps y triggers (sección 19)
   ├── checks que BLOQUEAN (status checks — Error 1 si
   │   son decorativos)
   ├── lint/validación (sección 19/21)
   ├── Dependabot: dependencias vigiladas (sección 20
   │   cap. 03)
   └── despliegue automático tras checks verdes
       (sección 22 cap. 04 — CD ligero)
```

```text
   │
   └── el salto conceptual: de «publico cuando quiero»
       a «solo lo VERIFICADO se publica» (Error 2 si
       el despliegue no espera a los checks)
```

---

## 2. Requisitos del proyecto

```text
SITIO:
   │
   ├── ≥ 4 páginas/pantallas con navegación
   ├── estilos organizados (archivos separados —
   │   sección 21 cap. 06: nada de un solo archivo
   │   monolítico gigante)
   ├── accesibilidad básica (contraste, textos
   │   alternativos — sección 14 cap. 03 mención)
   └── README: arquitectura del sitio + cómo ejecutar
       en local
```

```text
CALIDAD AUTOMATIZADA (el corazón del proyecto):
   │
   ├── workflow que corre en PR y en main (sección 19
   │   cap. 02: triggers `pull_request` + `push`)
   ├── pasos: build + lint/validación (+ pruebas si tu
   │   stack las tiene)
   ├── el check es OBLIGATORIO para mergear (protege la
   │   rama con el check requerido — Error 3 si
   │   cualquiera puede saltárselo)
   └── ≤ 5 minutos (presupuesto — sección 04 cap. 25)
```

```text
SEGURIDAD MÍNIMA:
   │
   ├── Dependabot activado (sección 20 cap. 03)
   └── sin secretos en el repo (sección 20 cap. 01 —
       si usas tokens, van a secrets del repo —
       Error 4 si van en código)
```

```text
DESPLIEGUE:
   │
   ├── al fusionar a main: build + publicación
   │   AUTOMÁTICA (sección 19 cap. 04 / 22 cap. 04)
   └── historial de deploys visible (runs del workflow
       — sección 19 cap. 03)
```

```text
   │
   └── requisito de entrega: un PR que NO pasa los
       checks y NO se puede mergear (Error 5 si nunca
       lo demuestras: no probaste que la puerta cierra)
```

---

## 3. El pipeline mínimo de calidad

```text
DISEÑO (aplicable a cualquier stack):
   │
   ├── trigger: pull_request + push a main
   ├── job 1 «calidad»:
   │     steps: checkout → setup → instalar →
   │     build → lint/validar
   └── (opcional job 2 «deploy») depende de «calidad»
       y solo en main (Error 6 si se pisan: deploy
       sin esperar)
```

```text
LO QUE APRENDES AL CONSTRUIRLO:
   │
   ├── a leer un log de workflow (sección 19 cap. 06:
   │   debugging)
   ├── a fijar versiones de acciones (sección 19 cap.
   │   05 Error 1 — referencias a versión)
   └── a caché de dependencias si el install es lento
       (sección 22 cap. 02)
```

```text
   │
   └── el pipeline es DOCUMENTO: en el README explica
       qué hace cada job (Error 7 si solo tú lo
       entiendes)
```

---

## 4. Despliegue como workflow

```text
DESPUÉS DE LOS CHECKS (sección 22 cap. 04):
   │
   ├── build reproducible (mismo comando de siempre)
   ├── publicación al hosting (el mecanismo que ofrezca
   │   tu plataforma — categoría)
   └── verificación post: el sitio responde (humo
       mínimo — sección 23 cap. 06 en versión pequeña)
```

```text
QUÉ NO HACES (a propósito, todavía):
   │
   ├── entornos múltiples con gates por riesgo (Proyecto
   │   final / sección 22)
   └── firma de artefactos (sección 24) — conociendo
       que existen (Error 8 si los copias sin
       necesidad: proceso de gigante, Error 4 sección
       15)
```

```text
   │
   └── con esto tu despliegue tiene HISTORIA: cada
       publicación es un run con fecha, autor y resultado
       — «¿cuándo se desplegó X?» tiene respuesta
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: checks decorativos

**Qué ocurrió:** el workflow existía pero no estaba requerido; se fusionó con build rojo.

**Por qué:** sin protección de rama con check obligatorio (punto 2).

**Cómo comprobarlo:** configura la rama: ¿el check aparece como «required»?

**Opciones:** requerirlo; probar con un PR que lo rompa (punto 2 requisito).

**Riesgos:** falsa sensación de control (Error 3 sección 26 cap. 02).

**Solución:** check bloqueante (punto 2).

**Cómo se evita:** la prueba de «PR que no pasa» en la entrega.

---

### Error 2: despliegue sin esperar a la calidad

**Qué ocurrió:** deploy corrió en paralelo al build; se publicó una versión rota.

**Por qué:** jobs sin dependencia (punto 4 Error 6).

**Cómo comprobarlo:** revisar `needs:`/dependencias del workflow.

**Opciones:** encadenar: deploy solo si calidad pasó.

**Riesgos:** producción recibiendo errores.

**Solución:** deploy después de checks (punto 4).

**Cómo se evita:** diagrama mental: calidad → despliegue.

---

### Error 3: cualquiera puede saltarse el check

**Qué ocurrió:** un admin hizo merge forzando la rama; el pipeline quedó sin sentido.

**Por qué:** protección incompleta (sección 20 cap. 06).

**Cómo comprobarlo:** ¿el administrador puede forzar? ¿se permite bypass?

**Opciones:** prohibir force-push y bypass en main; excepción escrita si es imprescindible (sección 25 cap. 03 punto 5).

**Riesgos:** el control existe solo cuando nadie tiene prisa.

**Solución:** protección real (Error 3 punto 2).

**Cómo se evita:** revisión de reglas con la matriz (sección 25 cap. 03).

---

### Error 4: secretos en el repositorio

**Qué ocurrió:** un token de servicio quedó en el código «temporalmente».

**Por qué:** sin hábito de secrets (sección 20 cap. 01).

**Cómo comprobarlo:** secret scanning (sección 20 cap. 02) y búsqueda en el historial.

**Opciones:** rotar el token YA, sacarlo del historial si es posible, usar secrets del repositorio.

**Riesgos:** robo de credencial (sección 20 cap. 01 Error 1).

**Solución:** secrets de la plataforma (punto 2 Error 4).

**Cómo se evita:** checklist: «¿algún token en el diff?».

---

### Error 5: nunca se probó que la puerta cierra

**Qué ocurrió:** el check estaba «required», pero nadie había visto un PR rechazado.

**Por qué:** se dio por hecho (punto 2 Error 5).

**Cómo comprobarlo:** abre un PR con un error deliberado de lint.

**Opciones:** hacer la prueba ahora; si pasa el merge, el control está mal.

**Riesgos:** descubrir el hueco en el peor momento.

**Solución:** prueba negativa (punto 2).

**Cómo se evita:** todo control nuevo se prueba rompiéndolo.

---

### Error 6: deploy y calidad sin dependencia

**Qué ocurrió:** dos jobs independientes; deploy terminó primero con artefacto viejo.

**Por qué:** estructura del workflow (punto 4 Error 6).

**Cómo comprobarlo:** leer la definición: ¿`needs`?

**Opciones:** encadenar jobs; publicar SOLO artefacto del build aprobado (sección 22 cap. 05).

**Riesgos:** versiones cruzadas.

**Solución:** cadena calidad → deploy (punto 4).

**Cómo se evita:** revisión del workflow en el PR que lo introduce.

---

### Error 7: pipeline indescifrable

**Qué ocurrió:** solo el autor entendía los pasos; una falla bloqueó al equipo entero.

**Por qué:** sin documentación (punto 3).

**Cómo comprobarlo:** lee el README: ¿explica cada job?

**Opciones:** comentar/ documentar pasos; nombres de jobs claros.

**Riesgos:** cuello de botella humano.

**Solución:** pipeline como documento (punto 3).

**Cómo se evita:** actualización del README en cada cambio de workflow.

---

## 6. Práctica guiada

### Objetivo

Entregar un sitio con pipeline de calidad bloqueante y despliegue automático verificado.

### Paso 1: estructura del sitio

1. ≥ 4 páginas, estilos separados, README con arquitectura y ejecución local.

### Paso 2: primer workflow

1. Calidad: checkout → install → build → lint. Corre en PR y push (punto 3).

### Paso 3: hazlo obligatorio

1. Protege la rama con el check requerido (punto 2).

### Paso 4: prueba negativa

```text
PR con error de lint → ¿se bloquea el merge?
   │
   ├── sí → la puerta cierra
   └── no → corrige la configuración y repite
```

### Paso 5: despliegue

1. Job de deploy encadenado (`needs:`) en main (punto 4). Verifica historial de runs.

### Paso 6: seguridad básica

1. Dependabot activado; sin secretos en el repo (punto 2).

### Paso 7: entrega

```text
Checklist:
   [ ] sitio con ≥ 4 páginas + README técnico
   [ ] pipeline < 5 min en PR y main
   [ ] check requerido (probado con PR rojo)
   [ ] deploy automático tras checks
   [ ] Dependabot activo · cero secretos
```

### Resultado esperado

Sitio publicado por pipeline, puerta de calidad probada en negativo y dependencias vigiladas.

### Conclusión esperada

La página web del Proyecto 4 es «otro sitio» solo en apariencia: lo que entregas es la primera fábrica automatizada — y esa fábrica es exactamente lo que se construye en los proyectos siguientes a mayor escala.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── este pipeline es la versión pequeña del «flujo
   │   completo» de la sección 22: allí se añaden
   │   entornos, gates y rollback
   │
   ├── lo de Dependabot + sin secretos abre la puerta a
   │   la sección 20 completa (SAST, scan de secretos,
   │   CodeQL)
   │
   ├── el check requerido es tu primera «puerta» con
   │   riesgo cero para practicar — en trabajo real es
   │   la misma mecánica (sección 19 cap. 04/20 cap. 06)
   │
   └── presupuesto de CI: la disciplina que en el
       Proyecto 5 evita el dolor de Python «todo»
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el Proyecto 4 entrega una fábrica: build, lint y despliegue encadenados y bloqueantes;
* los checks solo cuentan si están requeridos y se prueban en negativo;
* el despliegue espera a la calidad y deja historial visible de cada publicación;
* seguridad mínima real: Dependabot activo y cero secretos en el repo;
* los errores típicos (checks decorativos, deploy paralelo, bypass, secretos, puerta sin probar, jobs sin cadena, pipeline indescifrable) se previenen con configuración y prueba;
* la progresión: esta fábrica es la semilla del pipeline profesional del Proyecto final.

La idea principal es:

> **Una página web se considera terminada cuando publicarse deja de ser una decisión manual: desde entonces, solo lo que pasa sus propias pruebas tiene derecho a estar en línea.**

---

## Próximo paso

Ya tienes fábrica automatizada.

Ahora el Proyecto 5: Python con estructura, pruebas y liberación versionada.

Continúa con:

[`05-proyecto-5-proyecto-python.md`](05-proyecto-5-proyecto-python.md)
