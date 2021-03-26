<?php require_once 'header.php';
$server = htmlspecialchars($_GET['server']);
?>

<h2>Server <?php echo "${server}" ?></h2>
<form name='formStartServer' method="post" action="scripts/script_startServer.php">
    <input id="submit" class="btn btn-primary" type="submit" name="submit" value="Start Server">
</form>

<form name='formCloseServer' method="post" action="scripts/script_closeServer.php">
    <input id="submit" class="btn btn-primary" type="submit" name="submit" value="Close Server">
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
            echo "<tr>";

            foreach ($scanned_directory as $folder) {
                echo "  <td>${folder}</td>
                        <td>
                            <form name='formRestore' method='post' action='scripts/script_restoreBackup.php'>
                                <button class='btn btn-success' type='submit' name='product' value='${folder}'>Restore</button>
                            </form>
                            <form name='formRestore' method='post' action='scripts/script_deleteBackup.php'>
                                <button class='btn btn-danger' type='submit' name='product' value='${folder}'>Delete</button>
                            </form>
                        </td>";
            }

            echo "</tr>";
            ?>
        </tbody>
    </table>
</div>

</div>

<?php require_once 'footer.php'; ?>