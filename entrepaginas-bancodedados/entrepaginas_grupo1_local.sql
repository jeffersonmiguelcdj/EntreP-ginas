-- ============================================================
-- EntrePáginas - banco para uso LOCAL (testes na própria máquina)
-- Tabelas com o sufixo _grupo1, igual ao banco do servidor do professor.
-- ATENÇÃO: NÃO rode este script no servidor do professor. Lá o banco já existe.
-- ============================================================
CREATE DATABASE IF NOT EXISTS entrepaginas DEFAULT CHARACTER SET utf8mb4;
USE entrepaginas;
CREATE TABLE autor_grupo1 (
  id_autor INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  nacionalidade VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_autor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE categoria_grupo1 (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE livro_grupo1 (
  id_livro INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(200) NOT NULL,
  isbn VARCHAR(13) NOT NULL,
  ano_publicacao INT NOT NULL,
  preco_venda DECIMAL(10,2) NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_livro),
  UNIQUE KEY (isbn),
  FOREIGN KEY (id_categoria) REFERENCES categoria_grupo1 (id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE livro_autor_grupo1 (
  id_livro INT NOT NULL,
  id_autor INT NOT NULL,
  PRIMARY KEY (id_livro, id_autor),
  FOREIGN KEY (id_livro) REFERENCES livro_grupo1 (id_livro) ON DELETE CASCADE,
  FOREIGN KEY (id_autor) REFERENCES autor_grupo1 (id_autor) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE funcionario_grupo1 (
  id_funcionario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(250) NOT NULL,
  cpf CHAR(11) NOT NULL,
  email VARCHAR(200) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  tipo_funcionario VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_funcionario),
  UNIQUE KEY (email),
  UNIQUE KEY uq_funcionario_cpf (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE atendente_grupo1 (
  id_funcionario INT NOT NULL,
  PRIMARY KEY (id_funcionario),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario_grupo1 (id_funcionario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE admin_grupo1 (
  id_funcionario INT NOT NULL,
  nivel_acesso VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_funcionario),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario_grupo1 (id_funcionario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE exemplar_grupo1 (
  id_exemplar INT NOT NULL AUTO_INCREMENT,
  codigo_patrimonial VARCHAR(30) NOT NULL,
  status VARCHAR(30) NOT NULL,
  finalidade VARCHAR(30) NOT NULL,
  id_livro INT NOT NULL,
  id_funcionario INT NOT NULL,
  PRIMARY KEY (id_exemplar),
  UNIQUE KEY (codigo_patrimonial),
  FOREIGN KEY (id_livro) REFERENCES livro_grupo1 (id_livro),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario_grupo1 (id_funcionario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE usuario_grupo1 (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) NOT NULL,
  email_usuario VARCHAR(200) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY (email_usuario),
  UNIQUE KEY uq_usuario_cpf (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE emprestimo_grupo1 (
  id_emprestimo INT NOT NULL AUTO_INCREMENT,
  data_emprestimo DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  data_devolucao DATE NULL,
  status VARCHAR(30) NOT NULL,
  id_usuario INT NOT NULL,
  id_exemplar INT NOT NULL,
  id_funcionario INT NOT NULL,
  PRIMARY KEY (id_emprestimo),
  FOREIGN KEY (id_usuario) REFERENCES usuario_grupo1 (id_usuario),
  FOREIGN KEY (id_exemplar) REFERENCES exemplar_grupo1 (id_exemplar),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario_grupo1 (id_funcionario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE multa_grupo1 (
  id_multa INT NOT NULL AUTO_INCREMENT,
  valor DECIMAL(10,2) NOT NULL,
  data_geracao DATE NOT NULL,
  data_pagamento DATE NULL,
  status VARCHAR(30) NOT NULL,
  id_emprestimo INT NOT NULL,
  PRIMARY KEY (id_multa),
  FOREIGN KEY (id_emprestimo) REFERENCES emprestimo_grupo1 (id_emprestimo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE formapagamento_grupo1 (
  id_forma_pagamento INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_forma_pagamento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE venda_grupo1 (
  id_venda INT NOT NULL AUTO_INCREMENT,
  data_venda DATE NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,
  id_usuario INT NOT NULL,
  id_forma_pagamento INT NOT NULL,
  id_funcionario INT NOT NULL,
  PRIMARY KEY (id_venda),
  FOREIGN KEY (id_usuario) REFERENCES usuario_grupo1 (id_usuario),
  FOREIGN KEY (id_forma_pagamento) REFERENCES formapagamento_grupo1 (id_forma_pagamento),
  FOREIGN KEY (id_funcionario) REFERENCES funcionario_grupo1 (id_funcionario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE itemvenda_grupo1 (
  id_item_venda INT NOT NULL AUTO_INCREMENT,
  preco_unitario DECIMAL(10,2) NOT NULL,
  id_venda INT NOT NULL,
  id_exemplar INT NOT NULL,
  PRIMARY KEY (id_item_venda),
  FOREIGN KEY (id_venda) REFERENCES venda_grupo1 (id_venda) ON DELETE CASCADE,
  FOREIGN KEY (id_exemplar) REFERENCES exemplar_grupo1 (id_exemplar)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET NAMES utf8mb4;

INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (1,'Romance');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (2,'Ficção Científica');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (3,'Fantasia');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (4,'História');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (5,'Tecnologia');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (6,'Ciência');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (7,'Infantil');
INSERT INTO `categoria_grupo1` (`id_categoria`, `nome`) VALUES (8,'Literatura Brasileira');

INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (1,'Machado de Assis','Brasileira');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (2,'Clarice Lispector','Brasileira');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (3,'João Guimarães Rosa','Brasileira');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (4,'George Orwell','Britânica');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (5,'J.R.R. Tolkien','Britânica');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (6,'Yuval Noah Harari','Israelense');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (7,'Robert C. Martin','Americana');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (8,'Erich Gamma','Suíça');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (9,'Richard Helm','Australiana');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (10,'Ralph Johnson','Americana');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (11,'John Vlissides','Americana');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (12,'Carl Sagan','Americana');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (13,'Stephen Hawking','Britânica');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (14,'Jorge Amado','Brasileira');
INSERT INTO `autor_grupo1` (`id_autor`, `nome`, `nacionalidade`) VALUES (15,'Antoine de Saint-Exupéry','Francesa');

INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (1,'Dom Casmurro','9781000000016',1899,39.90,8);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (2,'Memórias Póstumas de Brás Cubas','9781000000023',1881,36.90,8);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (3,'A Hora da Estrela','9781000000030',1977,34.90,8);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (4,'Grande Sertão: Veredas','9781000000047',1956,59.90,8);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (5,'1984','9781000000054',1949,44.90,2);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (6,'A Revolução dos Bichos','9781000000061',1945,29.90,2);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (7,'O Hobbit','9781000000078',1937,49.90,3);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (8,'O Senhor dos Anéis','9781000000085',1954,89.90,3);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (9,'Sapiens: Uma Breve História da Humanidade','9781000000092',2011,64.90,4);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (10,'Código Limpo','9781000000108',2008,79.90,5);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (11,'Padrões de Projeto','9781000000115',1994,98.90,5);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (12,'Cosmos','9781000000122',1980,54.90,6);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (13,'Uma Breve História do Tempo','9781000000139',1988,47.90,6);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (14,'Capitães da Areia','9781000000146',1937,37.90,8);
INSERT INTO `livro_grupo1` (`id_livro`, `titulo`, `isbn`, `ano_publicacao`, `preco_venda`, `id_categoria`) VALUES (15,'O Pequeno Príncipe','9781000000153',1943,24.90,7);

INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (1,1);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (2,1);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (3,2);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (4,3);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (5,4);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (6,4);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (7,5);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (8,5);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (9,6);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (10,7);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (11,8);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (11,9);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (11,10);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (11,11);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (12,12);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (13,13);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (14,14);
INSERT INTO `livro_autor_grupo1` (`id_livro`, `id_autor`) VALUES (15,15);

INSERT INTO `funcionario_grupo1` (`id_funcionario`, `nome`, `cpf`, `email`, `senha_hash`, `tipo_funcionario`) VALUES (1,'Roberto Nogueira','72176604164','roberto.nogueira@biblioteca.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','Admin');
INSERT INTO `funcionario_grupo1` (`id_funcionario`, `nome`, `cpf`, `email`, `senha_hash`, `tipo_funcionario`) VALUES (2,'Patrícia Mendes','77080719763','patricia.mendes@biblioteca.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','Admin');
INSERT INTO `funcionario_grupo1` (`id_funcionario`, `nome`, `cpf`, `email`, `senha_hash`, `tipo_funcionario`) VALUES (3,'Sérgio Vieira','79576170346','sergio.vieira@biblioteca.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','Atendente');
INSERT INTO `funcionario_grupo1` (`id_funcionario`, `nome`, `cpf`, `email`, `senha_hash`, `tipo_funcionario`) VALUES (4,'Larissa Duarte','80660596806','larissa.duarte@biblioteca.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','Atendente');
INSERT INTO `funcionario_grupo1` (`id_funcionario`, `nome`, `cpf`, `email`, `senha_hash`, `tipo_funcionario`) VALUES (5,'Thiago Barbosa','83288513420','thiago.barbosa@biblioteca.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','Atendente');

INSERT INTO `admin_grupo1` (`id_funcionario`, `nivel_acesso`) VALUES (1,'Total');
INSERT INTO `admin_grupo1` (`id_funcionario`, `nivel_acesso`) VALUES (2,'Gerencial');

INSERT INTO `atendente_grupo1` (`id_funcionario`) VALUES (3);
INSERT INTO `atendente_grupo1` (`id_funcionario`) VALUES (4);
INSERT INTO `atendente_grupo1` (`id_funcionario`) VALUES (5);

INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (1,'PAT-0001','Disponível','Empréstimo',1,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (2,'PAT-0002','Disponível','Empréstimo',1,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (3,'PAT-0003','Vendido','Venda',1,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (4,'PAT-0004','Disponível','Empréstimo',2,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (5,'PAT-0005','Disponível','Empréstimo',2,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (6,'PAT-0006','Disponível','Venda',2,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (7,'PAT-0007','Emprestado','Empréstimo',3,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (8,'PAT-0008','Disponível','Empréstimo',3,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (9,'PAT-0009','Vendido','Venda',3,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (10,'PAT-0010','Emprestado','Empréstimo',4,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (11,'PAT-0011','Manutenção','Empréstimo',4,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (12,'PAT-0012','Vendido','Venda',4,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (13,'PAT-0013','Emprestado','Empréstimo',5,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (14,'PAT-0014','Emprestado','Empréstimo',5,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (15,'PAT-0015','Vendido','Venda',5,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (16,'PAT-0016','Emprestado','Empréstimo',6,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (17,'PAT-0017','Disponível','Empréstimo',6,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (18,'PAT-0018','Disponível','Venda',6,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (19,'PAT-0019','Emprestado','Empréstimo',7,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (20,'PAT-0020','Disponível','Empréstimo',7,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (21,'PAT-0021','Disponível','Venda',7,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (22,'PAT-0022','Disponível','Empréstimo',8,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (23,'PAT-0023','Disponível','Empréstimo',8,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (24,'PAT-0024','Vendido','Venda',8,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (25,'PAT-0025','Disponível','Empréstimo',9,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (26,'PAT-0026','Disponível','Empréstimo',9,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (27,'PAT-0027','Disponível','Venda',9,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (28,'PAT-0028','Disponível','Empréstimo',10,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (29,'PAT-0029','Disponível','Empréstimo',10,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (30,'PAT-0030','Vendido','Venda',10,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (31,'PAT-0031','Disponível','Empréstimo',11,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (32,'PAT-0032','Disponível','Empréstimo',11,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (33,'PAT-0033','Vendido','Venda',11,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (34,'PAT-0034','Disponível','Empréstimo',12,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (35,'PAT-0035','Disponível','Empréstimo',12,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (36,'PAT-0036','Vendido','Venda',12,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (37,'PAT-0037','Disponível','Empréstimo',13,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (38,'PAT-0038','Disponível','Empréstimo',13,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (39,'PAT-0039','Disponível','Venda',13,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (40,'PAT-0040','Disponível','Empréstimo',14,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (41,'PAT-0041','Disponível','Empréstimo',14,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (42,'PAT-0042','Vendido','Venda',14,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (43,'PAT-0043','Disponível','Empréstimo',15,1);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (44,'PAT-0044','Disponível','Empréstimo',15,2);
INSERT INTO `exemplar_grupo1` (`id_exemplar`, `codigo_patrimonial`, `status`, `finalidade`, `id_livro`, `id_funcionario`) VALUES (45,'PAT-0045','Vendido','Venda',15,1);

INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (1,'Ana Beatriz Souza','11601784619','ana.souza@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(11) 91234-5601');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (2,'Carlos Eduardo Lima','28290487258','carlos.lima@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(11) 91234-5602');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (3,'Mariana Ferreira','30802300278','mariana.ferreira@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(11) 91234-5603');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (4,'Rafael Almeida','39741900589','rafael.almeida@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(11) 91234-5604');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (5,'Juliana Costa','39767179593','juliana.costa@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(21) 98765-4305');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (6,'Pedro Henrique Rocha','41070427900','pedro.rocha@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(21) 98765-4306');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (7,'Fernanda Oliveira','42567571477','fernanda.oliveira@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(31) 99876-5407');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (8,'Lucas Martins','53157546422','lucas.martins@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(31) 99876-5408');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (9,'Camila Ribeiro','53355348694','camila.ribeiro@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(41) 99654-3209');
INSERT INTO `usuario_grupo1` (`id_usuario`, `nome`, `cpf`, `email_usuario`, `senha_hash`, `telefone`) VALUES (10,'Gabriel Santos','66509497441','gabriel.santos@email.com','$2y$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ0123456','(41) 99654-3210');

INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (1,'2026-08-05','2026-08-19','2026-08-18','Devolvido',1,1,3);
INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (2,'2026-08-12','2026-08-26','2026-09-05','Devolvido',2,2,3);
INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (3,'2026-08-20','2026-09-03','2026-09-03','Devolvido',3,4,4);
INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (4,'2026-09-01','2026-09-15','2026-09-25','Devolvido',4,5,4);
INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (6,'2026-09-15','2026-09-29','2026-09-28','Devolvido',6,8,4);
INSERT INTO `emprestimo_grupo1` (`id_emprestimo`, `data_emprestimo`, `data_prevista_devolucao`, `data_devolucao`, `status`, `id_usuario`, `id_exemplar`, `id_funcionario`) VALUES (12,'2026-07-10','2026-07-24','2026-07-24','Devolvido',3,20,4);

INSERT INTO `multa_grupo1` (`id_multa`, `valor`, `data_geracao`, `data_pagamento`, `status`, `id_emprestimo`) VALUES (1,5.00,'2026-09-05','2026-09-05','Paga',2);
INSERT INTO `multa_grupo1` (`id_multa`, `valor`, `data_geracao`, `data_pagamento`, `status`, `id_emprestimo`) VALUES (2,5.00,'2026-09-25','2026-09-30','Paga',4);

INSERT INTO `formapagamento_grupo1` (`id_forma_pagamento`, `tipo`) VALUES (1,'Dinheiro');
INSERT INTO `formapagamento_grupo1` (`id_forma_pagamento`, `tipo`) VALUES (2,'Pix');
INSERT INTO `formapagamento_grupo1` (`id_forma_pagamento`, `tipo`) VALUES (3,'Cartão de Crédito');
INSERT INTO `formapagamento_grupo1` (`id_forma_pagamento`, `tipo`) VALUES (4,'Cartão de Débito');
INSERT INTO `formapagamento_grupo1` (`id_forma_pagamento`, `tipo`) VALUES (5,'Boleto');

INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (1,'2026-08-03',84.80,1,2,1);
INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (2,'2026-08-10',89.90,3,3,2);
INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (3,'2026-08-21',233.70,5,3,1);
INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (4,'2026-09-02',34.90,2,1,3);
INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (5,'2026-09-14',37.90,7,4,4);
INSERT INTO `venda_grupo1` (`id_venda`, `data_venda`, `valor_total`, `id_usuario`, `id_forma_pagamento`, `id_funcionario`) VALUES (6,'2026-09-28',84.80,9,2,5);

INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (1,39.90,1,3);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (2,44.90,1,15);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (3,89.90,2,24);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (4,79.90,3,30);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (5,98.90,3,33);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (6,54.90,3,36);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (7,34.90,4,9);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (8,37.90,5,42);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (9,24.90,6,45);
INSERT INTO `itemvenda_grupo1` (`id_item_venda`, `preco_unitario`, `id_venda`, `id_exemplar`) VALUES (10,59.90,6,12);
