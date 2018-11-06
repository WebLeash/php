<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GCM (Venafi) Internal Certificate</title>
<link href="tcogen.css" rel="stylesheet" type="text/css">  
<style>
</style>
</head>

<body>
	
<div class="container">
<h1>GCM (Venafi) Internal Certificate Request</h1>
<hr>

<form action="http://xps/cgi-bin/confirmation.php" method="post" enctype="multipart/form-data"> 

<input type="hidden" name="MAX_FILE_SIZE" value="2004800"> <!-- value 200 * 1024 = 204800 KB -->



<b>BU</b> <input type="text" name="bu"><br> <br> 
<b>Department</b> <input type="text" name="dept"><br> <br> 
<b>Certificate Owners</b> <input type="text" name="owner"><br> <br> 


<b>Certificate Request</b> 
<select name="type"> 
  <option value=""></option> 
  <option value="single">Single</option>
  <option value="bulk">Bulk</option>
</select><br><br>


<b>Reporting Country</b> <input type="text" name="country"><br> <br> 

<form action="/confirmation.php" method="get">
  <input type="checkbox" name="private" value="private_ssl">Private (Internal) SSL Certificate<br>
  <input type="checkbox" name="multi" value="multi">Multi-Domain (UUC) SSL Certificate<br>

<b>Common Name (CN)</b> <input type="text" name="cn"><br> <br> 
<b>Subject Alternative Names (SANs)</b> <input type="text" name="san"><br>
 <br> 

  <input type="checkbox" name="der" value="der">DER - binary format<br>
  <input type="checkbox" name="pem" value="pem">PEM - Base64<br>

<h2>Certificate Submittal and Issuance</h1>
  <input type="checkbox" name="csr" value="csr">I will generate CSR<br>
  <input type="checkbox" name="base" value="base">CSR form me<br>
<p>

<label for="filename2"><b>Select File </b></label> <!-- 'for' attribute of the label takes the Id of the target element -->
<input type="file" name="filename2" id="filename2">
<br><br>
<hr>

<input type="submit" name="upload" value="Submit Request">
</form>
</p>

</form> 
</div>

<br><br>

</body>
</html>



