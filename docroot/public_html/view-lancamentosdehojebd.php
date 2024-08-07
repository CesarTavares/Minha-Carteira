<?php
    require_once("../minhacarteira/app/login/_sessao.php");

    require_once("../minhacarteira/app/login/_conexao/conexao.php");

    try{
        // comando SQL para buscar todos os registros da tabela
        //$sql = "SELECT * FROM lancamentos where codigo_usuario = :codigo";
// Obter a data atual
// $sql = "SELECT * FROM lancamentos_despesas
//         WHERE data_pagamento = CURDATE() AND codigo_usuario = :codigo
//         ORDER BY data_pagamento DESC";

         // comando SQL para buscar todos os registros da tabela
         $sql = "SELECT ld.*, c.descricao AS categoria_descricao, ca.descricao AS carteira_descricao
         FROM lancamentos_despesas ld
         LEFT JOIN categorias c ON ld.categoria = c.codigo
         LEFT JOIN carteiras ca ON ld.carteira = ca.codigo
         WHERE ld.codigo_usuario = :codigo AND ld.data = CURDATE()
         ORDER BY ld.data_pagamento DESC";
     

        // prepara a consulta
        $consulta = $conexao->prepare($sql);
        // vincula o valor do ID à consulta
        $consulta->bindValue(':codigo', $_SESSION['codigo']);
        // executa a consulta
        $consulta->execute();
        // obtém os dados retornados
        $dados = $consulta->fetchAll();
        // calcula o total de registros lidos da tabela
        $totalRegistros = $consulta->rowCount();

    }catch(PDOException $erro) {
        echo("Código dp erro.: ".$erro->getCode());
        echo("Descrição......: ".$erro->getMessage());
    }
