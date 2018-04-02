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
    	function buscaUltimo(){
    		$query = "SELECT tbUsuario.nomeUsuario,tbEvento.nomeEvento, listaPresensa.status, listaPresensa.horario FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento) ORDER BY horario DESC LIMIT 1";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados
    	}
    	function geraRelatorioGeral(){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario,tbEvento.nomeEvento FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento)ORDER BY tbEvento.nomeEvento ASC";
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados
    	}
    	function geraRelatorioPorEvento(idEvento){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario,tbEvento.nomeEvento FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento) WHERE listaPresensa.idEvento = ".$idEvento;
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados
    	}
    	function geraRelatorioPorUsuario(idUsuario){
    		$query = "SELECT DISTINCT tbUsuario.nomeUsuario,tbEvento.nomeEvento FROM ((listaPresensa INNER JOIN tbUsuario ON listaPresensa.idUsuario = tbUsuario.idUsuario) INNER JOIN tbEvento ON listaPresensa.idEvento = tbEvento.idEvento) WHERE tbUsuario.idUsuario = ".$idUsuario;
    		$busca = $this->con->query($query);
    		$dados = $busca->fetchAll(PDO::FETCH_ASSOC);
    		return $dados
    	}
	}
?>