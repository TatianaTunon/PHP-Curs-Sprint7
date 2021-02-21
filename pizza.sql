-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Provincia` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Provincia` (
  `idTRProvincia` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTRProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Localitat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Localitat` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Localitat` (
  `idTRLocalitat` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `TR-Provincia_idTRProvincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTRLocalitat`),
  CONSTRAINT `fk_TR-Localitat_TR-Provincia1`
    FOREIGN KEY (`TR-Provincia_idTRProvincia`)
    REFERENCES `pizzeria`.`TR-Provincia` (`idTRProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TR-Localitat_TR-Provincia1_idx` ON `pizzeria`.`TR-Localitat` (`TR-Provincia_idTRProvincia` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`T-Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`T-Clientes` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`T-Clientes` (
  `idT-Clientes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(25) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Adreça` VARCHAR(60) NOT NULL,
  `Codi Postal` VARCHAR(10) NULL,
  `Teléfono` VARCHAR(15) NOT NULL,
  `TR-Localitat_idTRLocalitat` INT NOT NULL,
  PRIMARY KEY (`idT-Clientes`),
  CONSTRAINT `fk_T-Clientes_TR-Localitat1`
    FOREIGN KEY (`TR-Localitat_idTRLocalitat`)
    REFERENCES `pizzeria`.`TR-Localitat` (`idTRLocalitat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_T-Clientes_TR-Localitat1_idx` ON `pizzeria`.`T-Clientes` (`TR-Localitat_idTRLocalitat` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`T-Botigues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`T-Botigues` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`T-Botigues` (
  `idTBotigues` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Adreça` VARCHAR(60) NOT NULL,
  `Codi Postal` VARCHAR(45) NULL,
  `TR-Localitat_idTRLocalitat` INT NOT NULL,
  PRIMARY KEY (`idTBotigues`),
  CONSTRAINT `fk_T-Botigues_TR-Localitat1`
    FOREIGN KEY (`TR-Localitat_idTRLocalitat`)
    REFERENCES `pizzeria`.`TR-Localitat` (`idTRLocalitat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_T-Botigues_TR-Localitat1_idx` ON `pizzeria`.`T-Botigues` (`TR-Localitat_idTRLocalitat` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`T-repartidor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`T-repartidor` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`T-repartidor` (
  `idTrepartidor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognom` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `Teléfono` VARCHAR(15) NOT NULL,
  `lliurament` DATETIME NULL COMMENT 'Data i hora lliurament	',
  PRIMARY KEY (`idTrepartidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`T-Comandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`T-Comandes` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`T-Comandes` (
  `idT-Comandes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Entrega` VARCHAR(45) NOT NULL COMMENT 'Repartiment a domicili o per a recollir en botiga,',
  `T-Clientes_idT-Clientes` INT UNSIGNED NOT NULL,
  `T-Botigues_idTBotigues` INT UNSIGNED NOT NULL,
  `T-repartidor_idTrepartidor` INT UNSIGNED NULL,
  PRIMARY KEY (`idT-Comandes`),
  CONSTRAINT `fk_T-Comandes_T-Clientes1`
    FOREIGN KEY (`T-Clientes_idT-Clientes`)
    REFERENCES `pizzeria`.`T-Clientes` (`idT-Clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T-Comandes_T-Botigues1`
    FOREIGN KEY (`T-Botigues_idTBotigues`)
    REFERENCES `pizzeria`.`T-Botigues` (`idTBotigues`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T-Comandes_T-repartidor1`
    FOREIGN KEY (`T-repartidor_idTrepartidor`)
    REFERENCES `pizzeria`.`T-repartidor` (`idTrepartidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_T-Comandes_T-Clientes1_idx` ON `pizzeria`.`T-Comandes` (`T-Clientes_idT-Clientes` ASC);

CREATE INDEX `fk_T-Comandes_T-Botigues1_idx` ON `pizzeria`.`T-Comandes` (`T-Botigues_idTBotigues` ASC);

CREATE INDEX `fk_T-Comandes_T-repartidor1_idx` ON `pizzeria`.`T-Comandes` (`T-repartidor_idTrepartidor` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Productos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Productos` (
  `idTRProductos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `T-Comandes_idT-Comandes` INT UNSIGNED NOT NULL,
  `Total_preu` DECIMAL(4,2) UNSIGNED NULL,
  `q_pizza` INT UNSIGNED NULL DEFAULT 0,
  `q_hamb` INT UNSIGNED NULL DEFAULT 0,
  `q_beguda` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`idTRProductos`),
  CONSTRAINT `fk_TR-Productos_T-Comandes1`
    FOREIGN KEY (`T-Comandes_idT-Comandes`)
    REFERENCES `pizzeria`.`T-Comandes` (`idT-Comandes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TR-Productos_T-Comandes1_idx` ON `pizzeria`.`TR-Productos` (`T-Comandes_idT-Comandes` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-TiposPizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-TiposPizza` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-TiposPizza` (
  `idTRTiposPizza` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTRTiposPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Pizzas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Pizzas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Pizzas` (
  `idTRPizzas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcio` VARCHAR(45) NULL,
  `Preu` DECIMAL(6) NOT NULL,
  `Imagen` VARCHAR(45) NULL ,
  `TR-Productos_idTRProductos` INT UNSIGNED NOT NULL,
  `TR-TiposPizza_idTRTiposPizza` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTRPizzas`),
  CONSTRAINT `fk_TR-Pizzas_TR-Productos1`
    FOREIGN KEY (`TR-Productos_idTRProductos`)
    REFERENCES `pizzeria`.`TR-Productos` (`idTRProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TR-Pizzas_TR-TiposPizza1`
    FOREIGN KEY (`TR-TiposPizza_idTRTiposPizza`)
    REFERENCES `pizzeria`.`TR-TiposPizza` (`idTRTiposPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TR-Pizzas_TR-Productos1_idx` ON `pizzeria`.`TR-Pizzas` (`TR-Productos_idTRProductos` ASC);

CREATE INDEX `fk_TR-Pizzas_TR-TiposPizza1_idx` ON `pizzeria`.`TR-Pizzas` (`TR-TiposPizza_idTRTiposPizza` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Hamburguesas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Hamburguesas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Hamburguesas` (
  `idTRHamburguesas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcio` VARCHAR(45) NULL,
  `Preu` DECIMAL(6) NOT NULL,
  `Imagen` VARCHAR(45) NULL,
  `TR-Productos_idTRProductos` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTRHamburguesas`),
  CONSTRAINT `fk_TR-Hamburguesas_TR-Productos1`
    FOREIGN KEY (`TR-Productos_idTRProductos`)
    REFERENCES `pizzeria`.`TR-Productos` (`idTRProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TR-Hamburguesas_TR-Productos1_idx` ON `pizzeria`.`TR-Hamburguesas` (`TR-Productos_idTRProductos` ASC);


-- -----------------------------------------------------
-- Table `pizzeria`.`TR-Begudes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`TR-Begudes` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`TR-Begudes` (
  `idTRBegudes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcio` VARCHAR(45) NULL,
  `Preu` DECIMAL(6) NOT NULL,
  `Imagen` VARCHAR(45) NULL,
  `TR-Productos_idTRProductos` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTRBegudes`),
  CONSTRAINT `fk_TR-Begudes_TR-Productos1`
    FOREIGN KEY (`TR-Productos_idTRProductos`)
    REFERENCES `pizzeria`.`TR-Productos` (`idTRProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TR-Begudes_TR-Productos1_idx` ON `pizzeria`.`TR-Begudes` (`TR-Productos_idTRProductos` ASC);

-- -----------------------------------------------------
-- Table `pizzeria`.`T-Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`T-Empleados` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`T-Empleados` (
  `idTEmpleados` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognom` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `Teléfono` VARCHAR(15) NOT NULL,
  `Categoria` VARCHAR(45) NULL COMMENT 'Cuiner o Repartidor',
  `T-Botigues_idTBotigues` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTEmpleados`),
  CONSTRAINT `fk_T-Empleados_T-Botigues1`
    FOREIGN KEY (`T-Botigues_idTBotigues`)
    REFERENCES `pizzeria`.`T-Botigues` (`idTBotigues`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_T-Empleados_T-Botigues1_idx` ON `pizzeria`.`T-Empleados` (`T-Botigues_idTBotigues` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
