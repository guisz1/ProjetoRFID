<?php 
	require_once 'cabecalho.php';
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
        <li><a href="cadastro.php">Cadastro de Usuarios</a></li>
    </ul>
    </nav>
    <div class="divform">
		<form method="post" action="../control/usuarioControl.php" class="formulario">
			<p class="pevento">Nome Completo</p><input type="text" style="width: 55%;" name="nome" required><br>
			<input type="hidden" name="acao" value="1"><br>
			<input type="submit" value="Cadastrar">
		</form>
	</div>
</div>
<?php
	require_once 'rodape.php';
?>