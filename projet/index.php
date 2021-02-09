<html>
        <head>
                <title>Test</title>
        </head>
        <body>
              <h1>Test</h1>
              <?php
               $output = shell_exec('./etest.sh');
               echo "<pre>$output</pre>";
              ?>
        </body>
</html>
