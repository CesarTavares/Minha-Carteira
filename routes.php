<?php

session_start();
ini_set('display_errors',1);

require_once __DIR__ . '/vendor/autoload.php';

$controller = new \App\Controllers\CategoriasController();
$controller->index();