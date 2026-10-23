/* ============================================================================
-- REPORTE: Inventario de Tablas y Vistas de Usuario
-- MODULO: UTIL (Utilitarios / Diccionario de Datos)
-- RUTA EN REPO: SQL_Server_Querys_Avalible.git/Metadatos.sql
-- AUTOR: Daniel Torres
-- FECHA CREACIÓN: 2026-10-22
-- 
-- DESCRIPCIÓN: 
-- Extrae el inventario completo de tablas de usuario ('U') y vistas ('V') definidas
-- en la base de datos activa, detallando su esquema perteneciente y las fechas de
-- creación y última modificación de estructura.
--
-- PARAMETROS REQUERIDOS:
-- - Ninguno (Consulta directa sobre catálogo de objetos del sistema)
-- ============================================================================ */

SELECT 
    s.name AS [Esquema],
    o.name AS [Nombre_Objeto],
    -- Mapea el código interno de SQL Server a una descripción legible
    CASE o.type
        WHEN 'U' THEN 'Tabla de Usuario'
        WHEN 'V' THEN 'Vista'
    END AS [Tipo_Objeto],
    o.create_date AS [Fecha_Creacion],
    o.modify_date AS [Fecha_Ultima_Modificacion]
FROM sys.objects o
-- Relaciona el objeto con su esquema de base de datos correspondiente
INNER JOIN sys.schemas s 
    ON o.schema_id = s.schema_id
-- Filtra únicamente tablas de usuario (U) y vistas (V)
WHERE o.type IN ('U', 'V') 
  -- Excluye catálogos administrativos del sistema
  AND s.name NOT IN ('sys', 'INFORMATION_SCHEMA')
-- Ordena jerárquicamente por tipo de objeto, esquema y nombre
ORDER BY 
    [Tipo_Objeto], 
    [Esquema], 
    [Nombre_Objeto];