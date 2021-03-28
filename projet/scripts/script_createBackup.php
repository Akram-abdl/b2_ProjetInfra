<?php
include '../config.php';

if (isset($_POST['submit'])) {
    $server = $_POST['submit'];
    shell_exec("bash ../../scripts/backup.sh ${server}");
    header("Location: ../serverBoard.php?server=${server}");
}
header("Location: ../index.php");
