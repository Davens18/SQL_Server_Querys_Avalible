SELECT 
    s.name AS [Esquema],
    o.name AS [Nombre_Objeto],
    CASE o.type
        WHEN 'U' THEN 'Tabla de Usuario'
        WHEN 'V' THEN 'Vista'
    END AS [Tipo_Objeto],
    o.create_date AS [Fecha_Creacion],
    o.modify_date AS [Fecha_Ultima_Modificacion]
FROM sys.objects o
INNER JOIN sys.schemas s 
    ON o.schema_id = s.schema_id
WHERE o.type IN ('U', 'V') -- U = User Table, V = View
  AND s.name NOT IN ('sys', 'INFORMATION_SCHEMA')
ORDER BY [Tipo_Objeto], [Esquema], [Nombre_Objeto];