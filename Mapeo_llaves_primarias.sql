/* ============================================================================
-- REPORTE: Identificación de Llaves Primarias (PK) por Tabla
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Mapeo_llaves_primarias.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Consulta las vistas estándar de metadatos (INFORMATION_SCHEMA) para listar
-- todas las restricciones de Llave Primaria (PRIMARY KEY) definidas en los esquemas
-- de usuario, detallando la columna participante y su posición ordinal en claves compuestas.
--
-- PARAMETROS REQUERIDOS:
-- - Ninguno (Consulta directa sobre metadatos del sistema)
-- ============================================================================ */

SELECT 
    tc.TABLE_SCHEMA AS [Esquema],
    tc.TABLE_NAME   AS [Tabla],
    tc.CONSTRAINT_NAME AS [Nombre_PK],
    kcu.COLUMN_NAME AS [Columna_PK],
    kcu.ORDINAL_POSITION AS [Posicion_En_PK]
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
-- Vincula las restricciones con las columnas específicas que componen la llave
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
   AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
-- Filtra exclusivamente restricciones de tipo Llave Primaria
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  -- Excluye catálogos administrativos y esquemas del sistema
  AND tc.TABLE_SCHEMA NOT IN ('sys', 'INFORMATION_SCHEMA')
-- Ordena por esquema, tabla y la secuencia de campos en llaves compuestas
ORDER BY 
    tc.TABLE_SCHEMA, 
    tc.TABLE_NAME, 
    kcu.ORDINAL_POSITION;