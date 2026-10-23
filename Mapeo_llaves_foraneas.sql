/* ============================================================================
-- REPORTE: Mapeo de Relaciones y Llaves Foráneas (FK)
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Mapeo_llaves_foraneas.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Mapea las relaciones de integridad referencial (Foreign Keys) en la base de datos,
-- detallando la tabla y columna de origen (dependiente) junto con la tabla y columna
-- de destino referenciada (llave primaria o candidata).
--
-- PARAMETROS REQUERIDOS:
-- - :NombreTabla (Opcional - Filtra por tabla de origen o destino, ej: 'SalesOrderHeader')
-- ============================================================================ */

SELECT 
    fk.name AS [Nombre_FK],
    sch_origen.name AS [Esquema_Origen],
    tbl_origen.name AS [Tabla_Origen],
    col_origen.name AS [Columna_Origen],
    ' ---> ' AS [Relacion],
    sch_destino.name AS [Esquema_Destino],
    tbl_destino.name AS [Tabla_Destino],
    col_destino.name AS [Columna_Destino]
FROM sys.foreign_keys fk
-- Vincula la restricción FK con el detalle de columnas involucradas
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id

-- Identifica la entidad de origen (Tabla y Columna que contiene la FK)
INNER JOIN sys.tables tbl_origen 
    ON fkc.parent_object_id = tbl_origen.object_id
INNER JOIN sys.schemas sch_origen 
    ON tbl_origen.schema_id = sch_origen.schema_id
INNER JOIN sys.columns col_origen 
    ON fkc.parent_object_id = col_origen.object_id 
   AND fkc.parent_column_id = col_origen.column_id

-- Identifica la entidad de destino (Tabla y Columna referenciada / PK)
INNER JOIN sys.tables tbl_destino 
    ON fkc.referenced_object_id = tbl_destino.object_id
INNER JOIN sys.schemas sch_destino 
    ON tbl_destino.schema_id = sch_destino.schema_id
INNER JOIN sys.columns col_destino 
    ON fkc.referenced_object_id = col_destino.object_id 
   AND fkc.referenced_column_id = col_destino.column_id

-- Filtro opcional: Descomentar para analizar la red de dependencias de una tabla
-- WHERE tbl_origen.name = 'SalesOrderHeader' OR tbl_destino.name = 'SalesOrderHeader'

-- Ordena por la tabla origen dependiente y el nombre de la restricción
ORDER BY 
    [Tabla_Origen], 
    [Nombre_FK];