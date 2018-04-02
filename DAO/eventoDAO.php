<?php 
	require_once '../control/conexao.php';
	class EventoDao{
    private $con;
		private $stm;

		function __construct(){
    	$o = new Conexao();
      $this->con = $o->conectar();
    }

    function listaGeral(){
  		$query = "SELECT * from tbEvento";
      $busca = $this->con->query($query);
      $dados = $busca->fetchAll(PDO::FETCH_ASSOC);

      return $dados;
    }
  }
?>