<?php
	class Evento{
		private $nomeEvento;
		private $dataEvento;

		public function getNomeEvento(){
			return $this->nomeEvento;
		}

		public function setNomeEvento($nomeEvento){
			$this->nomeEvento = $nomeEvento;
		}

		public function getDataEvento(){
			return $this->dataEvento;
		}

		public function setDataEvento($dataEvento){
			$this->dataEvento = $dataEvento;
		}	
	}  
?>