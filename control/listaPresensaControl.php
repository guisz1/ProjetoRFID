<?php
	require_once '../DAO/listaPresensaDAO.php';
	class listaPresensaControl{
		private $dao;
		private $acao;


		function __construct(){
			$this->acao = $_REQUEST["acao"];
    		$this->dao = new listaDao();
    		$this->verificaAcao();
    	}

    	function verificaAcao(){
	    	switch ($this->acao) {
		    	case 1:
		          $this->buscaUltimo();
		        break;
	      	}
	    }

    	function buscaRelatorioPorEvento($idEvento){
    		$dados = $this->dao->geraRelatorioPorEvento($idEvento);
    		return $dados;
    	}

    	function buscaUltimo(){
    		$id = $_POST["idEvento"];
    		$dado = $this->dao->buscaUltimo($id);
    		$string = "Nome: ".$dado["nomeUsuario"]."<br>Status: ".$dado["status"];
    		echo $string;
    		return $string;
    	}
	}
	new listaPresensaControl();
?>