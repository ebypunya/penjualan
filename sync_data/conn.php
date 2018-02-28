<?php
	$host = "localhost";
	$user = "root";
	$pass = "";
	$db = "pmc";


	$conn = mysql_connect($host, $user, $pass) or die("Tidak terkoneksi ke servera!");
	if ($conn) {
		$dbselect = mysql_select_db($db, $conn) or die("Tidak terhubung ke Databasea.");
	}

?>