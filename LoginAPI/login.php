<?php

	include 'conn.php';

	
	$email = $_POST["email"];
	$password = $_POST["password"];

	$queryResult=$connect->query("SELECT * FROM users WHERE email='".$email."' AND password='".$password."'");


	$result=array();


	while ($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}

	echo json_encode($result);

?>