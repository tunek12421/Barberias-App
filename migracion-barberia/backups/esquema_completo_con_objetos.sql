-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: barberia_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administradores`
--

DROP TABLE IF EXISTS `administradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administradores` (
  `id_administrador` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `dni` varchar(20) NOT NULL,
  `nivel_acceso` enum('limitado','completo','super_admin') NOT NULL DEFAULT 'limitado',
  `permisos_especiales` json DEFAULT NULL,
  `estado` enum('activo','inactivo','suspendido') NOT NULL DEFAULT 'activo',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_administrador`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barberias`
--

DROP TABLE IF EXISTS `barberias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barberias` (
  `id_barberia` int NOT NULL AUTO_INCREMENT,
  `id_administrador` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` text NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `horario_apertura` time NOT NULL,
  `horario_cierre` time NOT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `estado` enum('activo','inactivo','mantenimiento') NOT NULL DEFAULT 'activo',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_barberia`),
  KEY `id_administrador` (`id_administrador`),
  CONSTRAINT `barberias_ibfk_1` FOREIGN KEY (`id_administrador`) REFERENCES `administradores` (`id_administrador`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barbero_servicios`
--

DROP TABLE IF EXISTS `barbero_servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barbero_servicios` (
  `id_asignacion` int NOT NULL AUTO_INCREMENT,
  `id_barbero` int NOT NULL,
  `id_servicio` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_asignacion`),
  UNIQUE KEY `uk_barbero_servicio` (`id_barbero`,`id_servicio`),
  KEY `idx_barbero_servicios_barbero` (`id_barbero`,`activo`),
  KEY `idx_barbero_servicios_servicio` (`id_servicio`,`activo`),
  CONSTRAINT `barbero_servicios_ibfk_1` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`) ON DELETE CASCADE,
  CONSTRAINT `barbero_servicios_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barberos`
--

DROP TABLE IF EXISTS `barberos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barberos` (
  `id_barbero` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `dni` varchar(20) NOT NULL,
  `id_barberia` int NOT NULL,
  `especialidades` json DEFAULT NULL,
  `experiencia_anos` int DEFAULT '0',
  `calificacion_promedio` decimal(3,2) DEFAULT '0.00',
  `estado` enum('activo','inactivo','vacaciones','licencia') NOT NULL DEFAULT 'activo',
  `fecha_ingreso` date NOT NULL DEFAULT (curdate()),
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_barbero`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `dni` (`dni`),
  KEY `idx_barberos_barberia` (`id_barberia`),
  CONSTRAINT `barberos_ibfk_1` FOREIGN KEY (`id_barberia`) REFERENCES `barberias` (`id_barberia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `id_calificacion` int NOT NULL AUTO_INCREMENT,
  `id_reserva` int NOT NULL,
  `puntuacion_servicio` int NOT NULL,
  `puntuacion_barbero` int NOT NULL,
  `comentario` text,
  `fecha_calificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_calificacion`),
  UNIQUE KEY `id_reserva` (`id_reserva`),
  KEY `idx_calificaciones_puntuacion` (`puntuacion_barbero`,`puntuacion_servicio`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`) ON DELETE CASCADE,
  CONSTRAINT `calificaciones_chk_1` CHECK ((`puntuacion_servicio` between 1 and 5)),
  CONSTRAINT `calificaciones_chk_2` CHECK ((`puntuacion_barbero` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_actualizar_calificacion_barbero` AFTER INSERT ON `calificaciones` FOR EACH ROW BEGIN
    DECLARE v_id_barbero INT;
    DECLARE v_promedio DECIMAL(3,2);
    
    
    SELECT bs.id_barbero INTO v_id_barbero
    FROM reservas r
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE r.id_reserva = NEW.id_reserva;
    
    
    SELECT AVG(c.puntuacion_barbero) INTO v_promedio
    FROM calificaciones c
    JOIN reservas r ON c.id_reserva = r.id_reserva
    JOIN barbero_servicios bs ON r.id_barbero_servicio = bs.id_asignacion
    WHERE bs.id_barbero = v_id_barbero;
    
    
    UPDATE barberos 
    SET calificacion_promedio = v_promedio
    WHERE id_barbero = v_id_barbero;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `direccion` text,
  `fecha_nacimiento` date DEFAULT NULL,
  `preferencias` json DEFAULT NULL,
  `puntos_fidelidad` int DEFAULT '0',
  `fecha_primera_visita` date DEFAULT NULL,
  `estado` enum('activo','inactivo','suspendido') NOT NULL DEFAULT 'activo',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `id_promocion` int NOT NULL AUTO_INCREMENT,
  `id_barberia` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `descuento_porcentaje` decimal(5,2) DEFAULT NULL,
  `descuento_monto` decimal(10,2) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `max_usos` int DEFAULT NULL,
  `usos_actuales` int DEFAULT '0',
  `estado` enum('activa','pausada','vencida','agotada') NOT NULL DEFAULT 'activa',
  PRIMARY KEY (`id_promocion`),
  KEY `id_barberia` (`id_barberia`),
  KEY `idx_promociones_fechas` (`fecha_inicio`,`fecha_fin`),
  KEY `idx_promociones_vigencia` (`fecha_inicio`,`fecha_fin`,`estado`),
  CONSTRAINT `promociones_ibfk_1` FOREIGN KEY (`id_barberia`) REFERENCES `barberias` (`id_barberia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_actualizar_estado_promocion` BEFORE UPDATE ON `promociones` FOR EACH ROW BEGIN
    
    IF NEW.max_usos IS NOT NULL AND NEW.usos_actuales >= NEW.max_usos THEN
        SET NEW.estado = 'agotada';
    
    ELSEIF NEW.fecha_fin < CURDATE() THEN
        SET NEW.estado = 'vencida';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_barbero_servicio` int NOT NULL,
  `fecha_hora` timestamp NOT NULL,
  `duracion_estimada` int NOT NULL,
  `precio_acordado` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','confirmada','en_proceso','completada','cancelada','no_asistio') NOT NULL DEFAULT 'pendiente',
  `notas_cliente` text,
  `notas_barbero` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_confirmacion` timestamp NULL DEFAULT NULL,
  `fecha_completada` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `id_barbero_servicio` (`id_barbero_servicio`),
  KEY `idx_reservas_fecha_hora` (`fecha_hora`),
  KEY `idx_reservas_estado` (`estado`),
  KEY `idx_reservas_cliente_estado` (`id_cliente`,`estado`),
  KEY `idx_reservas_fecha_estado` (`fecha_hora`,`estado`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE,
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_barbero_servicio`) REFERENCES `barbero_servicios` (`id_asignacion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_validar_horario_reserva` BEFORE INSERT ON `reservas` FOR EACH ROW BEGIN
    DECLARE v_hora_apertura TIME;
    DECLARE v_hora_cierre TIME;
    DECLARE v_hora_reserva TIME;
    DECLARE v_hora_fin TIME;
    
    
    SELECT bar.horario_apertura, bar.horario_cierre
    INTO v_hora_apertura, v_hora_cierre
    FROM barbero_servicios bs
    JOIN barberos b ON bs.id_barbero = b.id_barbero
    JOIN barberias bar ON b.id_barberia = bar.id_barberia
    WHERE bs.id_asignacion = NEW.id_barbero_servicio;
    
    SET v_hora_reserva = TIME(NEW.fecha_hora);
    SET v_hora_fin = TIME(DATE_ADD(NEW.fecha_hora, INTERVAL NEW.duracion_estimada MINUTE));
    
    
    IF v_hora_reserva < v_hora_apertura OR v_hora_fin > v_hora_cierre THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La reserva está fuera del horario de atención';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_actualizar_puntos_fidelidad` AFTER UPDATE ON `reservas` FOR EACH ROW BEGIN
    DECLARE v_puntos INT;
    
    
    IF NEW.estado = 'completada' AND OLD.estado != 'completada' THEN
        
        SET v_puntos = FLOOR(NEW.precio_acordado / 10);
        
        UPDATE clientes 
        SET puntos_fidelidad = puntos_fidelidad + v_puntos
        WHERE id_cliente = NEW.id_cliente;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id_servicio` int NOT NULL AUTO_INCREMENT,
  `id_barberia` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `duracion_minutos` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `categoria` enum('corte','barba','combo','tratamiento','otros') NOT NULL,
  `estado` enum('activo','inactivo','descontinuado') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_servicio`),
  KEY `idx_servicios_barberia` (`id_barberia`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`id_barberia`) REFERENCES `barberias` (`id_barberia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vista_calificaciones_resumen`
--

DROP TABLE IF EXISTS `vista_calificaciones_resumen`;
/*!50001 DROP VIEW IF EXISTS `vista_calificaciones_resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_calificaciones_resumen` AS SELECT 
 1 AS `id_barberia`,
 1 AS `barberia`,
 1 AS `id_barbero`,
 1 AS `barbero`,
 1 AS `total_calificaciones`,
 1 AS `promedio_barbero`,
 1 AS `promedio_servicio`,
 1 AS `ultima_calificacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_clientes_vip`
--

DROP TABLE IF EXISTS `vista_clientes_vip`;
/*!50001 DROP VIEW IF EXISTS `vista_clientes_vip`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_clientes_vip` AS SELECT 
 1 AS `id_cliente`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `email`,
 1 AS `puntos_fidelidad`,
 1 AS `total_visitas`,
 1 AS `total_gastado`,
 1 AS `ticket_promedio`,
 1 AS `ultima_visita`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_disponibilidad_barberos`
--

DROP TABLE IF EXISTS `vista_disponibilidad_barberos`;
/*!50001 DROP VIEW IF EXISTS `vista_disponibilidad_barberos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_disponibilidad_barberos` AS SELECT 
 1 AS `id_barberia`,
 1 AS `barberia`,
 1 AS `id_barbero`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `estado`,
 1 AS `calificacion_promedio`,
 1 AS `servicios_disponibles`,
 1 AS `reservas_pendientes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_ingresos_barberia`
--

DROP TABLE IF EXISTS `vista_ingresos_barberia`;
/*!50001 DROP VIEW IF EXISTS `vista_ingresos_barberia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_ingresos_barberia` AS SELECT 
 1 AS `id_barberia`,
 1 AS `barberia`,
 1 AS `mes`,
 1 AS `total_reservas`,
 1 AS `clientes_unicos`,
 1 AS `ingresos`,
 1 AS `ticket_promedio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_servicios_populares`
--

DROP TABLE IF EXISTS `vista_servicios_populares`;
/*!50001 DROP VIEW IF EXISTS `vista_servicios_populares`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_servicios_populares` AS SELECT 
 1 AS `id_servicio`,
 1 AS `servicio`,
 1 AS `categoria`,
 1 AS `precio`,
 1 AS `barberia`,
 1 AS `total_reservas`,
 1 AS `calificacion_promedio`,
 1 AS `ingresos_generados`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'barberia_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `actualizar_promociones_vencidas` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `actualizar_promociones_vencidas` ON SCHEDULE EVERY 1 DAY STARTS '2025-09-18 00:05:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE promociones
    SET estado = 'vencida'
    WHERE fecha_fin < CURDATE()
    AND estado = 'activa';
    
    UPDATE promociones
    SET estado = 'agotada'
    WHERE max_usos IS NOT NULL 
    AND usos_actuales >= max_usos
    AND estado = 'activa';
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `cancelar_reservas_no_confirmadas` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `cancelar_reservas_no_confirmadas` ON SCHEDULE EVERY 1 HOUR STARTS '2025-09-18 09:43:52' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE reservas
    SET estado = 'cancelada',
        notas_barbero = CONCAT(IFNULL(notas_barbero, ''), 
            ' [Cancelada automáticamente por falta de confirmación]')
    WHERE estado = 'pendiente'
    AND fecha_creacion < DATE_SUB(NOW(), INTERVAL 24 HOUR);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'barberia_db'
--
/*!50003 DROP FUNCTION IF EXISTS `calcular_tiempo_espera` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_tiempo_espera`(p_id_barbero INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `es_cliente_vip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `es_cliente_vip`(p_id_cliente INT) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
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
    
    
    RETURN (v_puntos >= 500 OR v_visitas >= 10);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AplicarPromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AplicarPromocion`(
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
    
    
    IF v_max_usos IS NOT NULL AND v_usos_actuales >= v_max_usos THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Promoción agotada';
    END IF;
    
    
    SELECT precio_acordado INTO v_precio_original
    FROM reservas
    WHERE id_reserva = p_id_reserva;
    
    
    IF v_descuento_porcentaje IS NOT NULL THEN
        SET v_precio_final = v_precio_original * (1 - v_descuento_porcentaje/100);
    ELSE
        SET v_precio_final = v_precio_original - v_descuento_monto;
    END IF;
    
    
    UPDATE reservas 
    SET precio_acordado = v_precio_final,
        notas_barbero = CONCAT(IFNULL(notas_barbero, ''), 
            ' [Promoción aplicada: ID', p_id_promocion, ']')
    WHERE id_reserva = p_id_reserva;
    
    
    UPDATE promociones
    SET usos_actuales = usos_actuales + 1
    WHERE id_promocion = p_id_promocion;
    
    COMMIT;
    
    SELECT 
        v_precio_original AS precio_original,
        v_precio_final AS precio_con_descuento,
        (v_precio_original - v_precio_final) AS ahorro;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalcularDisponibilidadBarbero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalcularDisponibilidadBarbero`(
    IN p_id_barbero INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE v_hora_apertura TIME;
    DECLARE v_hora_cierre TIME;
    
    
    SELECT bar.horario_apertura, bar.horario_cierre
    INTO v_hora_apertura, v_hora_cierre
    FROM barberos b
    JOIN barberias bar ON b.id_barberia = bar.id_barberia
    WHERE b.id_barbero = p_id_barbero;
    
    
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerarReporteMensualBarberia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarReporteMensualBarberia`(
    IN p_id_barberia INT,
    IN p_mes INT,
    IN p_anio INT
)
BEGIN
    
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarReservaCompleta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarReservaCompleta`(
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
    
    
    START TRANSACTION;
    
    
    SELECT estado INTO v_estado_barbero 
    FROM barberos 
    WHERE id_barbero = p_id_barbero;
    
    IF v_estado_barbero != 'activo' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El barbero no está disponible';
    END IF;
    
    
    SELECT id_asignacion INTO v_id_asignacion
    FROM barbero_servicios
    WHERE id_barbero = p_id_barbero 
    AND id_servicio = p_id_servicio 
    AND activo = TRUE;
    
    IF v_id_asignacion IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El barbero no ofrece este servicio';
    END IF;
    
    
    SELECT duracion_minutos, precio 
    INTO v_duracion, v_precio
    FROM servicios 
    WHERE id_servicio = p_id_servicio;
    
    
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
    
    
    COMMIT;
    
    SELECT 'Reserva registrada exitosamente' AS mensaje, LAST_INSERT_ID() AS id_reserva;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_calificaciones_resumen`
--

/*!50001 DROP VIEW IF EXISTS `vista_calificaciones_resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_calificaciones_resumen` AS select `bar`.`id_barberia` AS `id_barberia`,`bar`.`nombre` AS `barberia`,`b`.`id_barbero` AS `id_barbero`,concat(`b`.`nombre`,' ',`b`.`apellido`) AS `barbero`,count(distinct `cal`.`id_calificacion`) AS `total_calificaciones`,avg(`cal`.`puntuacion_barbero`) AS `promedio_barbero`,avg(`cal`.`puntuacion_servicio`) AS `promedio_servicio`,max(`cal`.`fecha_calificacion`) AS `ultima_calificacion` from ((((`barberias` `bar` join `barberos` `b` on((`bar`.`id_barberia` = `b`.`id_barberia`))) join `barbero_servicios` `bs` on((`b`.`id_barbero` = `bs`.`id_barbero`))) join `reservas` `r` on((`bs`.`id_asignacion` = `r`.`id_barbero_servicio`))) join `calificaciones` `cal` on((`r`.`id_reserva` = `cal`.`id_reserva`))) group by `bar`.`id_barberia`,`b`.`id_barbero` order by `promedio_barbero` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_clientes_vip`
--

/*!50001 DROP VIEW IF EXISTS `vista_clientes_vip`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_clientes_vip` AS select `c`.`id_cliente` AS `id_cliente`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,`c`.`email` AS `email`,`c`.`puntos_fidelidad` AS `puntos_fidelidad`,count(distinct `r`.`id_reserva`) AS `total_visitas`,sum((case when (`r`.`estado` = 'completada') then `r`.`precio_acordado` else 0 end)) AS `total_gastado`,avg((case when (`r`.`estado` = 'completada') then `r`.`precio_acordado` else NULL end)) AS `ticket_promedio`,max(`r`.`fecha_hora`) AS `ultima_visita` from (`clientes` `c` join `reservas` `r` on((`c`.`id_cliente` = `r`.`id_cliente`))) where (`c`.`estado` = 'activo') group by `c`.`id_cliente` having (`total_visitas` >= 3) order by `total_gastado` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_disponibilidad_barberos`
--

/*!50001 DROP VIEW IF EXISTS `vista_disponibilidad_barberos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_disponibilidad_barberos` AS select `b`.`id_barberia` AS `id_barberia`,`bar`.`nombre` AS `barberia`,`b`.`id_barbero` AS `id_barbero`,`b`.`nombre` AS `nombre`,`b`.`apellido` AS `apellido`,`b`.`estado` AS `estado`,`b`.`calificacion_promedio` AS `calificacion_promedio`,count(distinct `bs`.`id_servicio`) AS `servicios_disponibles`,count(distinct `r`.`id_reserva`) AS `reservas_pendientes` from (((`barberos` `b` join `barberias` `bar` on((`b`.`id_barberia` = `bar`.`id_barberia`))) left join `barbero_servicios` `bs` on(((`b`.`id_barbero` = `bs`.`id_barbero`) and (`bs`.`activo` = true)))) left join `reservas` `r` on(((`bs`.`id_asignacion` = `r`.`id_barbero_servicio`) and (`r`.`estado` in ('pendiente','confirmada'))))) where (`b`.`estado` = 'activo') group by `b`.`id_barbero` order by `bar`.`nombre`,`b`.`calificacion_promedio` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ingresos_barberia`
--

/*!50001 DROP VIEW IF EXISTS `vista_ingresos_barberia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ingresos_barberia` AS select `b`.`id_barberia` AS `id_barberia`,`b`.`nombre` AS `barberia`,date_format(`r`.`fecha_hora`,'%Y-%m') AS `mes`,count(distinct `r`.`id_reserva`) AS `total_reservas`,count(distinct `r`.`id_cliente`) AS `clientes_unicos`,sum((case when (`r`.`estado` = 'completada') then `r`.`precio_acordado` else 0 end)) AS `ingresos`,avg((case when (`r`.`estado` = 'completada') then `r`.`precio_acordado` else NULL end)) AS `ticket_promedio` from (((`barberias` `b` join `barberos` `br` on((`b`.`id_barberia` = `br`.`id_barberia`))) join `barbero_servicios` `bs` on((`br`.`id_barbero` = `bs`.`id_barbero`))) join `reservas` `r` on((`bs`.`id_asignacion` = `r`.`id_barbero_servicio`))) where (`r`.`fecha_hora` >= (curdate() - interval 6 month)) group by `b`.`id_barberia`,date_format(`r`.`fecha_hora`,'%Y-%m') order by `b`.`nombre`,`mes` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_servicios_populares`
--

/*!50001 DROP VIEW IF EXISTS `vista_servicios_populares`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_servicios_populares` AS select `s`.`id_servicio` AS `id_servicio`,`s`.`nombre` AS `servicio`,`s`.`categoria` AS `categoria`,`s`.`precio` AS `precio`,`bar`.`nombre` AS `barberia`,count(distinct `r`.`id_reserva`) AS `total_reservas`,avg(`c`.`puntuacion_servicio`) AS `calificacion_promedio`,sum((case when (`r`.`estado` = 'completada') then `r`.`precio_acordado` else 0 end)) AS `ingresos_generados` from ((((`servicios` `s` join `barberias` `bar` on((`s`.`id_barberia` = `bar`.`id_barberia`))) join `barbero_servicios` `bs` on((`s`.`id_servicio` = `bs`.`id_servicio`))) left join `reservas` `r` on((`bs`.`id_asignacion` = `r`.`id_barbero_servicio`))) left join `calificaciones` `c` on((`r`.`id_reserva` = `c`.`id_reserva`))) where (`s`.`estado` = 'activo') group by `s`.`id_servicio` order by `total_reservas` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-25 22:14:53
