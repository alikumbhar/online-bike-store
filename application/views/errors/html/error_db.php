<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"><title>Database Error</title></head>
<body><h1><?= html_escape($heading ?? 'Database Error') ?></h1><?= isset($message) ? $message : '' ?></body></html>
