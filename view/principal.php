<?php 
	include "cabecalho.php";
?>
<?php 
	require_once '../DAO/listaPresensa.php';
	$dao = new listaDao();
?>
<script type="text/javascript">
	function verificaBanco(){
		
	}
	setTimeout(verificaBanco,100);
</script>

<?php 
	echo "aguardando cartão RFID";
?>
<?php 
	include "rodape.php";
?>