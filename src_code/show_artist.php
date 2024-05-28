<?php
/**
 * Created by PhpStorm.
 * User: MKochanski
 * Date: 7/24/2018
 * Time: 3:07 PM
 */
require_once 'config.inc.php';
// Get Artist ID
$id = $_GET['id'];
if ($id === "") {
    header('location: list_artists.php');
    exit();
}
if ($id === false) {
    header('location: list_artists.php');
    exit();
}
if ($id === null) {
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
    <div class="userProfilePage">
        <?php
        $conn = new mysqli($servername, $username, $password, $database, $port);
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Fetch artist information
        $sql = "SELECT ArtistID, artistName, country, ArtistRank FROM Artist WHERE ArtistID = ?";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($artistID, $artistName, $country, $artistRank);

            echo "<div class='profile-card-artist'>";
            while ($stmt->fetch()) {
                echo '
                    <div class="card-header">
                        <img src="https://i.scdn.co/image/ab676161000051747baf6a3e4e70248079e48c5a" alt="Artist Image">
                        <h2>' . $artistName . '</h2>
                        <button class="edit-profile"><a href="update_artist.php?id=' . $artistID . '">Update Profile</a></button>
                    </div>

                    <div class="card-body">
                        <div class="profile-stats">
                            <div class="stat-item">
                                <h3>Rank</h3>
                                <p>' . $artistRank . '</p>
                            </div>

                            <div class="stat-item">
                                <h3>Country</h3>
                                <p>' . $country . '</p>
                            </div>
                        </div>

                        <div class="card-links">
                            <p><strong>Artist Name:</strong> ' . $artistName . '</p>
                            <p><strong>Country:</strong> ' . $country . '</p>
                            <p><strong>Rank:</strong> ' . $artistRank . '</p>
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
                echo '<p>AlbumID: ' . $albumID . ' | Album Title: ' . $albumTitle . '</p>';
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