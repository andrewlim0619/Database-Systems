<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';

?>
<html>
<head>
    <title>Users PHP Database</title>
    <link rel="stylesheet" href="base.css">
    <script src="https://kit.fontawesome.com/224258cc50.js" crossorigin="anonymous"></script>
</head>
<body class="bodyUsers">
<?php
require_once 'header.inc.php';
?>
<div class="UsersPage">
    <div class="usersPageHeader" style="background-image: url(https://miro.medium.com/v2/resize:fit:1400/1*aGtb2VHBugJTa4LqqzOIaA.jpeg)">
        <h1><i id="spotifyLogo" class="fa-brands fa-spotify"></i> Spotify Users PHP Database</h1>
        <span>Database that contains all of the registered Spotify users</span>
    </div>

    <div class="usersList">
    <?php
    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

	// Prepare SQL Statement
    $sql = "SELECT CustomerNumber,CustomerName FROM customer ORDER BY CustomerName";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "failed to prepare";
    }
    else {
		
		// Execute the Statement
        $stmt->execute();
		
		// Loop Through Result
        $stmt->bind_result($customerNumber,$customerName);
        echo "<ol>";
        echo "<h2>List of Users</h2>";
        while ($stmt->fetch()) {
            echo '<li><a href="show_user.php?id='  . $customerNumber . '">' . $customerName . '</a></li>';
        }
        echo "</ol>";
    }

	// Close Connection
    $conn->close();

    ?>
    </div>
</div>
</body>
</html>
