<?php 
	include 'cabecalho.php';
	require_once '../DAO/listaPresensaDAO.php';
?>
<?php 
	$dao = new listaDao();
	$idEvento = $_POST["evento"];
	$dados=$dao->geraRelatorioPorEvento($idEvento);
	ob_start();
	$html = ob_get_clean();
	$html = utf8_encode($html);
	$html .= '<style type="text/css">
	.tg  {border-collapse:collapse;border-spacing:0;}
	.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
	.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
	.tg .tg-se7b{background-color:#f8a102;border-color:inherit;text-align:center;vertical-align:top}
	.tg .tg-kjho{background-color:#ffffc7;vertical-align:top}
	</style>
	<table class="tg">
  	<tr>
    	<th class="tg-se7b" colspan="2">Relatório de evento</th>
  	</tr>
  	<tr>
    	<td class="tg-kjho">Participante</td>
    	<td class="tg-kjho">Nome do Evento</td>
  	</tr>';
	foreach ($dados as $dado) {
		$html .= "<tr>";
		$html .= '<td class="tg-kjho">'.$dado["nomeUsuario"]."</td>";
		$html .= '<td class="tg-kjho">'.$dado["nomeEvento"]."</td>";
		$html .= "</tr>";
		$evento = $dado["nomeEvento"];
	}
	$html .= "</table>";

	include 'MPDF/mpdf.php';

	$mpdf = new mPDF();

	$mpdf->allow_charset_conversion = true;

	$mpdf->charset_in = 'UTF-8';

	$mpdf->WriteHTML($html);

	$mpdf->Output('relatorio_'.$evento.'.pdf','I');

	exit();
?>

<?php 
	include 'rodape.php';
?>