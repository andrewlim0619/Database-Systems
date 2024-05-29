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
    <title>Update User Profile</title>
    <link rel="stylesheet" href="base.css">
</head>
<body class="updatePageBody">
<?php
require_once 'header.inc.php';
?>
<div>
    <h2>Update User</h2>
    <?php
    // Create connection
    $conn = new mysqli($servername, $username, $password, $database, $port);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Check if the request is an update from user submitted via form
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $username = $_POST['username'];
        $email = $_POST['email'];
        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $birthDate = $_POST['birthDate'];
        $age = $_POST['age'];

        // Validate inputs
        if (empty(trim($username)) || empty(trim($email))) {
            echo "<div><i>Username and Email are required fields.</i></div>";
        } else {
            // Perform update using safe parameterized SQL
            $sql = "UPDATE User SET username = ?, email = ?, firstName = ?, lastName = ?, birthDate = ?, age = ? WHERE UserID = ?";
            $stmt = $conn->stmt_init();
            if (!$stmt->prepare($sql)) {
                echo "Failed to prepare the SQL statement.";
            } else {
                // Bind user input to statement
                $stmt->bind_param('ssssssi', $username, $email, $firstName, $lastName, $birthDate, $age, $id);

                // Execute statement and commit transaction
                if ($stmt->execute()) {
                    echo "<div>Profile updated successfully.</div>";
                } else {
                    echo "<div>Failed to update profile.</div>";
                }
            }
        }
    }

    // Fetch user data
    $sql = "SELECT UserID, username, email, firstName, lastName, birthDate, age FROM User WHERE UserID = ?";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "Failed to prepare the SQL statement.";
    } else {
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $stmt->bind_result($userID, $username, $email, $firstName, $lastName, $birthDate, $age);
        $stmt->fetch();
        ?>
        <form method="post">
            <input type="hidden" name="id" value="<?= $id ?>">
            <p>Username: <input type="text" name="username" value="<?= htmlspecialchars($username) ?>"></p>
            <p>Email: <input type="email" name="email" value="<?= htmlspecialchars($email) ?>"></p>
            <p>First Name: <input type="text" name="firstName" value="<?= htmlspecialchars($firstName) ?>"></p>
            <p>Last Name: <input type="text" name="lastName" value="<?= htmlspecialchars($lastName) ?>"></p>
            <p>Birth Date: <input type="date" name="birthDate" value="<?= htmlspecialchars($birthDate) ?>"></p>
            <p>Age: <input type="number" name="age" value="<?= htmlspecialchars($age) ?>"></p>
            <button type="submit">Update</button>
        </form>
        <button onclick="location.href='show_user.php?id=<?= $id ?>'">Go to Profile View</button>
        <?php
    }

    $stmt->close();
    $conn->close();
    ?>
</div>
</body>
</html>