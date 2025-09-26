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
-- Current Database: `barberia_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `barberia_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `barberia_db`;

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
-- Dumping data for table `administradores`
--

LOCK TABLES `administradores` WRITE;
/*!40000 ALTER TABLE `administradores` DISABLE KEYS */;
INSERT INTO `administradores` (`id_administrador`, `email`, `password_hash`, `nombre`, `apellido`, `telefono`, `dni`, `nivel_acceso`, `permisos_especiales`, `estado`, `fecha_registro`, `ultimo_acceso`) VALUES (1,'admin1@barberia.com','$2y$10$hash1','Carlos','RodrÃ­guez','70001001','12345001','super_admin',NULL,'activo','2025-09-18 08:32:26',NULL),(2,'admin2@barberia.com','$2y$10$hash2','MarÃ­a','GonzÃ¡lez','70001002','12345002','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(3,'admin3@barberia.com','$2y$10$hash3','Juan','LÃ³pez','70001003','12345003','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(4,'admin4@barberia.com','$2y$10$hash4','Ana','MartÃ­nez','70001004','12345004','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(5,'admin5@barberia.com','$2y$10$hash5','Pedro','SÃ¡nchez','70001005','12345005','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(6,'admin6@barberia.com','$2y$10$hash6','Laura','FernÃ¡ndez','70001006','12345006','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(7,'admin7@barberia.com','$2y$10$hash7','Miguel','Torres','70001007','12345007','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(8,'admin8@barberia.com','$2y$10$hash8','Carmen','Ruiz','70001008','12345008','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(9,'admin9@barberia.com','$2y$10$hash9','JosÃ©','Morales','70001009','12345009','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(10,'admin10@barberia.com','$2y$10$hash10','Elena','JimÃ©nez','70001010','12345010','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(11,'admin11@barberia.com','$2y$10$hash11','Roberto','Vargas','70001011','12345011','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(12,'admin12@barberia.com','$2y$10$hash12','Patricia','Herrera','70001012','12345012','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(13,'admin13@barberia.com','$2y$10$hash13','Fernando','Castro','70001013','12345013','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(14,'admin14@barberia.com','$2y$10$hash14','Silvia','Mendoza','70001014','12345014','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(15,'admin15@barberia.com','$2y$10$hash15','Ricardo','Paredes','70001015','12345015','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(16,'admin16@barberia.com','$2y$10$hash16','MÃ³nica','GutiÃ©rrez','70001016','12345016','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(17,'admin17@barberia.com','$2y$10$hash17','AndrÃ©s','RamÃ­rez','70001017','12345017','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(18,'admin18@barberia.com','$2y$10$hash18','Gabriela','Flores','70001018','12345018','completo',NULL,'activo','2025-09-18 08:32:26',NULL),(19,'admin19@barberia.com','$2y$10$hash19','Diego','Salazar','70001019','12345019','limitado',NULL,'activo','2025-09-18 08:32:26',NULL),(20,'admin20@barberia.com','$2y$10$hash20','Valeria','Ortega','70001020','12345020','completo',NULL,'activo','2025-09-18 08:32:26',NULL);
/*!40000 ALTER TABLE `administradores` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `barberias`
--

LOCK TABLES `barberias` WRITE;
/*!40000 ALTER TABLE `barberias` DISABLE KEYS */;
INSERT INTO `barberias` (`id_barberia`, `id_administrador`, `nombre`, `direccion`, `telefono`, `email`, `horario_apertura`, `horario_cierre`, `latitud`, `longitud`, `estado`, `fecha_registro`) VALUES (1,1,'BarberÃ­a Central','Av. HeroÃ­nas 123, Cochabamba','4-4123001','central@barberia.com','08:00:00','19:00:00',-17.38950000,-66.15680000,'activo','2025-09-18 08:32:26'),(2,2,'BarberÃ­a Norte','Av. AmÃ©rica 456, Cochabamba','4-4123002','norte@barberia.com','08:30:00','18:30:00',-17.37120000,-66.16250000,'activo','2025-09-18 08:32:26'),(3,3,'BarberÃ­a Sur','Av. Blanco Galindo 789, Cochabamba','4-4123003','sur@barberia.com','09:00:00','20:00:00',-17.41230000,-66.14560000,'activo','2025-09-18 08:32:26'),(4,4,'BarberÃ­a Este','Av. CircunvalaciÃ³n 321, Cochabamba','4-4123004','este@barberia.com','08:00:00','18:00:00',-17.38560000,-66.12340000,'activo','2025-09-18 08:32:26'),(5,5,'BarberÃ­a Oeste','Av. Petrolera 654, Cochabamba','4-4123005','oeste@barberia.com','09:00:00','19:00:00',-17.39450000,-66.17890000,'activo','2025-09-18 08:32:26'),(6,6,'BarberÃ­a Plaza','Plaza ColÃ³n 987, Cochabamba','4-4123006','plaza@barberia.com','08:30:00','18:30:00',-17.38890000,-66.15780000,'activo','2025-09-18 08:32:26'),(7,7,'BarberÃ­a Moderna','Av. Ayacucho 147, Cochabamba','4-4123007','moderna@barberia.com','08:00:00','19:30:00',-17.39120000,-66.15340000,'activo','2025-09-18 08:32:26'),(8,8,'BarberÃ­a ClÃ¡sica','Calle EspaÃ±a 258, Cochabamba','4-4123008','clasica@barberia.com','09:00:00','18:00:00',-17.38760000,-66.16120000,'activo','2025-09-18 08:32:26'),(9,9,'BarberÃ­a Premium','Av. Oquendo 369, Cochabamba','4-4123009','premium@barberia.com','08:00:00','20:00:00',-17.38340000,-66.14450000,'activo','2025-09-18 08:32:26'),(10,10,'BarberÃ­a Express','Av. Aroma 741, Cochabamba','4-4123010','express@barberia.com','07:30:00','19:00:00',-17.39670000,-66.16230000,'activo','2025-09-18 08:32:26'),(11,11,'BarberÃ­a Elegante','Calle BolÃ­var 852, Cochabamba','4-4123011','elegante@barberia.com','08:30:00','18:30:00',-17.38230000,-66.15670000,'activo','2025-09-18 08:32:26'),(12,12,'BarberÃ­a Tradicional','Av. San MartÃ­n 963, Cochabamba','4-4123012','tradicional@barberia.com','09:00:00','19:00:00',-17.39450000,-66.14890000,'activo','2025-09-18 08:32:26'),(13,13,'BarberÃ­a Juvenil','Calle Sucre 159, Cochabamba','4-4123013','juvenil@barberia.com','08:00:00','18:00:00',-17.38910000,-66.16340000,'activo','2025-09-18 08:32:26'),(14,14,'BarberÃ­a VIP','Av. BalliviÃ¡n 357, Cochabamba','4-4123014','vip@barberia.com','08:30:00','20:00:00',-17.37780000,-66.15120000,'activo','2025-09-18 08:32:26'),(15,15,'BarberÃ­a RÃ¡pida','Calle JordÃ¡n 468, Cochabamba','4-4123015','rapida@barberia.com','07:00:00','19:00:00',-17.39120000,-66.16780000,'activo','2025-09-18 08:32:26'),(16,16,'BarberÃ­a Stylish','Av. Pando 579, Cochabamba','4-4123016','stylish@barberia.com','08:00:00','18:30:00',-17.38450000,-66.15340000,'activo','2025-09-18 08:32:26'),(17,17,'BarberÃ­a Popular','Calle Antezana 681, Cochabamba','4-4123017','popular@barberia.com','08:30:00','19:30:00',-17.39230000,-66.16010000,'activo','2025-09-18 08:32:26'),(18,18,'BarberÃ­a Profesional','Av. 6 de Agosto 792, Cochabamba','4-4123018','profesional@barberia.com','09:00:00','18:00:00',-17.38670000,-66.14560000,'activo','2025-09-18 08:32:26'),(19,19,'BarberÃ­a EconÃ³mica','Calle Nataniel Aguirre 813, Cochabamba','4-4123019','economica@barberia.com','08:00:00','19:00:00',-17.39340000,-66.16230000,'activo','2025-09-18 08:32:26'),(20,20,'BarberÃ­a Familiar','Av. Beijing 924, Cochabamba','4-4123020','familiar@barberia.com','08:30:00','18:30:00',-17.37890000,-66.15670000,'activo','2025-09-18 08:32:26');
/*!40000 ALTER TABLE `barberias` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `barbero_servicios`
--

LOCK TABLES `barbero_servicios` WRITE;
/*!40000 ALTER TABLE `barbero_servicios` DISABLE KEYS */;
INSERT INTO `barbero_servicios` (`id_asignacion`, `id_barbero`, `id_servicio`, `activo`) VALUES (1,1,1,1),(2,1,2,1),(3,1,3,1),(4,2,1,1),(5,2,5,1),(6,3,4,1),(7,3,7,1),(8,4,4,1),(9,4,1,1),(10,5,6,1),(11,5,7,1),(12,6,5,1),(13,6,10,1),(14,7,8,1),(15,7,9,1),(16,7,1,1),(17,8,8,1),(18,8,4,1),(19,9,10,1),(20,9,11,1),(21,10,10,1),(22,10,1,1),(23,11,12,1),(24,11,13,1),(25,12,11,1),(26,12,17,1),(27,13,14,1),(28,13,15,1),(29,13,12,1),(30,14,14,1),(31,14,13,1),(32,15,17,1),(33,15,15,1),(34,16,16,1),(35,16,14,1),(36,17,19,1),(37,17,18,1),(38,18,19,1),(39,18,15,1),(40,19,20,1),(41,19,18,1),(42,19,1,1),(43,20,20,1),(44,20,4,1);
/*!40000 ALTER TABLE `barbero_servicios` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `barberos`
--

LOCK TABLES `barberos` WRITE;
/*!40000 ALTER TABLE `barberos` DISABLE KEYS */;
INSERT INTO `barberos` (`id_barbero`, `email`, `password_hash`, `nombre`, `apellido`, `telefono`, `dni`, `id_barberia`, `especialidades`, `experiencia_anos`, `calificacion_promedio`, `estado`, `fecha_ingreso`, `fecha_registro`, `ultimo_acceso`) VALUES (1,'juan.perez@barberia.com','$2y$10$hashB1','Juan','PÃ©rez','70101001','87654001',1,'[\"corte_clÃ¡sico\", \"barba\"]',5,4.50,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(2,'carlos.lopez@barberia.com','$2y$10$hashB2','Carlos','LÃ³pez','70101002','87654002',1,'[\"corte_moderno\", \"tratamiento\"]',3,4.20,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(3,'miguel.gonzalez@barberia.com','$2y$10$hashB3','Miguel','GonzÃ¡lez','70101003','87654003',2,'[\"barba\", \"combo\"]',7,4.70,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(4,'pedro.martinez@barberia.com','$2y$10$hashB4','Pedro','MartÃ­nez','70101004','87654004',2,'[\"corte_clÃ¡sico\"]',4,4.30,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(5,'luis.rodriguez@barberia.com','$2y$10$hashB5','Luis','RodrÃ­guez','70101005','87654005',3,'[\"corte_moderno\", \"barba\"]',6,4.60,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(6,'daniel.sanchez@barberia.com','$2y$10$hashB6','Daniel','SÃ¡nchez','70101006','87654006',3,'[\"tratamiento\", \"combo\"]',2,4.10,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(7,'andres.torres@barberia.com','$2y$10$hashB7','AndrÃ©s','Torres','70101007','87654007',4,'[\"corte_clÃ¡sico\", \"barba\"]',8,4.80,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(8,'ricardo.morales@barberia.com','$2y$10$hashB8','Ricardo','Morales','70101008','87654008',4,'[\"corte_moderno\"]',3,4.20,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(9,'fernando.jimenez@barberia.com','$2y$10$hashB9','Fernando','JimÃ©nez','70101009','87654009',5,'[\"barba\", \"tratamiento\"]',5,4.40,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(10,'roberto.vargas@barberia.com','$2y$10$hashB10','Roberto','Vargas','70101010','87654010',5,'[\"combo\", \"corte_clÃ¡sico\"]',4,4.30,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(11,'mario.herrera@barberia.com','$2y$10$hashB11','Mario','Herrera','70101011','87654011',6,'[\"corte_moderno\", \"barba\"]',6,4.50,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(12,'javier.castro@barberia.com','$2y$10$hashB12','Javier','Castro','70101012','87654012',6,'[\"tratamiento\"]',3,4.00,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(13,'alejandro.mendoza@barberia.com','$2y$10$hashB13','Alejandro','Mendoza','70101013','87654013',7,'[\"corte_clÃ¡sico\", \"combo\"]',7,4.60,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(14,'sergio.paredes@barberia.com','$2y$10$hashB14','Sergio','Paredes','70101014','87654014',7,'[\"barba\", \"corte_moderno\"]',4,4.20,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(15,'raul.gutierrez@barberia.com','$2y$10$hashB15','RaÃºl','GutiÃ©rrez','70101015','87654015',8,'[\"combo\", \"tratamiento\"]',5,4.40,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(16,'antonio.ramirez@barberia.com','$2y$10$hashB16','Antonio','RamÃ­rez','70101016','87654016',8,'[\"corte_clÃ¡sico\"]',3,4.10,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(17,'manuel.flores@barberia.com','$2y$10$hashB17','Manuel','Flores','70101017','87654017',9,'[\"barba\", \"corte_moderno\"]',6,4.50,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(18,'oscar.salazar@barberia.com','$2y$10$hashB18','Oscar','Salazar','70101018','87654018',9,'[\"tratamiento\", \"combo\"]',4,4.30,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(19,'eduardo.ortega@barberia.com','$2y$10$hashB19','Eduardo','Ortega','70101019','87654019',10,'[\"corte_clÃ¡sico\", \"barba\"]',8,4.70,'activo','2025-09-18','2025-09-18 08:32:26',NULL),(20,'victor.silva@barberia.com','$2y$10$hashB20','VÃ­ctor','Silva','70101020','87654020',10,'[\"corte_moderno\", \"combo\"]',5,4.40,'activo','2025-09-18','2025-09-18 08:32:26',NULL);
/*!40000 ALTER TABLE `barberos` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` (`id_calificacion`, `id_reserva`, `puntuacion_servicio`, `puntuacion_barbero`, `comentario`, `fecha_calificacion`) VALUES (1,1,5,5,'Excelente servicio, muy profesional','2024-01-15 12:00:00'),(2,2,4,4,'Buen trabajo, recomendado','2024-01-15 13:30:00'),(3,3,5,5,'Perfecto, exactamente lo que querÃ­a','2024-01-16 17:00:00'),(4,4,4,4,'Muy conforme con el resultado','2024-01-16 19:00:00'),(5,5,5,5,'Servicio excepcional, volverÃ©','2024-01-17 14:00:00'),(6,6,3,4,'Bien pero puede mejorar','2024-01-17 18:00:00'),(7,7,5,5,'IncreÃ­ble trabajo, muy detallado','2024-01-18 12:30:00'),(8,8,5,5,'Arte puro, quedÃ© impresionado','2024-01-18 16:00:00'),(9,9,4,4,'RÃ¡pido y eficiente como prometido','2024-01-19 13:00:00'),(10,10,5,5,'Estilo vintage perfecto','2024-01-19 19:00:00'),(11,11,4,5,'Mi hijo quedÃ³ feliz con su corte','2024-01-20 11:30:00'),(12,12,5,5,'Servicio VIP excepcional','2024-01-20 17:30:00'),(13,13,5,5,'Segundo servicio igual de bueno','2024-01-22 12:00:00'),(14,14,4,4,'Combo completo satisfactorio','2024-01-22 14:30:00'),(15,15,5,4,'Tratamiento muy relajante','2024-01-23 18:00:00'),(16,16,4,4,'Masaje excelente para el estrÃ©s','2024-01-23 20:00:00'),(17,17,5,5,'Barba perfecta, muy profesional','2024-01-24 13:30:00'),(18,18,5,5,'Vale cada peso del premium','2024-01-24 17:00:00'),(19,19,4,4,'Tratamiento efectivo','2024-01-25 12:30:00'),(20,20,5,5,'DiseÃ±o creativo impresionante','2024-01-25 19:30:00'),(21,21,4,5,'Barbero muy amable y hÃ¡bil','2024-01-26 14:00:00'),(22,22,5,4,'Corte moderno exacto','2024-01-26 18:30:00'),(23,23,4,4,'PreparaciÃ³n perfecta para reuniÃ³n','2024-01-27 11:00:00'),(24,24,5,5,'Siempre superan expectativas','2024-01-27 16:30:00'),(25,25,5,5,'Experiencia VIP inolvidable','2024-01-28 13:00:00');
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id_cliente`, `email`, `password_hash`, `nombre`, `apellido`, `telefono`, `dni`, `direccion`, `fecha_nacimiento`, `preferencias`, `puntos_fidelidad`, `fecha_primera_visita`, `estado`, `fecha_registro`, `ultimo_acceso`) VALUES (1,'maria.gonzalez@email.com','$2y$10$hashC1','MarÃ­a','GonzÃ¡lez','70201001','11223001','Av. HeroÃ­nas 234','1990-03-15',NULL,150,NULL,'activo','2025-09-18 08:32:26',NULL),(2,'jose.martinez@email.com','$2y$10$hashC2','JosÃ©','MartÃ­nez','70201002','11223002','Calle EspaÃ±a 567','1985-07-22',NULL,280,NULL,'activo','2025-09-18 08:32:26',NULL),(3,'ana.lopez@email.com','$2y$10$hashC3','Ana','LÃ³pez','70201003','11223003','Av. AmÃ©rica 890','1992-11-08',NULL,95,NULL,'activo','2025-09-18 08:32:26',NULL),(4,'carlos.rodriguez@email.com','$2y$10$hashC4','Carlos','RodrÃ­guez','70201004','11223004','Av. Ayacucho 123','1988-05-12',NULL,320,NULL,'activo','2025-09-18 08:32:26',NULL),(5,'laura.sanchez@email.com','$2y$10$hashC5','Laura','SÃ¡nchez','70201005','11223005','Calle BolÃ­var 456','1995-09-30',NULL,75,NULL,'activo','2025-09-18 08:32:26',NULL),(6,'miguel.torres@email.com','$2y$10$hashC6','Miguel','Torres','70201006','11223006','Av. Oquendo 789','1987-01-18',NULL,210,NULL,'activo','2025-09-18 08:32:26',NULL),(7,'elena.morales@email.com','$2y$10$hashC7','Elena','Morales','70201007','11223007','Calle Sucre 321','1993-04-25',NULL,140,NULL,'activo','2025-09-18 08:32:26',NULL),(8,'pedro.jimenez@email.com','$2y$10$hashC8','Pedro','JimÃ©nez','70201008','11223008','Av. San MartÃ­n 654','1986-12-03',NULL,390,NULL,'activo','2025-09-18 08:32:26',NULL),(9,'sofia.vargas@email.com','$2y$10$hashC9','SofÃ­a','Vargas','70201009','11223009','Calle JordÃ¡n 987','1991-08-14',NULL,110,NULL,'activo','2025-09-18 08:32:26',NULL),(10,'fernando.herrera@email.com','$2y$10$hashC10','Fernando','Herrera','70201010','11223010','Av. Pando 147','1989-06-07',NULL,260,NULL,'activo','2025-09-18 08:32:26',NULL),(11,'patricia.castro@email.com','$2y$10$hashC11','Patricia','Castro','70201011','11223011','Calle Antezana 258','1994-02-19',NULL,85,NULL,'activo','2025-09-18 08:32:26',NULL),(12,'ricardo.mendoza@email.com','$2y$10$hashC12','Ricardo','Mendoza','70201012','11223012','Av. 6 de Agosto 369','1983-10-11',NULL,450,NULL,'activo','2025-09-18 08:32:26',NULL),(13,'monica.paredes@email.com','$2y$10$hashC13','MÃ³nica','Paredes','70201013','11223013','Calle Nataniel Aguirre 741','1996-07-28',NULL,65,NULL,'activo','2025-09-18 08:32:26',NULL),(14,'andres.gutierrez@email.com','$2y$10$hashC14','AndrÃ©s','GutiÃ©rrez','70201014','11223014','Av. Beijing 852','1984-03-16',NULL,340,NULL,'activo','2025-09-18 08:32:26',NULL),(15,'gabriela.ramirez@email.com','$2y$10$hashC15','Gabriela','RamÃ­rez','70201015','11223015','Av. Blanco Galindo 963','1997-11-22',NULL,55,NULL,'activo','2025-09-18 08:32:26',NULL),(16,'diego.flores@email.com','$2y$10$hashC16','Diego','Flores','70201016','11223016','Av. CircunvalaciÃ³n 159','1982-08-05',NULL,520,NULL,'activo','2025-09-18 08:32:26',NULL),(17,'valeria.salazar@email.com','$2y$10$hashC17','Valeria','Salazar','70201017','11223017','Av. Petrolera 357','1998-04-13',NULL,45,NULL,'activo','2025-09-18 08:32:26',NULL),(18,'roberto.ortega@email.com','$2y$10$hashC18','Roberto','Ortega','70201018','11223018','Plaza ColÃ³n 468','1981-12-24',NULL,680,NULL,'activo','2025-09-18 08:32:26',NULL),(19,'carmen.silva@email.com','$2y$10$hashC19','Carmen','Silva','70201019','11223019','Av. Aroma 579','1999-01-09',NULL,35,NULL,'activo','2025-09-18 08:32:26',NULL),(20,'javier.ruiz@email.com','$2y$10$hashC20','Javier','Ruiz','70201020','11223020','Calle Esteban Arze 681','1980-09-17',NULL,750,NULL,'activo','2025-09-18 08:32:26',NULL),(21,'isabela.vera@email.com','$2y$10$hashC21','Isabela','Vera','70201021','11223021','Av. Libertador 792','1993-05-31',NULL,125,NULL,'activo','2025-09-18 08:32:26',NULL),(22,'manuel.cruz@email.com','$2y$10$hashC22','Manuel','Cruz','70201022','11223022','Calle Hamiraya 813','1987-02-14',NULL,295,NULL,'activo','2025-09-18 08:32:26',NULL),(23,'natalia.pena@email.com','$2y$10$hashC23','Natalia','PeÃ±a','70201023','11223023','Av. Tadeo Haenke 924','1995-10-26',NULL,180,NULL,'activo','2025-09-18 08:32:26',NULL),(24,'antonio.vega@email.com','$2y$10$hashC24','Antonio','Vega','70201024','11223024','Calle Calama 135','1988-07-08',NULL,415,NULL,'activo','2025-09-18 08:32:26',NULL),(25,'beatriz.leon@email.com','$2y$10$hashC25','Beatriz','LeÃ³n','70201025','11223025','Av. Melchor PÃ©rez 246','1992-03-20',NULL,90,NULL,'activo','2025-09-18 08:32:26',NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` (`id_promocion`, `id_barberia`, `nombre`, `descripcion`, `descuento_porcentaje`, `descuento_monto`, `fecha_inicio`, `fecha_fin`, `max_usos`, `usos_actuales`, `estado`) VALUES (1,1,'Descuento Enero','PromociÃ³n de inicio de aÃ±o',15.00,NULL,'2024-01-01','2024-01-31',100,25,'vencida'),(2,2,'Combo Especial','Descuento en combos completos',20.00,NULL,'2024-01-15','2024-02-15',50,12,'vencida'),(3,3,'Cliente Nuevo','Descuento para primeros clientes',25.00,NULL,'2024-01-01','2024-12-31',200,45,'vencida'),(4,4,'Lunes Ejecutivo','Descuento los lunes para ejecutivos',10.00,NULL,'2024-01-01','2024-03-31',80,18,'vencida'),(5,5,'Fin de Semana','PromociÃ³n de fin de semana',12.00,NULL,'2024-01-01','2024-02-29',60,22,'vencida'),(6,6,'Estudiante','Descuento para estudiantes',30.00,NULL,'2024-01-01','2024-06-30',150,38,'vencida'),(7,7,'CumpleaÃ±ero','Descuento del mes de cumpleaÃ±os',50.00,NULL,'2024-01-01','2024-12-31',300,75,'vencida'),(8,8,'Familia','Descuento familiar 3x2',33.00,NULL,'2024-01-01','2024-04-30',40,8,'vencida'),(9,9,'VIP Premium','Descuento para servicios premium',15.00,NULL,'2024-01-01','2024-05-31',30,15,'vencida'),(10,10,'Tercera Edad','Descuento para adultos mayores',40.00,NULL,'2024-01-01','2024-12-31',100,28,'vencida'),(11,11,'Referido','Descuento por traer amigos',20.00,NULL,'2024-01-01','2024-06-30',75,19,'vencida'),(12,12,'Madrugador','Descuento antes de las 10am',8.00,NULL,'2024-01-01','2024-03-31',90,31,'vencida'),(13,13,'San ValentÃ­n','PromociÃ³n especial parejas',25.00,NULL,'2024-02-10','2024-02-18',20,5,'vencida'),(14,14,'Express','Descuento en cortes express',10.00,NULL,'2024-01-01','2024-04-30',120,42,'vencida'),(15,15,'Fidelidad','Descuento por puntos acumulados',18.00,NULL,'2024-01-01','2024-12-31',200,67,'vencida'),(16,16,'MiÃ©rcoles Loco','Descuento especial miÃ©rcoles',22.00,NULL,'2024-01-01','2024-02-29',35,11,'vencida'),(17,17,'Barbero Nuevo','Descuento con barberos junior',15.00,NULL,'2024-01-01','2024-05-31',60,14,'vencida'),(18,18,'Hora Feliz','Descuento de 4-6pm',12.00,NULL,'2024-01-01','2024-03-31',85,29,'vencida'),(19,19,'Corporativo','Descuento para empresas',35.00,NULL,'2024-01-01','2024-12-31',25,6,'vencida'),(20,20,'Fin de AÃ±o','PromociÃ³n especial diciembre',30.00,NULL,'2024-12-01','2024-12-31',50,0,'vencida');
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;
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

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` (`id_reserva`, `id_cliente`, `id_barbero_servicio`, `fecha_hora`, `duracion_estimada`, `precio_acordado`, `estado`, `notas_cliente`, `notas_barbero`, `fecha_creacion`, `fecha_confirmacion`, `fecha_completada`) VALUES (1,1,1,'2024-01-15 09:00:00',30,25.00,'completada','Corte para evento especial',NULL,'2025-09-18 08:32:26',NULL,NULL),(2,2,2,'2024-01-15 10:30:00',20,15.00,'completada','Arreglo de barba semanal',NULL,'2025-09-18 08:32:26',NULL,NULL),(3,3,4,'2024-01-16 14:00:00',35,30.00,'completada','Primer corte en la barberÃ­a',NULL,'2025-09-18 08:32:26',NULL,NULL),(4,4,5,'2024-01-16 16:30:00',25,20.00,'completada','Corte juvenil moderno',NULL,'2025-09-18 08:32:26',NULL,NULL),(5,5,7,'2024-01-17 11:00:00',45,40.00,'completada','Combo ejecutivo',NULL,'2025-09-18 08:32:26',NULL,NULL),(6,6,8,'2024-01-17 15:00:00',30,28.00,'completada','Corte para trabajo',NULL,'2025-09-18 08:32:26',NULL,NULL),(7,7,10,'2024-01-18 09:30:00',40,32.00,'completada','Fade profesional',NULL,'2025-09-18 08:32:26',NULL,NULL),(8,8,12,'2024-01-18 13:00:00',50,45.00,'completada','Corte artÃ­stico Ãºnico',NULL,'2025-09-18 08:32:26',NULL,NULL),(9,9,14,'2024-01-19 10:00:00',20,18.00,'completada','Corte express',NULL,'2025-09-18 08:32:26',NULL,NULL),(10,10,16,'2024-01-19 16:00:00',35,30.00,'completada','Estilo vintage',NULL,'2025-09-18 08:32:26',NULL,NULL),(11,11,18,'2024-01-20 08:30:00',25,15.00,'completada','Corte para niÃ±o',NULL,'2025-09-18 08:32:26',NULL,NULL),(12,12,20,'2024-01-20 14:30:00',45,55.00,'completada','Servicio VIP',NULL,'2025-09-18 08:32:26',NULL,NULL),(13,13,1,'2024-01-22 09:00:00',30,25.00,'confirmada','Mantenimiento mensual',NULL,'2025-09-18 08:32:26',NULL,NULL),(14,14,3,'2024-01-22 11:30:00',50,35.00,'confirmada','Combo completo',NULL,'2025-09-18 08:32:26',NULL,NULL),(15,15,6,'2024-01-23 15:00:00',45,40.00,'confirmada','Tratamiento especial',NULL,'2025-09-18 08:32:26',NULL,NULL),(16,16,9,'2024-01-23 17:00:00',20,18.00,'confirmada','Masaje relajante',NULL,'2025-09-18 08:32:26',NULL,NULL),(17,17,11,'2024-01-24 10:30:00',35,22.00,'confirmada','Arreglo completo barba',NULL,'2025-09-18 08:32:26',NULL,NULL),(18,18,13,'2024-01-24 14:00:00',60,50.00,'confirmada','Combo premium',NULL,'2025-09-18 08:32:26',NULL,NULL),(19,19,15,'2024-01-25 09:30:00',30,35.00,'confirmada','Tratamiento anti-caspa',NULL,'2025-09-18 08:32:26',NULL,NULL),(20,20,17,'2024-01-25 16:30:00',25,20.00,'cancelada','DiseÃ±o barba creativo',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(21,21,2,'2024-01-26 11:00:00',20,15.00,'cancelada','Mantenimiento barba',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(22,22,4,'2024-01-26 15:30:00',35,30.00,'cancelada','Corte moderno actualizado',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(23,23,8,'2024-01-27 08:00:00',30,28.00,'cancelada','PreparaciÃ³n reuniÃ³n',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(24,24,12,'2024-01-27 13:30:00',50,45.00,'cancelada','Nuevo diseÃ±o artÃ­stico',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(25,25,19,'2024-01-28 10:00:00',45,55.00,'cancelada','Experiencia VIP completa',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(26,1,5,'2024-01-29 14:00:00',25,20.00,'cancelada','Cambio de look',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(27,3,7,'2024-01-29 16:00:00',45,40.00,'cancelada','Segundo combo del mes',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(28,5,10,'2024-01-30 09:00:00',40,32.00,'cancelada','Fade actualizado',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(29,7,14,'2024-01-30 11:30:00',20,18.00,'cancelada','Corte rÃ¡pido trabajo',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL),(30,9,18,'2024-01-31 15:00:00',25,15.00,'cancelada','Corte hijo mayor',' [Cancelada automÃ¡ticamente por falta de confirmaciÃ³n]','2025-09-18 08:32:26',NULL,NULL);
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` (`id_servicio`, `id_barberia`, `nombre`, `descripcion`, `duracion_minutos`, `precio`, `categoria`, `estado`) VALUES (1,1,'Corte ClÃ¡sico','Corte de cabello tradicional con tijera y mÃ¡quina',30,25.00,'corte','activo'),(2,1,'Arreglo de Barba','Recorte y diseÃ±o de barba profesional',20,15.00,'barba','activo'),(3,1,'Combo Completo','Corte + Barba + Lavado',50,35.00,'combo','activo'),(4,2,'Corte Moderno','Corte contemporÃ¡neo con diseÃ±os',35,30.00,'corte','activo'),(5,2,'Tratamiento Capilar','HidrataciÃ³n y nutriciÃ³n del cabello',45,40.00,'tratamiento','activo'),(6,3,'Corte Juvenil','Corte para jÃ³venes con estilo urbano',25,20.00,'corte','activo'),(7,3,'Barba Premium','Arreglo de barba con aceites especiales',30,25.00,'barba','activo'),(8,4,'Corte Ejecutivo','Corte profesional para oficina',30,28.00,'corte','activo'),(9,4,'Combo Ejecutivo','Corte + Barba para profesionales',45,40.00,'combo','activo'),(10,5,'Corte Fade','Corte degradado profesional',40,32.00,'corte','activo'),(11,5,'Masaje Capilar','Masaje relajante del cuero cabelludo',20,18.00,'tratamiento','activo'),(12,6,'Corte ArtÃ­stico','Corte con diseÃ±os personalizados',50,45.00,'corte','activo'),(13,6,'Barba Completa','Arreglo integral de barba y bigote',35,22.00,'barba','activo'),(14,7,'Corte Express','Corte rÃ¡pido y eficiente',20,18.00,'corte','activo'),(15,7,'Combo Premium','Servicio completo de lujo',60,50.00,'combo','activo'),(16,8,'Corte Vintage','Corte estilo retro y clÃ¡sico',35,30.00,'corte','activo'),(17,8,'Tratamiento Anti-caspa','Tratamiento especializado',30,35.00,'tratamiento','activo'),(18,9,'Corte Infantil','Corte especial para niÃ±os',25,15.00,'corte','activo'),(19,9,'Barba DiseÃ±o','DiseÃ±o creativo de barba',25,20.00,'barba','activo'),(20,10,'Corte VIP','Servicio exclusivo personalizado',45,55.00,'corte','activo');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Current Database: `barberia_db`
--

USE `barberia_db`;

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

-- Dump completed on 2025-09-25 21:23:33
