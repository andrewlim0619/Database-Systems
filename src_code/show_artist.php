<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';

// Get Artist ID from the URL
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) {
    header('location: list_artists.php');
    exit();
}
?>

<html>
<head>
    <title>Artist Profile</title>
    <link rel="stylesheet" href="base.css">
</head>
<body class="bodyUserProfile">
<?php
require_once 'header.inc.php';
?>
    <div class="artistProfilePage">
        <?php
        $conn = new mysqli($servername, $username, $password, $database, $port);
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Fetch artist information including listener count from ListeningHistoryArtist
        $sql = "
            SELECT a.ArtistID, a.artistName, a.country, a.ArtistRank, COALESCE(l.listenerCount, 0) AS listenerCount
            FROM Artist a
            LEFT JOIN ListeningHistoryArtist l 
                ON a.ArtistID = l.ArtistID
            WHERE a.ArtistID = ?
            ORDER BY l.year DESC, l.month DESC
            LIMIT 1";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($artistID, $artistName, $country, $artistRank, $listenerCount);

            echo "<div class='profile-card-artist'>";
            while ($stmt->fetch()) {
                echo '
                    <div class="card-header">
                        <img src="https://i.scdn.co/image/ab676161000051747baf6a3e4e70248079e48c5a" alt="Artist Image">
                        <h2>' . htmlspecialchars($artistName) . '</h2>
                        <button class="edit-profile"><a href="update_artist.php?id=' . htmlspecialchars($artistID) . '">Update Profile</a></button>
                    </div>

                    <div class="card-body">
                        <div class="profile-stats">
                            <div class="stat-item">
                                <h3>Followers</h3>
                                <p>2,021,234</p>
                            </div>

                            <div class="stat-item">
                                <h3>Monthly Listeners</h3>
                                <p>' . htmlspecialchars(number_format($listenerCount)) . '</p>
                            </div>
                        </div>

                        <div class="card-links">
                            <p><strong>Artist Name:</strong> ' . htmlspecialchars($artistName) . '</p>
                            <p><strong>Country:</strong> ' . htmlspecialchars($country) . '</p>
                            <p><strong>Rank:</strong> ' . htmlspecialchars($artistRank) . '</p>
                        </div>';
            }
            echo "</div>";
        }

        // Fetch artist albums
        $sql = "SELECT AlbumID, Title FROM Albums WHERE ArtistID = ?";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement for albums.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($albumID, $albumTitle);

            echo "<div class='card-links'>";
            echo "<h3>Artist Albums</h3>";

            $hasAlbums = false;
            while ($stmt->fetch()) {
                $hasAlbums = true;
                echo '<a href="show_albums.php?albumID=' . htmlspecialchars($albumID). '">AlbumID: ' . htmlspecialchars($albumID) . ' | Album Title: ' . htmlspecialchars($albumTitle) . '</a>';   
                echo '<br>';
                echo '<br>';
            }

            if (!$hasAlbums) {
                echo '<p>This artist has not created any albums.</p>';
            }

            echo "</div>";
        }

        $stmt->close();
        $conn->close();
        ?>
    </div>
</body>
</html>