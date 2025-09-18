# Base de Datos - Sistema de Gestión de Barberías

## Configuración MySQL con Docker

### Estructura del proyecto:
```
mysql-barberia-db/
├── docker-compose.yml    # Configuración del contenedor
├── data/                 # Datos persistentes de MySQL
├── logs/                 # Logs de MySQL
├── config/              # Configuraciones personalizadas
├── migrations/          # Scripts SQL de inicialización
└── README.md           # Este archivo
```

### Credenciales:
- **Host**: localhost
- **Puerto**: 3308
- **Base de datos**: barberia_db
- **Usuario root**: root / root123
- **Usuario aplicación**: barberia_user / barberia123

### Comandos:

#### Levantar el contenedor:
```bash
cd mysql-barberia-db
docker-compose up -d
```

#### Ver logs:
```bash
docker-compose logs -f mysql
```

#### Conectar a MySQL:
```bash
# Como root
docker exec -it mysql-barberia mysql -u root -proot123

# Como usuario de aplicación
docker exec -it mysql-barberia mysql -u barberia_user -pbarberia123 barberia_db
```

#### Detener el contenedor:
```bash
docker-compose down
```

#### Limpiar datos (CUIDADO):
```bash
docker-compose down -v
sudo rm -rf data/
```

### Esquema implementado:
- ✅ Modelo físico completo implementado en MySQL
- ✅ Relaciones con Foreign Keys
- ✅ Constraints e índices
- ✅ **20+ registros por tabla** (002_insert_sample_data.sql)
- ✅ Enums para estados y categorías

### Datos incluidos:
- **20 administradores** con diferentes niveles de acceso
- **20 barberías** distribuidas en Cochabamba
- **20 barberos** con especialidades variadas
- **20 servicios** diversos (cortes, barbas, combos, tratamientos)
- **25 clientes** con puntos de fidelidad
- **30 reservas** en diferentes estados
- **20 promociones** activas y variadas
- **25 calificaciones** con comentarios reales