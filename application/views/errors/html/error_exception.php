<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"><title><?= html_escape($heading ?? 'Exception') ?></title></head>
<body><h1><?= html_escape($heading ?? 'Exception') ?></h1><?= isset($message) ? $message : '' ?></body></html>
