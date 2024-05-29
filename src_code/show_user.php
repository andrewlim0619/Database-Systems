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
    header('location: list_users.php');
    exit();
}
if ($id === false) {
    header('location: list_users.php');
    exit();
}
if ($id === null) {
    header('location: list_users.php');
    exit();
}
?>

<html>
<head>
    <title>User Profile</title>
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

        // Fetch user information
        $sql = "SELECT UserID, username, email, firstName, lastName, birthDate, age FROM User WHERE UserID = ?";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($userID, $username, $email, $firstName, $lastName, $birthDate, $age);

            echo "<div class='profile-card'>";
            while ($stmt->fetch()) {
                echo '
                    <div class="card-header">
                        <img src="https://i.scdn.co/image/ab676161000051747baf6a3e4e70248079e48c5a" alt="User Image">
                        <h2>' . $username . '</h2>
                        <button class="edit-profile"><a href="update_user.php?id=' . $userID . '">Update Profile</a></button>
                    </div>

                    <div class="card-body">
                        <div class="profile-stats">
                            <div class="stat-item">
                                <h3>Followers</h3>
                                <p>50</p>
                            </div>

                            <div class="stat-item">
                                <h3>Following</h3>
                                <p>1.2K</p>
                            </div>
                        </div>

                        <div class="card-links">
                            <p><strong>Name:</strong> ' . $firstName . ' ' . $lastName . '</p>
                            <p><strong>Email:</strong> ' . $email . '</p>
                            <p><strong>Birth Date:</strong> ' . $birthDate . '</p>
                            <p><strong>Age:</strong> ' . $age . '</p>
                        </div>';
            }
            echo "</div>";
        }

        // Fetch user playlists
        $sql = "SELECT PlaylistID, playlistName FROM Playlist WHERE playlistCreator = ?";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement for playlists.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($playlistID, $playlistName);

            echo "<div class='card-links'>";
            echo "<h3>User Playlists</h3>";
            $hasPlaylists = false;
            while ($stmt->fetch()) {
                $hasPlaylists = true;
                echo '<a href="show_playlists.php?playlistID=' . $playlistID . '">Playlist Name: ' . $playlistName . '</a>';
                echo '<br>';
                echo '<br>';
            }

            if (!$hasPlaylists) {
                echo '<p>This user has not created any playlists.</p>';
            }
            echo "</div>";
        }

        // Fetch user liked songs
        $sql = "SELECT Songs.title, Artist.artistName, Albums.Title as albumTitle 
                FROM UserLikedSongs 
                JOIN Songs ON UserLikedSongs.SongID = Songs.SongID 
                JOIN Artist ON Songs.ArtistID = Artist.ArtistID 
                JOIN Albums ON Songs.AlbumID = Albums.AlbumID
                WHERE UserLikedSongs.UserID = ?
                ORDER BY Songs.title";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement for liked songs.";
        } else {
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $stmt->bind_result($songTitle, $artistName, $albumTitle);

            echo "<div class='card-links'>";
            echo "<h3>User Liked Songs</h3>";
            $hasLikedSongs = false;
            echo "<table>";
            echo "<tr class='table-header'><th>#</th><th>Title</th><th>Artist</th><th>Album</th></tr>";
            $index = 1;
            while ($stmt->fetch()) {
                $hasLikedSongs = true;
                echo '<tr><td>' . $index++ . '</td><td>' . $songTitle . '</td><td>' . $artistName . '</td><td>' . $albumTitle . '</td></tr>';
            }
            echo "</table>";

            if (!$hasLikedSongs) {
                echo '<p>This user has not liked any songs.</p>';
            }
            echo "</div>";
        }

        $stmt->close();
        $conn->close();
        ?>
    </div>
</body>
</html>