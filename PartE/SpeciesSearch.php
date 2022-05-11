<head>
	<title></title>
</head>

<body>
	<?php
	include 'open.php';

	//Override the PHP configuration file to display all errors
	//This is useful during development but generally disabled before release
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', true);

	$var = $_POST['var'];

	echo "<h2>Species Information</h2>";
	echo "Species ID: ";

	if (empty($var)) {
		echo "empty <br><br>";
	} else {

		echo $var . "<br><br>";

		if ($stmt = $conn->prepare("CALL FindSpeciesName(?)")) {

			$stmt->bind_param("s", $var);

			if ($stmt->execute()) {

				$result = $stmt->get_result();

				if (($result) && ($result->num_rows != 0)) {

					echo "<table border=\"1px solid black\">";

					echo "<tr>";
					// collect an array holding all attribute names in $result
					$flist = $result->fetch_fields();
					// output the name of each attribute in flist
					foreach ($flist as $fname) {
						echo "<th>" . $fname->name . "</th>";
					}
					echo "</tr>";



					$col = $result->field_count;

					while (null !== ($row = $result->fetch_assoc())) {
						echo "<tr>";
						foreach ($flist as $fname) {
							echo "<td>" . $row[$fname->name] . "</td>";
						}
						echo "</tr>";
					}

					echo "</table>";
				} else {
					echo "No species found";
				}
				$result->free_result();
			} else {

				//Call to execute failed, e.g. because server is no longer reachable,
				//or because supplied values are of the wrong type
				echo "Execute failed.<br>";
			}

			//Close down the prepared statement
			$stmt->close();
		} else {

			//A problem occurred when preparing the statement; check for syntax errors
			//and misspelled attribute names in the statement string.
			echo "Prepare failed.<br>";
			$error = $conn->errno . ' ' . $conn->error;
			echo $error;
		}
	}

	//Close the connection created in open.php
	$conn->close();
	?>
</body>