# Entrega 2 — Informe Proyecto N°2 (Semana 12)

**Caso 2:** Plataforma de Gestión de Proyectos de Construcción  
**Asignatura:** VTDF103 — Bases de Datos  
**Motor:** SQLite 3

Este directorio contiene los artefactos técnicos de la segunda fase del proyecto: implementación de la base de datos en SQL, separada en scripts independientes.

---

## Archivos generados

| Archivo | Descripción |
|---------|-------------|
| `decisiones.md` | Documento con las decisiones de modelado e implementación, y justificación técnica. |
| `modelo_relacional.md` | Diagrama del modelo relacional en sintaxis Mermaid. |
| `01_ddl.sql` | Script de creación de tablas, claves primarias, foráneas y restricciones (DDL). |
| `02_datos.sql` | Script de inserción de datos de prueba (DML). |
| `03_consultas_filtros.sql` | Tres consultas con tres o más tablas, filtros y operaciones lógicas. |
| `04_consultas_agrupamiento.sql` | Tres consultas con tres o más tablas, funciones de grupo y `HAVING`. |
| `05_procedimiento.sql` | Consulta equivalente a un procedimiento almacenado (SQLite no soporta SP). |
| `06_vista.sql` | Vista de personal activo en proyectos no finalizados. |

---

## Cómo ejecutar los scripts

Requisito: tener instalado **SQLite 3**.

### 1. Crear la base de datos y tablas

```bash
cd proyecto/entrega
sqlite3 constructora.db < 01_ddl.sql
```

### 2. Cargar los datos

```bash
sqlite3 constructora.db < 02_datos.sql
```

### 3. Ejecutar consultas y crear objetos

Cada script puede ejecutarse de forma independiente:

```bash
sqlite3 constructora.db < 03_consultas_filtros.sql
sqlite3 constructora.db < 04_consultas_agrupamiento.sql
sqlite3 constructora.db < 05_procedimiento.sql
sqlite3 constructora.db < 06_vista.sql
```

### 4. Verificar la vista

```bash
sqlite3 constructora.db "SELECT * FROM vw_personal_terreno_activo;"
```

---

## Nota importante

Este material fue generado con asistencia de IA. Antes de entregarlo, el grupo debe:

1. Revisar y comprender cada script.
2. Adaptar nombres, datos y decisiones si el docente dio retroalimentación específica.
3. Completar la portada del entregable (`vtdf103_s12_entregable.docx`) con los datos del grupo.
