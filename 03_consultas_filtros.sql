-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 03: Consultas con tres o más tablas, filtros y
--            operaciones lógicas
-- Motor: SQLite 3
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 1
-- Objetivo: Obtener los ingenieros que están asignados a
--           proyectos que se encuentran actualmente en ejecución.
-- Tablas: Empleados, Asignacion_Empleados, Proyectos
-- Filtros: especialidad = 'Ingeniería' AND estado = 'En ejecución'
-- Operador lógico: AND
-- Justificación: Permite identificar al personal de ingeniería
--                activo en obras para planificación de recursos.
-- ------------------------------------------------------------
SELECT
    E.rut,
    E.nombre_completo,
    E.especialidad,
    P.nombre AS nombre_proyecto,
    A.rol,
    A.horas_trabajadas
FROM Empleados E
INNER JOIN Asignacion_Empleados A ON E.rut = A.rut_empleado
INNER JOIN Proyectos P ON A.id_proyecto = P.id_proyecto
WHERE E.especialidad = 'Ingeniería'
  AND P.estado = 'En ejecución';

-- ------------------------------------------------------------
-- Consulta 2
-- Objetivo: Listar materiales, proveedores y costos asociados a
--           proyectos comerciales con más de 100 colaboradores.
-- Tablas: Uso_Materiales, Materiales, Proveedores,
--         Proyectos_Comerciales, Proyectos
-- Filtros: num_colaboradores > 100 AND costo_unitario > 5000
-- Operador lógico: AND
-- Justificación: Evalúa la cadena de suministro de proyectos
--                comerciales de gran envergadura.
-- ------------------------------------------------------------
SELECT
    M.nombre_material,
    Prov.nombre AS proveedor,
    U.cantidad,
    U.costo_unitario,
    P.nombre AS proyecto,
    PC.num_colaboradores
FROM Uso_Materiales U
INNER JOIN Materiales M ON U.id_material = M.id_material
INNER JOIN Proveedores Prov ON U.rut_proveedor = Prov.rut_proveedor
INNER JOIN Proyectos_Comerciales PC ON U.id_proyecto = PC.id_proyecto
INNER JOIN Proyectos P ON PC.id_proyecto = P.id_proyecto
WHERE PC.num_colaboradores > 100
  AND U.costo_unitario > 5000;

-- ------------------------------------------------------------
-- Consulta 3
-- Objetivo: Obtener las etapas pendientes o en progreso de los
--           proyectos residenciales, ordenadas por fecha de inicio.
-- Tablas: Proyectos, Proyectos_Residenciales, Etapas_Proyecto
-- Filtros: estado_etapa IN ('Pendiente', 'En progreso')
-- Operadores lógicos: IN, AND
-- Justificación: Monitorea cuellos de botella en obras de
--                vivienda para priorizar recursos operativos.
-- ------------------------------------------------------------
SELECT
    P.nombre AS proyecto,
    PR.cantidad_viviendas,
    EP.nombre_etapa,
    EP.estado_etapa,
    P.fecha_inicio
FROM Proyectos P
INNER JOIN Proyectos_Residenciales PR ON P.id_proyecto = PR.id_proyecto
INNER JOIN Etapas_Proyecto EP ON P.id_proyecto = EP.id_proyecto
WHERE EP.estado_etapa IN ('Pendiente', 'En progreso')
ORDER BY P.fecha_inicio ASC;
