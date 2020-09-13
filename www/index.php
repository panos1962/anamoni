<?php

require_once("../local/conf.php");
require_once("lib/anamoni.php");

anamoni::
database();

pandora::
session_init()::
document_head([
	"title" => "Ουρές αναμονής",
	"css" => [
		"lib/anamoni",
		"main",
	],
])::
document_body();

konsola::
lista_ipiresion();

pandora::
document_close();

class Konsola {
	public static function lista_ipiresion() {
		$query = "SELECT DISTINCT(`ipiresia`) FROM `oura`" .
			" ORDER BY `ipiresia`";
		$result = pandora::query($query, MYSQLI_NUM);

?>
<div id="ipiresiaLista">
<?php
		while ($row = $result->fetch_array())
		self::ipiresia_print($row[0]);

?>
</div>
<?php
	}

	public static function ipiresia_print($ipiresia) {
?>
<div class="ipiresiaContainer">
<div class="ipiresia"><?php print $ipiresia; ?></div>
</div>
<?php
	}
}

?>
