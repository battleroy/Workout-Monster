-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: workout_monster
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.15.04.1

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
-- Table structure for table `PHOTO`
--

DROP TABLE IF EXISTS `PHOTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PHOTO` (
  `PHOTO_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PHOTO_IMAGE_BYTES` longblob,
  `FK_SPOT_ID` int(11) NOT NULL,
  PRIMARY KEY (`PHOTO_ID`),
  KEY `FK_SPOT_ID` (`FK_SPOT_ID`),
  CONSTRAINT `PHOTO_ibfk_1` FOREIGN KEY (`FK_SPOT_ID`) REFERENCES `SPOT` (`SPOT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `REVIEW`
--

DROP TABLE IF EXISTS `REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REVIEW` (
  `REVIEW_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FK_REVIEW_CREATOR` varchar(20) DEFAULT NULL,
  `REVIEW_TEXT` varchar(300) NOT NULL,
  `FK_SPOT_ID` int(11) NOT NULL,
  PRIMARY KEY (`REVIEW_ID`),
  KEY `FK_REVIEW_CREATOR` (`FK_REVIEW_CREATOR`),
  KEY `FK_SPOT_ID` (`FK_SPOT_ID`),
  CONSTRAINT `REVIEW_ibfk_2` FOREIGN KEY (`FK_REVIEW_CREATOR`) REFERENCES `USER_CREDENTIALS` (`USER_NAME`),
  CONSTRAINT `REVIEW_ibfk_3` FOREIGN KEY (`FK_SPOT_ID`) REFERENCES `SPOT` (`SPOT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SPOT`
--

DROP TABLE IF EXISTS `SPOT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SPOT` (
  `SPOT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SPOT_NAME` varchar(64) DEFAULT NULL,
  `SPOT_ADDRESS` varchar(128) DEFAULT NULL,
  `SPOT_LATITUDE` double NOT NULL,
  `SPOT_LONGITUDE` double NOT NULL,
  `FK_USER_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SPOT_ID`),
  UNIQUE KEY `unique_SPOT_LONGITUDE_LATITUDE` (`SPOT_LONGITUDE`,`SPOT_LATITUDE`),
  KEY `FK_USER_ID` (`FK_USER_ID`),
  CONSTRAINT `SPOT_ibfk_1` FOREIGN KEY (`FK_USER_ID`) REFERENCES `USER_CREDENTIALS` (`USER_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_CREDENTIALS`
--

DROP TABLE IF EXISTS `USER_CREDENTIALS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_CREDENTIALS` (
  `USER_NAME` varchar(20) NOT NULL,
  `PASSWORD` varchar(128) DEFAULT NULL,
  `FIRST_NAME` varchar(20) NOT NULL,
  `LAST_NAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `USER_ROLE`
--

DROP TABLE IF EXISTS `USER_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ROLE` (
  `USER_ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE` varchar(20) NOT NULL,
  `FK_USER_NAME` varchar(20) NOT NULL,
  PRIMARY KEY (`USER_ROLE_ID`),
  KEY `FK_USER_NAME` (`FK_USER_NAME`),
  CONSTRAINT `USER_ROLE_ibfk_1` FOREIGN KEY (`FK_USER_NAME`) REFERENCES `USER_CREDENTIALS` (`USER_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-06 22:09:57