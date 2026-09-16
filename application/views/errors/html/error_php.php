<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><?= html_escape($heading ?? 'Application Error') ?></title>
    <style>
        body{font-family:Arial,sans-serif;background:#f5f5f5;margin:0;padding:40px;color:#333}
        .error{max-width:900px;margin:0 auto;background:#fff;padding:28px;border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,.08)}
        h1{margin-top:0;font-size:24px} p{line-height:1.6}
    </style>
</head>
<body>
<div class="error">
    <h1><?= html_escape($heading ?? 'Application Error') ?></h1>
    <?= isset($message) ? $message : '' ?>
</div>
</body>
</html>
