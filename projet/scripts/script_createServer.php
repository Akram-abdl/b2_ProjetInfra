<?php
include '../config.php';

if (isset($_POST['submit'])) {
    $jsonData = file_get_contents("../$TEMPLATE_CONFIG_PATH");
    // Convert to array 
    $arrayTemplate = json_decode($jsonData, true);

    $array = [];

    foreach ($arrayTemplate as $key => $value) {
        if (is_array($value)) {
            foreach ($value as $key2 => $value2) {
                $array[$key][$key2] = $_POST[$key2];
            }
        } else {
            $array[$key] = $_POST[$key];
        }
    }

    $serverPrefix = $_POST['server_prefix'];
    $outPath = "../${CONFIG_FOLDER}/${serverPrefix}";

    if (mkdir($outPath, 0777, true)) {
        $contents = json_encode($array, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
        file_put_contents("${outPath}/config.json", $contents);
    }
    header("Location: ../serverBoard.php?server=${serverPrefix}");
    exit;
}
header("Location: ../index.php");
