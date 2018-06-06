<?php
	require_once "../model/usuario.php";
	require_once "../DAO/usuarioDAO.php";
	class UsuarioControl{
		private $dao;
		private $usuario;
		private $acao;

		function __construct(){
	      	$this->acao = $_REQUEST["acao"];
	      	$this->usuario = new Usuario();
	      	$this->dao = new UsuarioDao();
	      	$this->verificaAcao();
	    }

	    function verificaAcao(){
	    	switch ($this->acao) {
		    	case 1:
		          $this->preparaCadastro();
		        break;
	      	}
	    }

	    function preparaCadastro(){
	    	$this->usuario->setNome($_POST["nome"]);
	    	$this->dao->inserir($this->usuario);
	    }
	}
	new UsuarioControl;
?>