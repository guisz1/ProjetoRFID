<?php  
	use Dompdf\Dompdf;
	require_once 'dompdf/autoload.inc.php';
	require_once '../control/listaPresensaControl.php';
	class criaPDF{
		function fazer($idEvento){
			$dompdf = new DOMPDF();
			$listaC = new listaPresensaControl();
			$dados = $listaC->buscaRelatorioPorEvento($idEvento);
			$evento = $dados[0];
			$data = $evento["data"];
			$i = 0;
			$html = '
			<link rel="stylesheet" href="style.css" type="text/css"/>
			<table class="tabelarodape">
				<td><img class="imagemum" src="logopti.png"></td>
				<td class="tdrodape">Relatorio do evento '.$evento['nomeEvento'].' na data de '.$data.'</td>
				<td><img class="imagem" align=right src="logocipa.png"></td>
			</table>
			<div>
				<table class=tbconteudo>
				  <tr>
				    <td class=tdrconteudo>Participantes</td>
				    <td class=tddrconteudo>Assinatura</td>
				  </tr>
				  ';
				foreach ($dados as $dado) {
					$html .='
					<tr>
					    <td class=tdconteudo>'.$dado["nomeUsuario"].'</td>
					    <td class=tddconteudo></td
					</tr>';
					$evento = $dado["nomeEvento"];
				}
				  $html .='
				</table>
			<div>
			';
			$dompdf->load_html($html);

			$dompdf->render();

			$dompdf->set_base_path('style.css');

			$dompdf->stream("relatorio.pdf",
				array(
					"Attachment" => false
				)
			);	
		}
	}
?>