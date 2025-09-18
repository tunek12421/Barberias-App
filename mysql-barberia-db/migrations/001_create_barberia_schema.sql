-- SCHEMA: Sistema de Gestión de Barberías - Implementación del Modelo Físico en MySQL

USE barberia_db;

-- Eliminar tablas si existen (orden inverso por FK)
DROP TABLE IF EXISTS calificaciones;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS barbero_servicios;
DROP TABLE IF EXISTS promociones;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS barberos;
DROP TABLE IF EXISTS barberias;
DROP TABLE IF EXISTS administradores;
DROP TABLE IF EXISTS clientes;

-- TABLA: clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    dni VARCHAR(20) UNIQUE,
    direccion TEXT,
    fecha_nacimiento DATE,
    preferencias JSON,
    puntos_fidelidad INT DEFAULT 0,
    fecha_primera_visita DATE,
    estado ENUM('activo', 'inactivo', 'suspendido') NOT NULL DEFAULT 'activo',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP
);

-- TABLA: administradores
CREATE TABLE administradores (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    dni VARCHAR(20) NOT NULL UNIQUE,
    nivel_acceso ENUM('limitado', 'completo', 'super_admin') NOT NULL DEFAULT 'limitado',
    permisos_especiales JSON,
    estado ENUM('activo', 'inactivo', 'suspendido') NOT NULL DEFAULT 'activo',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP
);

-- TABLA: barberias
CREATE TABLE barberias (
    id_barberia INT AUTO_INCREMENT PRIMARY KEY,
    id_administrador INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    horario_apertura TIME NOT NULL,
    horario_cierre TIME NOT NULL,
    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8),
    estado ENUM('activo', 'inactivo', 'mantenimiento') NOT NULL DEFAULT 'activo',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_administrador) REFERENCES administradores(id_administrador)
);

-- TABLA: barberos
CREATE TABLE barberos (
    id_barbero INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    dni VARCHAR(20) NOT NULL UNIQUE,
    id_barberia INT NOT NULL,
    especialidades JSON,
    experiencia_anos INT DEFAULT 0,
    calificacion_promedio DECIMAL(3,2) DEFAULT 0.00,
    estado ENUM('activo', 'inactivo', 'vacaciones', 'licencia') NOT NULL DEFAULT 'activo',
    fecha_ingreso DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP,

    FOREIGN KEY (id_barberia) REFERENCES barberias(id_barberia) ON DELETE CASCADE
);

-- TABLA: servicios
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_barberia INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_minutos INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria ENUM('corte', 'barba', 'combo', 'tratamiento', 'otros') NOT NULL,
    estado ENUM('activo', 'inactivo', 'descontinuado') NOT NULL DEFAULT 'activo',

    FOREIGN KEY (id_barberia) REFERENCES barberias(id_barberia) ON DELETE CASCADE
);

-- TABLA: barbero_servicios (Relación M:N)
CREATE TABLE barbero_servicios (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_barbero INT NOT NULL,
    id_servicio INT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    UNIQUE KEY uk_barbero_servicio (id_barbero, id_servicio),
    FOREIGN KEY (id_barbero) REFERENCES barberos(id_barbero) ON DELETE CASCADE,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio) ON DELETE CASCADE
);

-- TABLA: reservas
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_barbero_servicio INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    duracion_estimada INT NOT NULL,
    precio_acordado DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'en_proceso', 'completada', 'cancelada', 'no_asistio') NOT NULL DEFAULT 'pendiente',
    notas_cliente TEXT,
    notas_barbero TEXT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_confirmacion TIMESTAMP,
    fecha_completada TIMESTAMP,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_barbero_servicio) REFERENCES barbero_servicios(id_asignacion) ON DELETE CASCADE
);

-- TABLA: promociones
CREATE TABLE promociones (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    id_barberia INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    descuento_porcentaje DECIMAL(5,2),
    descuento_monto DECIMAL(10,2),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    max_usos INT,
    usos_actuales INT DEFAULT 0,
    estado ENUM('activa', 'pausada', 'vencida', 'agotada') NOT NULL DEFAULT 'activa',

    FOREIGN KEY (id_barberia) REFERENCES barberias(id_barberia) ON DELETE CASCADE
);

-- TABLA: calificaciones
CREATE TABLE calificaciones (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    puntuacion_servicio INT NOT NULL CHECK (puntuacion_servicio BETWEEN 1 AND 5),
    puntuacion_barbero INT NOT NULL CHECK (puntuacion_barbero BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_calificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) ON DELETE CASCADE
);

-- ÍNDICES PARA OPTIMIZACIÓN

-- Índices en campos de búsqueda frecuente
CREATE INDEX idx_reservas_fecha_hora ON reservas(fecha_hora);
CREATE INDEX idx_reservas_estado ON reservas(estado);
CREATE INDEX idx_barberos_barberia ON barberos(id_barberia);
CREATE INDEX idx_servicios_barberia ON servicios(id_barberia);
CREATE INDEX idx_promociones_fechas ON promociones(fecha_inicio, fecha_fin);

-- ESQUEMA LISTO PARA DATOS

-- El esquema está listo para recibir datos
-- Los datos se insertan en el archivo 002_insert_sample_data.sql