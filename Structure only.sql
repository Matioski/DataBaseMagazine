CREATE DATABASE  IF NOT EXISTS `giornale` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `giornale`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: giornale
-- ------------------------------------------------------
-- Server version	5.7.9-log

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
-- Table structure for table `allegata_a`
--

DROP TABLE IF EXISTS `allegata_a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allegata_a` (
  `Titolo_articolo` varchar(110) NOT NULL,
  `Titolo_foto` varchar(45) NOT NULL,
  `Categoria_foto` varchar(30) NOT NULL,
  PRIMARY KEY (`Titolo_articolo`,`Titolo_foto`,`Categoria_foto`),
  KEY `Foto_idx` (`Titolo_foto`,`Categoria_foto`),
  KEY `Categoria_idx` (`Titolo_articolo`),
  CONSTRAINT `Articolo` FOREIGN KEY (`Titolo_articolo`) REFERENCES `articolo` (`Titolo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Foto` FOREIGN KEY (`Titolo_foto`, `Categoria_foto`) REFERENCES `foto` (`Titolo`, `Categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articolo`
--

DROP TABLE IF EXISTS `articolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articolo` (
  `Titolo` varchar(110) NOT NULL,
  `Sottotitolo` varchar(130) DEFAULT NULL,
  `Occhiello` varchar(150) DEFAULT NULL,
  `Corpo` longtext NOT NULL,
  `#Battute` int(11) DEFAULT NULL,
  `Data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Autore` int(11) NOT NULL,
  `Categoria` varchar(30) NOT NULL,
  PRIMARY KEY (`Titolo`),
  KEY `Riguarda_idx` (`Categoria`),
  KEY `Scrive` (`Autore`),
  CONSTRAINT `Riguarda` FOREIGN KEY (`Categoria`) REFERENCES `settore` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Scrive` FOREIGN KEY (`Autore`) REFERENCES `giornalista` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collaboratore_esterno`
--

DROP TABLE IF EXISTS `collaboratore_esterno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collaboratore_esterno` (
  `ID` int(11) NOT NULL,
  `Provincia_di_competenza` enum('NA','SA','CE','BE','AV') NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Giornalista_esterno` FOREIGN KEY (`ID`) REFERENCES `giornalista` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collaboratore_interno`
--

DROP TABLE IF EXISTS `collaboratore_interno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collaboratore_interno` (
  `ID` int(11) NOT NULL,
  `Ruolo` varchar(45) NOT NULL,
  `Retribuzione` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Giornalista_interno` FOREIGN KEY (`ID`) REFERENCES `giornalista` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `foto`
--

DROP TABLE IF EXISTS `foto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foto` (
  `Titolo` varchar(45) NOT NULL,
  `Categoria` varchar(30) NOT NULL,
  `Descrizione` varchar(140) NOT NULL,
  PRIMARY KEY (`Titolo`,`Categoria`),
  KEY `Categorizza_idx` (`Categoria`),
  CONSTRAINT `Categorizza` FOREIGN KEY (`Categoria`) REFERENCES `settore` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `giornalista`
--

DROP TABLE IF EXISTS `giornalista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `giornalista` (
  `CF` char(16) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Data_Nascita` date NOT NULL,
  `Via` varchar(80) NOT NULL,
  `Città` varchar(50) NOT NULL,
  `Data_Assunzione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome_Settore` varchar(30) NOT NULL,
  `#Articoli` int(11) unsigned NOT NULL DEFAULT '0',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CF_UNIQUE` (`CF`),
  KEY `Settore_competenza` (`Nome_Settore`),
  CONSTRAINT `Settore_competenza` FOREIGN KEY (`Nome_Settore`) REFERENCES `settore` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `giornalista_ha`
--

DROP TABLE IF EXISTS `giornalista_ha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `giornalista_ha` (
  `Telefono` char(15) NOT NULL,
  `ID_Giornalista` int(11) NOT NULL,
  PRIMARY KEY (`Telefono`,`ID_Giornalista`),
  KEY `Rif_Giornalista` (`ID_Giornalista`),
  CONSTRAINT `Rif_Giornalista` FOREIGN KEY (`ID_Giornalista`) REFERENCES `giornalista` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recap` FOREIGN KEY (`Telefono`) REFERENCES `recapito` (`Telefono`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immagine`
--

DROP TABLE IF EXISTS `immagine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `immagine` (
  `titolo` varchar(45) NOT NULL,
  `Categoria` varchar(30) NOT NULL,
  `Immagine` longblob NOT NULL,
  PRIMARY KEY (`titolo`,`Categoria`),
  CONSTRAINT `foto_rif` FOREIGN KEY (`titolo`, `Categoria`) REFERENCES `foto` (`Titolo`, `Categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inserto_pubblicitario`
--

DROP TABLE IF EXISTS `inserto_pubblicitario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inserto_pubblicitario` (
  `società` varchar(80) NOT NULL,
  `Indice_imm` int(11) NOT NULL,
  `Immagine` longblob NOT NULL,
  `Pub_dovute` int(11) unsigned NOT NULL,
  `Pub_effettive` int(11) unsigned DEFAULT '0',
  `Costo` int(10) unsigned NOT NULL,
  `Prodotto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`società`,`Indice_imm`),
  KEY `RIF_società_index` (`società`),
  CONSTRAINT `RIF_società` FOREIGN KEY (`società`) REFERENCES `società` (`Nome_società`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `numero`
--

DROP TABLE IF EXISTS `numero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `numero` (
  `Annualità` year(4) NOT NULL,
  `#Settimana` int(11) NOT NULL,
  `Mensilità` enum('gennaio','febbraio','marzo','aprile','maggio','giugno','luglio','agosto','settembre','ottobre','novembre','dicembre') NOT NULL,
  `#Stampe` int(11) unsigned NOT NULL DEFAULT '1000',
  PRIMARY KEY (`Annualità`,`#Settimana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presente_su`
--

DROP TABLE IF EXISTS `presente_su`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presente_su` (
  `ID_soc` varchar(80) NOT NULL,
  `ind_imm` int(11) NOT NULL,
  `Ann` year(4) NOT NULL,
  `Sett` int(11) NOT NULL,
  `Impag` enum('intera','mezza','quarto','marquette') NOT NULL,
  `pag` int(11) NOT NULL,
  PRIMARY KEY (`ind_imm`,`Ann`,`Sett`,`ID_soc`),
  KEY `Imm_idx` (`ID_soc`,`ind_imm`),
  KEY `Num_idx` (`Ann`,`Sett`),
  CONSTRAINT `Imm` FOREIGN KEY (`ID_soc`, `ind_imm`) REFERENCES `inserto_pubblicitario` (`società`, `Indice_imm`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Num` FOREIGN KEY (`Ann`, `Sett`) REFERENCES `numero` (`Annualità`, `#Settimana`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pubblicato_su`
--

DROP TABLE IF EXISTS `pubblicato_su`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubblicato_su` (
  `Titolo` varchar(110) NOT NULL,
  `Annualità` year(4) NOT NULL,
  `#Settimana` int(11) NOT NULL,
  `Impaginazione` enum('spalla','apertura','civette','contornato') NOT NULL,
  `#Pagina` int(11) NOT NULL,
  PRIMARY KEY (`#Settimana`,`Annualità`,`Titolo`),
  UNIQUE KEY `Titolo_UNIQUE` (`Titolo`),
  KEY `Numero_idx` (`Annualità`,`#Settimana`),
  KEY `Articolo_pubbl` (`Titolo`),
  CONSTRAINT `Articolo_pubbl` FOREIGN KEY (`Titolo`) REFERENCES `articolo` (`Titolo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Numero_pubbl` FOREIGN KEY (`Annualità`, `#Settimana`) REFERENCES `numero` (`Annualità`, `#Settimana`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recapito`
--

DROP TABLE IF EXISTS `recapito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recapito` (
  `Telefono` char(15) NOT NULL,
  PRIMARY KEY (`Telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settore`
--

DROP TABLE IF EXISTS `settore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settore` (
  `Nome` varchar(30) NOT NULL,
  `Coordinatore` int(11) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  KEY `Coordin_idx` (`Coordinatore`),
  CONSTRAINT `Coordin` FOREIGN KEY (`Coordinatore`) REFERENCES `collaboratore_interno` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settore_ha`
--

DROP TABLE IF EXISTS `settore_ha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settore_ha` (
  `Telefono` char(15) NOT NULL,
  `Nome_sett` varchar(30) NOT NULL,
  PRIMARY KEY (`Telefono`,`Nome_sett`),
  KEY `Rif_sett_idx` (`Nome_sett`),
  CONSTRAINT `Rif_sett` FOREIGN KEY (`Nome_sett`) REFERENCES `settore` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recap_sett` FOREIGN KEY (`Telefono`) REFERENCES `recapito` (`Telefono`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `società`
--

DROP TABLE IF EXISTS `società`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `società` (
  `#P.Iva` char(13) NOT NULL,
  `Ragione_sociale` varchar(80) DEFAULT NULL,
  `Nome_società` varchar(80) NOT NULL,
  PRIMARY KEY (`Nome_società`),
  UNIQUE KEY `#P.Iva_UNIQUE` (`#P.Iva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `società_ha`
--

DROP TABLE IF EXISTS `società_ha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `società_ha` (
  `Telefono` char(15) NOT NULL,
  `ID_soc` varchar(80) NOT NULL,
  PRIMARY KEY (`Telefono`,`ID_soc`),
  KEY `Rif_soc_idx` (`ID_soc`),
  CONSTRAINT `Rif_soc` FOREIGN KEY (`ID_soc`) REFERENCES `società` (`Nome_società`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recap_soc` FOREIGN KEY (`Telefono`) REFERENCES `recapito` (`Telefono`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ufficio`
--

DROP TABLE IF EXISTS `ufficio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ufficio` (
  `#Ufficio` int(11) NOT NULL,
  `Nome_redazione` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`#Ufficio`),
  KEY `Risiede_idx` (`Nome_redazione`),
  CONSTRAINT `Risiede` FOREIGN KEY (`Nome_redazione`) REFERENCES `settore` (`Nome`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-14 10:49:02
