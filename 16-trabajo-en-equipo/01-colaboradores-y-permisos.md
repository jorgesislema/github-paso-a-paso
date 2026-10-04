# Colaboradores y permisos

## Introducción

Hasta ahora trabajaste en tu repo o en clones de otros. Cuando el repositorio es de un equipo, la primera pregunta no es técnica sino de control: ¿quién puede ver, quién puede escribir, quién puede integrar y quién puede cambiar la configuración?

Los permisos de GitHub son jerárquicos y granulares. Este capítulo enseña los roles, cómo asignarlos y los patrones de seguridad que evitan tanto el caos (todos admin) como el bloqueo (nadie puede integrar).

---

## Mapa conceptual de este capítulo

```text
Colaboradores y permisos
       │
       ├── 1. Niveles: plataforma, repo, rama
       ├── 2. Roles del repositorio (tabla)
       ├── 3. Cómo se asignan y a quién
       ├── 4. Fuera del repo: outside collaborators
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Niveles: plataforma, repo, rama

```text
JERARQUÍA DE CONTROL
──────────────────────────────────────────────────────
NIVEL 1 — Cuenta / plataforma
  · tu cuenta, tu 2FA, tus llaves SSH
NIVEL 2 — Organización (si aplica)
  · equipos, políticas de la org (cap. 02)
NIVEL 3 — Repositorio
  · quién es colaborador y con qué rol
  · ajustes: seguridad, ramas, merge
NIVEL 4 — Rama (protecciones)
  · reglas sobre main: checks, aprobaciones,
    integradores (sección 18)
```

```text
   │
   └── la pregunta correcta NO es «¿puede?» en
       abstracto sino «¿en qué NIVEL está restringido?»
       (permiso de escritura en repo ≠ poder hacer
       push a main)
```

---

## 2. Roles del repositorio (tabla)

```text
ROLES (privado; en público se simplifican)
──────────────────────────────────────────────────────
Read
  · clonar, leer issues/PRs, sin push
  · ideal: stakeholders, aprendices en observación

Triage
  · Read + gestionar issues/PRs (etiquetas,
    asignar, cerrar) SIN tocar código
  · ideal: quien ordena el tablero, no programa

Write
  · push a ramas NO protegidas, abrir PRs,
    revisar, gestionar issues
  · rol base del equipo que programa

Maintain
  · Write + ajustes no destructivos: etiquetas,
    ramas, colaboradores de nivel inferior
  · ideal: tech lead del área

Admin
  · todo: ajustes del repo, borrado, seguridad,
    ramas protegidas, integraciones
  · MÍNIMO posible (cap. 6)
```

```text
PERMISOS CLAVE QUE NO SON «EL ROL»:
   │
   ├── force push a rama protegida → NO (nadie sin
   │   excepción explícita)
   ├── merge a main → según rama protegida
   ├── borrar el repo → Admin
   └── aprobar PR → Write o superior (o revisor
       asignado con permisos)
```

```bash
# ver colaboradores (vía API/gh, concepto):
gh api repos/{owner}/{repo}/collaborators \
  --jq '.[].login'
```

---

## 3. Cómo se asignan y a quién

```text
ASIGNACIÓN (Settings → Collaborators)
   │
   ├── invitas por usuario → acepta (aparece como
   │   «pending» hasta aceptar)
   │
   ├── en organización: el rol default viene del
   │   EQUIPO (cap. 02) → más manejable que invitar
   │   uno a uno
   │
   └── revisión periódica: «¿sigue esta persona
       necesitando este rol?» (bajas, cambios de
       proyecto)
```

```text
PRINCIPIOS DE ASIGNACIÓN:
   │
   ├── mínimo privilegio: el rol suficiente para la
   │   función (no «bueno que sea admin por si acaso»)
   │
   ├── por función, no por antigüedad:
   │   │
   │   ├── quien solo comenta/docs → Triage o Write
   │   ├── quien integra → Write + permisos de rama
   │   └── quien configura → Maintain/Admin
   │
   └── Admin: 1-2 personas máximo por repo
```

```text
MENSAJE AL INVITAR (buena práctica):
   │
   └── «Te invité como Write: puedes hacer push a
       ramas y PRs; main está protegida con checks»
       — las expectativas claras evitan sustos
```

---

## 4. Fuera del repo: outside collaborators

```text
OUTSIDE COLLABORATOR
   │
   ├── persona con permisos en un repo PRIVADO sin
   │   pertenecer a la organización
   │
   ├── típico: contractor, proveedor, colaborador
   │   puntual
   │
   └── en repos PÚBLICOS no hace falta: cualquiera
       puede clonar; los permisos son para escribir
```

```text
CICLO DE VIDA:
   │
   ├── dar de alta con el rol mínimo
   ├── registrar quién lo invitó y para qué
   └── dar de baja AL TERMINAR el contrato
       (revisión de acceso = seguridad, sección 20)
```

```text
   │
   └── invitación que nunca se aceptó o que quedó
       olvidada = puerta abierta con llave perdida;
       revisa «pending» y «active»
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «Admin para todos» por comodidad

**Qué ocurrió:** 8 personas con Admin; alguien borró configuración por error.

**Por qué posibles:**
* miedo a bloquear el trabajo;
* no se conocen los roles intermedios.

**Cómo comprobarlo:** lista de colaboradores con rol.

**Opciones:** bajar a Write/Maintain a quien no necesita Admin; dejar 1-2 admins.

**Riesgos:** borrados, ajustes de seguridad y cambios de rama sin traza de quién.

**Solución:** mínimo privilegio (punto 3).

**Cómo se evita:** checklist de alta de colaborador con rol justificado.

---

### Error 2: bloqueo por falta de permisos («no puedo pushear»)

**Qué ocurrió:** la persona no puede push (rama protegida o rol Read) y el equipo se para.

**Por qué posibles:**
* rol demasiado bajo;
* rama protegida sin ruta de integración (nadie con merge);
* invitación pendiente de aceptar.

**Cómo comprobarlo:** mensaje exacto del push; Settings → Collaborators; protecciones de rama.

**Opciones:** subir rol al adecuado (Write); dar permiso de merge a los integradores; aceptar invitación.

**Riesgos:** frustración y atajos (compartir cuentas — prohibido).

**Solución:** mapear funciones → roles al abrir el proyecto.

**Cómo se evita:** documento «quién puede qué» en CONTRIBUTING.

---

### Error 3: cambio de persona sin revisión de accesos

**Qué ocurrió:** un colaborador externo se fue hace un año y sigue con Write (o Admin).

**Por qué:** no hay ciclo de baja.

**Cómo comprobarlo:** revisar lista de colaboradores; cruzar con el equipo actual.

**Opciones:** revocar; auditar su historial reciente si hubo actividad dudosa.

**Riesgos:** acceso fantasma (superficie de incidente, sección 20).

**Solución:** alta/baja como parte del onboarding/offboarding.

**Cómo se evita:** revisión trimestral de accesos.

---

### Error 4: confundir permiso de repo con permiso de rama

**Qué ocurrió:** «tiene Write» y aun así no puede integrar en main → o al revés, creía que Write era solo leer.

**Por qué:** las dos capas se explican mal.

**Cómo comprobarlo:** leer rama protegida (¿quién puede hacer merge?); leer rol.

**Opciones:** documentar: «Write = ramas libres; main = integración vía PR con checks».

**Riesgos:** expectativas rotas; intentos de fuerza desesperados.

**Solución:** explicación explícita en el welcome del repo.

**Cómo se evita:** plantilla de repo con protección + roles ya pensados (sección 18).

---

### Error 5: Triage sin usar (o sin darlo)

**Qué ocurrió:** el rol Triage no lo conoce nadie: o todos Write «para etiquetar», o quien gestiona issues no tiene permiso.

**Por qué:** desconocimiento del rol.

**Cómo comprobarlo:** quién gestiona issues hoy y con qué rol.

**Opciones:** asignar Triage a quien gestiona sin código; formar.

**Riesgos:** tablero en manos equivocadas o bloqueado.

**Solución:** rol Triage para gestión pura (punto 2).

**Cómo se evita:** mapeo de funciones al definir el equipo.

---

### Error 6: permisos por fuera de la plataforma

**Qué ocurrió:** se dio acceso compartiendo usuario/contraseña o llave personal «de emergencia».

**Por qué:** desconocimiento o prisa.

**Cómo comprobarlo:** mismos commits con autoría compartida; llaves SSH ajenas en ajustes.

**Opciones:** revocar credenciales; migrar a colaboradores reales con su propia identidad.

**Riesgos:** sin traza de quién hizo qué; incidente de seguridad.

**Solución:** cada persona = su cuenta (autoría e investigación con `git blame` funcionan).

**Cómo se evita:** regla escrita «no se comparten cuentas».

---

## 6. Práctica guiada

### Objetivo

Montar el acceso de un repo de práctica con roles mínimos y protecciones básicas.

### Paso 1: diagnóstico actual

```text
Settings → Collaboradores:
   │
   ├── lista rol por rol
   ├── invitaciones «pending» → resolver
   └── ¿algún Admin de más?
```

### Paso 2: mapear funciones

```text
Función                  Rol
──────────────────────────────────────
observador/docs          Read (o Triage)
gestión de issues        Triage
programar en ramas       Write
lead del área            Maintain
configurar repo          Admin (1-2)
```

### Paso 3: invitar con mensaje

1. Invita una segunda cuenta (o un usuario de prueba) como **Write** con el mensaje del punto 3.

### Paso 4: separar «escribir» de «integrar»

```text
Settings → Branches → protección de main:
   │
   ├── Require pull request antes de merge
   ├── Require approvals: 1
   ├── Require status checks: tu test principal
   └── (detalles: sección 18)
```

### Paso 5: simular

1. Como la otra cuenta: intenta push a main (debe fallar) y abre un PR (debe funcionar).
2. Vuelve a tu cuenta y observa el PR en vivo.

### Paso 6: registra

1. Escribe en CONTRIBUTING: tabla de roles del proyecto y quién integra.

### Resultado esperado

Repo con roles mínimos, invitación aceptada, main protegida y prueba de que Write ≠ merge en main.

### Conclusión esperada

Los permisos son dos capas — rol del repo y reglas de rama — y ambas se diseñan con mínimo privilegio.

---

## 7. Nivel profesional + resumen

### 7.1. Gestión de accesos como seguridad

```text
   │
   ├── mínimo privilegio + revisión periódica de
   │   accesos (alta/baja documentadas)
   │
   ├── 2FA obligatorio en la organización (sección
   │   18/20)
   │
   ├── Admin escaso; operación vía Maintain + ramas
   │   protegidas
   │
   ├── fuera de org: outside collaborators con fin
   │   de vida ligado al contrato
   │
   └── auditoría: quién invitó a quién y cuándo
       (la plataforma lo registra en el log de
       auditoría — sección 18)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* los permisos se dan en niveles: plataforma/org → repo (rol) → rama (protecciones);
* roles: Read, Triage, Write, Maintain, Admin — asignados por función con mínimo privilegio;
* las invitaciones se aceptan y se revisan; en organización los roles vienen de equipos;
* los outside collaborators son para colaboradores puntuales con fin de ciclo;
* los errores típicos (admin para todos, bloqueo por permisos, accesos fantasma, confundir repo con rama, Triage olvidado, cuentas compartidas) se previenen con mapeo de funciones y revisión de accesos;
* a nivel profesional: alta/baja documentadas, 2FA y auditoría.

La idea principal es:

> **El acceso correcto es el que dura lo que dura la función: rol mínimo por capa, integración por rama protegida y cuentas individuales siempre.**

---

## Próximo paso

Ya sabes quién puede qué en un repo.

Cuando el equipo crece, la administración sube un nivel: organizaciones y equipos.

Continúa con:

[`02-organizaciones-y-equipos.md`](02-organizaciones-y-equipos.md)
