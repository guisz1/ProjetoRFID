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
	<div class="divmenu">
		<nav id="menu">
		    <ul>
		        <li><a href="principal.php">Home</a></li>
			    <li><a href="cadastroEvento.php">Cadastro de Eventos</a></li>
				<li><a href="pedidoRelatorio.php">Relatorio de Eventos</a></li>
		    </ul>
		</nav>
	</div>
	<div class="tituloP">
		<p>Exibição de entrada no evento</p>
	</div>
	<form action="" class="formulario">
		<select id="selecionarEvento" name="customers">
			<option value=""></option>
			<?php
	            foreach ($eventos as $evento){
	                echo utf8_encode("<option value=".$evento["idEvento"].">COD: ".$evento["idEvento"]." | ".$evento["nomeEvento"]." | Data: ".$evento["dataEvento"]."</option>");
	            }
	        ?>
		</select>	
	</form>
	<div id="conteudo" class="conteudo">
	</div>
	<script>
		var id = null;
		var intervalo = null;
		$("#selecionarEvento").click(function(){
			if (intervalo != null){
				clearInterval(intervalo);
			}
			id = $( "#selecionarEvento" ).val();
			if (id === ""){
				$( "#conteudo").html(function() {
					return "<p></p>";
				});
			}else{
				$( "#conteudo").html(function() {
					intervalo = setInterval(function(){ 
						$.ajax({
							url: "../listaPresensaControl.php",
							dataType: 'html',
							data: {acao: 1,idEvento: id},
							type: "POST",
							succes: function(data){
								$('#conteudo').html('<b>Resultado da busca</b><br /><br/>'+data);
							},
							error: function(data){
								$('#conteudo').html(data);
							}
						});
					}, 200);
				});
			};

		});
	</script>
</div>
<?php 
	include "rodape.php";
?>