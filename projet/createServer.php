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
                    echo "<div id='$key'>$key</div>";
                    foreach ($value as $key2 => $value2) {
                        echo "
                            <div class='row g-3 align-items-center'>
                                <div class='col-auto'>
                                <label for='>$key2' class='col-form-label'>$key2</label>
                                </div>
                                <div class='col-auto'>
                                <input type='text' id='$key2'name='$key2' value='$value2' class='form-control'>
                                </div>
                                <div class='col-auto'>
                                <span id='passwordHelpInline' class='form-text'>
                                    $value2
                                </span>
                            </div>
                        </div>
                        ";
                    }
                } else {
                    echo "
                            <div class='row g-3 align-items-center'>
                            <div class='col-auto'>
                            <label for='>$key' class='col-form-label'>$key</label>
                            </div>
                            <div class='col-auto'>
                            <input type='text' id='$key' name='$key' value='$value' class='form-control'>
                            </div>
                            <div class='col-auto'>
                            <span class='form-text'>
                                $value
                            </span>
                            </div>
                        </div>
                        ";
                }
            }
            ?>

            <div class="input">
                <input class="btn btn-primary" id="submit" type="submit" name="submit" value="submit">
            </div>
        </div>
    </form>
</div>
<?php require_once 'footer.php'; ?>