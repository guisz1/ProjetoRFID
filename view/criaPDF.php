<?php  
	use Dompdf\Dompdf;
	require_once 'dompdf/autoload.inc.php';
	require_once '../control/listaPresensaControl.php';
	class criaPDF{
		function fazer($idEvento){
			$dompdf = new DOMPDF();
			$data=date('d/m/Y');
			$listaC = new listaPresensaControl();
			$dados = $listaC->buscaRelatorioPorEvento($idEvento);
			$html = '
			<style type="text/css">
			.tg  {border-collapse:collapse;border-spacing:0;align: center;}
			.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
			.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
			.tg .tg-ajwg{font-size:20px;background-color:#f8a102;border-color:inherit;text-align:center;vertical-align:top}
			.tg .tg-f47q{font-size:28px;background-color:#ffffc7;border-color:inherit;vertical-align:top}
			div {width: 100%;}
			.tabela {width: 100%; margin-bottom: 20px}
			</style>
			<table class="tabela">
				<tr>  
					<td align="left">Sistema de evento</td>  
					<td align="right">Gerado em: '.$data.'</td>  
				</tr>  
			</table>
			<div>
				<table class="tg" align=center width=80%>
				  <tr>
				    <th class="tg-ajwg" colspan="2">Relatório de evento</th>
				  </tr>
				  <tr>
				    <td class="tg-f47q" colspan="2" align="center">Participantes</td>
				  </tr>
				  ';
				foreach ($dados as $dado) {
					$html .='
					<tr>
					    <td class="tg-f47q" colspan="2" align="center">'.$dado["nomeUsuario"].'</td>
					</tr>';
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