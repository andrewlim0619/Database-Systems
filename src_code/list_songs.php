<?php
require_once 'config.inc.php';
?>

<html>
<head>
    <title>Songs PHP Database</title>
    <link rel="stylesheet" href="base.css">
    <script src="https://kit.fontawesome.com/224258cc50.js" crossorigin="anonymous"></script>
</head>
<body class="bodyUsers">
<?php
require_once 'header.inc.php';
?>
<div class="UsersPage">
    <div class="usersPageHeader" style="background-image: url(https://miro.medium.com/v2/resize:fit:1400/1*aGtb2VHBugJTa4LqqzOIaA.jpeg)">
        <h1><i id="spotifyLogo" class="fa-brands fa-spotify"></i> Spotify Songs PHP Database</h1>
        <span>Database that contains all of the registered Spotify Songs in our Database.</span>
    </div>

    <div class="searchBar">
        <form method="GET" action="">
            <input type="text" name="search" placeholder="Search songs..." value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>

    <div class="usersList">
    <?php
    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare SQL Statement with search functionality
    $search = isset($_GET['search']) ? '%' . $_GET['search'] . '%' : '%';
    $sql = "
        SELECT Songs.SongID, Songs.title, Artist.artistName AS artist_name
        FROM Songs
        JOIN Artist ON Songs.ArtistID = Artist.ArtistID
        WHERE Songs.title LIKE ? OR Artist.artistName LIKE ? OR Songs.weather LIKE ? OR Songs.season LIKE ?
        ORDER BY Songs.SongID
    ";
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        echo "Failed to prepare the SQL statement. Error: " . $conn->error;
    } else {
        // Bind parameters
        $stmt->bind_param("ssss", $search, $search, $search, $search);

        // Execute the Statement
        if (!$stmt->execute()) {
            echo "Failed to execute the SQL statement. Error: " . $stmt->error;
        } else {
            // Bind result variables
            $stmt->bind_result($SongID, $title, $artist_name);

            // Fetch values and display results
            echo "<ol>";
            echo "<h2>Complete Music List</h2>";
            while ($stmt->fetch()) {
                echo '<li><a href="show_user.php?id=' . $SongID . '">' . $SongID . ' - ' . $title . ' by ' . $artist_name . '</a></li>';
            }
            echo "</ol>";
        }

        // Close statement
        $stmt->close();
    }

    // Close connection
    $conn->close();
    ?>
    </div>
</div>
</body>
</html>
