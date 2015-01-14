<?php

use \PDO;

try {
    $dbh = new PDO('mysql:host=localhost', 'root', 'vagrant');
} catch (Exception $e) {
    $dbError = $e->getMessage();
}

$extensions = [
    'curl',
    'gd',
    'intl',
    'mcrypt',
    'pdo_mysql',
    'pdo_sqlite',
    'xdebug'
];

?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Vagrant LAMP Stack</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="apple-touch-icon" href="apple-touch-icon.png" />
    <!-- Place favicon.ico in the root directory -->

    <link href="//maxcdn.bootstrapcdn.com/bootswatch/3.3.1/united/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <header role="navigation" class="navbar navbar-default navbar-static-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" data-toggle="collapse" data-target=".navbar-collapse" class="navbar-toggle">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="/" class="navbar-brand">DevBox</a>
            </div>
        </div>
    </header>

    <main id="main" class="container" role="main">
        <h1>It works :-)</h1>
        <p class="lead">The Virtual Machine is up and running, yay! Here's some additional information you might need.</p>

        <h2>Installed software</h2>
        <table class="table table-striped">
            <tr>
                <td>Web Server</td>
                <td><?php echo $_SERVER['SERVER_SOFTWARE']; ?></td>
            </tr>
            <tr>
                <td>PHP Version</td>
                <td><?php echo phpversion(); ?></td>
            </tr>
            <tr>
                <td>MySQL version</td>
                <td>
                    <?php if (isset($dbh)) : ?>
                        <?php echo $dbh->getAttribute(PDO::ATTR_SERVER_VERSION); ?>
                    <?php else : ?>
                        <span class="label label-danger">
                            <?php echo $dbError; ?>
                        </span>
                    <?php endif; ?>
                </td>
            </tr>
        </table>

        <h2>PHP Modules</h2>
        <table class="table table-striped">
            <?php foreach ($extensions as $key => $extension) : ?>
                <tr>
                    <td><?php echo $extension; ?></td>
                    <td>
                        <?php if (extension_loaded($extension)) : ?>
                            <span class="label label-success">
                                <i class="glyphicon glyphicon-ok"></i> &nbsp; <?php echo phpversion($extension); ?>
                            </span>
                        <?php else : ?>
                            <span class="label label-danger">
                                <i class="glyphicon glyphicon-remove"></i>
                            </span>
                        <?php endif; ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </main>

    <footer class="container">
        <hr />
        <p class="text-center">
            Maintained by <a href="https://twitter.com/xtreamwayz">@xtreamwayz</a>
        </p>
    </footer>

    <script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</body>
</html>
