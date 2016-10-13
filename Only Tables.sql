

-- -----------------------------------------------------
-- Schema giornale
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `giornale` DEFAULT CHARACTER SET utf8 ;
USE `giornale` ;
-- -----------------------------------------------------
-- Table `giornale`.`settore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`settore` (
  `Nome` VARCHAR(30) NOT NULL,
  `Coordinatore` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Nome`));





-- -----------------------------------------------------
-- Table `giornale`.`giornalista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`giornalista` (
  `CF` CHAR(16) NOT NULL,
  `Nome` VARCHAR(30) NOT NULL,
  `Cognome` VARCHAR(30) NOT NULL,
  `Data_Nascita` DATE NOT NULL,
  `Via` VARCHAR(80) NOT NULL,
  `Città` VARCHAR(50) NOT NULL,
  `Data_Assunzione` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Nome_Settore` VARCHAR(30) NOT NULL,
  `#Articoli` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CF_UNIQUE` (`CF` ASC),
  INDEX `Settore_competenza` (`Nome_Settore` ASC),
  CONSTRAINT `Settore_competenza`
    FOREIGN KEY (`Nome_Settore`)
    REFERENCES `giornale`.`settore` (`Nome`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `giornale`.`settore` add foreign key constraint
-- -----------------------------------------------------
ALTER TABLE `giornale`.`settore` 
ADD INDEX `Coordin_idx` (`Coordinatore` ASC);
ALTER TABLE `giornale`.`settore` 
ADD CONSTRAINT `Coordin`
  FOREIGN KEY (`Coordinatore`)
  REFERENCES `giornale`.`collaboratore_interno` (`ID`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table `giornale`.`collaboratore_interno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`collaboratore_interno` (
  `ID` INT(11) NOT NULL,
  `Ruolo` VARCHAR(45) NOT NULL,
  `Retribuzione` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Giornalista_interno`
    FOREIGN KEY (`ID`)
    REFERENCES `giornale`.`giornalista` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `giornale`.`collaboratore_esterno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`collaboratore_esterno` (
  `ID` INT(11) NOT NULL,
  `Provincia_di_competenza` ENUM('NA', 'SA', 'CE', 'BE', 'AV') NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Giornalista_esterno`
    FOREIGN KEY (`ID`)
    REFERENCES `giornale`.`giornalista` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `giornale`.`articolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`articolo` (
  `Titolo` VARCHAR(110) NOT NULL,
  `Sottotitolo` VARCHAR(130) NULL DEFAULT NULL,
  `Occhiello` VARCHAR(150) NULL DEFAULT NULL,
  `Corpo` LONGTEXT NOT NULL,
  `#Battute` INT(11) NULL DEFAULT null,
  `Data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Autore` INT(11) NOT NULL,
  `Categoria` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Titolo`),
  INDEX `Riguarda_idx` (`Categoria` ASC),
  INDEX `Scrive` (`Autore` ASC),
  CONSTRAINT `Riguarda`
    FOREIGN KEY (`Categoria`)
    REFERENCES `giornale`.`settore` (`Nome`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Scrive`
    FOREIGN KEY (`Autore`)
    REFERENCES `giornale`.`giornalista` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`foto` (
  `Titolo` VARCHAR(45) NOT NULL,
  `Categoria` VARCHAR(30) NOT NULL,
  `Descrizione` VARCHAR(140) NOT NULL,
  PRIMARY KEY (`Titolo`, `Categoria`),
  INDEX `Categorizza_idx` (`Categoria` ASC),
  CONSTRAINT `Categorizza`
    FOREIGN KEY (`Categoria`)
    REFERENCES `giornale`.`settore` (`Nome`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`allegata_a`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`allegata_a` (
  `Titolo_articolo` VARCHAR(110) NOT NULL,
  `Titolo_foto` VARCHAR(45) NOT NULL,
  `Categoria_foto` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Titolo_articolo`, `Titolo_foto`, `Categoria_foto`),
  INDEX `Foto_idx` (`Titolo_foto` ASC, `Categoria_foto` ASC),
  INDEX `Categoria_idx` (`Titolo_articolo` ASC),
  CONSTRAINT `Articolo`
    FOREIGN KEY (`Titolo_articolo`)
    REFERENCES `giornale`.`articolo` (`Titolo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Foto`
    FOREIGN KEY (`Titolo_foto` , `Categoria_foto`)
    REFERENCES `giornale`.`foto` (`Titolo` , `Categoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `giornale`.`numero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`numero` (
  `Annualità` YEAR NOT NULL,
  `#Settimana` INT(11) NOT NULL,
  `Mensilità` ENUM('gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno', 'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre') NOT NULL,
  `#Stampe` INT(11) UNSIGNED NOT NULL DEFAULT '1000',
  PRIMARY KEY (`Annualità`, `#Settimana`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `giornale`.`recapito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`recapito` (
  `Telefono` CHAR(15) NOT NULL,
  PRIMARY KEY (`Telefono`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`giornalista_ha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`giornalista_ha` (
  `Telefono` CHAR(15) NOT NULL,
  `ID_Giornalista` INT(11) NOT NULL,
  PRIMARY KEY (`Telefono`, `ID_Giornalista`),
  INDEX `Rif_Giornalista` (`ID_Giornalista` ASC),
  CONSTRAINT `Rif_Giornalista`
    FOREIGN KEY (`ID_Giornalista`)
    REFERENCES `giornale`.`giornalista` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `recap`
    FOREIGN KEY (`Telefono`)
    REFERENCES `giornale`.`recapito` (`Telefono`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`immagine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`immagine` (
  `titolo` VARCHAR(45) NOT NULL,
  `Categoria` VARCHAR(30) NOT NULL,
  `Immagine` LONGBLOB NOT NULL,
  PRIMARY KEY (`titolo`, `Categoria`),
  CONSTRAINT `foto_rif`
    FOREIGN KEY (`titolo` , `Categoria`)
    REFERENCES `giornale`.`foto` (`Titolo` , `Categoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`società`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`società` (
  `#P.Iva` CHAR(13) NOT NULL,
  `Ragione_sociale` VARCHAR(80) NULL DEFAULT NULL,
  `Nome_società` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`Nome_società`),
  UNIQUE INDEX `#P.Iva_UNIQUE` (`#P.Iva` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`inserto_pubblicitario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`inserto_pubblicitario` (
  `società` VARCHAR(80) NOT NULL,
  `Indice_imm` INT(11) NOT NULL,
  `Immagine` LONGBLOB NOT NULL,
  `Pub_dovute` INT(11) UNSIGNED NOT NULL,
  `Pub_effettive` INT(11) UNSIGNED NULL DEFAULT '0',
  `Costo` INT(10) UNSIGNED NOT NULL,
  `Prodotto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`società`, `Indice_imm`),
  INDEX `RIF_società_index` (`società` ASC),
  CONSTRAINT `RIF_società`
    FOREIGN KEY (`società`)
    REFERENCES `giornale`.`società` (`Nome_società`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;





-- -----------------------------------------------------
-- Table `giornale`.`presente_su`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`presente_su` (
  `ID_soc` VARCHAR(80) NOT NULL,
  `ind_imm` INT(11) NOT NULL,
  `Ann` YEAR NOT NULL,
  `Sett` INT(11) NOT NULL,
  `Impag` ENUM('intera', 'mezza', 'quarto', 'marquette') NOT NULL,
  `pag` INT(11) NOT NULL,
  PRIMARY KEY (`ind_imm`, `Ann`, `Sett`, `ID_soc`),
  INDEX `Imm_idx` (`ID_soc` ASC, `ind_imm` ASC),
  INDEX `Num_idx` (`Ann` ASC, `Sett` ASC),
  CONSTRAINT `Imm`
    FOREIGN KEY (`ID_soc` , `ind_imm`)
    REFERENCES `giornale`.`inserto_pubblicitario` (`società` , `Indice_imm`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Num`
    FOREIGN KEY (`Ann` , `Sett`)
    REFERENCES `giornale`.`numero` (`Annualità` , `#Settimana`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `giornale`.`pubblicato_su`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`pubblicato_su` (
  `Titolo` VARCHAR(110) NOT NULL,
  `Annualità` YEAR NOT NULL,
  `#Settimana` INT(11) NOT NULL,
  `Impaginazione` ENUM('spalla', 'apertura', 'civette', 'contornato') NOT NULL,
  `#Pagina` INT(11) NOT NULL,
  PRIMARY KEY (`#Settimana`, `Annualità`, `Titolo`),
  UNIQUE INDEX `Titolo_UNIQUE` (`Titolo` ASC),
  INDEX `Numero_idx` (`Annualità` ASC, `#Settimana` ASC),
  INDEX `Articolo_pubbl` (`Titolo` ASC),
  CONSTRAINT `Articolo_pubbl`
    FOREIGN KEY (`Titolo`)
    REFERENCES `giornale`.`articolo` (`Titolo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Numero_pubbl`
    FOREIGN KEY (`Annualità` , `#Settimana`)
    REFERENCES `giornale`.`numero` (`Annualità` , `#Settimana`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;




-- -----------------------------------------------------
-- Table `giornale`.`società_ha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`società_ha` (
  `Telefono` CHAR(15) NOT NULL,
  `ID_soc` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`Telefono`, `ID_soc`),
  INDEX `Rif_soc_idx` (`ID_soc` ASC),
  CONSTRAINT `Rif_soc`
    FOREIGN KEY (`ID_soc`)
    REFERENCES `giornale`.`società` (`Nome_società`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `recap_soc`
    FOREIGN KEY (`Telefono`)
    REFERENCES `giornale`.`recapito` (`Telefono`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `giornale`.`settore_ha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`settore_ha` (
  `Telefono` CHAR(15) NOT NULL,
  `Nome_sett` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Telefono`, `Nome_sett`),
  INDEX `Rif_sett_idx` (`Nome_sett` ASC),
  CONSTRAINT `Rif_sett`
    FOREIGN KEY (`Nome_sett`)
    REFERENCES `giornale`.`settore` (`Nome`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `recap_sett`
    FOREIGN KEY (`Telefono`)
    REFERENCES `giornale`.`recapito` (`Telefono`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `giornale`.`ufficio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `giornale`.`ufficio` (
  `#Ufficio` INT(11) NOT NULL,
  `Nome_redazione` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`#Ufficio`),
  INDEX `Risiede_idx` (`Nome_redazione` ASC),
  CONSTRAINT `Risiede`
    FOREIGN KEY (`Nome_redazione`)
    REFERENCES `giornale`.`settore` (`Nome`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

