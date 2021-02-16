<?php
include 'config.php';
?>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Projet Infra</title>
    </head>
    <body>
        <h1>Projet Infra</h1>
        <form name='form1' method="post" action="config.php"> 
  
            <div id="form_page"> 
      
                <div id="form_body"> 
                    <div id="head"> 
                        <h1 id="heading">Config</h1> 
                    </div> 
                    <?php
                        foreach($array as $key => $value) {
                            if (is_array($value)) {
                                foreach($value as $key2 => $value2){
                                    echo "<div id='$key2' class='input'>$key2
                                    <input id='$key2' value='$value2' type='text'
                                        Placeholder='$key2' name='$key2'required> 
                                    </div>";
                                }
                            }
                            else{
                                echo "<div id='$key' class='input'>$key
                                <input id='$key' value='$value' type='text'
                                    Placeholder='$key' name='$key'required> 
                                </div>";
                            }
                                
                        }   
                    ?>
                    
                    <div class="id input"> 
                        <input id="submit" type="submit" 
                            name="submit" value="submit" 
                            onclick="on_submit()"> 
                    </div> 
                </div> 
            </div> 
        </form>   
    </body>
</html>
