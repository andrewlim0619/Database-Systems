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
    <title>Update Artist Profile</title>
    <link rel="stylesheet" href="base.css">
</head>
<body class="updatePageBody">
<?php
require_once 'header.inc.php';
?>
<div>
    <h2>Update Artist</h2>
    <?php
    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Check if the request is an update from artist submitted via form
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $artistName = $_POST['artistName'];
        $country = $_POST['country'];
        $artistRank = $_POST['artistRank'];

        // Validate inputs
        if (empty(trim($artistName))) {
            echo "<div><i>Artist Name is a required field.</i></div>";
        } else {
            // Perform update using safe parameterized SQL
            $sql = "UPDATE Artist SET artistName = ?, country = ?, ArtistRank = ? WHERE ArtistID = ?";
            $stmt = $conn->stmt_init();
            if (!$stmt->prepare($sql)) {
                echo "Failed to prepare the SQL statement.";
            } else {
                // Bind user input to statement
                $stmt->bind_param('ssii', $artistName, $country, $artistRank, $id);

                // Execute statement and commit transaction
                if ($stmt->execute()) {
                    echo "<div>Profile updated successfully.</div>";
                } else {
                    echo "<div>Failed to update profile.</div>";
                }
            }
        }
    }

    // Fetch artist data
    $sql = "SELECT ArtistID, artistName, country, ArtistRank FROM Artist WHERE ArtistID = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "Failed to prepare the SQL statement.";
    } else {
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $stmt->bind_result($artistID, $artistName, $country, $artistRank);
        $stmt->fetch();
        ?>
        <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
            <p>Artist Name: <input type="text" name="artistName" value="<?= htmlspecialchars($artistName) ?>"></p>
            <p>Country: <input type="text" name="country" value="<?= htmlspecialchars($country) ?>"></p>
            <p>Artist Rank: <input type="number" name="artistRank" value="<?= htmlspecialchars($artistRank) ?>"></p>
            <button type="submit">Update</button>
        </form>
        <?php
        echo '<button onclick="location.href=\'profile_view.php?id=' . $id . '\'">Return</button>';
    }

    $stmt->close();
    $conn->close();
    ?>
</div>
</body>
</html>