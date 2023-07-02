SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
-----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Farmacéuticos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Farmaceuticos` (
  `idFarmaceutico` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`idFarmaceutico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Ciudades
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ciudades` (
  `codigoPostal` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `idFarmaceutico` INT NULL,
  PRIMARY KEY (`codigoPostal`),
  INDEX `fk_Ciudades_Farmaceuticos1_idx` (`idFarmaceutico` ASC) VISIBLE,
  CONSTRAINT `fk_Ciudades_Farmaceuticos1`
    FOREIGN KEY (`idFarmaceutico`)
    REFERENCES `mydb`.`Farmaceuticos` (`idFarmaceutico`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Direccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Direccion` (
  `idDireccion` INT NOT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `codigoPostal` INT NOT NULL,
  PRIMARY KEY (`idDireccion`),
  INDEX `fk_Direccion_Ciudades_idx` (`codigoPostal` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Ciudades`
    FOREIGN KEY (`codigoPostal`)
    REFERENCES `mydb`.`Ciudades` (`codigoPostal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Afiliados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Afiliados` (
  `idAfiliado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `tipoDoc` VARCHAR(45) NULL,
  `documento` VARCHAR(45) NULL,
  `fechaNac` DATE NULL,
  `fechaIng` DATE NULL,
  `idDireccion` INT NOT NULL,
  `porcenDescuento` INT NULL,
  PRIMARY KEY (`idAfiliado`),
  INDEX `fk_Afiliados_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Afiliados_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Farmacia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Farmacia` (
  `idFarmacia` INT NOT NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idFarmacia`),
  INDEX `fk_Farmacia_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Farmacia_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- DiasGuardia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DiasGuardia` (
  `idFarmacia` INT NOT NULL,
  `diaDeGuardia` DATE NULL,
  PRIMARY KEY (`idFarmacia`),
  CONSTRAINT `fk_DiasGuardia_Farmacia1`
    FOREIGN KEY (`idFarmacia`)
    REFERENCES `mydb`.`Farmacia` (`idFarmacia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Empleados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleados` (
  `cuit` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fechaIngreso` DATE NULL,
  `idFarmacia` INT NOT NULL,
  PRIMARY KEY (`cuit`, `idFarmacia`),
  INDEX `fk_Empleados_Farmacia1_idx` (`idFarmacia` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Farmacia1`
    FOREIGN KEY (`idFarmacia`)
    REFERENCES `mydb`.`Farmacia` (`idFarmacia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Medicamentos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicamentos` (
  `idMedicamento` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `presentacion` VARCHAR(45) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`idMedicamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Laboratorios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Laboratorios` (
  `cuitLab` INT NOT NULL,
  `razonSocial` VARCHAR(45) NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`cuitLab`),
  INDEX `fk_Laboratorios_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratorios_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- StockFarmacia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockFarmacia` (
  `idFarmacia` INT NOT NULL,
  `idMedicamento` INT NOT NULL,
  PRIMARY KEY (`idFarmacia`, `idMedicamento`),
  INDEX `fk_Farmacia_has_Medicamentos_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  INDEX `fk_Farmacia_has_Medicamentos_Farmacia1_idx` (`idFarmacia` ASC) VISIBLE,
  CONSTRAINT `fk_Farmacia_has_Medicamentos_Farmacia1`
    FOREIGN KEY (`idFarmacia`)
    REFERENCES `mydb`.`Farmacia` (`idFarmacia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Farmacia_has_Medicamentos_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LaboratorioComercializaMedicamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LaboratorioComercializaMedicamento` (
  `cuitLab` INT NOT NULL,
  `idMedicamento` INT NOT NULL,
  PRIMARY KEY (`cuitLab`, `idMedicamento`),
  INDEX `fk_Laboratorios_has_Medicamentos_Medicamentos1_idx` (`Medicamentos_idMedicamento` ASC) VISIBLE,
  INDEX `fk_Laboratorios_has_Medicamentos_Laboratorios1_idx` (`cuitLab` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratorios_has_Medicamentos_Laboratorios1`
    FOREIGN KEY (`cuitLab`)
    REFERENCES `mydb`.`Laboratorios` (`cuitLab`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Laboratorios_has_Medicamentos_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Depositos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Depositos` (
  `idDeposito` INT NOT NULL,
  PRIMARY KEY (`idDeposito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- StockDeposito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StockDeposito` (
  `idDeposito` INT NOT NULL,
  `idMedicamento` INT NOT NULL,
  PRIMARY KEY (`idDeposito`, `idMedicamento`),
  INDEX `fk_DepositoCentral_has_Medicamentos_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  INDEX `fk_DepositoCentral_has_Medicamentos_DepositoCentral1_idx` (`idDeposito` ASC) VISIBLE,
  CONSTRAINT `fk_DepositoCentral_has_Medicamentos_DepositoCentral1`
    FOREIGN KEY (`idDeposito`)
    REFERENCES `mydb`.`Depositos` (`idDeposito`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DepositoCentral_has_Medicamentos_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Transportitas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transportistas` (
  `cuitTransportista` INT NOT NULL,
  `razonSocial` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`cuitTransportista`),
  INDEX `fk_Transportistas_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Transportistas_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Ingresos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ingresos` (
  `idDeposito` INT NOT NULL,
  `cuitLab` INT NOT NULL,
  `idIngreso` INT NOT NULL,
  `fechaIngreso` DATE NULL,
  `estado` VARCHAR(45) NULL,
  `cuitTransportista` INT NOT NULL,
  PRIMARY KEY (`idIngreso`),
  INDEX `fk_DepositoCentral_has_Laboratorios_Laboratorios1_idx` (`cuitLab` ASC) VISIBLE,
  INDEX `fk_DepositoCentral_has_Laboratorios_DepositoCentral1_idx` (`idDeposito` ASC) VISIBLE,
  INDEX `fk_Ingresos_Transportistas1_idx` (`cuitTransportista` ASC) VISIBLE,
  CONSTRAINT `fk_DepositoCentral_has_Laboratorios_DepositoCentral1`
    FOREIGN KEY (`idDeposito`)
    REFERENCES `mydb`.`Depositos` (`idDeposito`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DepositoCentral_has_Laboratorios_Laboratorios1`
    FOREIGN KEY (`cuitLab`)
    REFERENCES `mydb`.`Laboratorios` (`cuitLab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingresos_Transportistas1`
    FOREIGN KEY (`cuitTransportista`)
    REFERENCES `mydb`.`Transportistas` (`cuitTransportista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- CiudadesTransportista
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CiudadesTransportista` (
  `cuitTransportista` INT NOT NULL,
  `codigoPostal` INT NOT NULL,
  PRIMARY KEY (`cuitTransportista`, `codigoPostal`),
  INDEX `fk_Transportistas_has_Ciudades_Ciudades1_idx` (`codigoPostal` ASC) VISIBLE,
  INDEX `fk_Transportistas_has_Ciudades_Transportistas1_idx` (`cuitTransportista` ASC) VISIBLE,
  CONSTRAINT `fk_Transportistas_has_Ciudades_Transportistas1`
    FOREIGN KEY (`cuitTransportista`)
    REFERENCES `mydb`.`Transportistas` (`cuitTransportista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Transportistas_has_Ciudades_Ciudades1`
    FOREIGN KEY (`codigoPostal`)
    REFERENCES `mydb`.`Ciudades` (`codigoPostal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Transferencias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transferencias` (
  `idFarmacia` INT NOT NULL,
  `idDeposito` INT NOT NULL,
  `idTransferencia` INT NOT NULL,
  `fecha` DATE NULL,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idTransferencia`),
  INDEX `fk_Farmacia_has_DepositoCentral_DepositoCentral1_idx` (`idDeposito` ASC) VISIBLE,
  INDEX `fk_Farmacia_has_DepositoCentral_Farmacia1_idx` (`idFarmacia` ASC) VISIBLE,
  CONSTRAINT `fk_Farmacia_has_DepositoCentral_Farmacia1`
    FOREIGN KEY (`idFarmacia`)
    REFERENCES `mydb`.`Farmacia` (`idFarmacia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Farmacia_has_DepositoCentral_DepositoCentral1`
    FOREIGN KEY (`idDeposito`)
    REFERENCES `mydb`.`Depositos` (`idDeposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LineaTransferencia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LineaTransferencia` (
  `idTransferencia` INT NOT NULL,
  `cantidadMedicamento` INT NULL,
  `idMedicamento` INT NOT NULL,
  PRIMARY KEY (`idTransferencia`, `idMedicamento`),
  INDEX `fk_LineaTransferencia_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Transferencias1`
    FOREIGN KEY (`idTransferencia`)
    REFERENCES `mydb`.`Transferencias` (`idTransferencia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LineaTransferencia_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- MonoDrogas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MonoDrogas` (
  `nombreCientifico` VARCHAR(45) NOT NULL,
  `nombreComercial` VARCHAR(45) NULL,
  PRIMARY KEY (`nombreCientifico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- AccionesTerapeuticas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AccionesTerapeuticas` (
  `nombre` VARCHAR(45) NOT NULL,
  `tiempoEfectoHoras` INT NOT NULL,
  PRIMARY KEY (`nombre`, `tiempoEfectoHoras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- MedicamentoTieneMD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MedicamentoTieneMD` (
  `idMedicamento` INT NOT NULL,
  `nombreCientifico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMedicamento`, `nombreCientifico`),
  INDEX `fk_Medicamentos_has_MonoDrogas_MonoDrogas1_idx` (`nombreCientifico` ASC) VISIBLE,
  INDEX `fk_Medicamentos_has_MonoDrogas_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  CONSTRAINT `fk_Medicamentos_has_MonoDrogas_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Medicamentos_has_MonoDrogas_MonoDrogas1`
    FOREIGN KEY (`nombreCientifico`)
    REFERENCES `mydb`.`MonoDrogas` (`nombreCientifico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- MedicamentoTieneAT
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MedicamentoTieneAT` (
  `Medicamentos_idMedicamento` INT NOT NULL,
  `AccionesTerapeuticas_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Medicamentos_idMedicamento`, `AccionesTerapeuticas_nombre`),
  INDEX `fk_Medicamentos_has_AccionesTerapeuticas_AccionesTerapeutic_idx` (`AccionesTerapeuticas_nombre` 
ASC) VISIBLE,
  INDEX `fk_Medicamentos_has_AccionesTerapeuticas_Medicamentos1_idx` (`Medicamentos_idMedicamento` ASC) 
VISIBLE,
  CONSTRAINT `fk_Medicamentos_has_AccionesTerapeuticas_Medicamentos1`
    FOREIGN KEY (`Medicamentos_idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Medicamentos_has_AccionesTerapeuticas_AccionesTerapeuticas1`
    FOREIGN KEY (`AccionesTerapeuticas_nombre`)
    REFERENCES `mydb`.`AccionesTerapeuticas` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
CONSTRAINT `fk_Medicamentos_has_AccionesTerapeuticas_AccionesTerapeuticas1`
    FOREIGN KEY (`tiempoEfectoHoras`)
    REFERENCES `mydb`.`AccionesTerapeuticas` (`tiempoEfectoHoras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;


-- -----------------------------------------------------
-- AfiliadoCronico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AfiliadoCronico` (
  `idAfiliado` INT NOT NULL,
  PRIMARY KEY (`idAfiliado`),
  CONSTRAINT `fk_AfiliadoCronico_Afiliados1`
    FOREIGN KEY (`idAfiliado`)
    REFERENCES `mydb`.`Afiliados` (`idAfiliado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Diagnosticos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnosticos` (
  `idDiagnostico` INT NOT NULL,
  `fecha` DATE NULL,
  `idAfiliado` INT NOT NULL,
  PRIMARY KEY (`idDiagnostico`, `idAfiliado`),
  INDEX `fk_Diagnosticos_AfiliadoCronico1_idx` (`idAfiliado` ASC) VISIBLE,
  CONSTRAINT `fk_Diagnosticos_AfiliadoCronico1`
    FOREIGN KEY (`idAfiliado`)
    REFERENCES `mydb`.`AfiliadoCronico` (`idAfiliado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Comprobantes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comprobantes` (
  `idFarmacia` INT NOT NULL,
  `idAfiliado` INT NOT NULL,
  `idComprobante` INT NOT NULL,
  `fecha` DATE NULL,
  INDEX `fk_Farmacia_has_Afiliados_Afiliados1_idx` (`idAfiliado` ASC) VISIBLE,
  INDEX `fk_Farmacia_has_Afiliados_Farmacia1_idx` (`idFarmacia` ASC) VISIBLE,
  PRIMARY KEY (`idComprobante`),
  CONSTRAINT `fk_Farmacia_has_Afiliados_Farmacia1`
    FOREIGN KEY (`idFarmacia`)
    REFERENCES `mydb`.`Farmacia` (`idFarmacia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Farmacia_has_Afiliados_Afiliados1`
    FOREIGN KEY (`idAfiliado`)
    REFERENCES `mydb`.`Afiliados` (`idAfiliado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LineaComprobante
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LineaComprobante` (
  `idMedicamento` INT NOT NULL,
  `idComprobante` INT NOT NULL,
  `cantidad` VARCHAR(45) NULL,
  `precioTotal` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedicamento`, `idComprobante`),
  INDEX `fk_Comprobante_has_Medicamentos_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  INDEX `fk_LineaComprobante_Comprobante1_idx` (`idComprobante` ASC) VISIBLE,
  CONSTRAINT `fk_Comprobante_has_Medicamentos_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LineaComprobante_Comprobante1`
    FOREIGN KEY (`idComprobante`)
    REFERENCES `mydb`.`Comprobantes` (`idComprobante`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LineaIngreso
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LineaIngreso` (
  `idMedicamento` INT NOT NULL,
  `idIngreso` INT NOT NULL,
  `cantidad` INT NULL,
  `precioTotal` INT NULL,
  PRIMARY KEY (`idMedicamento`, `idIngreso`),
  INDEX `fk_Medicamentos_has_Ingresos_Ingresos1_idx` (`idIngreso` ASC) VISIBLE,
  INDEX `fk_Medicamentos_has_Ingresos_Medicamentos1_idx` (`idMedicamento` ASC) VISIBLE,
  CONSTRAINT `fk_Medicamentos_has_Ingresos_Medicamentos1`
    FOREIGN KEY (`idMedicamento`)
    REFERENCES `mydb`.`Medicamentos` (`idMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medicamentos_has_Ingresos_Ingresos1`
    FOREIGN KEY (`idIngreso`)
    REFERENCES `mydb`.`Ingresos` (`idIngreso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

