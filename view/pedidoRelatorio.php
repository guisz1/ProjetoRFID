<?php 
    include 'cabecalho.php';
?>
<?php 
    require_once '../DAO/eventoDAO.php';
    $dao = new EventoDao();
?>
    <?php 
        $eventos = $dao->listaGeral();
    ?>
    <form method="post" action="../view/geraRelatorio.php">
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
<?php 
    include 'rodape.php';
?>