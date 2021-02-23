<?php 
$filepath = "/usr/local/www/b2_ProjetInfra/scripts/config.json";
if(isset($_POST['submit'])) {
    
    $arr = array(
        'server_prefix'     => $_POST['server_prefix'],
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
    $json = json_encode($arr, JSON_PRETTY_PRINT);
    
    echo $json;
    $bytes = file_put_contents($filepath, $json);    
}
$jsondata = file_get_contents($filepath);
// Convert to array 
$array = json_decode($jsondata, true);



?> 
