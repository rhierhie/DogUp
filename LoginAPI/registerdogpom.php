<?php

	include 'conn.php';
	
	
	$color = $_POST['color'];
	$height = $_POST['height'];
	$weight = $_POST['weight'];
	$dogtype = $_POST['dogtype'];

	$connect->query("INSERT INTO pometable (color,height,weight,dogtype) VALUES ('".$color."','".$height."','".$weight."','".$dogtype."')")
?>
