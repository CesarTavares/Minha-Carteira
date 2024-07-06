<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorias</title>
</head>
<body>
    <h1>Lista de Categorias</h1>
    <?php 
    dump($categorias);

    foreach ($categorias as $categoria): ?>
        <p><?php echo $categoria['descricao']; ?> - <?php echo $categoria['tipo_categoria']; ?></p>
    <?php endforeach; ?>
</body>
</html>
