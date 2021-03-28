<?php
include '../config.php';

if (isset($_POST['submit'])) {
    $server = $_POST['submit'];
    shell_exec("bash ../../scripts/delete.sh ${server}");
}
header("Location: ../index.php");
