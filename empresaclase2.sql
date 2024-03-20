CREATE DATABASE  IF NOT EXISTS `empresaclase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `empresaclase`;
-- MySQL dump 10.13  Distrib 5.5.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: empresa_clase
-- ------------------------------------------------------
-- Server version	5.5.28-0ubuntu0.12.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `centros`
--

DROP TABLE IF EXISTS `centros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centros` (
  `numce` int(11) NOT NULL,
  `nomce` varchar(60) NOT NULL,
  `dirce` varchar(60) NOT NULL,
  `codpostal` char(5) NOT NULL DEFAULT '00000',
  CONSTRAINT pk_centros PRIMARY KEY (`numce`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centros`
--

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `numde` int(11) NOT NULL,
  `numce` int(11) NOT NULL,
  `presude` decimal(10,2) NOT NULL,
  `depende` int(11) DEFAULT NULL,
  `nomde` varchar(60) NOT NULL,
  CONSTRAINT pk_departamentos PRIMARY KEY (`numde`),
  CONSTRAINT fk_deptos_centros FOREIGN KEY (`numce`) REFERENCES `centros`(`numce`)
	ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_deptos_depen FOREIGN KEY (`depende`) REFERENCES `departamentos`(`numde`)
	ON DELETE NO ACTION ON UPDATE NO ACTION

  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `numem` int(11) NOT NULL,
  `numde` int(11) DEFAULT NULL,
  `extelem` char(3) DEFAULT NULL,
  `fecnaem` date NOT NULL,
  `fecinem` date NOT NULL,
  `salarem` decimal(7,2) DEFAULT NULL,
  `comisem` decimal(7,2) DEFAULT NULL,
  `numhiem` tinyint(3) DEFAULT NULL,
  `nomem` varchar(20) DEFAULT NULL,
  `ape1em` varchar(20) DEFAULT NULL,
  `ape2em` varchar(20) DEFAULT NULL,
  `dniem` char(9) DEFAULT NULL,
  `userem` char(12) DEFAULT NULL,
  `passem` char(12) DEFAULT NULL,
  CONSTRAINT pk_empleados PRIMARY KEY (`numem`),
  CONSTRAINT fk_empleados_deptos FOREIGN KEY (`numde`) REFERENCES `departamentos`(`numde`)
	ON DELETE NO ACTION ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--
--
-- Table structure for table `dirigir`
--

DROP TABLE IF EXISTS `dirigir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dirigir` (
  `numdepto` int(11) NOT NULL,
  `numempdirec` int(11) NOT NULL,
  `fecinidir` date NOT NULL,
  `fecfindir` date DEFAULT NULL,
  `tipodir` char(1) NOT NULL,
  CONSTRAINT pk_dirigir PRIMARY KEY (`numdepto`,`numempdirec`,`fecinidir`),

  CONSTRAINT fk_dirigir_deptos FOREIGN KEY (`numdepto`) REFERENCES `departamentos`(`numde`)
	ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_dirigir_empleados FOREIGN KEY (`numempdirec`) REFERENCES `empleados`(`numem`)
	ON DELETE NO ACTION ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dirigir`
--


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-14 12:22:34