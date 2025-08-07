-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: airport
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` int NOT NULL,
  `company` int NOT NULL,
  `plane` varchar(45) NOT NULL,
  `town_from` varchar(45) NOT NULL,
  `town_to` varchar(45) NOT NULL,
  `time_out` datetime NOT NULL,
  `time_in` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id_idx` (`company`),
  CONSTRAINT `company_id` FOREIGN KEY (`company`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1100,4,'Boeing','Rostov','Paris','1900-01-01 14:30:00','1900-01-01 17:50:00'),(1101,4,'Boeing','Paris','Rostov','1900-01-01 08:12:00','1900-01-01 11:45:00'),(1123,3,'TU-154','Rostov','Vladivostok','1900-01-01 16:20:00','1900-01-02 03:40:00'),(1124,3,'TU-154','Vladivostok','Rostov','1900-01-01 09:00:00','1900-01-01 19:50:00'),(1145,2,'IL-86','Moscow','Rostov','1900-01-01 09:35:00','1900-01-01 11:23:00'),(1146,2,'IL-86','Rostov','Moscow','1900-01-01 17:55:00','1900-01-01 20:01:00'),(1181,1,'TU-134','Rostov','Moscow','1900-01-01 06:12:00','1900-01-01 08:01:00'),(1182,1,'TU-134','Moscow','Rostov','1900-01-01 12:35:00','1900-01-01 14:30:00'),(1187,1,'TU-134','Rostov','Moscow','1900-01-01 15:42:00','1900-01-01 17:39:00'),(1188,1,'TU-134','Moscow','Rostov','1900-01-01 22:50:00','1900-01-02 00:48:00'),(1195,1,'TU-154','Rostov','Moscow','1900-01-01 23:30:00','1900-01-02 01:11:00'),(1196,1,'TU-154','Moscow','Rostov','1900-01-01 04:00:00','1900-01-01 05:45:00'),(7771,5,'Boeing','London','Singapore','1900-01-01 01:00:00','1900-01-01 11:00:00'),(7772,5,'Boeing','Singapore','London','1900-01-01 12:00:00','1900-01-02 02:00:00'),(7773,5,'Boeing','London','Singapore','1900-01-01 03:00:00','1900-01-01 13:00:00'),(7774,5,'Boeing','Singapore','London','1900-01-01 14:00:00','1900-01-02 06:00:00'),(7775,5,'Boeing','London','Singapore','1900-01-01 09:00:00','1900-01-01 20:00:00'),(7776,5,'Boeing','Singapore','London','1900-01-01 18:00:00','1900-01-02 08:00:00'),(7777,5,'Boeing','London','Singapore','1900-01-01 18:00:00','1900-01-02 06:00:00'),(7778,5,'Boeing','Singapore','London','1900-01-01 22:00:00','1900-01-02 12:00:00'),(8881,5,'Boeing','London','Paris','1900-01-01 03:00:00','1900-01-01 04:00:00'),(8882,5,'Boeing','Paris','London','1900-01-01 22:00:00','1900-01-01 23:00:00');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-07  2:09:21
