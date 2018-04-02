<?php 
	include 'cabecalho.php';
?>
<?php 
	require_once '../DAO/listaPresensa.php';
	$dao = new listaDao();
	$idEvento = $_POST["evento"];
	$dados=$dao->geraRelatorioPorEvento($idEvento);
?>

<?php 
	include 'rodape.php';
?>