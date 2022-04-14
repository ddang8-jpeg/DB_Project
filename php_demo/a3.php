<head><title>a3: Using a loop to produce data and display it in a table
</title></head>
<body>
<?php

	echo "<h2>a3 Results Page</h2><br>";
	echo "<table border=\"1px solid black\">";

	// Within html table, tr is table row, th is table header,
	// and td is table data
	echo "<tr><th> Count </th> <th> Value </th></tr>";
	$count = 1;
	do {
	   echo "<tr><td>";
	   echo $count."</td>";  //dot in php means string concatenation
	   $value = 2 * $count + 5;
	   echo "<td>".$value;
	   $count = $count + 1;
	   echo "</td></tr>";
	} while ($count <= 4);
	echo "</table>";
?>
</body>
