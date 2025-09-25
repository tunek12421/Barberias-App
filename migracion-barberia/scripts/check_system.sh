#!/bin/bash
# check_system.sh - Script para obtener información del sistema

echo "========================================"
echo "INFORMACIÓN DEL SISTEMA"
echo "========================================"
echo ""
echo "1. INFORMACIÓN DEL HOST:"
echo "------------------------"
echo "Sistema Operativo:"
uname -a
echo ""
echo "Versión del Kernel:"
uname -r
echo ""
echo "Memoria RAM:"
free -h
echo ""
echo "Espacio en Disco:"
df -h
echo ""
echo "CPU Info:"
lscpu | head -15
echo ""

echo "2. VERSIONES DE SOFTWARE:"
echo "------------------------"
echo "Docker Version:"
docker --version
echo ""
echo "Docker Compose Version:"
docker compose version
echo ""
echo "MySQL Client Version:"
mysql --version 2>/dev/null || echo "MySQL client no instalado"
echo ""
echo "PostgreSQL Client Version:"
psql --version 2>/dev/null || echo "PostgreSQL client no instalado"
echo ""

echo "3. CONTENEDOR MySQL ACTUAL:"
echo "------------------------"
echo "Estado del contenedor:"
docker ps -a | grep mysql-barberia
echo ""
echo "Estadísticas de recursos:"
docker stats mysql-barberia --no-stream
echo ""
echo "Información de red:"
docker network ls
echo ""
echo "Volúmenes:"
docker volume ls
echo ""

echo "4. TAMAÑO DE LA BASE DE DATOS MySQL:"
echo "------------------------"
docker exec mysql-barberia du -sh /var/lib/mysql/barberia_db 2>/dev/null || echo "No se puede acceder"
echo ""

echo "========================================"
echo "FIN DEL REPORTE"
echo "========================================"