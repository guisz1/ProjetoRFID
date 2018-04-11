<?php 
    include 'cabecalho.php';
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
<?php 
    require_once '../DAO/eventoDAO.php';
    $dao = new EventoDao();
?>
    <?php 
        $eventos = $dao->listaGeral();
    ?>
    <div class="divform">
    <form method="post" action="../view/geraRelatorio.php" class="formulario">
        <select name="evento" required>
        <option></option>
        <?php
            foreach ($eventos as $evento){
                echo utf8_encode("<option value=".$evento["idEvento"].">".$evento["nomeEvento"]."</option>");
            }
        ?>
        </select><br>
        <button type="submit">Gerar Relatorio</button>  
    </form>
    </div>
</div>
<?php 
    include 'rodape.php';
?>
