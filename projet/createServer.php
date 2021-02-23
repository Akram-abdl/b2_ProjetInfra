<?php
include 'config.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h1>Create server</h1>

    <div id="form_page">
        <form name='form1' method="post" action="scripts/script_createServer.php">
            <div id="form_body">
                <?php
                $jsondata = file_get_contents($TEMPLATE_CONFIG_PATH);
                // Convert to array 
                $array = json_decode($jsondata, true);

                foreach ($array as $key => $value) {
                    if (is_array($value)) {
                        foreach ($value as $key2 => $value2) {
                            echo "<div id='$key2' class='input'>$key2
                                <input id='$key2' value='$value2' type='text'
                                    Placeholder='$key2' name='$key2'required> 
                                </div>";
                        }
                    } else {
                        echo "<div id='$key' class='input'>$key
                            <input id='$key' value='$value' type='text'
                                Placeholder='$key' name='$key'required> 
                            </div>";
                    }
                }
                ?>

                <div class="id input">
                    <input id="submit" type="submit" name="submit" value="submit" onclick="on_submit()">
                </div>
            </div>
        </form>
    </div>
</body>

</html>