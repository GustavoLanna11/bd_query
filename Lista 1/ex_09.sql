CREATE DATABASE gerprojetos;
USE gerprojetos;

CREATE TABLE funcionarios (
funcionarioId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
cargo VARCHAR (100) NOT NULL, 
dtContratacao DATE NOT NULL,
salario VARCHAR (30) NOT NULL);

CREATE TABLE projetos (
projetoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
dtInicio DATE NOT NULL,
dtTermino DATE NOT NULL,
orcamento VARCHAR (100));

CREATE TABLE atribuicoes (
atribuicaoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
funcao VARCHAR (100) NOT NULL,
horasAlocadas VARCHAR (100) NOT NULL,
projetoId INT NOT NULL,
funcionarioId INT NOT NULL,
CONSTRAINT fk_projeto FOREIGN KEY (projetoId) REFERENCES projetos (projetoId),
CONSTRAINT fk_funcionario FOREIGN KEY (funcionarioId) REFERENCES funcionarios (funcionarioId));