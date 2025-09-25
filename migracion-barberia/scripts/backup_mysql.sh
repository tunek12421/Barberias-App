#!/bin/bash
# backup_mysql.sh - Script de respaldo completo de MySQL

FECHA=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="../backups"

echo "========================================"
echo "INICIANDO RESPALDO DE MySQL"
echo "Fecha: $FECHA"
echo "========================================"

# Crear directorio si no existe
mkdir -p $BACKUP_DIR

# Respaldo completo con estructura y datos
echo "1. Respaldando base de datos completa..."
docker exec mysql-barberia mysqldump \
    -u root -proot123 \
    --databases barberia_db \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --complete-insert \
    --extended-insert \
    --hex-blob \
    > $BACKUP_DIR/barberia_completo_$FECHA.sql

# Respaldo solo estructura
echo "2. Respaldando solo estructura..."
docker exec mysql-barberia mysqldump \
    -u root -proot123 \
    --databases barberia_db \
    --no-data \
    --routines \
    --triggers \
    --events \
    > $BACKUP_DIR/barberia_estructura_$FECHA.sql

# Respaldo solo datos
echo "3. Respaldando solo datos..."
docker exec mysql-barberia mysqldump \
    -u root -proot123 \
    --databases barberia_db \
    --no-create-info \
    --complete-insert \
    --skip-triggers \
    > $BACKUP_DIR/barberia_datos_$FECHA.sql

# Respaldar configuración de MySQL
echo "4. Respaldando configuración..."
docker exec mysql-barberia cat /etc/mysql/my.cnf > $BACKUP_DIR/my.cnf_$FECHA 2>/dev/null || echo "my.cnf no accesible"

# Verificar respaldos
echo ""
echo "Respaldos creados:"
ls -lh $BACKUP_DIR/*$FECHA*

echo ""
echo "========================================"
echo "RESPALDO COMPLETADO"
echo "========================================"