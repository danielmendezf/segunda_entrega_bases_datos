-- ============================================================
-- Script 03: Consultas con tres o más tablas, filtros y
--            operaciones lógicas
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 1
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
