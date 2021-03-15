<?php require_once 'header.php'; ?>

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
<?php require_once 'footer.php'; ?>