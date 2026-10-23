/* ============================================================================
-- REPORTE: Volumen de Datos y Almacenamiento por Tabla
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Volumen_registros_espacio_tablas.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Consulta las vistas de administración dinámica (DMV) de SQL Server para calcular 
-- de forma eficiente el número total de registros y el espacio reservado en disco 
-- (en MB) para cada tabla de usuario, evitando lecturas pesadas con COUNT(*).
--
-- PARAMETROS REQUERIDOS:
-- - Ninguno (Consulta directa sobre DMV de rendimiento del sistema)
-- ============================================================================ */

SELECT 
    s.name AS [Esquema],
    t.name AS [Tabla],
    -- Suma la cantidad total de filas considerando tablas particionadas
    SUM(ps.row_count) AS [Total_Registros],
    -- Convierte las páginas reservadas (8 KB por página) a Megabytes (MB)
    CAST((SUM(ps.reserved_page_count) * 8.0) / 1024.0 AS DECIMAL(10,2)) AS [Tamaño_MB]
FROM sys.tables t
-- Relaciona la tabla con su esquema perteneciente
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id
-- Asocia la tabla con sus definiciones de índices
INNER JOIN sys.indexes i 
    ON t.object_id = i.object_id
-- Une con la DMV de estadísticas de partición para obtener espacio y conteo de filas
INNER JOIN sys.dm_db_partition_stats ps 
    ON i.object_id = ps.object_id 
   AND i.index_id = ps.index_id
-- Considera únicamente el nivel principal de datos (0 = Heap / 1 = Clustered) para evitar duplicados
WHERE i.index_id IN (0, 1) 
  -- Excluye esquemas y catálogos administrativos del sistema
  AND s.name NOT IN ('sys', 'INFORMATION_SCHEMA')
-- Agrupa por esquema y tabla para consolidar particiones
GROUP BY 
    s.name, 
    t.name
-- Ordena de mayor a menor según el número de registros en cada tabla
ORDER BY 
    [Total_Registros] DESC;