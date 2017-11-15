-- MySQL Script generated by MySQL Workbench
-- Tue Nov 14 11:11:48 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema itechart_group_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema itechart_group_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `itechart_group_db` DEFAULT CHARACTER SET utf8mb4 ;
USE `itechart_group_db` ;

-- -----------------------------------------------------
-- Table `itechart_group_db`.`car_park`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`car_park` (
  `idcar` INT NOT NULL AUTO_INCREMENT,
  `car_name` VARCHAR(45) NULL,
  `car_number` VARCHAR(45) NULL,
  `car_type` ENUM('Carcase', 'Fridge', 'Tank') NULL,
  `car_consumption` INT NULL COMMENT 'the using up of a diesel',
  PRIMARY KEY (`idcar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`items` (
  `iditem` INT NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(45) NULL,
  `item_price` INT NULL,
  `item_type` ENUM('Count', 'Volume') NULL,
  PRIMARY KEY (`iditem`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`users` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `user_firstname` VARCHAR(45) NULL,
  `user_lastname` VARCHAR(45) NULL,
  `user_middlename` VARCHAR(45) NULL,
  `user_birthday` DATE NULL,
  `user_email` VARCHAR(45) NULL,
  `user_city` VARCHAR(45) NULL,
  `user_street` VARCHAR(45) NULL,
  `user_house` VARCHAR(45) NULL,
  `user_apartment` INT NULL,
  `user_role` ENUM('sysadmin', 'admin', 'manager', 'dispatcher', 'driver', 'owner') NULL,
  `user_login` VARCHAR(45) NULL,
  `user_password` VARCHAR(45) NULL,
  `user_passport` VARCHAR(45) NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`warehouses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`warehouses` (
  `idwarehouse` INT NOT NULL AUTO_INCREMENT,
  `warehouse_name` VARCHAR(45) NULL,
  `warehouse_country` VARCHAR(45) NULL,
  `warehouse_city` VARCHAR(45) NULL,
  `warehouse_street` VARCHAR(45) NULL,
  `warehouse_house` VARCHAR(45) NULL,
  `warehouse_lat` VARCHAR(45) NULL,
  `warehouse_lng` VARCHAR(45) NULL,
  PRIMARY KEY (`idwarehouse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`clients` (
  `idclients` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(255) NULL,
  PRIMARY KEY (`idclients`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`item_consignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`item_consignments` (
  `iditem_consignments` INT NOT NULL AUTO_INCREMENT,
  `items_iditem` INT NOT NULL,
  `item_amount` INT NULL,
  `item_status` ENUM('Registered', 'Checked', 'Delivered', 'Lost', 'Spoiled') NULL,
  PRIMARY KEY (`iditem_consignments`),
  INDEX `fk_item_consignments_items1_idx` (`items_iditem` ASC),
  CONSTRAINT `fk_item_consignments_items1`
    FOREIGN KEY (`items_iditem`)
    REFERENCES `itechart_group_db`.`items` (`iditem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`invoices` (
  `idinvoice` INT NOT NULL AUTO_INCREMENT,
  `invoice_checkdate` DATE NULL,
  `invoice_status` ENUM('I', 'C', 'D') NOT NULL DEFAULT 'I',
  `item_consignments_iditem_consignments` INT NOT NULL,
  `invoice_issuedate` DATE NOT NULL,
  `users_iduser_creator` INT NOT NULL,
  `users_iduser_inspector` INT NULL,
  `waybills_idwaybill` INT NULL,
  PRIMARY KEY (`idinvoice`),
  INDEX `fk_invoices_item_consignments1_idx` (`item_consignments_iditem_consignments` ASC),
  INDEX `fk_invoices_waybills1_idx` (`waybills_idwaybill` ASC),
  CONSTRAINT `fk_invoices_item_consignments1`
    FOREIGN KEY (`item_consignments_iditem_consignments`)
    REFERENCES `itechart_group_db`.`item_consignments` (`iditem_consignments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoices_waybills1`
    FOREIGN KEY (`waybills_idwaybill`)
    REFERENCES `itechart_group_db`.`waybills` (`idwaybill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`waybills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`waybills` (
  `idwaybill` INT NOT NULL AUTO_INCREMENT,
  `waybill_departure_date` DATE NULL,
  `waybill_status` ENUM('S', 'C') NOT NULL DEFAULT 'S',
  `warehouses_idwarehouse_from` INT NOT NULL,
  `warehouses_idwarehouse_to` INT NOT NULL,
  `car_park_idcar` INT NOT NULL,
  `clients_idclients` INT NOT NULL,
  `users_iduser_driver` INT NOT NULL,
  `waybills_issuedate` DATE NOT NULL,
  PRIMARY KEY (`idwaybill`),
  INDEX `fk_waybills_car_park_idx` (`car_park_idcar` ASC),
  INDEX `fk_waybills_clients1_idx` (`clients_idclients` ASC),
  INDEX `fk_waybills_warehouses1_idx` (`warehouses_idwarehouse_from` ASC),
  INDEX `fk_waybills_warehouses2_idx` (`warehouses_idwarehouse_to` ASC),
  CONSTRAINT `fk_waybills_car_park`
    FOREIGN KEY (`car_park_idcar`)
    REFERENCES `itechart_group_db`.`car_park` (`idcar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waybills_clients1`
    FOREIGN KEY (`clients_idclients`)
    REFERENCES `itechart_group_db`.`clients` (`idclients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waybills_warehouses1`
    FOREIGN KEY (`warehouses_idwarehouse_from`)
    REFERENCES `itechart_group_db`.`warehouses` (`idwarehouse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waybills_warehouses2`
    FOREIGN KEY (`warehouses_idwarehouse_to`)
    REFERENCES `itechart_group_db`.`warehouses` (`idwarehouse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`checkpoints`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`checkpoints` (
  `idcheckpoints` INT NOT NULL AUTO_INCREMENT,
  `checkpoint_name` VARCHAR(45) NULL,
  `checkpoint_lat` VARCHAR(45) NULL,
  `checkpoint_lng` VARCHAR(45) NULL,
  PRIMARY KEY (`idcheckpoints`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`waybills_has_checkpoints`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`waybills_has_checkpoints` (
  `waybills_idwaybill` INT NOT NULL,
  `checkpoints_idcheckpoints` INT NOT NULL,
  `checkpoint_datetime` DATETIME NULL,
  PRIMARY KEY (`waybills_idwaybill`, `checkpoints_idcheckpoints`),
  INDEX `fk_waybills_has_checkpoints_checkpoints1_idx` (`checkpoints_idcheckpoints` ASC),
  INDEX `fk_waybills_has_checkpoints_waybills1_idx` (`waybills_idwaybill` ASC),
  CONSTRAINT `fk_waybills_has_checkpoints_waybills1`
    FOREIGN KEY (`waybills_idwaybill`)
    REFERENCES `itechart_group_db`.`waybills` (`idwaybill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waybills_has_checkpoints_checkpoints1`
    FOREIGN KEY (`checkpoints_idcheckpoints`)
    REFERENCES `itechart_group_db`.`checkpoints` (`idcheckpoints`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itechart_group_db`.`act_of_loss`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itechart_group_db`.`act_of_loss` (
  `invoices_idinvoice` INT NOT NULL,
  `items_iditem` INT NOT NULL,
  `item_amount` INT NOT NULL,
  `act_of_loss_date` DATE NOT NULL,
  PRIMARY KEY (`invoices_idinvoice`, `items_iditem`),
  INDEX `fk_act_of_loss_invoices1_idx` (`invoices_idinvoice` ASC),
  INDEX `fk_act_of_loss_items1_idx` (`items_iditem` ASC),
  CONSTRAINT `fk_act_of_loss_invoices1`
    FOREIGN KEY (`invoices_idinvoice`)
    REFERENCES `itechart_group_db`.`invoices` (`idinvoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_act_of_loss_items1`
    FOREIGN KEY (`items_iditem`)
    REFERENCES `itechart_group_db`.`items` (`iditem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
