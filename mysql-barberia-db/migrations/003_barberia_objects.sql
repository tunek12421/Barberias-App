-- MIGRACIÓN 003: OBJETOS AVANZADOS PARA SISTEMA DE BARBERÍAS
-- Basado en el patrón del proyecto mysql-hardening

USE barberia_db;

-- Iniciar transacción para garantizar atomicidad
START TRANSACTION;

-- 1. USUARIOS Y ROLES CON PERMISOS ESPECÍFICOS

-- Usuario para clientes (solo consultas y reservas)
CREATE USER IF NOT EXISTS 'cliente_user'@'localhost' IDENTIFIED BY 'cliente123';
GRANT SELECT ON barberia_db.barberias TO 'cliente_user'@'localhost';
GRANT SELECT ON barberia_db.barberos TO 'cliente_user'@'localhost';
GRANT SELECT ON barberia_db.servicios TO 'cliente_user'@'localhost';
GRANT SELECT ON barberia_db.promociones TO 'cliente_user'@'localhost';
GRANT SELECT, INSERT ON barberia_db.reservas TO 'cliente_user'@'localhost';
GRANT SELECT, INSERT ON barberia_db.calificaciones TO 'cliente_user'@'localhost';
GRANT SELECT, UPDATE ON barberia_db.clientes TO 'cliente_user'@'localhost';

-- Usuario para barberos (gestión de sus servicios y citas)
CREATE USER IF NOT EXISTS 'barbero_user'@'localhost' IDENTIFIED BY 'barbero123';
GRANT SELECT ON barberia_db.* TO 'barbero_user'@'localhost';
GRANT UPDATE ON barberia_db.reservas TO 'barbero_user'@'localhost';
GRANT UPDATE ON barberia_db.barberos TO 'barbero_user'@'localhost';
GRANT INSERT, UPDATE ON barberia_db.barbero_servicios TO 'barbero_user'@'localhost';

-- Usuario administrador de barbería
CREATE USER IF NOT EXISTS 'admin_barberia'@'localhost' IDENTIFIED BY 'adminbarberia123';
GRANT ALL PRIVILEGES ON barberia_db.barberias TO 'admin_barberia'@'localhost';
GRANT ALL PRIVILEGES ON barberia_db.barberos TO 'admin_barberia'@'localhost';
GRANT ALL PRIVILEGES ON barberia_db.servicios TO 'admin_barberia'@'localhost';
GRANT ALL PRIVILEGES ON barberia_db.promociones TO 'admin_barberia'@'localhost';
GRANT SELECT ON barberia_db.* TO 'admin_barberia'@'localhost';

-- Usuario super administrador del sistema
CREATE USER IF NOT EXISTS 'super_admin'@'localhost' IDENTIFIED BY 'superadmin123';
GRANT ALL PRIVILEGES ON barberia_db.* TO 'super_admin'@'localhost';
GRANT CREATE USER ON *.* TO 'super_admin'@'localhost';
GRANT RELOAD ON *.* TO 'super_admin'@'localhost';

FLUSH PRIVILEGES;

-- 2. VISTAS PARA CONSULTAS FRECUENTES

-- Vista: Disponibilidad de barberos por barbería
CREATE OR REPLACE VIEW vista_disponibilidad_barberos AS
SELECT 
    b.id_barberia,
    bar.nombre AS barberia,
    b.id_barbero,
    b.nombre,
    b.apellido,
    b.estado,
    b.calificacion_promedio,
    COUNT(DISTINCT bs.id_servicio) AS servicios_disponibles,
    COUNT(DISTINCT r.id_reserva) AS reservas_pendientes
FROM barberos b
JOIN barberias bar ON b.id_barberia = bar.id_barberia
LEFT JOIN barbero_servicios bs ON b.id_barbero = bs.id_barbero AND bs.activo = TRUE
LEFT JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio 
    AND r.estado IN ('pendiente', 'confirmada')
WHERE b.estado = 'activo'
GROUP BY b.id_barbero
ORDER BY bar.nombre, b.calificacion_promedio DESC;

-- Vista: Servicios más populares
CREATE OR REPLACE VIEW vista_servicios_populares AS
SELECT 
    s.id_servicio,
    s.nombre AS servicio,
    s.categoria,
    s.precio,
    bar.nombre AS barberia,
    COUNT(DISTINCT r.id_reserva) AS total_reservas,
    AVG(c.puntuacion_servicio) AS calificacion_promedio,
    SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS ingresos_generados
FROM servicios s
JOIN barberias bar ON s.id_barberia = bar.id_barberia
JOIN barbero_servicios bs ON s.id_servicio = bs.id_servicio
LEFT JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio
LEFT JOIN calificaciones c ON r.id_reserva = c.id_reserva
WHERE s.estado = 'activo'
GROUP BY s.id_servicio
ORDER BY total_reservas DESC;

-- Vista: Clientes VIP (más frecuentes)
CREATE OR REPLACE VIEW vista_clientes_vip AS
SELECT 
    c.id_cliente,
    c.nombre,
    c.apellido,
    c.email,
    c.puntos_fidelidad,
    COUNT(DISTINCT r.id_reserva) AS total_visitas,
    SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS total_gastado,
    AVG(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE NULL END) AS ticket_promedio,
    MAX(r.fecha_hora) AS ultima_visita
FROM clientes c
JOIN reservas r ON c.id_cliente = r.id_cliente
WHERE c.estado = 'activo'
GROUP BY c.id_cliente
HAVING total_visitas >= 3
ORDER BY total_gastado DESC;

-- Vista: Dashboard de ingresos por barbería
CREATE OR REPLACE VIEW vista_ingresos_barberia AS
SELECT 
    b.id_barberia,
    b.nombre AS barberia,
    DATE_FORMAT(r.fecha_hora, '%Y-%m') AS mes,
    COUNT(DISTINCT r.id_reserva) AS total_reservas,
    COUNT(DISTINCT r.id_cliente) AS clientes_unicos,
    SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS ingresos,
    AVG(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE NULL END) AS ticket_promedio
FROM barberias b
JOIN barberos br ON b.id_barberia = br.id_barberia
JOIN barbero_servicios bs ON br.id_barbero = bs.id_barbero
JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio
WHERE r.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY b.id_barberia, DATE_FORMAT(r.fecha_hora, '%Y-%m')
ORDER BY b.nombre, mes DESC;

-- Vista: Calificaciones y feedback
CREATE OR REPLACE VIEW vista_calificaciones_resumen AS
SELECT 
    bar.id_barberia,
    bar.nombre AS barberia,
    b.id_barbero,
    CONCAT(b.nombre, ' ', b.apellido) AS barbero,
    COUNT(DISTINCT cal.id_calificacion) AS total_calificaciones,
    AVG(cal.puntuacion_barbero) AS promedio_barbero,
    AVG(cal.puntuacion_servicio) AS promedio_servicio,
    MAX(cal.fecha_calificacion) AS ultima_calificacion
FROM barberias bar
JOIN barberos b ON bar.id_barberia = b.id_barberia
JOIN barbero_servicios bs ON b.id_barbero = bs.id_barbero
JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio
JOIN calificaciones cal ON r.id_reserva = cal.id_reserva
GROUP BY bar.id_barberia, b.id_barbero
ORDER BY promedio_barbero DESC;

-- 3. PROCEDIMIENTOS ALMACENADOS

DELIMITER //

-- Procedimiento: Registrar reserva completa con validaciones
CREATE PROCEDURE RegistrarReservaCompleta(
    IN p_id_cliente INT,
    IN p_id_barbero INT,
    IN p_id_servicio INT,
    IN p_fecha_hora TIMESTAMP,
    IN p_notas_cliente TEXT
)
BEGIN
    DECLARE v_id_asignacion INT;
    DECLARE v_duracion INT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_estado_barbero VARCHAR(20);
    DECLARE v_conflicto INT DEFAULT 0;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- Verificar que el barbero esté activo
    SELECT estado INTO v_estado_barbero 
    FROM barberos 
    WHERE id_barbero = p_id_barbero;
    
    IF v_estado_barbero != 'activo' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El barbero no está disponible';
    END IF;
    
    -- Obtener la asignación barbero-servicio
    SELECT id_asignacion INTO v_id_asignacion
    FROM barbero_servicios
    WHERE id_barbero = p_id_barbero 
    AND id_servicio = p_id_servicio 
    AND activo = TRUE;
    
    IF v_id_asignacion IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El barbero no ofrece este servicio';
    END IF;
    
    -- Obtener duración y precio del servicio
    SELECT duracion_minutos, precio 
    INTO v_duracion, v_precio
    FROM servicios 
    WHERE id_servicio = p_id_servicio;
    
    -- Verificar disponibilidad (no hay conflicto de horario)
    SELECT COUNT(*) INTO v_conflicto
    FROM reservas r
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE bs.id_barbero = p_id_barbero
    AND r.estado IN ('confirmada', 'en_proceso')
    AND (
        (p_fecha_hora BETWEEN r.fecha_hora 
            AND DATE_ADD(r.fecha_hora, INTERVAL r.duracion_estimada MINUTE))
        OR 
        (DATE_ADD(p_fecha_hora, INTERVAL v_duracion MINUTE) 
            BETWEEN r.fecha_hora 
            AND DATE_ADD(r.fecha_hora, INTERVAL r.duracion_estimada MINUTE))
    );
    
    IF v_conflicto > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Horario no disponible, existe conflicto con otra reserva';
    END IF;
    
    -- Insertar la reserva
    INSERT INTO reservas (
        id_cliente, 
        id_barbero_servicio, 
        fecha_hora, 
        duracion_estimada, 
        precio_acordado, 
        estado, 
        notas_cliente
    ) VALUES (
        p_id_cliente,
        v_id_asignacion,
        p_fecha_hora,
        v_duracion,
        v_precio,
        'pendiente',
        p_notas_cliente
    );
    
    -- Confirmar transacción
    COMMIT;
    
    SELECT 'Reserva registrada exitosamente' AS mensaje, LAST_INSERT_ID() AS id_reserva;
END//

-- Procedimiento: Calcular disponibilidad de un barbero en fecha específica
CREATE PROCEDURE CalcularDisponibilidadBarbero(
    IN p_id_barbero INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE v_hora_apertura TIME;
    DECLARE v_hora_cierre TIME;
    
    -- Obtener horario de la barbería
    SELECT bar.horario_apertura, bar.horario_cierre
    INTO v_hora_apertura, v_hora_cierre
    FROM barberos b
    JOIN barberias bar ON b.id_barberia = bar.id_barberia
    WHERE b.id_barbero = p_id_barbero;
    
    -- Mostrar slots disponibles (intervalos de 30 minutos)
    WITH RECURSIVE time_slots AS (
        SELECT v_hora_apertura AS slot_time
        UNION ALL
        SELECT ADDTIME(slot_time, '00:30:00')
        FROM time_slots
        WHERE slot_time < SUBTIME(v_hora_cierre, '00:30:00')
    )
    SELECT 
        ts.slot_time AS hora_disponible,
        CASE 
            WHEN r.id_reserva IS NULL THEN 'Disponible'
            ELSE 'Ocupado'
        END AS estado
    FROM time_slots ts
    LEFT JOIN (
        SELECT r.*, bs.id_barbero
        FROM reservas r
        JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
        WHERE DATE(r.fecha_hora) = p_fecha
        AND bs.id_barbero = p_id_barbero
        AND r.estado IN ('pendiente', 'confirmada', 'en_proceso')
    ) r ON ts.slot_time BETWEEN TIME(r.fecha_hora) 
        AND TIME(DATE_ADD(r.fecha_hora, INTERVAL r.duracion_estimada MINUTE))
    ORDER BY ts.slot_time;
END//

-- Procedimiento: Aplicar promoción a una reserva
CREATE PROCEDURE AplicarPromocion(
    IN p_id_reserva INT,
    IN p_id_promocion INT
)
BEGIN
    DECLARE v_descuento_porcentaje DECIMAL(5,2);
    DECLARE v_descuento_monto DECIMAL(10,2);
    DECLARE v_precio_original DECIMAL(10,2);
    DECLARE v_precio_final DECIMAL(10,2);
    DECLARE v_usos_actuales INT;
    DECLARE v_max_usos INT;
    
    START TRANSACTION;
    
    -- Obtener datos de la promoción
    SELECT descuento_porcentaje, descuento_monto, usos_actuales, max_usos
    INTO v_descuento_porcentaje, v_descuento_monto, v_usos_actuales, v_max_usos
    FROM promociones
    WHERE id_promocion = p_id_promocion
    AND estado = 'activa'
    AND CURDATE() BETWEEN fecha_inicio AND fecha_fin;
    
    IF v_descuento_porcentaje IS NULL AND v_descuento_monto IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Promoción no válida o expirada';
    END IF;
    
    -- Verificar límite de usos
    IF v_max_usos IS NOT NULL AND v_usos_actuales >= v_max_usos THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Promoción agotada';
    END IF;
    
    -- Obtener precio original de la reserva
    SELECT precio_acordado INTO v_precio_original
    FROM reservas
    WHERE id_reserva = p_id_reserva;
    
    -- Calcular precio con descuento
    IF v_descuento_porcentaje IS NOT NULL THEN
        SET v_precio_final = v_precio_original * (1 - v_descuento_porcentaje/100);
    ELSE
        SET v_precio_final = v_precio_original - v_descuento_monto;
    END IF;
    
    -- Actualizar precio de la reserva
    UPDATE reservas 
    SET precio_acordado = v_precio_final,
        notas_barbero = CONCAT(IFNULL(notas_barbero, ''), 
            ' [Promoción aplicada: ID', p_id_promocion, ']')
    WHERE id_reserva = p_id_reserva;
    
    -- Incrementar contador de usos de la promoción
    UPDATE promociones
    SET usos_actuales = usos_actuales + 1
    WHERE id_promocion = p_id_promocion;
    
    COMMIT;
    
    SELECT 
        v_precio_original AS precio_original,
        v_precio_final AS precio_con_descuento,
        (v_precio_original - v_precio_final) AS ahorro;
END//

-- Procedimiento: Generar reporte mensual de barbería
CREATE PROCEDURE GenerarReporteMensualBarberia(
    IN p_id_barberia INT,
    IN p_mes INT,
    IN p_anio INT
)
BEGIN
    -- Resumen general del mes
    SELECT 
        'RESUMEN MENSUAL' AS seccion,
        COUNT(DISTINCT r.id_reserva) AS total_reservas,
        COUNT(DISTINCT CASE WHEN r.estado = 'completada' THEN r.id_reserva END) AS reservas_completadas,
        COUNT(DISTINCT CASE WHEN r.estado = 'cancelada' THEN r.id_reserva END) AS reservas_canceladas,
        COUNT(DISTINCT r.id_cliente) AS clientes_atendidos,
        SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS ingresos_totales,
        AVG(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE NULL END) AS ticket_promedio
    FROM reservas r
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    JOIN barberos b ON bs.id_barbero = b.id_barbero
    WHERE b.id_barberia = p_id_barberia
    AND MONTH(r.fecha_hora) = p_mes
    AND YEAR(r.fecha_hora) = p_anio;
    
    -- Top barberos del mes
    SELECT 
        'TOP BARBEROS' AS seccion,
        b.id_barbero,
        CONCAT(b.nombre, ' ', b.apellido) AS barbero,
        COUNT(r.id_reserva) AS servicios_realizados,
        SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS ingresos_generados,
        AVG(c.puntuacion_barbero) AS calificacion_promedio
    FROM barberos b
    JOIN barbero_servicios bs ON b.id_barbero = bs.id_barbero
    JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio
    LEFT JOIN calificaciones c ON r.id_reserva = c.id_reserva
    WHERE b.id_barberia = p_id_barberia
    AND MONTH(r.fecha_hora) = p_mes
    AND YEAR(r.fecha_hora) = p_anio
    GROUP BY b.id_barbero
    ORDER BY ingresos_generados DESC
    LIMIT 5;
    
    -- Servicios más solicitados
    SELECT 
        'SERVICIOS POPULARES' AS seccion,
        s.nombre AS servicio,
        s.categoria,
        COUNT(r.id_reserva) AS veces_solicitado,
        SUM(CASE WHEN r.estado = 'completada' THEN r.precio_acordado ELSE 0 END) AS ingresos
    FROM servicios s
    JOIN barbero_servicios bs ON s.id_servicio = bs.id_servicio
    JOIN reservas r ON bs.id_asignacion = r.id_barbero_servicio
    WHERE s.id_barberia = p_id_barberia
    AND MONTH(r.fecha_hora) = p_mes
    AND YEAR(r.fecha_hora) = p_anio
    GROUP BY s.id_servicio
    ORDER BY veces_solicitado DESC
    LIMIT 10;
END//

DELIMITER ;

-- 4. TRIGGERS PARA AUTOMATIZACIÓN

DELIMITER //

-- Trigger: Actualizar calificación promedio del barbero
CREATE TRIGGER tr_actualizar_calificacion_barbero
AFTER INSERT ON calificaciones
FOR EACH ROW
BEGIN
    DECLARE v_id_barbero INT;
    DECLARE v_promedio DECIMAL(3,2);
    
    -- Obtener el barbero de la reserva
    SELECT bs.id_barbero INTO v_id_barbero
    FROM reservas r
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE r.id_reserva = NEW.id_reserva;
    
    -- Calcular nuevo promedio
    SELECT AVG(c.puntuacion_barbero) INTO v_promedio
    FROM calificaciones c
    JOIN reservas r ON c.id_reserva = r.id_reserva
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE bs.id_barbero = v_id_barbero;
    
    -- Actualizar calificación del barbero
    UPDATE barberos 
    SET calificacion_promedio = v_promedio
    WHERE id_barbero = v_id_barbero;
END//

-- Trigger: Actualizar puntos de fidelidad del cliente
CREATE TRIGGER tr_actualizar_puntos_fidelidad
AFTER UPDATE ON reservas
FOR EACH ROW
BEGIN
    DECLARE v_puntos INT;
    
    -- Si la reserva se completó, agregar puntos
    IF NEW.estado = 'completada' AND OLD.estado != 'completada' THEN
        -- 1 punto por cada 10 soles gastados
        SET v_puntos = FLOOR(NEW.precio_acordado / 10);
        
        UPDATE clientes 
        SET puntos_fidelidad = puntos_fidelidad + v_puntos
        WHERE id_cliente = NEW.id_cliente;
    END IF;
END//

-- Trigger: Validar horario de reserva dentro del horario de la barbería
CREATE TRIGGER tr_validar_horario_reserva
BEFORE INSERT ON reservas
FOR EACH ROW
BEGIN
    DECLARE v_hora_apertura TIME;
    DECLARE v_hora_cierre TIME;
    DECLARE v_hora_reserva TIME;
    DECLARE v_hora_fin TIME;
    
    -- Obtener horario de la barbería
    SELECT bar.horario_apertura, bar.horario_cierre
    INTO v_hora_apertura, v_hora_cierre
    FROM barbero_servicios bs
    JOIN barberos b ON bs.id_barbero = b.id_barbero
    JOIN barberias bar ON b.id_barberia = bar.id_barberia
    WHERE bs.id_asignacion = NEW.id_barbero_servicio;
    
    SET v_hora_reserva = TIME(NEW.fecha_hora);
    SET v_hora_fin = TIME(DATE_ADD(NEW.fecha_hora, INTERVAL NEW.duracion_estimada MINUTE));
    
    -- Validar que la reserva esté dentro del horario
    IF v_hora_reserva < v_hora_apertura OR v_hora_fin > v_hora_cierre THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La reserva está fuera del horario de atención';
    END IF;
END//

-- Trigger: Actualizar estado de promociones vencidas
CREATE TRIGGER tr_actualizar_estado_promocion
BEFORE UPDATE ON promociones
FOR EACH ROW
BEGIN
    -- Si se alcanzó el máximo de usos
    IF NEW.max_usos IS NOT NULL AND NEW.usos_actuales >= NEW.max_usos THEN
        SET NEW.estado = 'agotada';
    -- Si pasó la fecha de fin
    ELSEIF NEW.fecha_fin < CURDATE() THEN
        SET NEW.estado = 'vencida';
    END IF;
END//

DELIMITER ;

-- 5. FUNCIONES ÚTILES

DELIMITER //

-- Función: Calcular tiempo de espera estimado
CREATE FUNCTION calcular_tiempo_espera(p_id_barbero INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_minutos_espera INT DEFAULT 0;
    
    SELECT IFNULL(SUM(duracion_estimada), 0) INTO v_minutos_espera
    FROM reservas r
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE bs.id_barbero = p_id_barbero
    AND r.estado IN ('confirmada', 'en_proceso')
    AND DATE(r.fecha_hora) = CURDATE()
    AND r.fecha_hora >= NOW();
    
    RETURN v_minutos_espera;
END//

-- Función: Verificar si cliente es VIP
CREATE FUNCTION es_cliente_vip(p_id_cliente INT)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_puntos INT;
    DECLARE v_visitas INT;
    
    SELECT puntos_fidelidad INTO v_puntos
    FROM clientes
    WHERE id_cliente = p_id_cliente;
    
    SELECT COUNT(*) INTO v_visitas
    FROM reservas
    WHERE id_cliente = p_id_cliente
    AND estado = 'completada';
    
    -- Es VIP si tiene más de 500 puntos o más de 10 visitas
    RETURN (v_puntos >= 500 OR v_visitas >= 10);
END//

DELIMITER ;

-- 6. ÍNDICES ADICIONALES PARA OPTIMIZACIÓN

-- Índices para mejorar JOINs frecuentes
CREATE INDEX idx_barbero_servicios_barbero ON barbero_servicios(id_barbero, activo);
CREATE INDEX idx_barbero_servicios_servicio ON barbero_servicios(id_servicio, activo);
CREATE INDEX idx_reservas_cliente_estado ON reservas(id_cliente, estado);
CREATE INDEX idx_reservas_fecha_estado ON reservas(fecha_hora, estado);
CREATE INDEX idx_calificaciones_puntuacion ON calificaciones(puntuacion_barbero, puntuacion_servicio);
CREATE INDEX idx_promociones_vigencia ON promociones(fecha_inicio, fecha_fin, estado);

-- 7. EVENTOS PROGRAMADOS (JOBS)

-- Activar el programador de eventos
SET GLOBAL event_scheduler = ON;

DELIMITER //

-- Evento: Actualizar automáticamente promociones vencidas (diario)
CREATE EVENT IF NOT EXISTS actualizar_promociones_vencidas
ON SCHEDULE EVERY 1 DAY
STARTS CONCAT(CURDATE(), ' 00:05:00')
DO
BEGIN
    UPDATE promociones
    SET estado = 'vencida'
    WHERE fecha_fin < CURDATE()
    AND estado = 'activa';
    
    UPDATE promociones
    SET estado = 'agotada'
    WHERE max_usos IS NOT NULL 
    AND usos_actuales >= max_usos
    AND estado = 'activa';
END//

-- Evento: Cancelar reservas no confirmadas después de 24 horas
CREATE EVENT IF NOT EXISTS cancelar_reservas_no_confirmadas
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    UPDATE reservas
    SET estado = 'cancelada',
        notas_barbero = CONCAT(IFNULL(notas_barbero, ''), 
            ' [Cancelada automáticamente por falta de confirmación]')
    WHERE estado = 'pendiente'
    AND fecha_creacion < DATE_SUB(NOW(), INTERVAL 24 HOUR);
END//

DELIMITER ;

-- MENSAJE FINAL

-- Confirmar transacción
COMMIT;

SELECT 'Migración 003 completada exitosamente' AS status,
       'Objetos creados: 4 usuarios, 5 vistas, 4 procedimientos, 4 triggers, 2 funciones, 6 índices, 2 eventos' AS resumen;