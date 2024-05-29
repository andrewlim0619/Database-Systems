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
<div class="ArtistsPage">
    <div class="ArtistsPageHeader" style="background-image: url(https://media.pitchfork.com/photos/638902d5f777c8e284615da3/master/pass/SZA.jpg)">
        <h1><i id="spotifyLogo" class="fa-brands fa-spotify"></i> Spotify Songs PHP Database</h1>
        <span>Database that contains all of the registered Spotify Songs</span>
    </div>

    <div class="searchBar">
        <form method="GET" action="">
            <input type="text" name="search" placeholder="Search songs..." value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>">
            <select name="weather">
                <option value="">Filter by Weather</option>
                <option value="sunny">Sunny</option>
                <option value="rainy">Rainy</option>
                <option value="Snowy">Snowy</option>
                <option value="Cloudy">Cloudy</option>
            </select>
            <select name="season">
                <option value="">Filter by Season</option>
                <option value="spring">Spring</option>
                <option value="summer">Summer</option>
                <option value="Winter">Winter</option>
                <option value="Autumn">Autumn</option>
            </select>
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

    // Prepare SQL Statement with search functionality and filters
    $search = isset($_GET['search']) ? '%' . $_GET['search'] . '%' : '%';
    $weatherFilter = isset($_GET['weather']) && !empty($_GET['weather']) ? $_GET['weather'] : '%';
    $seasonFilter = isset($_GET['season']) && !empty($_GET['season']) ? $_GET['season'] : '%';

    $sql = "
        SELECT Songs.SongID, Songs.title, Artist.artistName AS artist_name
        FROM Songs
        JOIN Artist ON Songs.ArtistID = Artist.ArtistID
        WHERE (Songs.title LIKE ? OR Artist.artistName LIKE ?)
        AND (Songs.weather LIKE ? OR ? = '%')
        AND (Songs.season LIKE ? OR ? = '%')
        ORDER BY Songs.SongID
    ";

    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        echo "Failed to prepare the SQL statement. Error: " . $conn->error;
    } else {
        // Bind parameters
        $stmt->bind_param("ssssss", $search, $search, $weatherFilter, $weatherFilter, $seasonFilter, $seasonFilter);

        // Execute the Statement
        if (!$stmt->execute()) {
            echo "Failed to execute the SQL statement. Error: " . $stmt->error;
        } else {
            // Bind result variables
            $stmt->bind_result($SongID, $title, $artist_name);

            // Fetch values and display results
            echo "<ol>";
            echo "<h2>Filtered Music List</h2>";
            while ($stmt->fetch()) {
                echo '<li><a' . $SongID . '">' . $SongID . ' - ' . $title . ' by ' . $artist_name . '</a></li>';
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
