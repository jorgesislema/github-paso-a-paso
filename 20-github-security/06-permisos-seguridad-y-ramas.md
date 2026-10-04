# Permisos, accesos y protección de ramas

## Introducción

Toda la detección del mundo sirve de poco si un atacante — o un error humano — tiene permisos de más. Este capítulo es la gobernanza de acceso: 2FA, SSO, roles y permisos de repositorio/organización, revisión de quién tiene acceso, y la protección de ramas y reglas como barrera estructural. La seguridad aquí no es una herramienta: es política que se aplica por plataforma.

---

## Mapa conceptual de este capítulo

```text
Permisos, accesos y protección de ramas
       │
       ├── 1. Identidad fuerte: 2FA, SSO, passkeys
       ├── 2. Permisos: de quien tiene acceso a lo que
       │   │   puede hacer
       │   ├── 3. Revisar quién tiene acceso (y cuándo
       │   │       se fue)
       │   ├── 4. Protección de ramas y reglas
       │   └── 5. Controles como código (rulesets)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Identidad fuerte: 2FA, SSO, passkeys

```text
2FA (segundo factor):
   │
   ├── obligatorio para entornos serios (obligable en
   │   organización — según configuración del plan)
   │
   ├── factores: app TOTP / llave física (FIDO) /
   │   passkeys — la llave física/passkey resiste
   │   phishing; el SMS es el más débil (evitar como
   │   único)
   │
   └── un robo de contraseña sin 2FA = cuenta tuya
```

```text
SSO empresarial:
   │
   ├── la identidad la controla la empresa (directorio
   │   central) → baja coordinada = baja de acceso
   │
   └── SAML/OIDC según plataforma — mención de
       categoría; añade contexto: corporate device
       policies
```

```text
EN LA PRÁCTICA:
   │
   ├── 2FA + passkey/llave para toda la gente del repo
   │
   ├── tokens PAT con caducidad corta (cap. 01)
   │
   └── claves SSH por persona con revocación al irse
       (cap. 01 punto 4)
```

---

## 2. Permisos: de quién tiene acceso a lo que puede hacer

```text
MODELO GITHUB (estratificado):
   │
   ├── a nivel cuenta → 2FA, tokens, llaves
   ├── a nivel repo → permisos base (read/triage/
   │   write/maintain/admin)
   ├── a nivel organización → equipos y permisos
   │   heredados
   └── a nivel enterprise → políticas globales
       (mención)
```

```text
PERMISOS DE REPO (semántica esencial):
──────────────────────────────────────────────────────
read      leer el repo
triage    gestionar issues/PRs (sin escribir código)
write    push a ramas NO protegidas + revisar
maintain  ajustar settings menores (sin danger zone)
admin    settings, riesgos, borrado, protección
```

```text
REGLAS:
   │
   ├── mínimo privilegio (cap. 05 sección 19 y aquí)
   │
   ├── write no es admin: nadie necesita admin «para
   │   trabajar»
   │
   ├── fuera de colaboradores individuales en orgs →
   │   equipos (sección 16 cap. 02)
   │
   └── externos: colaborador limitado + ramas
       protegidas + revisión (sección 15)
```

```bash
# quién tiene permiso (vista conceptual / API):
gh api repos/{owner}/{repo}/collaborators
# o Settings → Collaboradores (con filtro por permiso)
```

---

## 3. Revisar quién tiene acceso (y cuándo se fue)

```text
REVISIÓN (checklist trimestral):
   │
   ├── 1. lista de colaboradores y sus permisos
   ├── 2. para cada uno: ¿sigue en el equipo/empresa?
   ├── 3. permisos por encima de lo que su rol necesita
   │   → bajar
   ├── 4. apps/acciones instaladas con acceso al repo
   │   (integraciones — olvidadizas)
   └── 5. tokens y llaves: ¿caducados? (cap. 01)
```

```text
BAJAS:
   │
   ├── el baja se ejecuta el MISMO día (SSO ayuda)
   │
   ├── además: quitar de equipos, revocar tokens,
   │   quitar llaves SSH, revisar claves de deploy
   │
   └── post-baja: ¿su último commit necesita revisión?
       (buena señal de cultura)
```

```text
   │
   └── auditoría = «¿este acceso sigue justificado?» —
       sin revisión, los permisos solo crecen (Error 1)
```

---

## 4. Protección de ramas y reglas

```text
PROTECCIÓN DE RAMAS (controles):
   │
   ├── PR obligatorio para fusionar (nunca directo a
   │   main)
   ├── revisores obligatorios (nº mínimo)
   ├── checks obligatorios (CI verde — sección 09/19)
   ├── administrador también sujeto a reglas
   │   (incluyendo a ti)
   ├── bloqueo de borrado / force push
   └── conversión de discusión resuelta, aprobaciones
       estables
```

```text
   │
   └── la rama protegida es la garantía estructural de
       que «las reglas del proceso» no son voluntarias
       — Error 4 si la saltas
```

```text
CÓMO SE COMBINA CON WORKFLOWS:
   │
   ├── la protección exige checks → tus workflows son
   │   ahora obligatorios de facto (sección 19)
   │
   └── cuidado: si el workflow se puede saltar (PR de
       fork con aprobación olvidada, bypass list),
       la barrera tiene puerta (sección 19 cap. 05)
```

```text
GUARDIAS DE LA PLATAFORMA:
   │
   ├── administradores sujetos a las reglas (siempre)
   │
   └── bypass: lista explícita y mínima (quién y por
       qué — documentado)
```

---

## 5. Controles como código (rulesets)

```text
RULESETS (evolución de branch protection):
   │
   ├── reglas versionables/revisables y aplicables a
   │   varios repos
   │
   ├── fuerza de reglas: pueden ser sugeridas o
   │   obligatorias (según rol/config)
   │
   └── mismos controles: PR, checks, bloqueos,
       reglas de naming (sección 18 cap. 03)
```

```text
   │
   └── ventaja de gobernanza: la regla se audita como
       cualquier configuración (qué cambió, quién, en
       qué PR/commit de config) — sección 18/24
```

```text
POLÍTICA MÍNIMA POR REPO DE PRODUCCIÓN:
   │
   ├── main protegido (PR + check + 1 revisor + no
   │   force)
   ├── administradores incluidos en las reglas
   ├── mínimo privilegio en colaboradores
   └── 2FA obligatorio en la organización
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: permisos que solo crecen

**Qué ocurrió:** diez personas con write/maintain; la mitad ya no toca el repo.

**Por qué:** nunca hubo revisión (punto 3).

**Cómo comprobarlo:** lista de colaboradores vs. actividad real.

**Opciones:** bajar a read/triage donde baste; reactivar con justificación.

**Riesgos:** superficie de acceso enorme.

**Solución:** revisión trimestral (punto 3).

**Cómo se evita:** dueño de la revisión en gobernanza (sección 18).

---

### Error 2: 2FA débil o inexistente

**Qué ocurrió:** contraseña robada en un reuse → acceso total sin segundo factor.

**Por qué:** 2FA opcional y sin obligar en org.

**Cómo comprobarlo:** settings de organización: ¿requerido?

**Opciones:** obligar 2FA; migrar a passkeys/llaves; revisar factores débiles.

**Riesgos:** la cuenta es la llave maestra de todo.

**Solución:** identidad fuerte (punto 1).

**Cómo se evita:** checklist de alta (sección 16).

---

### Error 3: directo a main «solo para arreglar»

**Qué ocurrió:** hotfix sin PR ni revisión; nadie sabe qué entró.

**Por qué:** la rama no estaba protegida o había bypass amplio.

**Cómo comprobarlo:** settings de protección; historial de pushes directos.

**Opciones:** proteger main; permitir hotfix vía PR exprés con revisor (el proceso se acelera, no se salta).

**Riesgos:** cambios sin auditoría.

**Solución:** protección estructural (punto 4).

**Cómo se evita:** regla escrita + administradores sujetos a reglas.

---

### Error 4: saltarse la protección «ya que soy admin»

**Qué ocurrió:** un admin desactivó la regla, fusionó y la reactivó.

**Por qué:** la regla no cubría administradores o se podía tocar settings.

**Cómo comprobarlo:** historial de cambios de protección.

**Opciones:** activar «administradores sujetos a reglas»; audit de cambios de settings; exigir PR para config sensible (sección 18 cap. 03).

**Riesgos:** la barrera es decorativa para quien más poder tiene.

**Solución:** sin excepciones para admins (punto 4/5).

**Cómo se evita:** cultura + auditoría de eventos.

---

### Error 5: bajas lentas (el que se fue conservó acceso)

**Qué ocurrió:** un ex-colaborador con acceso semanas después de irse.

**Por qué:** no había proceso de baja (punto 3).

**Cómo comprobarlo:** revisar lista vs. activos; historial de equipos.

**Opciones:** revocar ya + proceso automático con RR. HH./SSO.

**Riesgos:** acceso fantasma (el escenario preferido de un atacante).

**Solución:** baja el mismo día (punto 3).

**Cómo se evita:** checklist de baja con dueño.

---

### Error 6: integraciones/apps olvidadas con acceso

**Qué ocurrió:** una app instalada años atrás seguía con permisos sobre todos los repos.

**Por qué:** nadie revisa apps además de personas.

**Cómo comprobarlo:** settings de organización → aplicaciones instaladas.

**Opciones:** retirar lo que no se usa; acotar alcance de lo que queda.

**Riesgos:** terceros con credencial permanente.

**Solución:** apps = colaboradores (punto 3 paso 4).

**Cómo se evita:** incluir apps en la revisión trimestral.

---

## 7. Práctica guiada

### Objetivo

Dejar un repositorio con acceso y ramas gobernados.

### Paso 1: identidad

1. Activa 2FA con passkey/llave en tu cuenta; comprueba la configuración de organización (¿obligatorio?).
2. Revisa tus factores: ¿sigue algún SMS como único?

### Paso 2: mapa de accesos

```text
Exporta y anota:
   │
   ├── colaboradores → permiso → ¿sigue? → destino
   │   (bajar / mantener / revocar)
   └── apps instaladas → ¿se usan? → retirar/acotar
```

### Paso 3: jerarquía

1. Identifica a alguien con más permiso del que necesita y bájalo (o propónlo en el ejercicio).

### Paso 4: protección

```text
En main (o en ruleset):
   │
   ├── PR obligatorio · 1 revisor · check obligatorio
   ├── bloquear force push y borrado
   └── «administradores sujetos a reglas» ACTIVADO
```

### Paso 5: prueba el muro

1. Intenta fusionar directo a main: debe fallar.
2. Intenta un push con force: debe fallar.

### Paso 6: política

```markdown
## Accesos
- 2FA obligatorio; passkeys preferidas
- Permiso mínimo (tabla de la sección 16)
- Revisión trimestral: colaboradores + apps + tokens
- Bajas: mismo día (checklist en docs)
- main: ruleset con PR + check + revisor; admins
  sujetos a reglas; bypass mínimo documentado
```

### Resultado esperado

Identidad reforzada, accesos auditados, main blindado y política publicada.

### Conclusión esperada

La seguridad de acceso es lista + reglas + disciplina: lo que no se revisa se pudre, y lo que un admin puede saltar no protege a nadie.

---

## 8. Nivel profesional + resumen

### 8.1. Gobernanza de acceso a escala

```text
   │
   ├── 2FA/SSO obligatorios en organización; passkeys
   │   como factor preferente
   │
   ├── permisos por defecto por plantilla de repo;
   │   mínimo privilegio como política global
   │
   ├── revisión trimestral automatizada donde sea
   │   posible (exportes/audit log); baja sincronizada
   │   con directorio (SSO)
   │
   ├── rulesets como código, aplicados a grupos de
   │   repos (sección 18 cap. 03)
   │
   ├── administradores sujetos a reglas + auditoría de
   │   eventos (quién cambió settings)
   │
   └── métrica: nº de accesos «justificados», tiempo
       medio de baja, excepciones de bypass abiertas
```

### 8.2. Resumen

En este capítulo aprendiste que:

* identidad fuerte: 2FA con passkeys/llaves, SSO empresarial, PATs con caducidad;
* modelo de permisos por niveles y la semántica read/triage/write/maintain/admin — siempre mínimo;
* revisión de accesos trimestral incluida apps y tokens; bajas el mismo día;
* protección de ramas: PR + revisor + checks + administradores sujetos a reglas + bypass mínimo;
* rulesets versionables como evolución de la protección de ramas;
* los errores típicos (permisos crecientes, 2FA débil, directo a main, admins que se saltan la regla, bajas lentas, apps olvidadas) se previenen con revisión y política;
* a nivel profesional: automatización de auditoría y métricas de excepciones.

La idea principal es:

> **Un control solo es un control si también le aplica al que más poder tiene: accesos que se revisan, ramas que nadie salta y bajas que ocurren hoy, no la semana que viene.**

---

## Próximo paso

Ya gobiernas quién entra y qué puede romper.

El último capítulo de la sección: la seguridad específica de tus automatizaciones — environments, OIDC y auditoría de workflows.

Continúa con:

[`07-seguridad-de-github-actions.md`](07-seguridad-de-github-actions.md)
