-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Tempo de geração: 22/05/2018 às 09:41
-- Versão do servidor: 5.7.22-0ubuntu0.16.04.1
-- Versão do PHP: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbEvento`
--

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `ativarEvento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ativarEvento` (IN `evento` INT)  BEGIN
	DECLARE ide INT;
    	SET ide = evento;
	UPDATE tbEvento SET ativo = 1 WHERE idEvento = ide;
END$$

DROP PROCEDURE IF EXISTS `controlaPresensa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `controlaPresensa` (IN `idEven` INT, IN `codigoCartao` VARCHAR(100))  BEGIN
	DECLARE idUsu INT;
	DECLARE stat BOOLEAN;
   	DECLARE statD VARCHAR(3);
    DECLARE ativa INT;
    SET idUsu = cartaouserId(codigoCartao);
    SET stat = verificaEntrada(idUsu,idEven);
    SELECT ativo INTO ativa FROM tbEvento WHERE idEvento = idEven;
    IF  (stat = TRUE  AND idUsu != 0) THEN
    	SET statD  = checkStatus(idUsu,idEven);
    END IF;
    IF (stat = FALSE AND ativa = 1 AND idUsu != 0) THEN
   		INSERT INTO listaPresensa(idEvento,idUsuario,status,horario) VALUES (idEven,idUsu,"IN",CURRENT_TIMESTAMP);
        
        UPDATE tbEvento SET inserido = 1 WHERE idEvento = idEven;
    END IF;
    IF (statD = "IN" AND ativa = 1 AND idUsu != 0) THEN
    	INSERT INTO listaPresensa(idEvento,idUsuario,status,horario) VALUES (idEven,idUsu,"OUT",CURRENT_TIMESTAMP);
    END IF;
    IF (statD = "OUT" AND ativa = 1 AND idUsu != 0) THEN
    	 INSERT INTO listaPresensa(idEvento,idUsuario,status,horario) VALUES (idEven,idUsu,"IN",CURRENT_TIMESTAMP);
    END IF;
END$$

DROP PROCEDURE IF EXISTS `eventoSelecionado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eventoSelecionado` (IN `idEvento` INT)  BEGIN
	DECLARE idEve INT;
    SET idEve = idEvento;
    UPDATE idSelecionado SET idSelecionado = idEve where id = 1;
END$$

--
-- Funções
--
DROP FUNCTION IF EXISTS `cartaouserId`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `cartaouserId` (`cartao` VARCHAR(100)) RETURNS INT(11) BEGIN
    	DECLARE codigo INT;
        SET codigo = 0;
    	SELECT idUsuario INTO codigo FROM tbCartao WHERE codigoCartao
= cartao;
        RETURN codigo;
	END$$

DROP FUNCTION IF EXISTS `checkStatus`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `checkStatus` (`idUser` INT, `idEvent` INT) RETURNS VARCHAR(3) CHARSET utf8 BEGIN
	DECLARE stat VARCHAR(3);
    SELECT status INTO stat FROM listaPresensa WHERE idUsuario = idUser AND idEvento = idEvent AND horario = (SELECT MAX(horario) FROM listaPresensa WHERE idEvento= idEvent AND idUsuario = idUser);
    RETURN stat;
END$$

DROP FUNCTION IF EXISTS `ultimo`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ultimo` () RETURNS INT(11) BEGIN
	DECLARE idS INT;
    SELECT idSelecionado INTO idS FROM idSelecionado WHERE id = 1;
    RETURN idS;
END$$

DROP FUNCTION IF EXISTS `verificaEntrada`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `verificaEntrada` (`idUser` INT, `idEvent` INT) RETURNS TINYINT(1) BEGIN
    DECLARE stat INT;
    DECLARE evento INT;
    DECLARE usuario INT;
    SET evento = idEvent;
    SET usuario = idUser;
    SELECT COUNT(0) INTO stat FROM listaPresensa WHERE idEvento = evento AND idUsuario = usuario;
	IF (stat > 0) THEN
    	RETURN TRUE;
    ELSE
    	RETURN FALSE;
    END IF;
END$$

DROP FUNCTION IF EXISTS `verificaExistencia`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `verificaExistencia` (`evento` INT) RETURNS TINYINT(4) BEGIN
	DECLARE verifica INT;
    SELECT idEvento INTO verifica FROM tbEvento WHERE idEvento = evento;
    IF verifica <> 0 THEN
    	RETURN TRUE;
    ELSE
    	RETURN FALSE;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `idSelecionado`
--

DROP TABLE IF EXISTS `idSelecionado`;
CREATE TABLE IF NOT EXISTS `idSelecionado` (
  `id` int(11) NOT NULL,
  `idSelecionado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `idSelecionado`
--

INSERT INTO `idSelecionado` (`id`, `idSelecionado`) VALUES
(1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `listaPresensa`
--

DROP TABLE IF EXISTS `listaPresensa`;
CREATE TABLE IF NOT EXISTS `listaPresensa` (
  `idEvento` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `status` varchar(3) NOT NULL,
  `horario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbCartao`
--

DROP TABLE IF EXISTS `tbCartao`;
CREATE TABLE IF NOT EXISTS `tbCartao` (
  `idCartao` int(11) NOT NULL AUTO_INCREMENT,
  `codigoCartao` varchar(255) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idCartao`),
  UNIQUE KEY `codigoCartao` (`codigoCartao`),
  UNIQUE KEY `idUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tbCartao`
--

INSERT INTO `tbCartao` (`idCartao`, `codigoCartao`, `idUsuario`) VALUES
(1, '5EE8511B', 1),
(2, 'FE93591B', 2),
(3, '6CA33E72', 3),
(4, '5C5F4D72', 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbEvento`
--

DROP TABLE IF EXISTS `tbEvento`;
CREATE TABLE IF NOT EXISTS `tbEvento` (
  `idEvento` int(11) NOT NULL AUTO_INCREMENT,
  `nomeEvento` varchar(100) NOT NULL,
  `dataEvento` date DEFAULT NULL,
  `ativo` int(11) NOT NULL,
  `inserido` int(11) NOT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tbEvento`
--

INSERT INTO `tbEvento` (`idEvento`, `nomeEvento`, `dataEvento`, `ativo`, `inserido`) VALUES
(3, 'SIPAT 2018', '2018-05-22', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbUsuario`
--

DROP TABLE IF EXISTS `tbUsuario`;
CREATE TABLE IF NOT EXISTS `tbUsuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nomeUsuario` varchar(100) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tbUsuario`
--

INSERT INTO `tbUsuario` (`idUsuario`, `nomeUsuario`) VALUES
(1, 'Guilherme Seibert'),
(2, 'Pedro Ivo Martins de Vasconcelos'),
(3, 'Lucas Brito'),
(5, 'Marcos Vinicius Alves Balsamo');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
