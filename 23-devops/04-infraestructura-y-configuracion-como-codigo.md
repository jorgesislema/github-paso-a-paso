# Infraestructura y configuración como código

## Introducción

Si la aplicación vive en Git, ¿por qué la máquina que la corre no? **Infraestructura como código** (IaC) significa describir servidores, redes y servicios en archivos versionados; **configuración como código** aplica la misma idea a cómo se instala y ajusta el software. El resultado: entornos reproducibles, cambios revisables como PRs y un historial de quién movió qué — la misma disciplina de Git llevada al centro de datos (o a la nube).

---

## Mapa conceptual de este capítulo

```text
Infraestructura y configuración como código
       │
       ├── 1. El cambio: de clics a archivos
       ├── 2. Qué vive en código y qué no
       │   ├── 3. El ciclo: plan → apply → drift
       │   ├── 4. Configuración: capas y entornos
       │   └── 5. Reseña de herramientas (categorías)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El cambio: de clics a archivos

```text
MODELO ANTERIOR:
   │
   └── consola de la nube: clics manuales → nadie
       sabe qué hay, nadie sabe replicarlo, nadie
       sabe qué cambió
```

```text
IaC:
   │
   ├── describes el estado deseado en archivos
   │   (ej: «esta máquina con estos paquetes y este
   │   firewall»)
   │
   ├── una herramienta lo APLICA (y detecta
   │   diferencias)
   │
   └── los archivos van a Git: PRs, revisión,
       historial — sección 14/15 aplica igualito
```

```text
BENEFICIOS CONCRETOS:
   │
   ├── reproducibilidad: mismo archivo → mismo entorno
   │   (sección 22 cap. 03)
   │
   ├── auditoría: qué cambió, quién y cuándo (Git)
   │
   ├── reversibilidad: revertir el archivo y re-aplicar
   │   (cuidado: ver punto 3)
   └── velocidad: entornos completos en minutos
```

```text
   │
   └── IaC no es «más YAML»: es que la infraestructura
       se somete al MISMO proceso que el código
       (Error 1)
```

---

## 2. Qué vive en código y qué no

```text
VIVE EN EL REPO (normalmente):
   │
   ├── definición de recursos (máquinas, redes, DNS,
   │   colas, buckets)
   │
   ├── configuración de software (qué versión, qué
   │   parámetros — configuración como código)
   │
   ├── políticas (retenciones, permisos — mención:
   │   políticas como código)
   │
   └── scripts de arranque/provisión (idempotentes —
       sección 02)
```

```text
NO VIVE EN EL REPO:
   │
   ├── secretos (claves, tokens) — secciones 19/20
   │   (referencias, no valores)
   │
   ├── datos de producción y copias de seguridad
   │
   └── decisiones que no tienen forma estable (todavía)
```

```text
   │
   └── la frontera: descripción del mundo → sí; las
       credenciales del mundo → nunca en claro (Error
       3)
```

---

## 3. El ciclo: plan → apply → drift

```text
CICLO TÍPICO:
──────────────────────────────────────────────────────
1. editas el código (PR)
2. plan: «esto cambiaría» (vista previa — sección 19
   cap. 03: dry-run)
3. revisión del plan (¡el PR revisa infraestructura!)
4. apply: se ejecuta el cambio
5. verificación (¿funciona? humo — sección 22)
```

```text
DRIFT (desviación):
   │
   └── alguien tocó algo A MANO (consola, SSH) → el
       mundo real ya no coincide con el código
```

```text
RESPUESTA AL DRIFT:
   │
   ├── detectarlo (comparaciones periódicas — la
   │   herramienta lo reporta)
   │
   ├── decidir: ¿el código manda (re-aplicar) o el
   │   cambio manual era legítimo (actualizar el
   │   código) — Error 4 si no se decide
   │
   └── prohibir cambios manuales en entornos serios
       (norma del equipo) — el «arreglo rápido» en la
       consola es la puerta del drift (Error 5)
```

```text
   │
   └── el drift es deuda silenciosa: un día el plan
       dice 40 cambios y nadie recuerda por qué
```

---

## 4. Configuración: capas y entornos

```text
SEPARACIÓN CLAVE:
   │
   ├── receta (cómo se instala/configura) → código
   │
   └── valores (¿puerto? ¿URL? ¿qué nivel de log?) →
       por entorno, referenciados
```

```text
ENTORNOS:
   │
   ├── staging y producción comparten la RECETA y
   │   difieren en VALORES (entornos gemelos — sección
   │   22 cap. 04 Error 3)
   │
   └── los valores sensibles: en secretos de la
       plataforma (sección 19/20), no en el archivo
```

```text
REGLAS DE CONFIGURACIÓN:
   │
   ├── valores por defecto seguros (si falta algo, lo
   │   peor no ocurre)
   ├── configuración explícita y validada al arrancar
   │   (falla temprana con mensaje claro)
   └── la configuración también se revisa en PR
       (Error 6)
```

```text
   │
   └── «configuración» ≠ «secretos»: la URL es
       configuración; la clave del API es secreto —
       mezclarlas contamina ambas (Error 3)
```

---

## 5. Reseña de herramientas (categorías)

```text
PROVISIÓN DE INFRAESTRUCTURA:
   │
   ├── herramientas declarativas de nube (tipo
   │   Terraform y similares): describen recursos,
   │   plan y apply
   │
   └── mención: ecosistema amplio; elija según su
       plataforma y aprenda el patrón (plan/apply/
       drift) que es común a casi todas
```

```text
CONFIGURACIÓN/GESTIÓN DE ESTADO:
   │
   ├── herramientas de configuración de servidores
   │   (tipo Ansible y similares): idempotentes, sin
   │   agente en muchas configuraciones
   │
   └── el principio sección 02 (idempotencia) es la
       base aquí también
```

```text
PAPEL DE GITHUB EN EL FLUJO:
   │
   ├── los archivos viven aquí → PRs, CODEOWNERS
   │   (sección 16 cap. 06), protección
   │
   ├── Actions ejecuta plan/apply con permisos
   │   mínimos y environments (sección 19/20)
   │
   └── secretos por entorno (sección 19 cap. 04)
```

```text
   │
   └── no se aprende «la herramienta del tutorial»: se
       aprende EL PATRÓN (código → plan → revisión →
       apply → drift) — Error 1 si se confunde
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: IaC como «otro script»

**Qué ocurrió:** los archivos existían pero se ejecutaban a mano, sin plan ni revisión — igual que antes, solo que con más sintaxis.

**Por qué:** se copió la tecnología sin el proceso (punto 1/3).

**Cómo comprobarlo:** ¿los cambios de infraestructura pasan por PR? ¿se ejecuta plan revisable?

**Opciones:** insertar el ciclo completo (plan en CI, apply con gate); formación en el patrón.

**Riesgos:** coste del cambio sin beneficio del control.

**Solución:** código + proceso (punto 1/3).

**Cómo se evita:** checklist de infra: PR + plan + apply automatizado.

---

### Error 2: sin plan (apply a ciegas)

**Qué ocurrió:** el pipeline aplicó cambios destructivos que nadie vio («el plan lo escribí yo»).

**Por qué:** no se guardó/miró la vista previa (punto 3).

**Cómo comprobarlo:** ¿los cambios de infra dejan registro del plan?

**Opciones:** plan como artefacto del PR (comentario/adjunto) + aprobación para cambios destructivos.

**Riesgos:** borrar producción con un commit.

**Solución:** plan visible y revisado (punto 3).

**Cómo se evita:** regla de aprobación por tipo de cambio (sección 20 cap. 07).

---

### Error 3: secretos en los archivos de infra

**Qué ocurrió:** claves en claro en la definición; el repo (o su historial) quedó comprometido.

**Por qué:** se confundió configuración con credenciales (punto 4).

**Cómo comprobarlo:** secret scanning (sección 20 cap. 02).

**Opciones:** incidente completo (rotar → limpiar → verificar); migrar a referencias/secret manager.

**Riesgos:** credencial con poder sobre la nube.

**Solución:** secretos fuera (punto 4).

**Cómo se evita:** plantilla con referencias + escaneo.

---

### Error 4: drift detectado y no decidido

**Qué ocurrió:** la herramienta avisaba diferencias durante meses; nadie sabía si el código o el mundo eran la verdad.

**Por qué:** sin política de drift (punto 3).

**Cómo comprobarlo:** ¿tienes comparaciones periódicas? ¿alguna vez actuaste sobre ellas?

**Opciones:** reunión de reconciliación: cada diff → código o manual; luego, norma de cero cambios manuales.

**Riesgos:** restaurar entornos = lotería.

**Solución:** decisión explícita y normal (punto 3).

**Cómo se evita:** chequeo de drift en la revisión trimestral (sección 18/24).

---

### Error 5: arreglo manual «rápido» en consola

**Qué ocurrió:** hotfix en la nube a las 19:00; al día siguiente nadie pudo reproducirlo.

**Por qué:** urgencia sin camino de emergencia para infra (punto 3).

**Cómo comprobarlo:** cambios registrados en la nube sin commit correspondiente.

**Opciones:** reconstruir el cambio en código lo antes posible; definir el procedimiento de emergencia: «aplicar a mano + ticket obligatorio para versionar en < 24 h».

**Riesgos:** el entorno deja de ser creíble.

**Solución:** el código manda (punto 3).

**Cómo se evita:** acuerdo de equipo y revisión de eventos de consola.

---

### Error 6: configuración de entornos en red y no en código

**Qué ocurrió:** staging tenía parámetros distintos a producción porque «se fueron ajustando a mano».

**Por qué:** la configuración no estaba versionada (punto 4).

**Cómo comprobarlo:** ¿puedes listar los valores de cada entorno desde el repo?

**Opciones:** versionar valores no sensibles; secretos por environment; entornos gemelos (sección 22 cap. 04 Error 3).

**Riesgos:** «funciona en staging» pierde significado.

**Solución:** receta compartida, valores explícitos (punto 4).

**Cómo se evita:** plantilla de entornos (sección 18).

---

## 7. Práctica guiada

### Objetivo

Versionar la definición de un entorno pequeño y someterla al proceso de PR.

### Paso 1: describe

1. Elige un recurso sencillo de tu práctica (una máquina, un bucket, un servicio DNS — según tu plataforma).
2. Escribe su definición en `infra/` en el repo.

### Paso 2: plan

```text
Con tu herramienta (patrón plan/apply):
   │
   ├── ejecuta el plan → ¿qué cambiaría?
   └── guarda esa salida como referencia
```

### Paso 3: PR de infraestructura

1. Abre un PR con el cambio; adjunta el plan (texto o descripción).
2. Pide revisión como cualquier código (CODEOWNERS si aplica — sección 16).

### Paso 4: apply con gate

1. Aplica tras la aprobación (a mano para este ejercicio, o vía CI con environment).
2. Verifica: ¿el recurso existe tal cual el código?

### Paso 5: provoca drift

1. Cambia algo del recurso A MANO (por ejemplo, una etiqueta).
2. Ejecuta la comparación: ¿lo detecta?
3. Decide: código → re-aplica; manual → actualiza el código. Documenta tu decisión.

### Paso 6: política

```markdown
## Infraestructura
- Todo cambio: PR con plan visible + aprobación
- Cero cambios manuales en entornos (emergencias:
  ticket < 24 h para versionar)
- Secretos: solo referencias
- Drift: comparación semanal + reconciliación
```

### Resultado esperado

Recurso versionado, PR con plan, drift detectado y reconciliado, política publicada.

### Conclusión esperada

La infraestructura como código es Git llevado al mundo real: si el cambio no tiene commit, no existe — y si existe a mano, se convierte en commit antes de que se olvide.

---

## 8. Nivel profesional + resumen

### 8.1. IaC a escala

```text
   │
   ├── repos dedicados de infraestructura con su
   │   gobernanza (sección 25: monorepo/multirepo)
   │
   ├── módulos/reutilización: plantillas aprobadas
   │   para crear recursos estándar (sección 25)
   │
   ├── drift con chequeo automático y alerta (no
   │   mensual manual)
   │
   ├── pipelines de infra con permisos mínimos,
   │   environments y OIDC (sección 19/20)
   │
   ├── políticas como código: reglas automáticas de
   │   seguridad/coste (mención)
   │
   └── métrica: tiempo de aprovisionar un entorno;
       nº de cambios manuales pendientes de versionar
```

### 8.2. Resumen

En este capítulo aprendiste que:

* IaC/configuración como código: descripción en archivos versionados aplicados por herramientas — el proceso del PR llevado a la infraestructura;
* ciclo plan → revisión → apply → verificación, con drift detectado y reconciliado;
* frontera: receta y valores sensibles no sensibles en su sitio; secretos por referencias;
* categorías de herramientas (provisión declarativa, configuración idempotente) — el patrón es lo que se aprende;
* los errores típicos (IaC como script, apply a ciegas, secretos, drift olvidado, arreglo manual, config en red) se previenen con disciplina de código;
* a nivel profesional: módulos, políticas como código y métricas de aprovisionamiento.

La idea principal es:

> **Lo que no tiene commit no tiene historia ni reversión: si la infraestructura cambió, alguien tiene que poder señalar la línea exacta del archivo que lo explica — o el entorno ya no es tuyo, es de la suerte.**

---

## Próximo paso

Ya describes y aplicas tu infraestructura con el mismo proceso que el código.

Ahora ensamblar el despliegue sobre esa infraestructura real.

Continúa con:

[`05-despliegue-en-infraestructura-real.md`](05-despliegue-en-infraestructura-real.md)
