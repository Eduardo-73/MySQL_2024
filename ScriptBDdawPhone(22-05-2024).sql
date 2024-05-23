-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: dawphone
-- ------------------------------------------------------
-- Server version	8.0.19
CREATE DATABASE  IF NOT EXISTS `scripdawphone` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `scripdawphone`;
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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idCliente` int NOT NULL,
  `nomCli` varchar(20) NOT NULL,
  `ape1Cli` varchar(20) NOT NULL,
  `ape2Cli` varchar(20) NOT NULL,
  `dniCli` char(9) NOT NULL,
  `numCuentaCli` char(16) NOT NULL,
  `entidadCtaCli` char(4) NOT NULL,
  `idEntidad` int NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `fk_clientes_entidades` (`idEntidad`),
  CONSTRAINT `fk_clientes_entidades` FOREIGN KEY (`idEntidad`) REFERENCES `entidades` (`idEntidad`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Pepe','Aguilar','Sánchez','11111111F','123456789012','5678',1),(2,'José','Benítez','Gómez','11111111F','123456789012','5678',1),(3,'María','Saborido','del Río','11111111F','987654321032','5432',1),(4,'Angel','Ortiz','Pérez','11111111F','563289415630','8941',1),(5,'Berta','Hernandez','Tapia','11111111F','495621853164','2185',1),(6,'Manuel','Fernandez','Quero','11111111F','164978520316','7852',1),(7,'Ataurfo','Festivo','Domingo','11111111F','467985621548','8562',1),(8,'Carlos','De la Rosa','Mustia','11111111F','321654987852','5498',1),(9,'Juana','De Arco','Quemada','11111111F','649785623104','8562',1),(10,'Eva','Tortosa','Tortosa','11111111F','000000000000','0000',1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entidades`
--

DROP TABLE IF EXISTS `entidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entidades` (
  `idEntidad` int NOT NULL,
  `nomEntidad` varchar(20) NOT NULL,
  `dirSedeEntidad` varchar(100) NOT NULL,
  `dirEnvioFicheros` varchar(100) NOT NULL,
  PRIMARY KEY (`idEntidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entidades`
--

LOCK TABLES `entidades` WRITE;
/*!40000 ALTER TABLE `entidades` DISABLE KEYS */;
INSERT INTO `entidades` VALUES (1,'Santander','C/ Principal Santander','urlllllllll'),(2,'BBVA','C/ Principal Bilbao','ftp:......'),(3,'ING','C/ Principal Madrid','.........'),(4,'Unicaja','C/ Principal Ronda','---------');
/*!40000 ALTER TABLE `entidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planes` (
  `idPlan` int NOT NULL,
  `nombrePlan` varchar(40) NOT NULL,
  `cuotaPlan` decimal(5,2) NOT NULL,
  PRIMARY KEY (`idPlan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes`
--

LOCK TABLES `planes` WRITE;
/*!40000 ALTER TABLE `planes` DISABLE KEYS */;
INSERT INTO `planes` VALUES (1,'Básico',19.99),(2,'HogarDuo',29.99),(3,'Familiar',39.99),(4,'Familiar premium',59.99),(5,'Duo Series y deportes',49.99);
/*!40000 ALTER TABLE `planes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planesclientes`
--

DROP TABLE IF EXISTS `planesclientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planesclientes` (
  `idPlan` int NOT NULL,
  `idCliente` int NOT NULL,
  `fecIniPlan` date NOT NULL,
  `fecFinPlan` date DEFAULT NULL,
  `Activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`fecIniPlan`,`idPlan`,`idCliente`),
  KEY `fk_planesClientes_planes` (`idPlan`),
  KEY `fk_planesClientes_clientes` (`idCliente`),
  CONSTRAINT `fk_planesClientes_clientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `fk_planesClientes_planes` FOREIGN KEY (`idPlan`) REFERENCES `planes` (`idPlan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planesclientes`
--

LOCK TABLES `planesclientes` WRITE;
/*!40000 ALTER TABLE `planesclientes` DISABLE KEYS */;
INSERT INTO `planesclientes` VALUES (1,1,'2022-02-01','2024-05-15',0),(2,2,'2023-12-01',NULL,1),(2,1,'2024-05-14',NULL,1);
/*!40000 ALTER TABLE `planesclientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recibos`
--

DROP TABLE IF EXISTS `recibos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recibos` (
  `idRecibo` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL,
  `fecRecibo` date NOT NULL,
  `importeRecibo` decimal(5,2) NOT NULL,
  `numCuentaBanc` char(12) NOT NULL,
  `entidadBanc` char(4) NOT NULL,
  `estadoRecibo` enum('pendienteEnvio','pagado','impagado') NOT NULL DEFAULT 'pendienteEnvio',
  PRIMARY KEY (`idRecibo`),
  KEY `fk_recibos_clientes` (`idCliente`),
  CONSTRAINT `fk_recibos_clientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recibos`
--

LOCK TABLES `recibos` WRITE;
/*!40000 ALTER TABLE `recibos` DISABLE KEYS */;
INSERT INTO `recibos` VALUES (1,2,'2024-05-05',29.99,'123456789012','5678','pendienteEnvio'),(2,1,'2024-05-05',4.00,'123456789012','5678','pendienteEnvio'),(3,2,'2024-04-05',29.99,'123456789012','5678','pagado'),(4,1,'2024-04-23',25.78,'123456789012','5678','pagado'),(5,2,'2024-03-05',29.99,'123456789012','5678','pagado'),(6,1,'2024-03-05',39.99,'123456789012','5678','pagado'),(7,2,'2024-02-05',29.99,'123456789012','5678','pagado'),(8,1,'2024-02-05',29.99,'123456789012','5678','pagado');
/*!40000 ALTER TABLE `recibos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-23  7:19:47
