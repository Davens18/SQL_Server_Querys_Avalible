/* ============================================================================
-- REPORTE: Extracción del Código Fuente T-SQL de Vistas
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Extraccion_codigo_fuente_vistas.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Extrae la definición y el código fuente T-SQL completo almacenado en los módulos 
-- del sistema para una vista específica, permitiendo la auditoría, revisión técnica 
-- y documentación de su lógica de negocio interna.
--
-- PARAMETROS REQUERIDOS:
-- - :NombreVista (Nombre de la vista a auditar, ej: 'vSalesPerson')
-- ============================================================================ */

SELECT 
    s.name AS [Esquema],
    v.name AS [Nombre_Vista],
    m.definition AS [Codigo_Fuente_TSQL]
FROM sys.views v
-- Relaciona la vista con su esquema de base de datos correspondiente
INNER JOIN sys.schemas s 
    ON v.schema_id = s.schema_id
-- Vincula con el catálogo de módulos SQL que contiene el script de creación/definición
INNER JOIN sys.sql_modules m 
    ON v.object_id = m.object_id
-- Filtra por la vista específica que se requiere auditar
WHERE v.name = 'vSalesPerson' -- 👈 Reemplazar por el nombre de la vista a auditar
-- Ordena alfabéticamente por esquema y nombre
ORDER BY 
    s.name, 
    v.name;