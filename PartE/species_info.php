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

	$id = $_POST['id'];

	echo "<h2>Species Information</h2>";
	echo "Species ID: ";

	if (empty($id)) {
		echo "empty <br><br>";
	} else {

		echo $id . "<br><br>";

		if ($stmt = $conn->prepare(
			"SELECT * ".
			"FROM Species ".
			"WHERE species_id = ? ;"
			)) {

			$stmt->bind_param("s", $id);

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


					$row = $result->fetch_row();
					for ($i = 0; $i < 8; $i++) {
						echo "<td>" . $row[$i] . "</td>";
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
