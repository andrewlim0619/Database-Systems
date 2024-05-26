<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';
// Get Customer Number
$id = $_GET['id'];
if ($id === "") {
    header('location: list_customers.php');
    exit();
}
if ($id === false) {
    header('location: list_customers.php');
    exit();
}
if ($id === null) {
    header('location: list_customers.php');
    exit();
}
?>
<html>
<head>
    <title>Sample PHP Database Program</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
<?php
require_once 'header.inc.php';
?>
<div>
    <h2>Update Customer</h2>
    <?php

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

	// Check the Request is an Update from User -- Submitted via Form
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $customerName = $_POST['customerName'];
        if ($customerName === null)
            echo "<div><i>Specify a new name</i></div>";
        else if ($customerName === false)
            echo "<div><i>Specify a new name</i></div>";
        else if (trim($customerName) === "")
            echo "<div><i>Specify a new name</i></div>";
        else {
			
            /* perform update using safe parameterized sql */
            $sql = "UPDATE customer SET CustomerName = ? WHERE CustomerNumber = ?";
            $stmt = $conn->stmt_init();
            if (!$stmt->prepare($sql)) {
                echo "failed to prepare";
            } else {
				
				// Bind user input to statement
                $stmt->bind_param('ss', $customerName,$id);
				
				// Execute statement and commit transaction
                $stmt->execute();
                $conn->commit();
            }
        }
    }

    /* Refresh the Data */
    $sql = "SELECT CustomerNumber,CustomerName,StreetAddress,CityName,StateCode,PostalCode FROM customer C " .
        "INNER JOIN address A ON C.defaultAddressID = A.addressID WHERE CustomerNumber = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
        $stmt->bind_param('s',$id);
        $stmt->execute();
        $stmt->bind_result($customerNumber,$customerName,$streetName,$cityName,$stateCode,$postalCode);
        ?>
        <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
        <?php
        while ($stmt->fetch()) {
            echo '<a href="show_customer.php?id='  . $customerNumber . '">' . $customerName . '</a><br>' .
             $streetName . ',' . $stateCode . '  ' . $postalCode;
        }
    ?><br><br>
            New Name: <input type="text" name="customerName">
            <button type="submit">Update</button>
        </form>
    <?php
    }

    $conn->close();

    ?>
</>
</body>
</html>
