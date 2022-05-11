<head>
	<title></title>
</head>

<body>
	<?php
	include 'open.php';

	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', true);

	$var1 = $_POST['var1'];
	$var2 = $_POST['var2'];
	$dateIndex = $var1 . "-01-01";
	$end = $var2 . "-01-01";

	echo "<h2>Species Information</h2>";
	echo "Refuge Name: ";

	if (empty($var2)) {
		echo "empty <br><br>";
	} else {

		echo $dateIndex . "<br>";
		echo $end . "<br><br>";

		if ($stmt = $conn->prepare("CALL ShowListedSpeciesCountDateRange(?)")) {

			$stmt->bind_param('s', $dateIndex);

			if ($stmt->execute()) {

				$result = $stmt->get_result();

				if (($result) && ($result->num_rows != 0)) {

					echo "<table border=\"1px solid black\">";

					echo "<tr>";
					echo "<th>Year</th>";
					echo "<th>Count</th>";
					echo "</tr>";

					$row = $result->fetch_row();
					echo "<td>" . $var1 . "</td>";
					echo "<td>" . $row[0] . "</td>";
					$dateIndex = date('Y-m-d', strtotime($dateIndex . ' + 1 year'));

					$var1++;
					$dateIndex = $var1 . "-01-01";

					$result->free_result();
				} else {
					echo "No Species found";
				}
			} else {

				echo "Execute failed.<br>";
			}

			//	while ($dateIndex < $end) {
			if ($stmt->execute()) {

				$result = $stmt->get_result();

				if (($result) && ($result->num_rows != 0)) {
					$row = $result->fetch_row();
					echo "<td>" . $var1 . "</td>";
					echo "<td>" . $row[0] . "</td>";
				} else {
					echo "<td>" . $var1 . "</td>";
					echo "<td>0</td>";
				}

				$result->free_result();
				$var1++;
				$dateIndex = $var1 . "-01-01";
			} else {
				echo $dateIndex . " execute failed.<br>";
			}
			//	}




			echo "</table>";


			$stmt->close();
		} else {

			echo "Prepare failed.<br>";
			$error = $conn->errno . ' ' . $conn->error;
			echo $error;
		}
	}

	$conn->close();
	?>
</body>