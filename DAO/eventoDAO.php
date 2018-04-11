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
  		$query = "SELECT * from tbEvento where ativo = 1";
      $busca = $this->con->query($query);
      $dados = $busca->fetchAll(PDO::FETCH_ASSOC);

      return $dados;
    }

    function inserir(Evento $e){
      $nome = $e->getNomeEvento();
      $data = $e->getDataEvento();
      $query = "insert into tbEvento(nomeEvento,dataEvento,ativo) values ('".$nome."','".$data."','0');";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute();

      header("Location:../view/principal.php");

    }
  }
?>