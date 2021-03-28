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
    <a href="createServer.php"><button class='btn btn-primary' type='submit'>Create new server</button></a>
</div>

<div>
    <h2>Backup list</h2>
    <?php
    $servers = array_diff(scandir($BACKUP_FOLDER), array('..', '.'));

    foreach ($servers as $server) {
        echo "<h3>${server}</h3>"; ?>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <?php

                $backupFolder = "${BACKUP_FOLDER}/${server}/";
                $scanned_directory = array_diff(scandir($backupFolder), array('..', '.'));

                $scanned_directory = array_reverse($scanned_directory);

                foreach ($scanned_directory as $folder) {
                    echo "  <tr>
                                <td>${folder}</td>
                                <td>
                                    <a href='scripts/script_restoreBackup.php?server=${server}&folder=${folder}'><button id='btn-delete' class='btn btn-success' type='submit' >Restore</button></a>
                                    <a href='scripts/script_deleteBackup.php?server=${server}&folder=${folder}'><button id='btn-delete' class='btn btn-danger' type='submit' >Delete</button></a>
                                </td>
                            </tr>";
                }
                ?>
            </tbody>
        </table>
    <?php } ?>

</div>
<?php
require_once 'footer.php';
?>