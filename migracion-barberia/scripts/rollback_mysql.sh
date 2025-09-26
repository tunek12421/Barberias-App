#!/bin/bash
# rollback_mysql.sh - Script de reversión en caso de fallo

echo "========================================"
echo "ROLLBACK: Restaurando MySQL Original"
echo "========================================"

# Solicitar confirmación
read -p "¿Seguro que deseas revertir la migración? (s/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "Rollback cancelado"
    exit 1
fi

# Detener PostgreSQL
echo "1. Deteniendo PostgreSQL..."
docker stop postgres-barberia

# Restaurar backup más reciente
ULTIMO_BACKUP=$(ls -t ../backups/barberia_completo_*.sql | head -1)
echo "2. Restaurando desde: $ULTIMO_BACKUP"
docker exec -i mysql-barberia mysql -u root -proot123 barberia_db < $ULTIMO_BACKUP

# Verificar restauración
echo "3. Verificando restauración..."
docker exec mysql-barberia mysql -u root -proot123 -e "USE barberia_db; SELECT COUNT(*) as 'Total Reservas' FROM reservas;"

echo "========================================"
echo "ROLLBACK COMPLETADO"
echo "Tiempo estimado: 5 minutos"
echo "========================================"