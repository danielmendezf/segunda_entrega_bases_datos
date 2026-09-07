-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 05: Procedimiento almacenado
-- Motor: PostgreSQL 17.6
-- ============================================================
-- Equivalente de 05_procedimiento.sql (SQLite 3).
-- SQLite no soporta procedimientos almacenados y lo resolvía
-- con una consulta parametrizada; PostgreSQL sí los implementa,
-- por lo que aquí se entrega como función PL/pgSQL que recibe un
-- id_proyecto y retorna el presupuesto total invertido en
-- materiales hasta la fecha.
-- ============================================================

-- ------------------------------------------------------------
-- Función: sp_presupuesto_proyecto
-- Objetivo: Calcular el presupuesto total invertido en materiales
--           de un proyecto específico hasta la fecha.
-- Tablas involucradas: Proyectos, Uso_Materiales, Materiales
-- Función de grupo: SUM
-- Parámetro: p_id_proyecto (ID del proyecto a consultar)
-- Justificación: Agiliza la emisión de estados de pago y el
--                control de costos de una obra en particular.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION sp_presupuesto_proyecto(p_id_proyecto INTEGER)
RETURNS TABLE (
    id_proyecto INTEGER,
    nombre_proyecto TEXT,
    cantidad_pedidos BIGINT,
    total_inversion_materiales DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        P.id_proyecto,
        P.nombre AS nombre_proyecto,
        COUNT(UM.id_uso) AS cantidad_pedidos,
        COALESCE(SUM(UM.cantidad * UM.costo_unitario), 0) AS total_inversion_materiales
    FROM Proyectos P
    LEFT JOIN Uso_Materiales UM ON P.id_proyecto = UM.id_proyecto
    LEFT JOIN Materiales M ON UM.id_material = M.id_material
    WHERE P.id_proyecto = p_id_proyecto
    GROUP BY P.id_proyecto, P.nombre;
END;
$$ LANGUAGE plpgsql;

-- ------------------------------------------------------------
-- Ejemplos de uso:
--   SELECT * FROM sp_presupuesto_proyecto(1);
--   SELECT * FROM sp_presupuesto_proyecto(15);
-- ------------------------------------------------------------
SELECT * FROM sp_presupuesto_proyecto(1);
