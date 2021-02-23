<?php
include '../config.php';

function str_replace_json($search, $replace, $subject)
{
    return json_decode(str_replace($search, $replace,  json_encode($subject)));
}

if (isset($_POST['submit'])) {
    $serverPrefix = $_POST['server_prefix'];


    $arr = array(
        'server_prefix'     => $serverPrefix,
        'server_path'     => $_POST['server_path'],
        'mysql_path'     => $_POST['mysql_path'],
        'backup_path'     => $_POST['backup_path'],
        'mysql_user'     => $_POST['mysql_user'],
        'mysql_password'    => $_POST['mysql_password'],
        "mysql_bases" => array(
            "account"      => $_POST["account"],
            "common"     => $_POST['common'],
            "hotbackup"     => $_POST['hotbackup'],
            "log"     => $_POST['log'],
            "player"     => $_POST['player']
        )
    );
    $outPath = "../${CONFIG_FOLDER}/${serverPrefix}";

    if (mkdir($outPath, 0777, true)) {
        $contents = json_encode($arr, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
        file_put_contents("${outPath}/config.json", $contents);

        header("Location: ../serverBoard.php?server=${serverPrefix}");
        exit;
    } else {
        echo 'Le serveur existe déjà...';
    }
}
header("Location: ../index.php");
