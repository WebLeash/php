<?php #this php block will be executed after the form below (see the '<div class="section3">' section) has been submitted
//$max = $_POST['MAX_FILE_SIZE'];


//$max= 150 * 1024; #size in Bytes, here max is 150 KBytes, works with hidden input field, see form below

//includes the external file that stores SCID number as keys with corresponding Broker ID number as values; key=>value
//include 'list.php'; 

$bu = $_POST['bu']; //collects and stores the input of the 'Mnemonic)' edit box
$dept = $_POST['dept']; //collects and stores the input of the 'System' drop down list
$owner = $_POST['owner']; //collects and stores the input of the 'Line of business' drop down list 
$type = $_POST['type']; //collects and stores the input of the 'User email' edit box
$country = $_POST['country']; //collects and stores the input of the 'SCID' edit box    //testing
$private = $_POST['private']; //collects and stores the input of the 'SCID' edit box    //testing
$multi = $_POST['multi']; //collects and stores the input of the 'SCID' edit box    //testing
$cn = $_POST['cn']; //collects and stores the input of the 'SCID' edit box    //testing
$san = $_POST['san']; //collects and stores the input of the 'SCID' edit box    //testing
$der = $_POST['der']; //collects and stores the input of the 'SCID' edit box    //testing
$pem = $_POST['pem']; //collects and stores the input of the 'SCID' edit box    //testing
$csr = $_POST['csr']; //collects and stores the input of the 'SCID' edit box    //testing
$base = $_POST['base']; //collects and stores the input of the 'SCID' edit box    //testing


function missingMandatoryData($a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k)
{
  if (($a == '') || ($b == '') || ($c == '') || ($d == '') || ($e == ' ') || ($f == ' ' ) || ($g == ' ') || ($h == ' ' ) || ($i == ' ' ) || ($j == ' ') ||( $k == ' ' ))  //if any of these variables is empty...
  {
    return false;
	
  }
    else 
    {
         return true;
   }
}


   
///////////////////////// Do the following on submit.. /////////////////////////

//'upload' - name of the submit button in the form, 
//'isset' — determines if a variable is set and is not NULL
if(missingMandatoryData($bu, $dept, $owner,$type, $countryi, $private, $multi, $cn, $san, $der, $pem))  
{


 $displayData = true;	//if all mandatory data is provided
 
//	shell_exec("/var/www/html/TCO_SOFTWARE/START.sh");
//	$output="Engine Results Below:";
}


?>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GCM (Venafi) Internal Certificate Request</title>

<link href="tcogen.css" rel="stylesheet" type="text/css">  
<style>
</style>
</head>

<body>
			

<!--
>>> HTML FORM  that allow users to choose the files they want to upload <<<<<<
1) Uses method="post"
2) The form attribute: enctype="multipart/form-data" specifies which content-type to use when submitting the form
3) The type="file" attribute of the <input> tag shows the input field as a file-select control, with a "browse" button next to the input control
This form sends data to a temoprary defautl directory on the server, and it then picke up and moved 
by the php code located in this file above <!doctype html> tag
-->
<!------------------------- START of the FORM  --------------------------->
<div class="container">
<h1>GCM (Venaif) Internal Certificate Request</h1>
<hr>


<form action="http://xps/index.php" > 

<h3>Confirmation; <?php  ?></h3>

<?php 
if($displayData) //if all mandatory data was provided
{
#echo $mainFile;

echo "BU = " . $bu;
echo "<br>";

echo "Dept = " . $dept; 
echo "<br>";

echo "owner = " . $owner; 
echo "<br>";

echo "type = " . $type ; 
echo "<br>";

echo "Country = " . $country;
echo "<br>";

echo "private = " . $private; 
echo "<br><br>";

echo "multu = " . $multi; 
echo "CN = " . $cn; 
echo "SAN = " . $san; 
echo "DER = " . $der; 
echo "pem = " . $pem; 
echo "csr = " . $csr; 
echo "base = " . $base; 
echo "<br><br>";
}
else
{
	if( $bu == '')
	{
		echo "missing data BU";
	}
}
?>


<hr>
<p>
<input type="submit" name="goback" value="Go back" >

</p>
</div>

</form> 

</body>
</html>

