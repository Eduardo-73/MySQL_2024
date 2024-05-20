CREATE DATABASE  IF NOT EXISTS `prueba` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `prueba`;
-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: 192.168.1.127    Database: prueba
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1


--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `pk` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha_nac` datetime DEFAULT NULL,
  PRIMARY KEY (`pk`)
);

