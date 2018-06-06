<?php
	require_once '../control/conexao.php';

	class UsuarioDAO{
		private $con;
		private $stm;

	function __construct(){
  		$o = new Conexao();
    	$this->con = $o->conectar();
    }

  	function inserir(Usuario $u){
     	$nome = $u->getNome();
     	$query = "insert into tbUsuario(nomeUsuario) values ('".$nome."'); UPDATE cadastro SET idUsuario = LAST_INSERT_ID() WHERE id = 1;";
    	$this->stm = $this->con->prepare($query);
    	$this->stm->execute();
    	header("Location:../view/principal.php");
    }
	}
?>