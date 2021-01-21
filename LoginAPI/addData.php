<?php

	include 'conn.php';

	$email = $_POST['email'];
	$password = $_POST['password'];
	$usertype = $_POST['usertype'];

	$connect->query("INSERT INTO users (email,password,usertype) VALUES ('".$email."','".$password."','".$usertype."')")
	
?>
