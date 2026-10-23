/* ============================================================================
-- REPORTE: Búsqueda de Columnas y Metadatos en Esquemas de Usuario
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Buscar_Columnas.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Consulta de metadatos de diccionario de datos que localiza todas las tablas y 
-- esquemas de usuario donde existe una columna cuyo nombre coincida con un patrón 
-- determinado. Devuelve la estructura básica (tipo de dato y permitividad de NULLs).
--
-- PARAMETROS REQUERIDOS:
-- - :PatronColumna (Patrón de texto para la cláusula LIKE, ej: '%CustomerID%')
-- ============================================================================ */

SELECT 
    TABLE_SCHEMA AS [Esquema],
    TABLE_NAME   AS [Tabla],
    COLUMN_NAME  AS [Columna_Encontrada],
    DATA_TYPE    AS [Tipo_Dato],
    IS_NULLABLE  AS [Acepta_Nulls]
FROM INFORMATION_SCHEMA.COLUMNS
-- Filtra por el patrón del nombre de la columna que se desea buscar
WHERE COLUMN_NAME LIKE '%CustomerID%' -- 👈 Reemplazar por el patrón deseado (ej. '%Fecha%', '%ID%')
  -- Excluye catálogos del sistema y esquemas administrativos de SQL Server
  AND TABLE_SCHEMA NOT IN ('sys', 'INFORMATION_SCHEMA')
-- Ordena los resultados alfabéticamente para facilitar la navegación por esquemas
ORDER BY 
    TABLE_SCHEMA, 
    TABLE_NAME;