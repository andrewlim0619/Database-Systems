<?php
require_once 'config.inc.php';
?>

<html>
<head>
    <title>User's Playlist PHP Database</title>
    <link rel="stylesheet" href="playlist_album.css">
    <script src="https://kit.fontawesome.com/224258cc50.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

            // Get playlist ID from the URL
            $playlistID = isset($_GET['playlistID']) ? $_GET['playlistID'] : 1;

            // Prepare SQL Statement to get playlist details including user and cover image
            $playlistSql = "
                SELECT p.playlistName, p.playlistImage, u.username 
                FROM Playlist p
                JOIN User u ON p.playlistCreator = u.UserID
                WHERE p.PlaylistID = ?";
            $playlistStmt = $conn->stmt_init();
            if (!$playlistStmt->prepare($playlistSql)) {
                echo "Failed to prepare the SQL statement.";
            } else {
                // Bind and execute the statement
                $playlistStmt->bind_param("i", $playlistID);
                $playlistStmt->execute();

                // Bind result variables
                $playlistStmt->bind_result($playlistName, $playlistImage, $username);

                // Fetch the playlist details
                if ($playlistStmt->fetch()) {
                    // Display the playlist cover image
                    echo '<img class="albumAvatar" src="' . htmlspecialchars($playlistImage) . '" alt="' . htmlspecialchars($playlistName) . ' cover">';
                }
                $playlistStmt->close();
            }
            ?>
        </div>

        <div class="albumInfo">
            <?php
            // Fetch the playlist details again to display title and creator name
            $playlistStmt = $conn->stmt_init();
            if ($playlistStmt->prepare($playlistSql)) {
                $playlistStmt->bind_param("i", $playlistID);
                $playlistStmt->execute();
                $playlistStmt->bind_result($playlistName, $playlistImage, $username);

                if ($playlistStmt->fetch()) {
                    echo "<p>Playlist</p>";
                    echo "<h1>" . htmlspecialchars($playlistName) . "</h1>";
                    echo "<span>Created by " . htmlspecialchars($username) . "</span>";
                }
                $playlistStmt->close();
            }
            ?>
        </div>
    </div>

    <div class="songsInAlbum">
        <?php
        // Prepare SQL Statement to get songs from the playlist
        $sql = "
            SELECT s.SongID, s.title, s.duration, s.Features, ar.artistName 
            FROM PlaylistSongs ps
            JOIN Songs s ON ps.SongID = s.SongID
            JOIN Artist ar ON s.ArtistID = ar.ArtistID
            WHERE ps.PlaylistID = ? 
            ORDER BY s.SongID";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "Failed to prepare the SQL statement.";
        } else {
            // Bind and execute the statement
            $stmt->bind_param("i", $playlistID);
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

        // Close statement
        $stmt->close();
        ?>
    </div>

    <!-- Search Form -->
    <br>
    <br>
    <div class="searchMusic">
        <form method="GET" action="">
            <input type="text" name="search" placeholder="Add music...">
            <input type="hidden" name="playlistID" value="<?php echo $playlistID; ?>">
            <button class="playlistSearchButton" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>


    <!-- Search Results Section -->
    <div class="searchResults">
        <?php
        // Check if search query is set
        $search = isset($_GET['search']) ? $_GET['search'] : '';

        if ($search) {
            // Prepare SQL Statement to search for songs
            $sql = "
                SELECT s.SongID, s.title, s.duration, s.Features, ar.artistName 
                FROM Songs s
                JOIN Artist ar ON s.ArtistID = ar.ArtistID
                WHERE s.title LIKE ? OR ar.artistName LIKE ?
                ORDER BY s.SongID";
            $stmt = $conn->stmt_init();
            if (!$stmt->prepare($sql)) {
                echo "Failed to prepare the SQL statement.";
            } else {
                // Bind and execute the statement
                $searchTerm = '%' . $search . '%';
                $stmt->bind_param("ss", $searchTerm, $searchTerm);
                $stmt->execute();

                // Bind result variables
                $stmt->bind_result($songID, $title, $duration, $features, $artistName);

                // Fetch values and display results
                echo "<h2>Search Results</h2>";
                echo "<table class='song-table'>";
                echo "<tr><th>ADD</th><th>Title</th><th>Artist(s)</th><th class='duration'>Duration</th></tr>";
                while ($stmt->fetch()) {
                    $artistNames = htmlspecialchars($artistName);
                    if ($features) {
                        $artistNames .= ", " . htmlspecialchars($features);
                    }
                    echo "<tr>";
                    echo "<td>
                        <form class='addSongForm' method='POST' action='add_song_to_playlist.php'>
                            <input type='hidden' name='songID' value='" . htmlspecialchars($songID) . "'>
                            <input type='hidden' name='playlistID' value='" . htmlspecialchars($playlistID) . "'>
                            <button type='submit'><i class='fa-solid fa-plus'></i></button>
                        </form>
                    </td>";
                    echo "<td>" . htmlspecialchars($title) . "</td>";
                    echo "<td>$artistNames</td>";
                    echo "<td class='duration'>" . gmdate("i:s", $duration) . "</td>";
                    echo "</tr>";
                }
                echo "</table>";
            }

            // Close statement
            $stmt->close();
        }
        // Close connection
        $conn->close();
        ?>
    </div>
</div>

<script>
$(document).ready(function() {
    $('.addSongForm').submit(function(event) {
        event.preventDefault();

        var $form = $(this);
        var url = $form.attr('action');
        var formData = $form.serialize();

        $.post(url, formData, function(response) {
            location.reload();
        });
    });
});
</script>

</body>
</html>