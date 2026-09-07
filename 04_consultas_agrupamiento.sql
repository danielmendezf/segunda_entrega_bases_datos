-- ============================================================
-- Script 04: Consultas con tres o más tablas, funciones de grupo
--            y cláusula HAVING
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 1
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
-- Consulta 2
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
-- Consulta 3
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
