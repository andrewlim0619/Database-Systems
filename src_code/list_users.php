<?php
require_once 'config.inc.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $database, $port);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submission for adding a new user or deleting an existing user
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['add_user'])) {
        $username = $_POST['username'];
        $email = $_POST['email'];
        $password = $_POST['password'];
        $firstName = $_POST['firstName'];
        $middleName = $_POST['middleName'];
        $lastName = $_POST['lastName'];
        $birthDate = $_POST['birthDate'];
        $age = $_POST['age'];
        $artistID = $_POST['artistID'];

        // Set ArtistID to NULL if it is empty
        $artistID = !empty($artistID) ? $artistID : NULL;

        $insertSql = "INSERT INTO User (username, email, password, firstName, middleName, lastName, birthDate, age, ArtistID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $insertStmt = $conn->stmt_init();
        if ($insertStmt->prepare($insertSql)) {
            $insertStmt->bind_param('sssssssii', $username, $email, $password, $firstName, $middleName, $lastName, $birthDate, $age, $artistID);
            if ($insertStmt->execute()) {
                // Refresh the page to show the new user in the list
                header("Location: " . $_SERVER['PHP_SELF']);
                exit();
            } else {
                $error_message = "Failed to add user: " . $insertStmt->error;
            }
            $insertStmt->close();
        } else {
            $error_message = "Failed to prepare the insert statement: " . $conn->error;
        }
    } elseif (isset($_POST['delete_user'])) {
        $userID = $_POST['user_id'];
        $enteredPassword = $_POST['password'];

        // Verify the password
        $passwordSql = "SELECT password FROM User WHERE UserID = ?";
        $passwordStmt = $conn->stmt_init();
        if ($passwordStmt->prepare($passwordSql)) {
            $passwordStmt->bind_param('i', $userID);
            $passwordStmt->execute();
            $passwordStmt->bind_result($storedPassword);
            $passwordStmt->fetch();
            $passwordStmt->close();

            if ($storedPassword === $enteredPassword) {
                $deleteSql = "DELETE FROM User WHERE UserID = ?";
                $deleteStmt = $conn->stmt_init();
                if ($deleteStmt->prepare($deleteSql)) {
                    $deleteStmt->bind_param('i', $userID);
                    if ($deleteStmt->execute()) {
                        // Refresh the page to show the updated user list
                        header("Location: " . $_SERVER['PHP_SELF']);
                        exit();
                    } else {
                        $error_message = "Failed to delete user: " . $deleteStmt->error;
                    }
                    $deleteStmt->close();
                } else {
                    $error_message = "Failed to prepare the delete statement: " . $conn->error;
                }
            } else {
                $error_message = "Incorrect password. User not deleted.";
            }
        } else {
            $error_message = "Failed to verify password: " . $conn->error;
        }
    }
}
?>
<html>
<head>
    <title>Users PHP Database</title>
    <link rel="stylesheet" href="base.css">
    <script src="https://kit.fontawesome.com/224258cc50.js" crossorigin="anonymous"></script>

    <script>
        function toggleForm() {
            var form = document.getElementById("addUserForm");
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block";
            } else {
                form.style.display = "none";
            }
        }

        function showDeletePrompt(userID) {
            var prompt = document.getElementById("deletePrompt");
            document.getElementById("delete_user_id").value = userID;
            prompt.style.display = "block";
        }

        function hideDeletePrompt() {
            var prompt = document.getElementById("deletePrompt");
            prompt.style.display = "none";
        }
    </script>
</head>
<body class="bodyUsers">
<?php
require_once 'header.inc.php';
?>

<div class="UsersPage">
    <div class="usersPageHeader" style="background-image: url(https://miro.medium.com/v2/resize:fit:1400/1*aGtb2VHBugJTa4LqqzOIaA.jpeg)">
        <h1><i id="spotifyLogo" class="fa-brands fa-spotify"></i> Spotify Users PHP Database</h1>
        <span>Database that contains all of the registered Spotify users</span>
    </div>

    <div class="usersList">
    <?php
    // Display any error messages from form processing
    if (isset($error_message)) {
        echo "<p>$error_message</p>";
    }

    // Prepare SQL Statement
    $sql = "SELECT UserID, username FROM User ORDER BY UserID";
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare($sql)) {
        echo "Failed to prepare the SQL statement: " . $conn->error;
    } else {
        // Execute the Statement
        $stmt->execute();

        // Bind result variables
        $stmt->bind_result($userID, $username);

        // Fetch values and display results
        echo "<ol>";
        echo "<h2>List of Users</h2>";
        while ($stmt->fetch()) {
            echo '<li>';
            echo '<a href="show_user.php?id=' . htmlspecialchars($userID) . '">' . htmlspecialchars($userID) . ' - ' . htmlspecialchars($username) . '</a>';
            echo '<button class="deleteButton" onclick="showDeletePrompt(' . htmlspecialchars($userID) . ')"> <i id="deleteIcon" class="fa-solid fa-trash"></i></button>';
            echo '</li>';
        }
        echo "</ol>";
    }

    // Close statement and connection
    $stmt->close();
    $conn->close();
    ?>
    </div>

    <button class="showFormButton" onclick="toggleForm()">Add New User</button>
    <div id="addUserForm" class="addUserForm" style="display: none;">
        <h2>Add New User</h2>
        <form method="post" action="">
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" required><br>
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br>
            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" required><br>
            <label for="firstName">First Name:</label><br>
            <input type="text" id="firstName" name="firstName"><br>
            <label for="middleName">Middle Name:</label><br>
            <input type="text" id="middleName" name="middleName"><br>
            <label for="lastName">Last Name:</label><br>
            <input type="text" id="lastName" name="lastName"><br>
            <label for="birthDate">Birth Date:</label><br>
            <input type="date" id="birthDate" name="birthDate"><br>
            <label for="age">Age:</label><br>
            <input type="number" id="age" name="age"><br>
            <label for="artistID">Artist ID:</label><br>
            <input type="number" id="artistID" name="artistID"><br>
            <input type="submit" name="add_user" value="Add User">
        </form>
    </div>

    <div id="deletePrompt" style="display: none;">
        <h2>Delete User</h2>
        <form method="post" action="">
            <input type="hidden" id="delete_user_id" name="user_id">
            <label for="password">Enter Password to Confirm:</label><br>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" name="delete_user" value="Delete">
            <button type="button" onclick="hideDeletePrompt()">Cancel</button>
        </form>
    </div>
</div>
</body>
</html>