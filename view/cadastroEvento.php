<?php 
	include "cabecalho.php";
?>
<?php 
	$data = date("Y-m-d");
?>
<div class="divPrincipal">
	<table class="tabelarodape">
		<td><img src="logopti.png" width="120"></td>
		<td><img align=right src="logocipa.png" width="100"></td>
	</table>
	<nav id="menu">
    	<ul>
        	<li><a href="principal.php">Home</a></li>
	    	<li><a href="cadastroEvento.php">Cadastro de Eventos</a></li>
			<li><a href="pedidoRelatorio.php">Relatorio de Eventos</a></li>
    	</ul>
	</nav>	
	<div class="divform">
		<form method="post" action="../control/eventoControl.php" class="formulario">
			<p class="pevento">Nome do evento</p><input type="text" name="nomeEvento" required><br>
			<p class="pevento">Data do evento</p><input type="date" name="dataEvento" min="<?php echo $data ?>" required><br>
			<input type="hidden" name="acao" value="1"><br>
			<input type="submit" value="Cadastrar">
		</form>
	</div>
</div>
<?php 
	include "rodape.php";
?>