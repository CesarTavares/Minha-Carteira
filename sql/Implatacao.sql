use db_minhacarteira;

/* Criar usuario mysql padrão da aplicação*/
CREATE USER 'usuario_app'@'localhost' IDENTIFIED BY 'abcd1234';
GRANT Select ON db_minhacarteira.* TO 'usuario_app'@'localhost';
GRANT Insert ON db_minhacarteira.* TO 'usuario_app'@'localhost';
GRANT Update ON db_minhacarteira.* TO 'usuario_app'@'localhost';
GRANT Delete ON db_minhacarteira.* TO 'usuario_app'@'localhost';
GRANT Execute ON db_minhacarteira.* TO 'usuario_app'@'localhost';

/* Criação dos niveis de usuários */
INSERT INTO db_minhacarteira.niveis_usuarios (descricao, super_usuario) VALUES('Administrador', 1);
INSERT INTO db_minhacarteira.niveis_usuarios (descricao, super_usuario) VALUES('Usuário Web', 0);
INSERT INTO db_minhacarteira.niveis_usuarios (descricao, super_usuario) VALUES('Usuário Teste', 0);

/* Criação de um usuario administrativo */
INSERT INTO db_minhacarteira.usuarios (id, nome, email, senha, id_nivel_usuario, fg_ativo) VALUES(0, 'Admin', 'email@email.com.br', '', 1, 1);
INSERT INTO db_minhacarteira.usuarios (id, nome, email, senha, id_nivel_usuario, fg_ativo) VALUES(0, 'Usuario Padrão', 'usuario@minhascarteira.com.br', '', 3, 1);

/* Preenchendo a tabela de Tipos de Carteiras */
INSERT INTO db_minhacarteira.tipo_carteiras (descricao) VALUES('Dinheiro em Espécie');
INSERT INTO db_minhacarteira.tipo_carteiras (descricao) VALUES('Conta Corrente');
INSERT INTO db_minhacarteira.tipo_carteiras (descricao) VALUES('Cartão de Crédito');
INSERT INTO db_minhacarteira.tipo_carteiras (descricao) VALUES('Conta Investimento');
