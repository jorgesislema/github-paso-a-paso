# Despliegue en infraestructura real

## Introducción

La sección 22 diseñó el carril de entrega; este capítulo lo pone sobre terreno: servidores, contenedores, nube y las realidades que solo aparecen cuando la infraestructura deja de ser un diagrama. Cómo llega el artefacto a dónde corre, cómo se orquesta el arranque, cómo se manejan dominios y certificados, y por qué el despliegue es tan seguridad como operación (secretos y permisos — sección 20 — vuelven a entrar).

---

## Mapa conceptual de este capítulo

```text
Despliegue en infraestructura real
       │
       ├── 1. El viaje del artefacto hasta corriendo
       ├── 2. Patrones de despliegue (recap aplicado)
       │   ├── 3. Dominios, puertos y certificados
       │   ├── 4. Arranque, salud y configuración real
       │   └── 5. Despliegue seguro (permisos y secretos)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El viaje del artefacto hasta corriendo

```text
CADENA COMPLETA (unifica el curso):
──────────────────────────────────────────────────────
commit → CI → imagen/paquete identificado
   → registry (sección 22 cap. 05)
   → el host/orquestador lo DESCARGA en el entorno
   → lo arranca con su configuración y secretos
   → humo (sección 22 cap. 04) → verde
```

```text
PIEZAS QUE INTERVIENEN:
   │
   ├── transporte: cómo llega (pull de imagen, scp de
   │   binario, agente — según plataforma)
   │
   ├── quién ejecuta: el pipeline (environment +
   │   aprobación — sección 20 cap. 07), nunca la
   │   laptop (Error 1)
   │
   └── con qué identidad: credencial mínima de
       despliegue (OIDC ideal — sección 20 cap. 07)
```

```text
   │
   └── cada flecha de este viaje tiene dueño y
       registro: «¿quién desplegó 1.4.0 a producción
       y cuándo?» debe tener respuesta de un minuto
       (sección 22 cap. 05 Error 4)
```

---

## 2. Patrones de despliegue (recap aplicado)

```text
YA VISTOS (sección 22 cap. 04), aquí el «cómo»
real:
   │
   ├── in-place: paramos, reemplazamos, arrancamos —
   │   ventana visible; necesita humo y rollback
   │   rápidos
   │
   ├── blue-green: dos copias; el cambio entra
   │   apagado y el tráfico salta — requiere soporte
   │   de infra (doble capacidad, balanceo)
   │
   ├── canary: fracción de tráfico — requiere
   │   métricas accionables (cap. 06)
   │
   └── flags: código apagado — requiere la capa de
       configuración (sección 25)
```

```text
ELECCIÓN EN TERRENO REAL:
   │
   ├── pequeño y tolerante → in-place con humo
   ├── público y sensible → canary/blue-green
   └── irreversibles (migraciones) → expand/contract
       (sección 22 cap. 06 Error 4)
```

```text
   │
   └── la estrategia se decide con el equipo de
       operaciones ANTES del incidente — y se
       documenta (Error 2)
```

---

## 3. Dominios, puertos y certificados

```text
LAS TRES CUESTIONES CLÁSICAS:
   │
   ├── dominio: cómo me encuentran (DNS → equilibrio
   │   de carga → instancia)
   │
   ├── puerto: en qué puerto escucha la app y cómo se
   │   expone (y el firewall/red — mención)
   │
   └── TLS: certificado válido y renovado (los
       caducados son incidente de fin de semana —
       automatiza la renovación — sección 02)
```

```text
   │
   ├── configuración de red y DNS: idealmente también
   │   en código (cap. 04) — cambios por PR
   │
   └── el «no me carga la página tras el deploy» casi
       siempre es: DNS, certificado, puerto o health
       check (Error 4)
```

```bash
# diagnóstico rápido conceptual:
# 1. ¿responde el host?  2. ¿responde el puerto?
# 3. ¿resuelve el dominio?  4. ¿el certificado es
#    válido?
```

---

## 4. Arranque, salud y configuración real

```text
ARRANQUE LIMPIO:
   │
   ├── la app falla RÁPIDO si la configuración es
   │   inválida (sección 04 cap. 04: fail temprano)
   │
   ├── no arrancar si falta un secreto obligatorio
   │   (Error 5)
   │
   └── logs al arranque que digan qué versión corre
       (identidad — sección 22 cap. 05)
```

```text
SALUD (para el humo y el orquestador):
   │
   ├── endpoint de salud que refleje de verdad (no
   │   «200 siempre»)
   │
   └── el humo del despliegue usa ese endpoint + un
       camino real (sección 22 cap. 04 Error 5)
```

```text
CONFIGURACIÓN EN RUNTIME:
   │
   ├── variables/archivo según entorno (cap. 04)
   │
   └── secretos inyectados al arrancar, jamás
       embebidos (sección 19/20)
```

```text
   │
   └── «arrancó» ≠ «sirve bien»: por eso hay humo
       post-arranque (sección 22)
```

---

## 5. Despliegue seguro (permisos y secretos)

```text
LO QUE YA SABES, APLICADO AQUÍ:
   │
   ├── credencial de despliegue: environment con
   │   aprobación + alcance mínimo (sección 20 cap.
   │   07)
   │
   ├── OIDC: sin claves estáticas cuando la
   │   plataforma lo permita (sección 20 cap. 07)
   │
   ├── el host: mínimo de paquetes, parches, usuario
   │   no-root (sección 03 cap. 05)
   │
   ├── el transporte: canales con integridad (la
   │   imagen se verifica por digest — sección 20
   │   cap. 05)
   │
   └── post-deploy: humo + alertas (cap. 06) — un
       despliegue sin vigilancia es un despliegue a
       ciegas (Error 6)
```

```text
   │
   └── seguridad del despliegue = la misma de todo el
       curso, en su momento más crítico: es cuando
       cambia lo que corre ante los usuarios
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: despliegue desde la laptop

**Qué ocurrió:** alguien desplegó desde su equipo con sus credenciales; no quedó registro y no se pudo repetir.

**Por qué:** no se cerró el camino del pipeline (punto 1).

**Cómo comprobarlo:** ¿hay despliegues sin ejecución de CI en el registro?

**Opciones:** desactivar credenciales personales; todo por environment de CI; reconstruir lo manual como procedimiento.

**Riesgos:** despliegue irreproducible y sin auditoría.

**Solución:** solo el carril (punto 1).

**Cómo se evita:** permisos: las personas leen; el pipeline despliega (sección 20 cap. 07).

---

### Error 2: estrategia improvisada el día del incidente

**Qué ocurrió:** ante un rojo, se intentaron 3 formas distintas de volver atrás y se agravó.

**Por qué:** nadie decidió la estrategia antes (punto 2).

**Cómo comprobarlo:** runbook: ¿qué patrón usamos y cómo se ejecuta?

**Opciones:** decidir y documentar (cap. 06 sección 22); ensayar (sección 22 cap. 06).

**Riesgos:** experimentación en producción.

**Solución:** patrón acordado (punto 2).

**Cómo se evita:** plantilla de operaciones.

---

### Error 3: certificado caducado

**Qué ocurrió:** la web dejó de cargar un domingo por la mañana.

**Por qué:** renovación manual olvidadiza (punto 3).

**Cómo comprobarlo:** fecha del certificado; recordatorios.

**Opciones:** renovación automática (herramientas estándar del oficio); alerta de caducidad temprana.

**Riesgos:** caída visible y evitable.

**Solución:** automatizar la renovación (punto 3).

**Cómo se evita:** entra en la lista de «lo olvidadizo» (sección 02).

---

### Error 4: humo débil (solo TCP abierto)

**Qué ocurrió:** el health check devolvía 200 aunque la base de datos no respondiera; el deploy pasó y la app estaba rota.

**Por qué:** salud falsa (punto 4).

**Cómo comprobarlo:** ¿qué comprueba el humo de verdad?

**Opciones:** salud profunda (dependencias) + un camino real; alertar si falla post-deploy (sección 22 cap. 04 Error 5).

**Riesgos:** despliegue «verde» con usuarios caídos.

**Solución:** humo que miente no es humo (punto 4).

**Cómo se evita:** revisar el endpoint en cada cambio de arquitectura.

---

### Error 5: la app arranca sin su secreto

**Qué ocurrió:** arrancó en modo degradado con un secreto vacío y empezó a fallar en silencio.

**Por qué:** no se validó la configuración al arrancar (punto 4).

**Cómo comprobarlo:** logs de arranque; ¿qué versión y qué config reporta?

**Opciones:** validación obligatoria (falta → error claro y salida); humo que cubra el camino con secretos.

**Riesgos:** modo fantasma que «corre» sin servir.

**Solución:** falla temprana (punto 4).

**Cómo se evita:** patrón de configuración (sección 04 cap. 04).

---

### Error 6: despliegue sin vigilancia posterior

**Qué ocurrió:** nadie miró 20 minutos; las alertas ya existían pero sin destinatario (sección 19 cap. 06 Error 6).

**Por qué:** el proceso terminaba en «deploy ejecutado» (punto 5).

**Cómo comprobarlo:** runbook: ¿qué pasa después del apply?

**Opciones:** ventana de vigilancia post-deploy + responsable + alertas al canal del equipo (cap. 06).

**Riesgos:** detección por usuarios.

**Solución:** humo y vigilancia como parte del despliegue (punto 5).

**Cómo se evita:** checklist de despliegue con dueño.

---

## 7. Práctica guiada

### Objetivo

Llevar un artefacto hasta corriendo en un entorno de práctica con el carril completo.

### Paso 1: cadena

```text
Dibuja tu cadena real:
   │
   CI → registry → [cómo llega] → [quién arranca] →
   config/secretos → humo → registro
```

1. Señala qué flecha hoy es manual y por qué.

### Paso 2: despliegue por carril

1. Ejecuta el despliegue SOLO desde el pipeline (environment con aprobación si lo tienes).
2. Anota: quién aprobó, qué versión, qué digest.

### Paso 3: salud real

1. Revisa tu endpoint de salud: ¿refleja dependencias? ¿está el humo usando un camino real?
2. Provoca un fallo simulado (apaga una dependencia) y comprueba que el humo FALLA.

### Paso 4: configuración y secretos

1. Valida que la app falla con mensaje claro si falta un secreto (prueba en staging quitando la referencia).
2. Comprueba que ningún secreto está embebido en artefactos/config de despliegue.

### Paso 5: dominios

1. Documenta: dominio → puerto → certificado (fecha de caducidad) → quién renueva (automático o recordatorio con fecha).

### Paso 6: registro y vigilancia

```text
Antes de cerrar:
   │
   ├── el registro refleja la versión desplegada
   └── hay quién mira los primeros minutos (tú, en
       este ejercicio) y a quién alertar
```

### Resultado esperado

Despliegue por pipeline con identidad, humo profundo, config validada y registro/turno definidos.

### Conclusión esperada

En terreno real el despliegue es una cadena de confianza: cada eslabón (quién, qué, cómo llega, qué vigila) está escrito — lo no escrito se descubre el día que falla.

---

## 8. Nivel profesional + resumen

### 8.1. Operación de despliegue a escala

```text
   │
   ├── despliegues 100% por carril (CI/CD) con
   │   auditoría de aprobaciones (sección 19/20)
   │
   ├── estrategias definidas por tipo de servicio
   │   (sección 22 cap. 04 / 26)
   │
   ├── red, DNS y certificados como código con
   │   renovación automática (cap. 04)
   │
   ├── humo y canarios con alertas y ventanas de
   │   vigilancia (cap. 06)
   │
   ├── runbooks por servicio con dueños (sección 16/26)
   │
   └── métrica: frecuencia de despliegue, tiempo de
       despliegue, % con humo y vigilancia
```

### 8.2. Resumen

En este capítulo aprendiste que:

* la cadena completa: artefacto identificado → registry → host con carril → config/secretos → humo → registro;
* patrones de despliegue aplicados a terreno real, elegidos antes del incidente;
* dominios, puertos y certificados: lo que suele fallar, con renovación automatizada;
* arranque honesto: falla temprana, salud profunda, versión visible en logs;
* despliegue seguro: credencial mínima, digest verificado, host endurecido, vigilancia post-deploy;
* los errores típicos (laptop, estrategia improvisada, certificado, humo débil, secreto ausente, sin vigilancia) se previenen con carril escrito;
* a nivel profesional: auditoría y métricas de despliegue.

La idea principal es:

> **Despliegue es la cadena de confianza más corta del sistema: si un eslabón — quién, qué, cómo, qué vigila — vive solo en la memoria de alguien, ahí es donde se romperá primero.**

---

## Próximo paso

Ya despliegas sobre infraestructura real.

La pieza que cierra el bucle DevOps: saber qué pasa después.

Continúa con:

[`06-observabilidad.md`](06-observabilidad.md)
