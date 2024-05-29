<?php
require_once 'config.inc.php';
?>

<html>
<head>
    <title>User's Playlist PHP Database</title>
    <link rel="stylesheet" href="playlist_album.css">
    <script src="https://kit.fontawesome.com/224258cc50.js" crossorigin="anonymous"></script>
</head>

<?php
require_once 'header.inc.php';
?>
<div class="AlbumPage">
    <div class="albumHeader">
        <div class="albumAvatar">
            <?php
            // Create connection
            $conn = new mysqli($servername, $username, $password, $database, $port);

            // Check connection
            if ($conn->connect_error) {
                die("Connection failed: " . $conn->connect_error);
            }

            // Get album ID from the URL
            $albumID = isset($_GET['albumID']) ? $_GET['albumID'] : 1;

            // Prepare SQL Statement to get album details including artist name and cover image
            $albumSql = "
                SELECT a.Title, a.ArtistID, a.coverImage, ar.artistName 
                FROM Albums a
                JOIN Artist ar ON a.ArtistID = ar.ArtistID
                WHERE a.AlbumID = ?";
            $albumStmt = $conn->stmt_init();
            if (!$albumStmt->prepare($albumSql)) {
                echo "Failed to prepare the SQL statement.";
            } else {
                // Bind and execute the statement
                $albumStmt->bind_param("i", $albumID);
                $albumStmt->execute();

                // Bind result variables
                $albumStmt->bind_result($albumTitle, $artistID, $coverImage, $artistName);

                // Fetch the album details
                if ($albumStmt->fetch()) {
                    // Display the album cover image
                    echo '<img class="albumAvatar" src="' . htmlspecialchars($coverImage) . '" alt="' . htmlspecialchars($albumTitle) . ' cover">';
                }
                $albumStmt->close();
            }
            ?>
        </div>

        <div class="albumInfo">
            <?php
            // Fetch the album details again to display title and artist name
            $albumStmt = $conn->stmt_init();
            if ($albumStmt->prepare($albumSql)) {
                $albumStmt->bind_param("i", $albumID);
                $albumStmt->execute();
                $albumStmt->bind_result($albumTitle, $artistID, $coverImage, $artistName);

                if ($albumStmt->fetch()) {
                    echo "<p>Album</p>";
                    echo "<h1>" . htmlspecialchars($albumTitle) . "</h1>";
                    echo "<span>" . htmlspecialchars($artistName) . "</span>";
                }
                $albumStmt->close();
            }
            ?>
        </div>
    </div>

    <div class="songsInAlbum">
    <?php
    // Prepare SQL Statement to get songs from the album
    $sql = "
        SELECT s.SongID, s.title, s.duration, s.Features, ar.artistName 
        FROM Songs s
        JOIN Artist ar ON s.ArtistID = ar.ArtistID
        WHERE s.AlbumID = ? 
        ORDER BY s.SongID";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "Failed to prepare the SQL statement.";
    } else {
        // Bind and execute the statement
        $stmt->bind_param("i", $albumID);
        $stmt->execute();

        // Bind result variables
        $stmt->bind_result($songID, $title, $duration, $features, $artistName);

        // Fetch values and display results
        echo "<h2>List of Songs</h2>";
        echo "<table class='song-table'>";
        echo "<tr><th>#</th><th>Title</th><th>Artist(s)</th><th class='duration'>Duration</th></tr>";
        $count = 1;
        while ($stmt->fetch()) {
            $artistNames = htmlspecialchars($artistName);
            if ($features) {
                $artistNames .= ", " . htmlspecialchars($features);
            }
            echo "<tr>";
            echo "<td>$count</td>";
            echo "<td>" . htmlspecialchars($title) . "</td>";
            echo "<td>$artistNames</td>";
            echo "<td class='duration'>" . gmdate("i:s", $duration) . "</td>";
            echo "</tr>";
            $count++;
        }
        echo "</table>";
    }

    // Close statement and connection
    $stmt->close();
    $conn->close();
    ?>
    </div>
</div>
</body>
</html>