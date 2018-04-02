<?php

class Conexao{
	private $con;
	function  conectar(){
		$retorno = null;
		try{
			$usuario = "root";
			$senha = "Lasse@123";
			$this->con = new PDO("mysql:host=localhost; dbname=dbEvento",$usuario,$senha);
			$this->con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$retorno= $this->con;
		}catch(PDOException $e){
			echo $e->getMessage();
     	}
		return $retorno;
	}
}
?>
