<?php

require_once("../local/conf.php");
require_once("lib/anamoni.php");

pandora::header_json();

anamoni::
database();

$query = "SELECT * FROM `oura`" .
	" WHERE `ipiresia` = '" . $_REQUEST["ipiresia"] . "'" .
	" ORDER BY `kodikos`";

$result = pandora::query($query, MYSQLI_ASSOC);

print "[";
$ante = "";

while ($row = $result->fetch_array()) {
	print $ante;

	$ante = ",";

	print '{';
	print '"k":' . pandora::json_string($row['kodikos']) . ',';
	print '"p":' . pandora::json_string($row['perigrafi']) . ',';
	print '"i":' . pandora::json_string($row['info']);
	print '}';
}

print "]";

?>
