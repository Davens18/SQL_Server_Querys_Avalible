/* ============================================================================
-- REPORTE: Inspección de Estructura y Metadatos de Tabla
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Estructura_Campos.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Consulta detallada del catálogo de objetos del sistema que expone la estructura 
-- técnica completa de las columnas de una tabla específica: orden ordinal, tipos 
-- de dato, tamaño en bytes, precisión numérica, permitividad de nulos y flag de identidad.
--
-- PARAMETROS REQUERIDOS:
-- - :NombreTabla (Nombre de la tabla a inspeccionar, ej: 'SalesOrderHeader')
-- ============================================================================ */

SELECT 
    s.name AS [Esquema],
    t.name AS [Tabla],
    c.column_id AS [Orden],
    c.name AS [Columna],
    ty.name AS [Tipo_Dato],
    c.max_length AS [Longitud_Bytes],
    c.precision AS [Precision_Numerica],
    -- Convierte el flag numérico a un estado explícito de permitividad de NULLs
    CASE WHEN c.is_nullable = 1 THEN 'SÍ' ELSE 'NO' END AS [Permite_Null],
    -- Identifica si la columna posee propiedad de autoincremento (IDENTITY)
    CASE WHEN c.is_identity = 1 THEN 'SÍ' ELSE 'NO' END AS [Es_Autoincremental]
FROM sys.tables t
-- Relaciona la tabla con el esquema al que pertenece
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id
-- Vincula las columnas asociadas al objeto tabla
INNER JOIN sys.columns c 
    ON t.object_id = c.object_id
-- Relaciona con el catálogo de tipos de datos (nativos o de usuario)
INNER JOIN sys.types ty 
    ON c.user_type_id = ty.user_type_id
-- Filtra por la tabla específica a analizar
WHERE t.name = 'SalesOrderHeader' -- 👈 Reemplazar por el nombre de la tabla a inspeccionar
-- Ordena por la posición ordinal en que fue creada cada columna
ORDER BY 
    c.column_id;