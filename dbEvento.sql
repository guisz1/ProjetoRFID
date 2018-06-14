-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Tempo de geração: 07/06/2018 às 09:31
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
    DECLARE cadastro INT;
    SET cadastro = ultimoIdUsuario();
    SET idUsu = cartaouserId(codigoCartao);
    IF (cadastro != 0 AND idUsu = 0) THEN
    	INSERT INTO tbCartao(codigoCartao,idUsuario) values (codigoCartao,cadastro);
        SET idUsu = cartaouserId(codigoCartao);
    END IF;
    IF (idUsu != 0) THEN
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
    ELSEIF (idEven !=0) THEN
    SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO listaPresensa(idEvento,idUsuario,status,horario) VALUES (idEven,0,"NAO",CURRENT_TIMESTAMP);
    SET FOREIGN_KEY_CHECKS=1;
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

DROP FUNCTION IF EXISTS `ultimoIdUsuario`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ultimoIdUsuario` () RETURNS INT(11) BEGIN
	DECLARE idU INT;
    SELECT idUsuario INTO idU FROM cadastro WHERE id = 1;
    UPDATE cadastro SET idUsuario = 0 WHERE id = 1;
    RETURN idU;
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
-- Estrutura para tabela `cadastro`
--

DROP TABLE IF EXISTS `cadastro`;
CREATE TABLE `cadastro` (
  `id` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `cadastro`
--

INSERT INTO `cadastro` (`id`, `idUsuario`) VALUES
(1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `idSelecionado`
--

DROP TABLE IF EXISTS `idSelecionado`;
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

DROP TABLE IF EXISTS `listaPresensa`;
CREATE TABLE `listaPresensa` (
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
CREATE TABLE `tbCartao` (
  `idCartao` int(11) NOT NULL,
  `codigoCartao` varchar(255) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbEvento`
--

DROP TABLE IF EXISTS `tbEvento`;
CREATE TABLE `tbEvento` (
  `idEvento` int(11) NOT NULL,
  `nomeEvento` varchar(100) NOT NULL,
  `dataEvento` date DEFAULT NULL,
  `ativo` int(11) NOT NULL,
  `inserido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbUsuario`
--

DROP TABLE IF EXISTS `tbUsuario`;
CREATE TABLE `tbUsuario` (
  `idUsuario` int(11) NOT NULL,
  `nomeUsuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `listaPresensa`
--
ALTER TABLE `listaPresensa`
  ADD KEY `idEvento` (`idEvento`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idUsuario_2` (`idUsuario`),
  ADD KEY `idUsuario_3` (`idUsuario`);

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
  MODIFY `idCartao` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `tbEvento`
--
ALTER TABLE `tbEvento`
  MODIFY `idEvento` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de tabela `tbUsuario`
--
ALTER TABLE `tbUsuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `listaPresensa`
--
ALTER TABLE `listaPresensa`
  ADD CONSTRAINT `fk_id_evento` FOREIGN KEY (`idEvento`) REFERENCES `tbEvento` (`idEvento`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tbUsuario` (`idUsuario`);

--
-- Restrições para tabelas `tbCartao`
--
ALTER TABLE `tbCartao`
  ADD CONSTRAINT `fk_id_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tbUsuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
