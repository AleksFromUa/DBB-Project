-- MySQL Script generated by MySQL Workbench
-- Tue Dec 10 22:40:18 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `RoleName_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `Roles_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idUser_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_Users_Roles1_idx` (`Roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Roles1`
    FOREIGN KEY (`Roles_id`)
    REFERENCES `mydb`.`Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Documents` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `authorID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `DocID_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Access` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Access` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Users_id` INT NOT NULL,
  `Documents_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Access_Users1_idx` (`Users_id` ASC) VISIBLE,
  INDEX `fk_Access_Documents1_idx` (`Documents_id` ASC) VISIBLE,
  CONSTRAINT `fk_Access_Users1`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Access_Documents1`
    FOREIGN KEY (`Documents_id`)
    REFERENCES `mydb`.`Documents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paragraphs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Paragraphs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Paragraphs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Documents_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Paragraphs_Documents1_idx` (`Documents_id` ASC) VISIBLE,
  CONSTRAINT `fk_Paragraphs_Documents1`
    FOREIGN KEY (`Documents_id`)
    REFERENCES `mydb`.`Documents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tags` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag` JSON NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Links` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Links` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tagIndex` VARCHAR(45) NOT NULL,
  `Paragraphs_id` INT NOT NULL,
  `Tags_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Links_Paragraphs1_idx` (`Paragraphs_id` ASC) VISIBLE,
  INDEX `fk_Links_Tags1_idx` (`Tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_Links_Paragraphs1`
    FOREIGN KEY (`Paragraphs_id`)
    REFERENCES `mydb`.`Paragraphs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Links_Tags1`
    FOREIGN KEY (`Tags_id`)
    REFERENCES `mydb`.`Tags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Permissions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Permissions_has_Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Permissions_has_Roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Permissions_has_Roles` (
  `Permissions_id` INT NOT NULL,
  `Roles_id` INT NOT NULL,
  PRIMARY KEY (`Permissions_id`, `Roles_id`),
  INDEX `fk_Permissions_has_Roles_Roles1_idx` (`Roles_id` ASC) VISIBLE,
  INDEX `fk_Permissions_has_Roles_Permissions_idx` (`Permissions_id` ASC) VISIBLE,
  CONSTRAINT `fk_Permissions_has_Roles_Permissions`
    FOREIGN KEY (`Permissions_id`)
    REFERENCES `mydb`.`Permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Permissions_has_Roles_Roles1`
    FOREIGN KEY (`Roles_id`)
    REFERENCES `mydb`.`Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;