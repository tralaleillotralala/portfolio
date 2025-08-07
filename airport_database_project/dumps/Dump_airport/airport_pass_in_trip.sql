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
-- Table structure for table `pass_in_trip`
--

DROP TABLE IF EXISTS `pass_in_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pass_in_trip` (
  `id` int NOT NULL,
  `trip` int NOT NULL,
  `passenger` int NOT NULL,
  `place` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `passenger_id_idx` (`passenger`),
  KEY `trip_id_idx` (`trip`),
  CONSTRAINT `passenger_id` FOREIGN KEY (`passenger`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trip_id` FOREIGN KEY (`trip`) REFERENCES `trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pass_in_trip`
--

LOCK TABLES `pass_in_trip` WRITE;
/*!40000 ALTER TABLE `pass_in_trip` DISABLE KEYS */;
INSERT INTO `pass_in_trip` VALUES (1,1100,1,'1a\r'),(2,1123,3,'2a\r'),(3,1123,1,'4c\r'),(4,1123,6,'4b\r'),(5,1124,2,'2d\r'),(6,1145,3,'2c\r'),(7,1181,1,'1a\r'),(8,1181,6,'1b\r'),(9,1181,8,'3c\r'),(10,1181,5,'1b\r'),(11,1182,5,'4b\r'),(12,1187,8,'3a\r'),(13,1188,8,'3a\r'),(14,1182,9,'6d\r'),(15,1145,5,'1d\r'),(16,1187,10,'3d\r'),(17,8882,37,'1a\r'),(18,7771,37,'1c\r'),(19,7772,37,'1a\r'),(20,8881,37,'1d\r'),(21,7778,10,'2a\r'),(22,7772,10,'3a\r'),(23,7771,11,'4a\r'),(24,7771,11,'1b\r'),(25,7771,11,'5a\r'),(26,7772,12,'1d\r'),(27,7773,13,'2d\r'),(28,7772,13,'1b\r'),(29,8882,14,'3d\r'),(30,7771,14,'4d\r'),(31,7771,14,'5d\r'),(32,7772,14,'1c\r');
/*!40000 ALTER TABLE `pass_in_trip` ENABLE KEYS */;
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
