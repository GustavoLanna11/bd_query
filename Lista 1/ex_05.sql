CREATE DATABASE gerPedidos;
USE gerPedidos;

CREATE TABLE clientes (
clienteId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
cidade VARCHAR (50) NOT NULL,
estado VARCHAR (50) NOT NULL,
rua VARCHAR (50) NOT NULL, 
numero INT NOT NULL,
email VARCHAR (100),
pedidoId INT,
CONSTRAINT fk_pedido FOREIGN KEY (pedidoId) REFERENCES pedidos (pedidoId));

CREATE TABLE pedidos (
pedidoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
dtPedido DATE,
totalPedido VARCHAR (50),
statusPedido VARCHAR (100));
