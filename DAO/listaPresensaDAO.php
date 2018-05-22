<?php
	require_once '../control/conexao.php';
	class listaDao{
    	private $con;
		private $stm;

		function __construct(){
    		$o = new Conexao();
      		$this->con = $o->conectar();
    	}

    	function buscaGeral(){
    		$query = "SELECT tbUsuario.nomeUsuario,tbEvento.nomeEvento, listaPresensa.status, listaPresensa.horario FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento)";
      		$busca = $this->con->query($query);
      		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);

      		return $dados;
    	}
    	function buscaUltimo($idEvento){
    		$query = "SELECT tbUsuario.nomeUsuario AS nomeUsuario,tbEvento.nomeEvento AS nomeEvento, listaPresensa.status AS statuss, listaPresensa.horario AS horario FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento) WHERE tbEvento.idEvento = ".$idEvento." ORDER BY horario DESC LIMIT 1";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados;
    	}
    	function geraRelatorioGeral(){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario,tbEvento.nomeEvento FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento)ORDER BY tbEvento.nomeEvento ASC";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados;
    	}
    	function geraRelatorioPorEvento($idEvento){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario as nomeUsuario,tbEvento.nomeEvento as nomeEvento, date_format(tbEvento.dataEvento, '%d/%m/%Y') as data, MIN(date_format(listaPresensa.horario, '%d/%m/%Y %H:%i:%s')) as ent,MAX(date_format(listaPresensa.horario, '%d/%m/%Y %H:%i:%s')) as saida FROM listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario  INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento WHERE listaPresensa.idEvento = ".$idEvento." GROUP BY tbUsuario.nomeUsuario ORDER BY tbUsuario.nomeUsuario ASC  ";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados;
    	}
    	function geraRelatorioPorUsuario($idUsuario){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario,tbEvento.nomeEvento, date_format(tbEvento.dataEvento, '%d/%m/%Y') as data FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento) WHERE tbUsuario.idUsuario = ".$idUsuario."ORDER BY tbEvento.nomeEvento ASC";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados;
    	}

	}
?>