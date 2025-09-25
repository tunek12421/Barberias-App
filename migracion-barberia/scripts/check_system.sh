#!/bin/bash
# inventario_completo.sh - Genera inventario con tablas formateadas

echo "========================================"
echo "INVENTARIO DEL SISTEMA - MIGRACIÓN MySQL → PostgreSQL"
echo "Fecha: $(date)"
echo "========================================"
echo ""

# Obtener valores
HOSTNAME=$(hostname)
CPU=$(lscpu | grep -E 'Model name|Nombre del modelo' | cut -d: -f2 | xargs | head -c 60)
CORES=$(nproc)
RAM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
RAM_DISP=$(free -h | grep Mem | awk '{print $7}')
DISK_TOTAL=$(df -h / | tail -1 | awk '{print $2}')
DISK_DISP=$(df -h / | tail -1 | awk '{print $4}')
DISK_TYPE=$(lsblk -d -o ROTA | grep -E "0|1" | head -1 | sed 's/0/SSD/; s/1/HDD/')
SO=$(lsb_release -ds)
KERNEL=$(uname -r)
MYSQL_VER=$(docker exec mysql-barberia mysql --version 2>/dev/null | grep -o '[0-9]\.[0-9]\.[0-9]*' | head -1)
PG_VER=$(docker exec postgres-barberia psql --version 2>/dev/null | grep -o '[0-9]*\.[0-9]*' | head -1)
DOCKER_VER=$(docker --version | grep -o '[0-9]*\.[0-9]*\.[0-9]*' | head -1)
COMPOSE_VER=$(docker compose version | grep -o '[0-9]*\.[0-9]*\.[0-9]*' | head -1)
# Red física
NET_TYPE=$(ip a | grep -E "(wlp|wifi)" >/dev/null && echo "WiFi" || echo "Ethernet")
NET_ACTIVE=$(ip a | grep -A 3 "state UP" | grep -E "(wlp|enp|eth)" | head -1 | awk '{print $2}' | cut -d: -f1)
# IP real del sistema
REAL_IP=$(ip route get 8.8.8.8 2>/dev/null | grep -oP 'src \K\S+' || echo "127.0.0.1")
# Firewall
FW_STATUS=$(echo "Aj112895" | sudo -S ufw status 2>/dev/null | grep "Estado:" | awk '{print $2}' || echo "desconocido")
# Redes Docker reales
MYSQL_NETWORK=$(docker network ls | grep barberia | grep mysql | awk '{print $2}' || echo "barberia-network")
PG_NETWORK=$(docker network ls | grep barberia | grep postgres | awk '{print $2}' || echo "barberia-network-pg")
# Estados de servicios/contenedores
MYSQL_STATUS=$(docker ps --format "{{.Status}}" --filter name=mysql-barberia 2>/dev/null | head -1 || echo "Detenido")
PG_STATUS=$(docker ps --format "{{.Status}}" --filter name=postgres-barberia 2>/dev/null | head -1 || echo "Detenido")
DOCKER_SERVICE=$(systemctl is-active docker 2>/dev/null || echo "inactivo")

echo "## TABLA HARDWARE"
printf "%-15s | %-45s | %-20s\n" "Componente" "Detalle/Especificación" "Observaciones"
printf "%-15s | %-45s | %-20s\n" "---------------" "---------------------------------------------" "--------------------"
printf "%-15s | %-45s | %-20s\n" "Servidor" "$HOSTNAME ($REAL_IP)" "Ambiente desarrollo"
printf "%-15s | %-45s | %-20s\n" "Procesador" "${CPU:-N/A}" "$CORES núcleos"
printf "%-15s | %-45s | %-20s\n" "Memoria RAM" "$RAM_TOTAL" "$RAM_DISP disponibles"
printf "%-15s | %-45s | %-20s\n" "Almacenamiento" "$DISK_TOTAL ${DISK_TYPE:-SSD}" "$DISK_DISP disponibles"
printf "%-15s | %-45s | %-20s\n" "Red" "$NET_TYPE ($NET_ACTIVE)" "Conexión activa"
echo ""

echo "## TABLA SOFTWARE"
printf "%-18s | %-20s | %-20s\n" "Componente" "Versión/Detalle" "Observaciones"
printf "%-18s | %-20s | %-20s\n" "------------------" "--------------------" "--------------------"
printf "%-18s | %-20s | %-20s\n" "Sistema Operativo" "$SO" "Kernel $KERNEL"
printf "%-18s | %-20s | %-20s\n" "SGBD Origen" "MySQL $MYSQL_VER" "$MYSQL_STATUS"
printf "%-18s | %-20s | %-20s\n" "SGBD Destino" "PostgreSQL $PG_VER" "$PG_STATUS"
printf "%-18s | %-20s | %-20s\n" "Docker" "$DOCKER_VER" "Servicio $DOCKER_SERVICE"
printf "%-18s | %-20s | %-20s\n" "Docker Compose" "$COMPOSE_VER" "Orquestación"
printf "%-18s | %-20s | %-20s\n" "Cliente MySQL" "$(mysql --version 2>/dev/null | grep -o '[0-9]\.[0-9]\.[0-9]*' | head -1 || echo 'N/A')" "Host"
echo ""

echo "## TABLA RED"
printf "%-22s | %-19s | %-20s\n" "Configuración" "Detalle" "Observaciones"
printf "%-22s | %-19s | %-20s\n" "----------------------" "-------------------" "--------------------"
printf "%-22s | %-19s | %-20s\n" "IP Local" "127.0.0.1" "localhost"
printf "%-22s | %-19s | %-20s\n" "Puerto MySQL" "3308" "Mapeado desde 3306"
printf "%-22s | %-19s | %-20s\n" "Puerto PostgreSQL" "5433" "Mapeado desde 5432"
printf "%-22s | %-19s | %-20s\n" "Red Docker MySQL" "$MYSQL_NETWORK" "Bridge"
printf "%-22s | %-19s | %-20s\n" "Red Docker PostgreSQL" "$PG_NETWORK" "Bridge"
printf "%-22s | %-19s | %-20s\n" "Firewall UFW" "$FW_STATUS" "Estado actual"
printf "%-22s | %-19s | %-20s\n" "IP Red" "$REAL_IP" "Acceso desde LAN"
echo ""

echo "========================================"
echo "FIN DEL INVENTARIO"
echo "========================================"