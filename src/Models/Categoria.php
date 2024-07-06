<?php

namespace App\Models;

use App\Config\Database;

class Categoria
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }

    public function getAll()
    {
        $retorno = $this->db->query("Select * from categorias");
        return $retorno->fetchAll(\PDO::FETCH_ASSOC); 
    }

    public function getCategoriasReceitas()
    {
        $retorno = $this->db->query("Select * from categorias where tipo_categoria='receita'");
        return $retorno->fetchAll(\PDO::FETCH_ASSOC); 
    }
}