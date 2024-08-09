CREATE DATABASE gerInventario;
USE gerInventario;

CREATE TABLE categorias (
categoriaId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100), 
descricao VARCHAR (100),
produtoId INT, 
CONSTRAINT fk_pedido FOREIGN KEY (produtoId) REFERENCES produtos (produtoId));


CREATE TABLE produtos (
produtoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nomeProduto VARCHAR (100) NOT NULL,
preco VARCHAR (50) NOT NULL,
qtdEstoque INT NOT NULL);