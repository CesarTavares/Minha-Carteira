<?php

namespace App\Controllers;

use App\Models\Categoria;

class CategoriasController
{
    public function index()
    {
        $categoriaModel = new Categoria();
        $categorias = $categoriaModel->getAll();

        require __DIR__ . '/../Views/categorias/index.php';
    }
}