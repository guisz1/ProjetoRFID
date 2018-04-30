-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Tempo de geração: 27/04/2018 às 11:10
-- Versão do servidor: 5.7.22-0ubuntu0.16.04.1
-- Versão do PHP: 7.0.28-0ubuntu0.16.04.1

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ativarEvento` (IN `evento` INT)  BEGIN
	DECLARE ide INT;
    	SET ide = evento;
	UPDATE tbEvento SET ativo = 1 WHERE idEvento = ide;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `eventoSelecionado` (IN `idEvento` INT)  BEGIN
	DECLARE idEve INT;
    SET idEve = idEvento;
    UPDATE idSelecionado SET idSelecionado = idEve where id = 1;
END$$

--
-- Funções
--
CREATE DEFINER=`root`@`localhost` FUNCTION `cartaouserId` (`cartao` VARCHAR(100)) RETURNS INT(11) BEGIN
    	DECLARE codigo INT;
        SET codigo = 0;
    	SELECT idUsuario INTO codigo FROM tbCartao WHERE codigoCartao
= cartao;
        RETURN codigo;
	END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `checkStatus` (`idUser` INT, `idEvent` INT) RETURNS VARCHAR(3) CHARSET utf8 BEGIN
	DECLARE stat VARCHAR(3);
    SELECT status INTO stat FROM listaPresensa WHERE idUsuario = idUser AND idEvento = idEvent AND horario = (SELECT MAX(horario) FROM listaPresensa WHERE idEvento= idEvent AND idUsuario = idUser);
    RETURN stat;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `ultimo` () RETURNS INT(11) BEGIN
	DECLARE idS INT;
    SELECT idSelecionado INTO idS FROM idSelecionado WHERE id = 1;
    RETURN idS;
END$$

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

CREATE TABLE `idSelecionado` (
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

CREATE TABLE `listaPresensa` (
  `idEvento` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `status` varchar(3) NOT NULL,
  `horario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `listaPresensa`
--

INSERT INTO `listaPresensa` (`idEvento`, `idUsuario`, `status`, `horario`) VALUES
(1, 1, 'IN', '2018-04-27 12:38:01'),
(1, 1, 'OUT', '2018-04-27 12:38:41'),
(1, 1, 'IN', '2018-04-27 12:38:49'),
(1, 1, 'OUT', '2018-04-27 12:38:52'),
(1, 1, 'IN', '2018-04-27 12:39:13'),
(1, 1, 'OUT', '2018-04-27 12:39:21'),
(2, 1, 'IN', '2018-04-27 13:13:34'),
(1, 1, 'IN', '2018-04-27 13:13:39'),
(2, 1, 'OUT', '2018-04-27 13:13:45'),
(1, 1, 'OUT', '2018-04-27 13:13:49'),
(2, 1, 'IN', '2018-04-27 13:15:02'),
(1, 1, 'IN', '2018-04-27 13:15:16'),
(1, 1, 'OUT', '2018-04-27 13:15:20'),
(1, 2, 'IN', '2018-04-27 13:15:36'),
(1, 1, 'IN', '2018-04-27 13:20:59'),
(1, 1, 'OUT', '2018-04-27 13:21:05'),
(2, 1, 'OUT', '2018-04-27 13:21:12'),
(1, 1, 'IN', '2018-04-27 13:28:59'),
(1, 1, 'OUT', '2018-04-27 13:29:03'),
(1, 1, 'IN', '2018-04-27 13:31:44');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbCartao`
--

CREATE TABLE `tbCartao` (
  `idCartao` int(11) NOT NULL,
  `codigoCartao` varchar(255) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tbEvento` (
  `idEvento` int(11) NOT NULL,
  `nomeEvento` varchar(100) NOT NULL,
  `dataEvento` date DEFAULT NULL,
  `ativo` int(11) NOT NULL,
  `inserido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tbEvento`
--

INSERT INTO `tbEvento` (`idEvento`, `nomeEvento`, `dataEvento`, `ativo`, `inserido`) VALUES
(1, 'SIPAT 2018', '2018-04-19', 1, 1),
(2, 'SIPAT 2020', '2018-04-26', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbUsuario`
--

CREATE TABLE `tbUsuario` (
  `idUsuario` int(11) NOT NULL,
  `nomeUsuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tbUsuario`
--

INSERT INTO `tbUsuario` (`idUsuario`, `nomeUsuario`) VALUES
(1, 'Guilherme Seibert'),
(2, 'Pedro Ivo Martins de Vasconcelos'),
(3, 'Lucas Brito'),
(5, 'Marcos Vinicius Alves Balsamo');

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `tbCartao`
--
ALTER TABLE `tbCartao`
  ADD PRIMARY KEY (`idCartao`),
  ADD UNIQUE KEY `codigoCartao` (`codigoCartao`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`);

--
-- Índices de tabela `tbEvento`
--
ALTER TABLE `tbEvento`
  ADD PRIMARY KEY (`idEvento`);

--
-- Índices de tabela `tbUsuario`
--
ALTER TABLE `tbUsuario`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `tbCartao`
--
ALTER TABLE `tbCartao`
  MODIFY `idCartao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de tabela `tbEvento`
--
ALTER TABLE `tbEvento`
  MODIFY `idEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de tabela `tbUsuario`
--
ALTER TABLE `tbUsuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
