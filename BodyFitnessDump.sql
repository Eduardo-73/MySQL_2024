CREATE DATABASE  IF NOT EXISTS `bodyfitness` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bodyfitness`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 192.168.1.170    Database: bodyfitness
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Clientes`
--

DROP TABLE IF EXISTS `Clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clientes` (
  `codcli` int NOT NULL,
  `nomcli` varchar(60) DEFAULT NULL,
  `ape1cli` varchar(60) DEFAULT NULL,
  `ape2cli` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codcli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clientes`
--

LOCK TABLES `Clientes` WRITE;
/*!40000 ALTER TABLE `Clientes` DISABLE KEYS */;
INSERT INTO `Clientes` VALUES (1,'Tomás','González','Atienza'),(2,'Aiman','Harrar','Daoud');
/*!40000 ALTER TABLE `Clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detalles_Reservas`
--

DROP TABLE IF EXISTS `Detalles_Reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Detalles_Reservas` (
  `coddetreserva` int NOT NULL,
  `fecreservacli` date NOT NULL,
  `codreserva` int NOT NULL,
  `codhora` int NOT NULL,
  `codcli` int NOT NULL,
  PRIMARY KEY (`coddetreserva`,`fecreservacli`,`codreserva`,`codhora`,`codcli`),
  KEY `fk_det_reserva_hora` (`codreserva`,`codhora`),
  KEY `fk_det_cli` (`codcli`),
  CONSTRAINT `fk_det_cli` FOREIGN KEY (`codcli`) REFERENCES `Clientes` (`codcli`) ON UPDATE CASCADE,
  CONSTRAINT `fk_det_reserva_hora` FOREIGN KEY (`codreserva`, `codhora`) REFERENCES `Reservas` (`codreserva`, `codhora`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detalles_Reservas`
--

LOCK TABLES `Detalles_Reservas` WRITE;
/*!40000 ALTER TABLE `Detalles_Reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Detalles_Reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dias`
--

DROP TABLE IF EXISTS `Dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dias` (
  `coddia` int NOT NULL,
  `desdia` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`coddia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dias`
--

LOCK TABLES `Dias` WRITE;
/*!40000 ALTER TABLE `Dias` DISABLE KEYS */;
INSERT INTO `Dias` VALUES (1,'Lunes'),(2,'Martes'),(3,'Miércoles'),(4,'Jueves'),(5,'Viernes'),(6,'Sábado'),(7,'Domingo');
/*!40000 ALTER TABLE `Dias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Horarios`
--

DROP TABLE IF EXISTS `Horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Horarios` (
  `codhora` int NOT NULL,
  `plazadisp` int DEFAULT NULL,
  `fecinihora` datetime DEFAULT NULL,
  `fecfinhora` datetime DEFAULT NULL,
  `codcli` int DEFAULT NULL,
  `codmonitores` int DEFAULT NULL,
  `codtipodeporte` int DEFAULT NULL,
  `coddia` int DEFAULT NULL,
  `codtramo` int DEFAULT NULL,
  `codsala` int DEFAULT NULL,
  PRIMARY KEY (`codhora`),
  KEY `fk_hora_cli` (`codcli`),
  KEY `fk_hora_moni` (`codmonitores`),
  KEY `fk_hora_tipodeporte` (`codtipodeporte`),
  KEY `fk_hora_dia` (`coddia`),
  KEY `fk_hora_tramo` (`codtramo`),
  KEY `fk_hora_sala` (`codsala`),
  CONSTRAINT `fk_hora_cli` FOREIGN KEY (`codcli`) REFERENCES `Clientes` (`codcli`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hora_dia` FOREIGN KEY (`coddia`) REFERENCES `Dias` (`coddia`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hora_moni` FOREIGN KEY (`codmonitores`) REFERENCES `Monitores` (`codmonitores`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hora_sala` FOREIGN KEY (`codsala`) REFERENCES `Salas` (`codsala`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hora_tipodeporte` FOREIGN KEY (`codtipodeporte`) REFERENCES `TipoDeporte` (`codtipodeporte`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hora_tramo` FOREIGN KEY (`codtramo`) REFERENCES `TramoHorario` (`codtramo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Horarios`
--

LOCK TABLES `Horarios` WRITE;
/*!40000 ALTER TABLE `Horarios` DISABLE KEYS */;
INSERT INTO `Horarios` VALUES (1,20,'2024-02-18 08:00:00','2024-02-18 10:00:00',NULL,1,1,1,1,1),(2,15,'2024-02-18 10:00:00','2024-02-18 12:00:00',NULL,2,2,1,2,2),(3,25,'2024-02-18 13:00:00','2024-02-18 15:00:00',NULL,3,3,1,3,3),(4,10,'2024-02-18 15:00:00','2024-02-18 17:00:00',NULL,4,4,1,4,4);
/*!40000 ALTER TABLE `Horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitores`
--

DROP TABLE IF EXISTS `Monitores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Monitores` (
  `codmonitores` int NOT NULL,
  `nommonitores` varchar(60) DEFAULT NULL,
  `ape1monitores` varchar(60) DEFAULT NULL,
  `ape2monitores` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codmonitores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitores`
--

LOCK TABLES `Monitores` WRITE;
/*!40000 ALTER TABLE `Monitores` DISABLE KEYS */;
INSERT INTO `Monitores` VALUES (1,'Aiman','Harrar','Daoud'),(2,'Jose','Rodríguez','Díaz'),(3,'Alejandro','Luque','Maillo'),(4,'Alejandro','Luque','Maillo');
/*!40000 ALTER TABLE `Monitores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservas`
--

DROP TABLE IF EXISTS `Reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservas` (
  `codreserva` int NOT NULL,
  `descripreserva` varchar(60) DEFAULT NULL,
  `codhora` int NOT NULL,
  PRIMARY KEY (`codreserva`,`codhora`),
  KEY `fk_reserva_hora` (`codhora`),
  CONSTRAINT `fk_reserva_hora` FOREIGN KEY (`codhora`) REFERENCES `Horarios` (`codhora`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservas`
--

LOCK TABLES `Reservas` WRITE;
/*!40000 ALTER TABLE `Reservas` DISABLE KEYS */;
INSERT INTO `Reservas` VALUES (1,'Reserva de sala para reunión de equipo',1),(2,'Reserva para hacer boxeo',3),(3,'Reserva para hacer extreme fit',2),(4,'Reserva para zumba',4);
/*!40000 ALTER TABLE `Reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salas`
--

DROP TABLE IF EXISTS `Salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Salas` (
  `codsala` int NOT NULL,
  `plazas` int DEFAULT NULL,
  `datos` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codsala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salas`
--

LOCK TABLES `Salas` WRITE;
/*!40000 ALTER TABLE `Salas` DISABLE KEYS */;
INSERT INTO `Salas` VALUES (1,50,'Zumba'),(2,30,'Yoga'),(3,20,'Sala fitness'),(4,40,'Core');
/*!40000 ALTER TABLE `Salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoDeporte`
--

DROP TABLE IF EXISTS `TipoDeporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TipoDeporte` (
  `codtipodeporte` int NOT NULL,
  `desdeporte` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codtipodeporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoDeporte`
--

LOCK TABLES `TipoDeporte` WRITE;
/*!40000 ALTER TABLE `TipoDeporte` DISABLE KEYS */;
INSERT INTO `TipoDeporte` VALUES (1,'Fútbol'),(2,'Baloncesto'),(3,'Tenis'),(4,'Natación'),(5,'Atletismo');
/*!40000 ALTER TABLE `TipoDeporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TramoHorario`
--

DROP TABLE IF EXISTS `TramoHorario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TramoHorario` (
  `codtramo` int NOT NULL,
  `horaini` datetime DEFAULT NULL,
  `horafin` datetime DEFAULT NULL,
  PRIMARY KEY (`codtramo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TramoHorario`
--

LOCK TABLES `TramoHorario` WRITE;
/*!40000 ALTER TABLE `TramoHorario` DISABLE KEYS */;
INSERT INTO `TramoHorario` VALUES (1,'2024-02-18 08:00:00','2024-02-18 10:00:00'),(2,'2024-02-18 10:00:00','2024-02-18 12:00:00'),(3,'2024-02-18 13:00:00','2024-02-18 15:00:00'),(4,'2024-02-18 15:00:00','2024-02-18 17:00:00');
/*!40000 ALTER TABLE `TramoHorario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bodyfitness'
--

--
-- Dumping routines for database 'bodyfitness'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-03 11:55:04
