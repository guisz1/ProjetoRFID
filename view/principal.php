<?php 
	include "cabecalho.php";
?>
<?php 
	require_once '../DAO/eventoDAO.php';
	$dao = new EventoDao();
?>
<?php 
	 $eventos = $dao->listaGeralf();
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
	<form action="" class="formulario">
		<select id="selecionarEvento" name="customers" onclick="mostraEvento()">
			<option value=""></option>
			<?php
	            foreach ($eventos as $evento){
	                echo utf8_encode("<option value=".$evento["idEvento"].">".$evento["nomeEvento"]." ".$evento["dataEvento"]."</option>");
	            }
	        ?>
		</select>	
	</form>
	<div id="conteudo" class="conteudo">
		
	</div>
</div>

<script type="text/javascript">
	function mostraEvento() {
		var id = document.getElementById('selecionarEvento').value;
		var conteudo = document.getElementById('conteudo');
		if (id === "") {
			conteudo.innerHTML = "";
		}else{
			conteudo.innerHTML = id;
		}
	}
</script>
<?php 
	include "rodape.php";
?>