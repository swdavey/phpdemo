<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<h1>Names List</h1>
<?php
        require_once 'vendor/autoload.php';

        $dotenv = Dotenv\Dotenv::createImmutable(__DIR__."/../config");
        $dotenv->load();

        $conn = new mysqli($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASS"], $_ENV["DB_NAME"]);
        if ($conn->connect_error) {
                echo "Connection to DB could not be established.";
        } else {
                $result = $conn->query("SELECT * FROM t1");
                while ($row = $result->fetch_assoc()) {
                        echo $row['name'] . "<br>";
                }
                $conn->close();
        }
?>
</body>
</html>
