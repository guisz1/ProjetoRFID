<?php
	require_once "../model/evento.php";
	require_once "../DAO/eventoDAO.php"; 
	class cracha{
		private $dao = null;
		private $acao = null;
		
		function __construct(){
	      	$this->acao = $_REQUEST["acao"];
	      	$this->dao = new EventoDao();
	      	$this->verificaAcao();
	    }

	    function verificaAcao(){
	    	switch ($this->acao) {
		    	case 1:
		          $this->preparaAtualizacao();
		        break;
	      	}
	    }
	    function preparaAtualizacao(){
	    	$id = $_POST["idEvento"];
		    $this->dao->setaId($id);
	    }
	    function controlaPresensa($cracha){
	    	$dados = $this->dao->pegaId();
	    	foreach ($dados as $dado) {
	    		$id = $dado['ultimo()'];
	    	}
	    	$this->dao->controlaPresensa($id,$cracha);	
	    }
	}

	new cracha();
?>