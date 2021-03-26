<?php require_once 'header.php'; ?>

<h2>Server List</h2>
<div class="list-group">
    <?php
    foreach (glob("../scripts/config/*") as $folderPath) {
        $folderName = basename($folderPath);
        echo "<a href='serverBoard.php?server=${folderName}' class='list-group-item list-group-item-action'>- ${folderName}</a> </br>";
    }
    ?>
    <br>
    <br>
    <a href="createServer.php" class="btn btn-primary">Create new server</a>
</div>
<?php
require_once 'footer.php';
?>