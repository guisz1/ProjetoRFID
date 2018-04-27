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
    		$dados = $this->dao->buscaUltimo($id);
    		foreach ($dados as $dado) {
    			$result = "Nome: ".$dado["nomeUsuario"]."<br>Status: ".$dado["statuss"];
    		}
            echo $result;
    		
    	}
	}
	new listaPresensaControl();
?>