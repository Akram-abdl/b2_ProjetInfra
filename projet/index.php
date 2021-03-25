<?php require_once 'header.php'; ?>

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


<?php
require_once 'footer.php';
?>