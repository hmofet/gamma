<html><body><?php

if (isset($_POST['csv'])){
	$content = $_POST['csv']; 
	$file = "eeg.csv"; 
	$file_to_save = fopen($file, 'a'); 
	fwrite($file_to_save, $content); 
	fclose($file_to_size);
	echo $_POST['csv'];
} else if (isset($_POST['mmse'])){
	$content = $_POST['mmse']; 
	$file = "mmse.csv"; 
	$file_to_save = fopen($file, 'a'); 
	fwrite($file_to_save, $content); 
	fclose($file_to_size);
	echo $_POST['mmse'];
}
?></body></html>