-- validate_mysql.sql - Validación del estado actual de MySQL
USE barberia_db;

-- Información general de la base de datos
SELECT '=== INFORMACIÓN GENERAL DE LA BASE DE DATOS ===' as '';
SELECT 
    SCHEMA_NAME as 'Base de Datos',
    DEFAULT_CHARACTER_SET_NAME as 'Character Set',
    DEFAULT_COLLATION_NAME as 'Collation'
FROM INFORMATION_SCHEMA.SCHEMATA 
WHERE SCHEMA_NAME = 'barberia_db';

-- Conteo de objetos
SELECT '=== CONTEO DE OBJETOS ===' as '';
SELECT 'Tablas' as 'Tipo de Objeto', COUNT(*) as 'Cantidad'
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'barberia_db' AND TABLE_TYPE = 'BASE TABLE'
UNION ALL
SELECT 'Vistas', COUNT(*)
FROM INFORMATION_SCHEMA.VIEWS 
WHERE TABLE_SCHEMA = 'barberia_db'
UNION ALL
SELECT 'Procedimientos', COUNT(*)
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_SCHEMA = 'barberia_db' AND ROUTINE_TYPE = 'PROCEDURE'
UNION ALL
SELECT 'Triggers', COUNT(*)
FROM INFORMATION_SCHEMA.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'barberia_db'
UNION ALL
SELECT 'Eventos', COUNT(*)
FROM INFORMATION_SCHEMA.EVENTS 
WHERE EVENT_SCHEMA = 'barberia_db';

-- Tamaño de tablas
SELECT '=== TAMAÑO DE TABLAS ===' as '';
SELECT 
    TABLE_NAME as 'Tabla',
    TABLE_ROWS as 'Registros',
    ROUND(DATA_LENGTH/1024/1024, 2) as 'Datos (MB)',
    ROUND(INDEX_LENGTH/1024/1024, 2) as 'Índices (MB)',
    ROUND((DATA_LENGTH + INDEX_LENGTH)/1024/1024, 2) as 'Total (MB)'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'barberia_db' AND TABLE_TYPE = 'BASE TABLE'
ORDER BY DATA_LENGTH + INDEX_LENGTH DESC;

-- Conteo de registros por tabla
SELECT '=== CONTEO DE REGISTROS POR TABLA ===' as '';
SELECT 'clientes' as Tabla, COUNT(*) as Registros FROM clientes
UNION ALL SELECT 'administradores', COUNT(*) FROM administradores
UNION ALL SELECT 'barberias', COUNT(*) FROM barberias
UNION ALL SELECT 'barberos', COUNT(*) FROM barberos
UNION ALL SELECT 'servicios', COUNT(*) FROM servicios
UNION ALL SELECT 'barbero_servicios', COUNT(*) FROM barbero_servicios
UNION ALL SELECT 'reservas', COUNT(*) FROM reservas
UNION ALL SELECT 'promociones', COUNT(*) FROM promociones
UNION ALL SELECT 'calificaciones', COUNT(*) FROM calificaciones;

-- Verificar integridad referencial
SELECT '=== VERIFICACIÓN DE INTEGRIDAD ===' as '';
SELECT 'Reservas con FK válidas' as 'Verificación', COUNT(*) as 'Cantidad'
FROM reservas r
INNER JOIN clientes c ON r.id_cliente = c.id_cliente
INNER JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion;

-- Usuarios del sistema
SELECT '=== USUARIOS DE LA BASE DE DATOS ===' as '';
SELECT User, Host, authentication_string IS NOT NULL as 'Tiene Password'
FROM mysql.user 
WHERE User IN ('root', 'barberia_user', 'cliente_user', 'barbero_user', 'admin_barberia', 'super_admin');