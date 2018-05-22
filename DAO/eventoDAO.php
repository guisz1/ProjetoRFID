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
  		$query = "SELECT * from tbEvento where ativo = 1 and inserido = 1";
      $busca = $this->con->query($query);
      $dados = $busca->fetchAll(PDO::FETCH_ASSOC);

      return $dados;
    }
    function listaGeralf(){
      $data = date("Y-m-d");
      $query = "SELECT idEvento,nomeEvento,date_format(dataEvento, '%d/%m/%Y') as dataEvento from tbEvento";
      $busca = $this->con->query($query);
      $dados = $busca->fetchAll(PDO::FETCH_ASSOC);

      return $dados;
    }

    function inserir(Evento $e){
      $nome = $e->getNomeEvento();
      $data = $e->getDataEvento();
      $query = "insert into tbEvento(nomeEvento,dataEvento,ativo,inserido) values ('".$nome."','".$data."','0','0');";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute();
      header("Location:../view/principal.php");

    }

    function ativar($id){
      $query = "CALL ativarEvento(".$id.");";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute();
    }

    function setaId($id){
      $query = "CALL eventoSelecionado(".$id.");";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute();
      $query = "CALL ativarEvento(".$id.");";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute();
    }
    function pegaId(){
      $query = "SELECT ultimo();";
      $busca = $this->con->query($query);
      $dado = $busca->fetchALL(PDO::FETCH_ASSOC);

      return $dado;
    }
    function controlaPresensa($idEvento,$cartao){
      $query = "CALL controlaPresensa('".$idEvento."','".$cartao."');";
      $this->stm = $this->con->prepare($query);
      $this->stm->execute(); 
    }
  }
?>