<?php require_once 'header.php';
$server = htmlspecialchars($_GET['server']);
$chan = htmlspecialchars($_GET['chan']);
$core = htmlspecialchars($_GET['core']);
?>

<h2>Server <?php echo "${server}" ?></h2>
<form name='formStartServer' method="post" action="scripts/script_startServer.php">
    <input id="submit" class="btn btn-primary" type="submit" name="submit" value="Start Server">
</form>

<form name='formCloseServer' method="post" action="scripts/script_closeServer.php">
    <input id="submit" class="btn btn-primary" type="submit" name="submit" value="Close Server">
</form>


<form name='formCreateBackup' method='post' action='scripts/script_deleteServer.php'>
    <?php echo "<button class='btn btn-primary' type='submit' name='submit' value='${server}'>Delete Server</button>" ?>
</form>

<div>
    <h2>Backup list</h2>
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
</div>

<div>
    <form name='formCreateBackup' method='post' action='scripts/script_createBackup.php'>
        <?php echo "<button class='btn btn-primary' type='submit' name='submit' value='${server}'>Create backup</button>" ?>
    </form>

</div>


<?php require_once 'footer.php'; ?>
