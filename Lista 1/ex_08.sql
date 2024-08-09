CREATE DATABASE publicacao;
USE publicacao;

CREATE TABLE autores (
autorId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
afiliacao VARCHAR (100) NOT NULL,
email VARCHAR (100) NOT NULL);

CREATE TABLE artigos (
artigoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR (100) NOT NULL,
resumo VARCHAR(100) NOT NULL,
dtPublicacao DATE NOT NULL);

CREATE TABLE contribuicoes (
contribuicaoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
papelAutor VARCHAR (300) NOT NULL,
ordemAutoria VARCHAR (100) NOT NULL,
artigoId INT NOT NULL,
autorId INT NOT NULL,
CONSTRAINT fk_artigo FOREIGN KEY (artigoId) REFERENCES artigos (artigoId),
CONSTRAINT fk_autor FOREIGN KEY (autorId) REFERENCES autores (autorId));