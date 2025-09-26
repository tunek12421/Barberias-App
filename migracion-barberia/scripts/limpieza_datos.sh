#!/bin/bash
# limpieza_datos.sh - Validar integridad de datos

echo "========================================"
echo "NORMALIZACIÓN Y LIMPIEZA DE DATOS"
echo "========================================"

echo -e "\n1. VERIFICACIÓN DE DUPLICADOS:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 'Emails duplicados' as Verificacion, COUNT(*) as Cantidad
FROM (SELECT email FROM clientes GROUP BY email HAVING COUNT(*) > 1) d
UNION
SELECT 'DNIs duplicados', COUNT(*)
FROM (SELECT dni FROM barberos GROUP BY dni HAVING COUNT(*) > 1) d;"

echo -e "\n2. VERIFICACIÓN DE NULOS EN CAMPOS OBLIGATORIOS:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 'Clientes sin email' as Campo_Nulo, COUNT(*) as Cantidad
FROM clientes WHERE email IS NULL
UNION SELECT 'Barberos sin barberia', COUNT(*)
FROM barberos WHERE id_barberia IS NULL
UNION SELECT 'Reservas sin cliente', COUNT(*)
FROM reservas WHERE id_cliente IS NULL;"

echo -e "\n3. INTEGRIDAD REFERENCIAL:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 'Reservas con FK validas' as Verificacion, COUNT(*) as Cantidad
FROM reservas r
WHERE EXISTS (SELECT 1 FROM clientes c WHERE c.id_cliente = r.id_cliente)
AND EXISTS (SELECT 1 FROM barbero_servicios bs WHERE bs.id_asignacion = r.id_barbero_servicio);"

echo "========================================"