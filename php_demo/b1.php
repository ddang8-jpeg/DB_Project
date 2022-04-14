<body>
<?php
        //open a connection to dbase server
	//this will require an updated conf.php with appropriate credentials
	include 'open.php';

        // prepare the query statement
        //we'll soon see how to upgrade our queries so they aren't plain strings
        $myQuery = "SELECT label, yval FROM datapoints3;";

        // execute it, and if non-empty result, output each row of result
        if ($result = mysqli_query($conn, $myQuery)){
            foreach($result as $row){
	        //to improve the look of the output, we could add html table
		//tags too, which would add border lines, center the values, etc.
	    	echo $row["label"]." ".$row["yval"]."<br>";
            }
        } 

        //close the connection opened by open.php since we no longer need access to dbase
        $conn->close();

?>
</body>