<?php

    $dns = "mysql:host=localhost;dbname=db_minhacarteira;charset=utf8";
    $user = "usuario_app";
    $pass = "abcd1234";

    try{
        $conexao = new PDO($dns, $user, $pass);
        // echo("Conexão realizada com sucesso!");
    }
    catch(PDOException $erro){
       /*
        echo("Código de Erro = ".$erro->getCode()."<br>");
        echo("Descrição do Erro = ".$erro->getMessage());
       */
        echo("Entre em contato com o Administrador.");
    }
       














