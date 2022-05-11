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

	echo "<h2>Species Information</h2>";
	echo "Refuge Name: ";

	if (empty($var2)) {
		echo "empty <br><br>";
	} else {

		echo $var1 . "<br>";
		echo $var2 . "<br><br>";

		if ($var1 == 'Before') {
			$stmt = $conn->prepare("CALL ShowSpeciesDelistedBeforeDate(?)");
		} else {
			$stmt = $conn->prepare("CALL ShowSpeciesDelistedAfterDate(?)");
		}

		if ($stmt) {

			$stmt->bind_param("s", $var2);

			if ($stmt->execute()) {

				$result = $stmt->get_result();

				if (($result) && ($result->num_rows != 0)) {

					echo "<table border=\"1px solid black\">";

					echo "<tr>";
					$flist = $result->fetch_fields();
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
					echo "No refuge found";
				}
				$result->free_result();
			} else {

				echo "Execute failed.<br>";
			}

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