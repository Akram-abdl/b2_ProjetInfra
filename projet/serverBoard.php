<?php require_once 'header.php'; ?>

<h1>Server <?php echo htmlspecialchars($_GET["server"]) ?></h1>
<form name='form1' method="post" action="scripts/script_startServer.php">
<input id="submit" type="submit" name="submit" value="Start Server" onclick="on_submit()">
</form>

<form name='form2' method="post" action="scripts/script_closeServer.php">
<input id="submit" type="submit" name="submit" value="Close Server" onclick="on_submit()">
</form>

<?php require_once 'footer.php'; ?>