CREATE DATABASE gerenciamento;
USE gerenciamento;

CREATE TABLE clientes (
clienteId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL, 
cidade VARCHAR (50) NOT NULL,
estado VARCHAR (50) NOT NULL,
rua VARCHAR (50) NOT NULL, 
numero INT NOT NULL);

CREATE TABLE cartoes (
cartaoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
numero VARCHAR (20) NOT NULL,
dtValidade DATE NOT NULL,
limite VARCHAR (100) NOT NULL);