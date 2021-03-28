<?php
include '../config.php';

function delTree($dir)
{
    $files = array_diff(scandir($dir), array('.', '..'));
    foreach ($files as $file) {
        (is_dir("$dir/$file")) ? delTree("$dir/$file") : unlink("$dir/$file");
    }
    return rmdir($dir);
}

if (empty($_GET['folder']))
    header("Location: ../index.php");

$folder = htmlspecialchars($_GET['folder']);
$server = htmlspecialchars($_GET['server']);

$backupFolder = "${BACKUP_FOLDER}/${server}/";

delTree($backupFolder . $folder);

header("Location: ../serverBoard.php?server=${server}");
