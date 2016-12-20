<?php
//Code written by JrMasterModelBuilder.

//This block helps prevent browser caching problems.
header("Cache-Control: no-cache");
header("Expires: -1");
header("Content-Type: text/plain");

//Get action variable.
$action = isset($_POST['ACTION']) ? $_POST['ACTION'] : "";

//Get current save data.
if($action == "GetUserInfo")
{
	//Get progress data if available.
	if(file_exists("savegame.txt"))
	{
		$level = file_get_contents("savegame.txt");
	}
	else
	{
		$level = "0";
	}
	echo "&login=1&guid=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX&level=".$level."&";
}
else if($action == "SaveLevel")
{
	echo "<RESPONSE STATUS=\"OK\"/>";
	//Get level variable.
	$level = $_POST['LEVEL'];
	$savestate = $level;
	//Write current level to file.
	$writefile = "savegame.txt";
	$fh=fopen($writefile, 'w');
	fwrite($fh, $savestate); 
	fclose($fh);
}
else
{
	echo "<RESPONSE STATUS=\"ERROR\">No script action passed in.</RESPONSE>";
}
?>