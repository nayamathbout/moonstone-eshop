/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for osx10.20 (arm64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `detailed_plocklista`
--

DROP TABLE IF EXISTS `detailed_plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detailed_plocklista` (
  `ordernummer` int(11) NOT NULL,
  `produktkod` int(11) NOT NULL,
  `produktnamn` varchar(255) NOT NULL,
  `hyllansnummer` int(11) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`ordernummer`,`produktkod`,`hyllansnummer`,`produktnamn`),
  KEY `ordernummer` (`ordernummer`,`produktkod`,`produktnamn`),
  KEY `hyllansnummer` (`hyllansnummer`),
  CONSTRAINT `detailed_plocklista_ibfk_1` FOREIGN KEY (`ordernummer`, `produktkod`, `produktnamn`) REFERENCES `order_produkt` (`ordernummer`, `produktkod`, `produktnamn`) ON DELETE CASCADE,
  CONSTRAINT `detailed_plocklista_ibfk_2` FOREIGN KEY (`hyllansnummer`) REFERENCES `produkt_lager` (`hyllansnummer`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailed_plocklista`
--

LOCK TABLES `detailed_plocklista` WRITE;
/*!40000 ALTER TABLE `detailed_plocklista` DISABLE KEYS */;
/*!40000 ALTER TABLE `detailed_plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktora`
--

DROP TABLE IF EXISTS `faktora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktora` (
  `faktoranummer` int(11) NOT NULL AUTO_INCREMENT,
  `ordernummer` int(11) NOT NULL,
  `pris` int(11) NOT NULL,
  PRIMARY KEY (`faktoranummer`),
  KEY `ordernummer` (`ordernummer`),
  CONSTRAINT `faktora_ibfk_1` FOREIGN KEY (`ordernummer`) REFERENCES `order` (`ordernummer`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktora`
--

LOCK TABLES `faktora` WRITE;
/*!40000 ALTER TABLE `faktora` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `kategori` varchar(255) NOT NULL,
  `produktnamn` varchar(255) NOT NULL,
  PRIMARY KEY (`kategori`,`produktnamn`),
  KEY `produktnamn` (`produktnamn`),
  CONSTRAINT `kategori_ibfk_1` FOREIGN KEY (`produktnamn`) REFERENCES `produkt` (`namn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES
('crystal','moonstone'),
('spiritual','moonstone'),
('kortlek','oracle'),
('spiritual','oracle'),
('crystal','sunstone'),
('spiritual','sunstone'),
('kortlek','tarot'),
('spiritual','tarot');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(255) DEFAULT NULL,
  `adress` varchar(255) DEFAULT NULL,
  `telefonnummer` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES
(1,'Naya','Kristianstad',444),
(2,'Huda','Göteborg',33333),
(3,'Sarah','Stockholm',3355),
(4,'Mohamad','Helsingborg',99999);
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager` (
  `hyllansnummer` int(11) NOT NULL AUTO_INCREMENT,
  `produktnamn` varchar(255) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`hyllansnummer`,`produktnamn`),
  KEY `index_lager_produktnamn` (`produktnamn`),
  CONSTRAINT `lager_ibfk_1` FOREIGN KEY (`produktnamn`) REFERENCES `produkt` (`namn`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES
(1,'moonstone',2),
(2,'moonstone',3),
(3,'sunstone',2),
(4,'sunstone',1),
(5,'tarot',2),
(6,'oracle',3);
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `logg_id` int(11) NOT NULL AUTO_INCREMENT,
  `handelse` varchar(255) NOT NULL,
  `datum_tid` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`logg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES
(1,'New insert on produkt tabel','2025-04-09 23:38:25'),
(2,'New insert on produkt tabel','2025-04-09 23:38:25'),
(3,'New insert on produkt tabel','2025-04-09 23:38:25'),
(4,'New insert on produkt tabel','2025-04-09 23:38:25');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `ordernummer` int(11) NOT NULL AUTO_INCREMENT,
  `kund_id` int(11) NOT NULL,
  `skapad_tid` timestamp NULL DEFAULT current_timestamp(),
  `uppdaterad_tid` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `raderad_tid` timestamp NULL DEFAULT NULL,
  `bestalld_tid` timestamp NULL DEFAULT NULL,
  `skickad_tid` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ordernummer`),
  KEY `kund_id` (`kund_id`),
  KEY `index_order_updated` (`uppdaterad_tid`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES
(1,1,'2025-04-09 23:38:25',NULL,NULL,NULL,NULL),
(2,3,'2025-04-09 23:38:25','2025-04-09 23:38:25',NULL,'2025-04-09 23:38:25',NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_produkt`
--

DROP TABLE IF EXISTS `order_produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_produkt` (
  `ordernummer` int(11) NOT NULL,
  `produktkod` int(11) NOT NULL,
  `produktnamn` varchar(255) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`ordernummer`,`produktkod`,`produktnamn`),
  CONSTRAINT `order_produkt_ibfk_1` FOREIGN KEY (`ordernummer`) REFERENCES `order` (`ordernummer`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_produkt`
--

LOCK TABLES `order_produkt` WRITE;
/*!40000 ALTER TABLE `order_produkt` DISABLE KEYS */;
INSERT INTO `order_produkt` VALUES
(2,2,'moonstone',1);
/*!40000 ALTER TABLE `order_produkt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista` (
  `ordernummer` int(11) NOT NULL,
  `plocklistanummer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`plocklistanummer`),
  KEY `ordernummer` (`ordernummer`),
  CONSTRAINT `plocklista_ibfk_1` FOREIGN KEY (`ordernummer`) REFERENCES `order` (`ordernummer`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista`
--

LOCK TABLES `plocklista` WRITE;
/*!40000 ALTER TABLE `plocklista` DISABLE KEYS */;
/*!40000 ALTER TABLE `plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `namn` varchar(255) NOT NULL,
  `pris` int(11) DEFAULT NULL,
  `beskrivning` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`namn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES
('moonstone',90,'feminine energy'),
('oracle',250,'theme cards'),
('sunstone',100,'masculine energy'),
('tarot',300,'fortune telling cards');
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER logg_produkt_insert
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (handelse)
    VALUES ('New insert on produkt tabel') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER logg_produkt_update
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (handelse)
    VALUES ('New update on produkt tabel') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt_kod`
--

DROP TABLE IF EXISTS `produkt_kod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt_kod` (
  `produktkod` int(11) NOT NULL,
  `produktnamn` varchar(255) NOT NULL,
  PRIMARY KEY (`produktkod`,`produktnamn`),
  KEY `produktnamn` (`produktnamn`),
  CONSTRAINT `produkt_kod_ibfk_1` FOREIGN KEY (`produktnamn`) REFERENCES `produkt` (`namn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt_kod`
--

LOCK TABLES `produkt_kod` WRITE;
/*!40000 ALTER TABLE `produkt_kod` DISABLE KEYS */;
INSERT INTO `produkt_kod` VALUES
(1,'moonstone'),
(2,'moonstone'),
(3,'moonstone'),
(4,'moonstone'),
(5,'moonstone'),
(6,'moonstone'),
(1,'oracle'),
(2,'oracle'),
(3,'oracle'),
(1,'sunstone'),
(2,'sunstone'),
(3,'sunstone'),
(1,'tarot'),
(2,'tarot');
/*!40000 ALTER TABLE `produkt_kod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt_lager`
--

DROP TABLE IF EXISTS `produkt_lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt_lager` (
  `hyllansnummer` int(11) NOT NULL,
  `produktkod` int(11) NOT NULL,
  `produktnamn` varchar(255) NOT NULL,
  PRIMARY KEY (`hyllansnummer`,`produktkod`,`produktnamn`),
  KEY `produktkod` (`produktkod`),
  KEY `produktnamn` (`produktnamn`),
  CONSTRAINT `produkt_lager_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkt_kod` (`produktkod`) ON DELETE CASCADE,
  CONSTRAINT `produkt_lager_ibfk_2` FOREIGN KEY (`produktnamn`) REFERENCES `produkt_kod` (`produktnamn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt_lager`
--

LOCK TABLES `produkt_lager` WRITE;
/*!40000 ALTER TABLE `produkt_lager` DISABLE KEYS */;
INSERT INTO `produkt_lager` VALUES
(1,1,'moonstone'),
(3,1,'sunstone'),
(5,1,'tarot'),
(6,1,'oracle'),
(1,2,'moonstone'),
(3,2,'sunstone'),
(5,2,'tarot'),
(6,2,'oracle'),
(1,3,'moonstone'),
(4,3,'sunstone'),
(6,3,'oracle'),
(2,4,'moonstone'),
(2,5,'moonstone'),
(2,6,'moonstone');
/*!40000 ALTER TABLE `produkt_lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_customer_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `get_customer_id`(a_ordernummer INT
) RETURNS int(11)
BEGIN 
    DECLARE a_kund_id INT;

    SELECT kund_id
    INTO a_kund_id
    FROM `order`
    WHERE ordernummer = a_ordernummer;

    RETURN a_kund_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_ordernummer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `get_ordernummer`(a_kund_id INT
) RETURNS int(11)
BEGIN 
    DECLARE a_ordernummer INT;

    SELECT ordernummer 
    INTO a_ordernummer
    FROM `order`
    WHERE kund_id = a_kund_id
    ORDER BY ordernummer DESC 
    LIMIT 1;

    RETURN a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `order_status`(skapad_tid TIMESTAMP,
    uppdaterad_tid TIMESTAMP,
    raderad_tid TIMESTAMP,
    bestalld_tid TIMESTAMP,
    skickad_tid TIMESTAMP
) RETURNS varchar(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    DETERMINISTIC
BEGIN
    IF skickad_tid IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF bestalld_tid IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF raderad_tid IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF uppdaterad_tid IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSE
        RETURN 'Skapad';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `add_product`(
    IN a_namn VARCHAR(255),
    IN a_pris INT,
    IN a_beskrivning VARCHAR(255)
)
BEGIN
    INSERT INTO produkt
        (namn, pris, beskrivning) 
    VALUES
    (a_namn, a_pris, a_beskrivning);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product_to_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `add_product_to_order`(
    IN a_kund_id INT, 
    IN a_ordernummer INT, 
    IN a_produktnamn VARCHAR(255), 
    IN a_antal INT
)
BEGIN 
    DECLARE a_produktkod INT; 
    DECLARE i INT DEFAULT 1;

    WHILE i <= a_antal DO 
        SELECT produktkod 
        INTO a_produktkod
        FROM produkt_kod 
        WHERE produktnamn = a_produktnamn 
        ORDER BY produktkod ASC
        LIMIT 1 OFFSET i;

        INSERT INTO order_produkt
            (ordernummer, produktkod, produktnamn, antal)
        VALUES 
            (a_ordernummer, a_produktkod, a_produktnamn, 1);

        UPDATE lager
        SET antal = antal - 1
        WHERE produktnamn = a_produktnamn
        LIMIT 1;

        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `change_order_status`(
    IN a_ordernummer INT
)
BEGIN 
    UPDATE `order`
    SET bestalld_tid = CURRENT_TIMESTAMP
    WHERE ordernummer = a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `delete_product`(
    IN a_namn VARCHAR(255)
)
BEGIN
    DELETE FROM produkt 
    WHERE namn = a_namn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `generate_picklist`(
    IN a_ordernummer INT
)
BEGIN
    
    INSERT INTO plocklista (ordernummer)
    VALUES (a_ordernummer);

    
    INSERT INTO detailed_plocklista (ordernummer, produktkod, produktnamn, hyllansnummer, antal)
    SELECT 
        op.ordernummer,
        op.produktkod,
        op.produktnamn,
        pl.hyllansnummer,
        op.antal
    FROM order_produkt op
    JOIN produkt_lager pl
        ON op.produktkod = pl.produktkod AND op.produktnamn = pl.produktnamn
    WHERE op.ordernummer = a_ordernummer;

    
    UPDATE lager l
    JOIN (
        SELECT 
            pl.hyllansnummer,
            pl.produktnamn,
            op.antal
        FROM order_produkt op
        JOIN produkt_lager pl
            ON op.produktkod = pl.produktkod AND op.produktnamn = pl.produktnamn
        WHERE op.ordernummer = a_ordernummer
    ) AS plockdata
    ON l.hyllansnummer = plockdata.hyllansnummer AND l.produktnamn = plockdata.produktnamn
    SET l.antal = l.antal - plockdata.antal;

    
    SELECT 
        dp.ordernummer,
        dp.produktkod,
        dp.produktnamn,
        dp.hyllansnummer,
        dp.antal AS antal_att_plocka,
        l.antal AS antal_kvar_i_lager
    FROM detailed_plocklista dp
    JOIN lager l
        ON dp.hyllansnummer = l.hyllansnummer AND dp.produktnamn = l.produktnamn
    WHERE dp.ordernummer = a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `inv`()
BEGIN
    SELECT 
        pl.produktkod,
        pk.produktnamn,
        l.hyllansnummer,
        l.antal
    FROM produkt_lager AS pl
    JOIN produkt_kod AS pk
        ON pl.produktkod = pk.produktkod
    JOIN lager AS l
        ON pl.hyllansnummer = l.hyllansnummer
        AND pk.produktnamn = l.produktnamn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `invadd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `invadd`(
    IN a_produktnamn VARCHAR(255),
    IN a_hyllansnummer INT,
    IN a_antal INT
)
BEGIN
    DECLARE ny_kod INT;

    INSERT INTO produkt(namn)
    VALUES (a_produktnamn)
    ON DUPLICATE KEY UPDATE namn = namn;

    INSERT INTO lager (hyllansnummer, produktnamn, antal)
    VALUES (a_hyllansnummer, a_produktnamn, a_antal)
    ON DUPLICATE KEY UPDATE
        antal = antal + a_antal;

    SELECT MAX(produktkod) INTO ny_kod
    FROM produkt_kod
    WHERE produktnamn = a_produktnamn;

    IF ny_kod IS NULL THEN
        SET ny_kod = 1;
    ELSE
        SET ny_kod = ny_kod + 1;
    END IF;

    INSERT INTO produkt_kod (produktkod, produktnamn)
    VALUES (ny_kod, a_produktnamn);

    INSERT INTO produkt_lager (hyllansnummer, produktkod, produktnamn)
    VALUES (a_hyllansnummer, ny_kod, a_produktnamn)
    ON DUPLICATE KEY UPDATE produktnamn = produktnamn; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `invdel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `invdel`(
    IN a_produktnamn VARCHAR(255),
    IN a_hyllansnummer INT,
    IN a_antal INT
)
BEGIN
    UPDATE lager
    SET antal = antal - a_antal
    WHERE hyllansnummer = a_hyllansnummer
        AND produktnamn = a_produktnamn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inv_filter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `inv_filter`(
    IN filter VARCHAR(255)
)
BEGIN
    SELECT 
        pl.produktkod,
        pk.produktnamn,
        l.hyllansnummer,
        l.antal
    FROM produkt_lager AS pl
    JOIN produkt_kod AS pk
        ON pl.produktkod = pk.produktkod
    JOIN lager AS l
        ON pl.hyllansnummer = l.hyllansnummer
        AND pk.produktnamn = l.produktnamn
    WHERE 
        pl.produktkod LIKE CONCAT('%', filter, '%')
        OR pl.produktnamn LIKE CONCAT('%', filter, '%')
        OR l.hyllansnummer LIKE CONCAT('%', filter, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logg_number` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `logg_number`(
    IN a_number INT
)
BEGIN 
    SELECT *
    FROM logg 
    ORDER BY datum_tid DESC
    LIMIT a_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `make_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `make_order`(
    IN a_kund_id INT
)
BEGIN 
    INSERT INTO `order`
        (kund_id)
    VALUES
        (a_kund_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `read_produkt`(
    IN a_namn VARCHAR(255)
)
BEGIN 
    SELECT * 
    FROM produkt
    WHERE namn = a_namn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `shelf`()
BEGIN
    SELECT * FROM lager;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `ship_order`(
    IN a_ordernummer INT
)
BEGIN
    UPDATE `order`
    SET skickad_tid = CURRENT_TIMESTAMP
    WHERE ordernummer = a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_costumers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_costumers`()
BEGIN 
    SELECT * FROM kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_kategori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_kategori`()
BEGIN
SELECT DISTINCT kategori FROM kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_orders`()
BEGIN  
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN skickad_tid

            ELSE NULL
        END AS status_tid,
        
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,
        COUNT(op.produktkod) AS antal_produkter
    FROM `order` AS o

    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    GROUP BY 
        o.ordernummer,
        o.kund_id,
        o.skapad_tid,
        o.uppdaterad_tid,
        o.raderad_tid,
        o.bestalld_tid,
        o.skickad_tid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orders_filter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_orders_filter`(
    IN a_id INT
)
BEGIN  
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN skickad_tid

            ELSE NULL
        END AS status_tid,
        
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,
        COUNT(op.produktkod) AS antal_produkter
    FROM `order` AS o

    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    WHERE o.kund_id = a_id OR o.ordernummer = a_id
    GROUP BY 
        o.ordernummer,
        o.kund_id,
        o.skapad_tid,
        o.uppdaterad_tid,
        o.raderad_tid,
        o.bestalld_tid,
        o.skickad_tid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_order_information` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_order_information`(
    IN a_ordernummer INT
)
BEGIN 
    SELECT 
        o.ordernummer,
        o.kund_id,
        CASE
            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skapad' THEN o.skapad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Uppdaterad' THEN o.uppdaterad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Raderad' THEN o.raderad_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Beställd' THEN o.bestalld_tid

            WHEN order_status(
                o.skapad_tid,
                o.uppdaterad_tid,
                o.raderad_tid,
                o.bestalld_tid,
                o.skickad_tid
            ) = 'Skickad' THEN o.skickad_tid

            ELSE NULL
        END AS status_tid,
        order_status(
            o.skapad_tid,
            o.uppdaterad_tid,
            o.raderad_tid,
            o.bestalld_tid,
            o.skickad_tid
        ) AS status,

        op.produktkod,
        op.produktnamn
    FROM `order` AS o
    LEFT JOIN order_produkt AS op
        ON o.ordernummer = op.ordernummer
    WHERE a_ordernummer = o.ordernummer;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_product`()
BEGIN
    SELECT 
        p.namn AS produktnamn, 
        p.pris, 

        (SELECT GROUP_CONCAT(DISTINCT pk.produktkod SEPARATOR ', ') 
            FROM produkt_kod AS pk 
            WHERE pk.produktnamn = p.namn) AS ideer,  

        (SELECT GROUP_CONCAT(DISTINCT k.kategori SEPARATOR ', ') 
            FROM kategori AS k 
            WHERE k.produktnamn = p.namn) AS kategori,  

        (SELECT SUM(l.antal) 
            FROM lager AS l 
            WHERE l.produktnamn = p.namn) AS antal_i_lager  

    FROM produkt p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `skapa_picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `skapa_picklist`(
    IN a_ordernummer INT
)
BEGIN
    INSERT INTO plocklista (ordernummer)
    VALUES (a_ordernummer);

    INSERT INTO detailed_plocklista (ordernummer, produktkod, produktnamn, hyllansnummer, antal)
    SELECT 
        op.ordernummer,
        op.produktkod,
        op.produktnamn,
        pl.hyllansnummer,
        op.antal
    FROM order_produkt op
    JOIN produkt_lager pl
        ON op.produktkod = pl.produktkod AND op.produktnamn = pl.produktnamn
    WHERE op.ordernummer = a_ordernummer;

    SELECT 
        dp.ordernummer,
        dp.produktkod,
        dp.produktnamn,
        dp.hyllansnummer,
        dp.antal AS antal_att_plocka,
        CONCAT("Available because ordering was successfull") AS antal_kvar_i_lager
    FROM detailed_plocklista dp
    JOIN lager l
        ON dp.hyllansnummer = l.hyllansnummer AND dp.produktnamn = l.produktnamn
    WHERE dp.ordernummer = a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `update_produkt`(
    IN a_namn VARCHAR(255),
    IN a_pris INT,
    IN a_beskrivning VARCHAR(255)
)
BEGIN
    UPDATE produkt
        SET 
            pris = a_pris,
            beskrivning = a_beskrivning
        WHERE 
            namn = a_namn; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-04-10  4:11:45
