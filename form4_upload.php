<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TCO Generator</title>
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
This form sends data to a temoprary defautl directory on the server. The files are then picked up by the
second php page 'upload.php' and moved to their acctual descitaion /upload
-->
<!--^^^^^^^^^^^^^^^^^^^^^^ START of the FORM  ^^^^^^^^^^^^^^^^^^^^^^  -->
<div class="container">
<h1>TCO GENERATOR</h1>
<hr>

<form action="http://10.80.11.43/stuff/confirmation.php" method="post" enctype="multipart/form-data"> 

<!-- hidden input filed used to restrict max size of the file to be uploaded, 
see $max value in form4_upload.php -->
<input type="hidden" name="MAX_FILE_SIZE" value="2004800"> <!-- value 200 * 1024 = 204800 KB -->

<!------------------------------------------->
<!-- section of the form for selecting the 1st file -->
<label for="filename1"><b>Select ABIQ file  </b></label> <!-- 'for' attribute of the label takes the Id of the target element -->
<input type="file" name="filename1" id="filename1">
<br><br>

<!------------------------------------------->

<!-- section of the form for selecting the 2nd file-->
<label for="filename2"><b>Select Output file </b></label> <!-- 'for' attribute of the label takes the Id of the target element -->
<input type="file" name="filename2" id="filename2">
<br><br>
<hr>

<!------------------------------------------->

<!--user input for the broker's SCID number -->
<b>SCID</b> (defaults to S00007 if left empty) <input type="text" name="scid"><br> <br> 

<!------------------------------------------->

<!-- drop down list for the user to choose broker's system  -->
<b>System</b> (required)
<select name="sys"> 
  <option value=""></option> 
  <option value="PURE">Pure</option>
  <option value="M3">M3</option>
  <option value="AGGREGATOR">Aggregator</option>
</select><br><br>


<!-- drop down list for the user to choose line of business    -->
<b>Line of business</b> (required)
<select name="lob"> 
  <option value=""></option> 
  <option value="PC">PC</option> 
  <option value="CV">CV</option>
  <option value="HH">HH</option>
  <option value="MB">MB</option>
</select><br><br> 
  
<!-- user input for the user's email address   -->
<b>User email address</b> (required)
<input type="text" name="email"><br><br>

<!-- user input for the scheme mnemonic  -->
<b>Scheme mnemonic </b> (required)
<input type="text" name="mnemonic"><br><br>  

<hr>
<p>

<!-- submit - section of the form 
'value' - the button caption
'name' - name of the submit button-->
<input type="submit" name="upload" value="Quote Engine">

</p>

</form> 
</div>
<!--^^^^^^^^^^^^^^^^^^^^^^ END of the FORM  ^^^^^^^^^^^^^^^^^^^^^^  -->


</body>
</html>



