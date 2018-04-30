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
<?php 
	
?>
<div class="divPrincipal">
	<table class="tabelarodape">
		<td><img src="logopti.png" width="120"></td>
		<td><img align=right src="logocipa.png" width="100"></td>
	</table>
		<div class="tituloP">
		<p>Exibição de entrada no evento</p>
	</div>
	<form action="" class="formulario">
		<select id="selecionarEvento" name="customers" focus>
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
		$(document).ready(function(){
			document.getElementById("selecionarEvento").focus();
  			$.ajax({
				url: "../control/cracha.php",
				dataType: 'html',
				data: {acao:1,idEvento: 0},
				type: "POST"
			});
		});
		$("#selecionarEvento").click(function(){
			if (intervalo != null){
				clearInterval(intervalo);
			}
			id = $( "#selecionarEvento" ).val();
			if (id === ""){
				$.ajax({
						url: "../control/cracha.php",
						dataType: 'html',
						data: {acao:1,idEvento: 0},
						type: "POST"
					});
				$( "#conteudo").html(function() {
					return "<p></p>";
				});
			}else{
				document.getElementById("selecionarEvento").blur();
				$.ajax({
					url: "../control/cracha.php",
					dataType: 'html',
					data: {acao:1,idEvento: id},
					type: "POST"
				});
				intervalo = setInterval(function(){ 
					$.ajax({
						url: "../control/listaPresensaControl.php",
						dataType: 'html',
						data: {acao: 1,idEvento: id},
						type: "POST",
						success: function(data){
							$('#conteudo').html("<b>Relatorio de entrada</b><br/><br/>"+data);
						},
						error: function(data){
							$('#conteudo').html(data);
						}
					});
				}, 200);
			};

		});
	</script>
</div>
<?php 
	include "rodape.php";
?>