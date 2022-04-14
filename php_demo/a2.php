<head><title>a2: collecting a value</title></head>
<body>
<?php
	echo "<h2>a2 Results Page</h2>";
	echo "<br>";

	// collect the posted value in a variable called $IDNum
	$IDNum = $_POST['IDNum'];
	echo "The ID Num collected from the form was ";
	if (!empty($IDNum)) {
	   echo $IDNum;
	} else {
	   echo "not set";
	}
	echo ".<br>";
?>
</body>
