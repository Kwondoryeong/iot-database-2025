Dept-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema madangniv
-- -----------------------------------------------------
-- 마당대학교 모델링

-- -----------------------------------------------------
-- Schema madangniv
--
-- 마당대학교 모델링
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `madangniv` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `madangniv` ;

-- -----------------------------------------------------
-- Table `madangniv`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`Professor` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `rank` VARCHAR(20) NOT NULL,
  `speciality` VARCHAR(45) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangniv`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`Dept` (
  `dno` INT NOT NULL,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  `runprofessorssn` INT NOT NULL,
  PRIMARY KEY (`dno`),
  INDEX `fk_Dept_Professor_idx` (`runprofessorssn` ASC) VISIBLE,
  CONSTRAINT `fk_Dept_Professor`
    FOREIGN KEY (`runprofessorssn`)
    REFERENCES `madangniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `madangniv`.`Graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`Graduate` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `deg_prog` VARCHAR(45) NULL,
  `dno` INT NOT NULL,
  `graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_Graduate_Dept1_idx` (`dno` ASC) VISIBLE,
  INDEX `fk_Graduate_Graduate1_idx` (`graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Graduate_Dept1`
    FOREIGN KEY (`dno`)
    REFERENCES `madangniv`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Graduate_Graduate1`
    FOREIGN KEY (`graduate_ssn`)
    REFERENCES `madangniv`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangniv`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`Project` (
  `pid` INT NOT NULL,
  `pname` VARCHAR(50) NULL,
  `sponsor` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `budget` INT NULL,
  `managessn` INT NOT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_Project_Professor1_idx` (`managessn` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Professor1`
    FOREIGN KEY (`managessn`)
    REFERENCES `madangniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `madangniv`.`work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`work_dept` (
  `Professor_ssn` INT NOT NULL,
  `Dept_dno` INT NOT NULL,
  `pct_time` INT NOT NULL COMMENT '교수참여백분율',
  PRIMARY KEY (`Professor_ssn`, `Dept_dno`),
  INDEX `fk_work_dept_Professor1_idx` (`Professor_ssn` ASC) VISIBLE,
  INDEX `fk_work_dept_Dept1_idx` (`Dept_dno` ASC) VISIBLE,
  CONSTRAINT `fk_work_dept_Professor1`
    FOREIGN KEY (`Professor_ssn`)
    REFERENCES `madangniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_dept_Dept1`
    FOREIGN KEY (`Dept_dno`)
    REFERENCES `madangniv`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangniv`.`work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`work_in` (
  `Professorssn_id` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`Professorssn_id`, `pid`),
  INDEX `fk_work_in_Project1_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_work_in_Professor1`
    FOREIGN KEY (`Professorssn_id`)
    REFERENCES `madangniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_in_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `madangniv`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangniv`.`work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangniv`.`work_prog` (
  `pid` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`pid`, `graduatessn`),
  INDEX `fk_work_prog_Graduate1_idx` (`graduatessn` ASC) VISIBLE,
  CONSTRAINT `fk_work_prog_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `madangniv`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_prog_Graduate1`
    FOREIGN KEY (`graduatessn`)
    REFERENCES `madangniv`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
