<head><title>c1: displaying bid history</title></head>
<body>
<?php

	//open a connection to dbase server 
	include 'open.php';

	// collect the posted value in a variable called $item
	$item = $_POST['item'];

        echo "<h2>Bid History</h2><br>";
	echo "Item number: ";

	if (!empty($item)) {
	   echo $item;
	   echo "<br><br>";

       if ($result = $conn->query("CALL ShowBidHistory('".$item."');")) {
 
       echo "<table border=\"2px solid black\">";
       echo "<tr><td>buyerNum</td><td>bidTime</td><td>amount</td></tr>";
          foreach($result as $row){
             echo "<tr>";
             echo "<td>".$row["buyerNum"]."</td>";
             echo "<td>".$row["bidTime"]."</td>";
             echo "<td>".$row["amount"]."</td>";
             echo "</tr>";
          }
	      echo "</table>";
       } else {
          echo "Call to ShowBidHistory failed<br>";
       }
	} else {
	   echo "not set";
	}
	$conn->close();

?>
</body>
