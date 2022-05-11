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
					$dateIndex = date('Y-m-d', strtotime($Date . ' + 1 year'));

					while ($dateIndex < $end) {
						if ($stmt->execute()) {

							$result = $stmt->get_result();

							while (null !== ($row = $result->fetch_assoc())) {
								echo "<tr>";
								foreach ($flist as $fname) {
									echo "<td>" . $row[$fname->name] . "</td>";
								}
								echo "</tr>";
							}

							$result->free_result();
						} else {
							echo $dateIndex . " execute failed.<br>";
						}

						$dateIndex = date('Y-m-d', strtotime($Date . ' + 1 year'));
					}

					echo "</table>";
				} else {
					echo "No Species found";
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