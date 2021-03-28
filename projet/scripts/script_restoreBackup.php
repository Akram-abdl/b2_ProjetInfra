<?php
include '../config.php';

if (empty($_GET['folder']))
    header("Location: ../index.php");

$folder = htmlspecialchars($_GET['folder']);
$server = htmlspecialchars($_GET['server']);

shell_exec("bash ../../scripts/restore.sh ${server} ${folder}");

header("Location: ../serverBoard.php?server=${server}");
