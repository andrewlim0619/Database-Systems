<?php
require_once 'config.inc.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $database, $port);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if songID and playlistID are set
if (isset($_POST['songID']) && isset($_POST['playlistID'])) {
    $songID = $_POST['songID'];
    $playlistID = $_POST['playlistID'];

    // Prepare SQL statement to insert the song into the playlist
    $sql = "INSERT INTO PlaylistSongs (PlaylistID, SongID) VALUES (?, ?)";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "Failed to prepare the SQL statement.";
    } else {
        // Bind and execute the statement
        $stmt->bind_param("ii", $playlistID, $songID);
        if ($stmt->execute()) {
            echo "Success";
        } else {
            echo "Error adding song to playlist: " . $conn->error;
        }
    }

    // Close statement
    $stmt->close();
}

// Close connection
$conn->close();
?>