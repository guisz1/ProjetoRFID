<?php  
	require_once "../model/evento.php";
	require_once "../DAO/eventoDAO.php";
	class EventoControl{
		private $dao = null;
	    private $garcom = null;
	    private $acao = null;

	    function __construct(){
	      	$this->acao = $_REQUEST["acao"];
	      	$this->evento = new Evento();
	      	$this->dao = new EventoDao();
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
	    	$this->evento->setNomeEvento($_POST["nomeEvento"]);
	    	$this->evento->setDataEvento($_POST["dataEvento"]);
		    $this->dao->inserir($this->evento);
	    }
	}
	new EventoControl();
?>