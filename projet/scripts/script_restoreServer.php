<?php
include '../config.php';

if (isset($_POST['submit'])) {
    $serverPrefix = $_POST['server_prefix'];

    shell_exec("bash ../../scripts/restore.sh ${serverPrefix}");
    header("Location: ../serverBoard.php?server=${serverPrefix}");
}
header("Location: ../index.php");
