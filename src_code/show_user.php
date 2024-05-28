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
    header('location: list_customers.php');
    exit();
}
if ($id === false) {
    header('location: list_customers.php');
    exit();
}
if ($id === null) {
    header('location: list_customers.php');
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

        $sql = "SELECT CustomerNumber, CustomerName, StreetAddress, CityName, StateCode, PostalCode FROM customer C " .
            "INNER JOIN address A ON C.defaultAddressID = A.addressID WHERE CustomerNumber = ?";
        $stmt = $conn->stmt_init();
        if (!$stmt->prepare($sql)) {
            echo "failed to prepare";
        } else {
            $stmt->bind_param('s', $id);
            $stmt->execute();
            $stmt->bind_result($customerNumber, $customerName, $streetName, $cityName, $stateCode, $postalCode);
            echo "<div class='profile-card'>";
            while ($stmt->fetch()) {
                echo '
                    <div class="card-header">
                        <img src="https://cdns-images.dzcdn.net/images/cover/134fc31d51182276b6fbcc8be24bcc9a/500x500.jpg" alt="User Image">
                        <h2>' . $customerName . '</h2>
                        <button class="edit-profile"><a href="update_customer.php?id=' . $customerNumber . '">Update Profile</a></button>
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
                        <a>Name: </a>
                        <a>email: </a>
                        <a>birthDate: </a>
                        <a>Age: </a>
                        <a href="">Playlist</a>
                        <a href="">Listening History</a>
                    </div>
                </div>';
            }
            echo "</div>";
        }
        $conn->close();
        ?>
    </div>
</body>
</html>