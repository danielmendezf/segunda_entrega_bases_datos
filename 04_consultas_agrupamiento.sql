-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 04: Consultas con tres o más tablas, funciones de grupo
--            y cláusula HAVING
-- Motor: SQLite 3
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 4
-- Objetivo: Determinar los materiales más utilizados en los
--           proyectos durante el último año.
-- Tablas: Materiales, Uso_Materiales, Proyectos
-- Funciones de grupo: SUM, COUNT
-- HAVING: SUM(cantidad) > 0
-- Justificación: Identifica materiales de alta rotación para
--                negociación de precios con proveedores.
-- ------------------------------------------------------------
SELECT
    M.id_material,
    M.nombre_material,
    M.unidad_medida,
    COUNT(DISTINCT U.id_proyecto) AS cantidad_proyectos,
    SUM(U.cantidad) AS cantidad_total_usada
FROM Materiales M
INNER JOIN Uso_Materiales U ON M.id_material = U.id_material
INNER JOIN Proyectos P ON U.id_proyecto = P.id_proyecto
WHERE U.fecha_registro >= '2023-01-01'
GROUP BY M.id_material, M.nombre_material, M.unidad_medida
HAVING SUM(U.cantidad) > 0
ORDER BY cantidad_total_usada DESC;

-- ------------------------------------------------------------
-- Consulta 5
-- Objetivo: Encontrar los empleados que han participado en más
--           de un proyecto y la cantidad total de horas trabajadas.
-- Tablas: Empleados, Asignacion_Empleados, Proyectos
-- Funciones de grupo: COUNT, SUM
-- HAVING: COUNT(DISTINCT id_proyecto) > 1
-- Justificación: Detecta empleados multitarea para análisis de
--                bonos y distribución de carga laboral.
-- ------------------------------------------------------------
SELECT
    E.rut,
    E.nombre_completo,
    E.especialidad,
    COUNT(DISTINCT A.id_proyecto) AS total_proyectos,
    SUM(A.horas_trabajadas) AS total_horas_trabajadas
FROM Empleados E
INNER JOIN Asignacion_Empleados A ON E.rut = A.rut_empleado
INNER JOIN Proyectos P ON A.id_proyecto = P.id_proyecto
GROUP BY E.rut, E.nombre_completo, E.especialidad
HAVING COUNT(DISTINCT A.id_proyecto) > 1
ORDER BY total_proyectos DESC, total_horas_trabajadas DESC;

-- ------------------------------------------------------------
-- Consulta 6
-- Objetivo: Identificar los proveedores cuyo costo total de
--           materiales suministrados supere los $1.000.000.
-- Tablas: Proveedores, Uso_Materiales, Materiales
-- Funciones de grupo: SUM, COUNT
-- HAVING: SUM(cantidad * costo_unitario) > 1000000
-- Justificación: Clasifica proveedores clave por volumen
--                financiero transaccionado.
-- ------------------------------------------------------------
SELECT
    Prov.rut_proveedor,
    Prov.nombre AS nombre_proveedor,
    COUNT(DISTINCT U.id_material) AS materiales_distintos,
    SUM(U.cantidad) AS cantidad_total_suministrada,
    SUM(U.cantidad * U.costo_unitario) AS monto_total_facturado
FROM Proveedores Prov
INNER JOIN Uso_Materiales U ON Prov.rut_proveedor = U.rut_proveedor
INNER JOIN Materiales M ON U.id_material = M.id_material
GROUP BY Prov.rut_proveedor, Prov.nombre
HAVING SUM(U.cantidad * U.costo_unitario) > 1000000
ORDER BY monto_total_facturado DESC;
