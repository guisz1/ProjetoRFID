<?php 
	require_once '../control/cracha.php';
?>
<?php
	$cartao = $_REQUEST['cartao'];
	$cracha = new cracha();
	if ($cartao == null) {
		header("Location:principal.php");
	}
	$cracha->controlaPresensa($cartao);
?>
