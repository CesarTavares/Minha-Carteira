<?php

namespace App\Config;

class Database
{
    private static $instance = null;
    private $connection;

    private function __construct()
    {
        $dotenv = \Dotenv\Dotenv::createImmutable(__DIR__);
        $dotenv->load();

        $this->connection = new \PDO(
            'mysql:host=' . $_ENV['DB_HOST'] . ';dbname=' . $_ENV['DB_DATABASE'] . ';charset=utf8mb4', 
            $_ENV['DB_USERNAME'],
            $_ENV['DB_PASSWORD']
        );
    }

    public static function getInstance() 
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;        
    }

    public function getConnection()
    {
        return $this->connection;
    }
}