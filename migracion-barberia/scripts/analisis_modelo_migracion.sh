#!/bin/bash
# analisis_modelo_migracion.sh - Análisis detallado para migración MySQL a PostgreSQL

echo "========================================"
echo "ANÁLISIS DEL MODELO - MIGRACIÓN MySQL a PostgreSQL"
echo "========================================"

# PUNTO 1: REVISAR ESTRUCTURAS, TIPOS DE DATOS, RESTRICCIONES
echo -e "\n>>> PUNTO 1: REVISAR ESTRUCTURAS, TIPOS Y RESTRICCIONES"
echo "----------------------------------------"

echo -e "\nESTRUCTURAS DE TABLAS:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT TABLE_NAME, TABLE_ROWS, ENGINE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'barberia_db' 
AND TABLE_TYPE = 'BASE TABLE';"

echo -e "\nTIPOS DE DATOS UTILIZADOS:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT DATA_TYPE, COUNT(*) as Cantidad
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'barberia_db'
GROUP BY DATA_TYPE
ORDER BY COUNT(*) DESC
LIMIT 10;"

echo -e "\nRESTRICCIONES EXISTENTES:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT CONSTRAINT_TYPE, COUNT(*) as Cantidad
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'barberia_db'
GROUP BY CONSTRAINT_TYPE;"

echo -e "\nDETALLE DE RESTRICCIONES:"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 
    TABLE_NAME as Tabla,
    CONSTRAINT_NAME as Restriccion,
    CONSTRAINT_TYPE as Tipo
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'barberia_db'
ORDER BY CONSTRAINT_TYPE, TABLE_NAME
LIMIT 20;"

# PUNTO 2: EXTRAER ESQUEMA Y DETECTAR DIFERENCIAS
echo -e "\n>>> PUNTO 2: EXTRAER ESQUEMA Y DETECTAR DIFERENCIAS"
echo "----------------------------------------"

echo -e "\nEXTRACCIÓN DEL ESQUEMA:"
docker exec mysql-barberia mysqldump -u root -proot123 \
  --no-data --routines --triggers \
  barberia_db > ../backups/esquema_mysql.sql
echo "   Esquema extraído: ../backups/esquema_mysql.sql"

echo -e "\nDIFERENCIAS DETECTADAS PARA MIGRACIÓN:"

echo -e "\nAUTO_INCREMENT (cambiar a SERIAL) - Total: 9"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 
    TABLE_NAME as Tabla,
    COLUMN_NAME as Columna
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'barberia_db' 
AND EXTRA LIKE '%auto_increment%';"

echo -e "\nENUM (cambiar a CHECK) - Total: 11"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 
    TABLE_NAME as Tabla,
    COLUMN_NAME as Columna,
    COLUMN_TYPE as Valores_Enum
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'barberia_db' 
AND DATA_TYPE = 'enum'
LIMIT 10;"

echo -e "\nTINYINT (cambiar a BOOLEAN) - Total: 1"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 
    TABLE_NAME as Tabla,
    COLUMN_NAME as Columna
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'barberia_db' 
AND COLUMN_TYPE = 'tinyint(1)';"

echo -e "\nJSON (cambiar a JSONB) - Total: 3"
docker exec mysql-barberia mysql -u root -proot123 barberia_db -e "
SELECT 
    TABLE_NAME as Tabla,
    COLUMN_NAME as Columna
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'barberia_db' 
AND DATA_TYPE = 'json';"

echo "========================================"
echo "ANÁLISIS COMPLETADO"
echo "========================================"