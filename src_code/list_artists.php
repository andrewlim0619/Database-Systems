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
<body class="bodyArtists">
<?php
require_once 'header.inc.php';
?>
<div class="ArtistsPage">
    <div class="ArtistsPageHeader" style="background-image: url(https://i.redd.it/every-tyler-album-as-a-wallpaper-v0-llehfn3lg3591.jpg?width=2424&format=pjpg&auto=webp&s=9a2915c0106d857bd254ba03ec9313f4e76b9c82)">
        <h1><i id="spotifyLogo" class="fa-brands fa-spotify"></i> Spotify Artists PHP Database</h1>
        <span>Database that contains all of the registered Spotify Artists</span>
    </div>

    <div class="artistsList">
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
        echo "<h2>List of Artists</h2>";
        while ($stmt->fetch()) {
            echo '<li><a href="show_customer.php?id='  . $customerNumber . '">' . $customerName . '</a></li>';
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
