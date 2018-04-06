<?php
	$idEvento = $_POST["evento"];
	if(is_null($idEvento)){
		header("Location: pedidoRelatorio.php");
	}
	$idEvento = intval($idEvento);
	require_once 'criaPDF.php';
	$pdf = new criaPDF();
	$pdf->fazer($idEvento);
?>