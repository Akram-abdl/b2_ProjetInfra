<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projet infra</title>
</head>

<body>
    <h1>Projet infra</h1>
    <h2>Server List</h2>

    <?php
    foreach (glob("../scripts/config/*") as $folderPath) {
        $folderName = basename($folderPath);
        echo "<a href='serverBoard.php?server=${folderName}'>- ${folderName}</a> </br>";
    }
    ?>
    <br>
    <br>
    <a href="createServer.php">Create new server</a>
</body>

</html>