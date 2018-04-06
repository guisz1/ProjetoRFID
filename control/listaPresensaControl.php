<?php
	require_once '../DAO/listaPresensaDAO.php';
	class listaPresensaControl{
		private $dao;

		function __construct(){
    		$this->dao = new listaDao();
    	}

    	function buscaRelatorioPorEvento($idEvento){
    		$dados = $this->dao->geraRelatorioPorEvento($idEvento);
    		return $dados;
    	}

	}
	new listaPresensaControl();
?>