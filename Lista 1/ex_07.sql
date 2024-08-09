CREATE DATABASE academico;
USE academico;

CREATE TABLE alunos (
alunoId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
dtNasc DATE NOT NULL,
cidade VARCHAR (50) NOT NULL,
estado VARCHAR (50) NOT NULL,
rua VARCHAR (50) NOT NULL, 
numero INT NOT NULL,
email VARCHAR (100) NOT NULL);

CREATE TABLE disciplinas (
disciplinaId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
professor VARCHAR(100) NOT NULL,
horario VARCHAR (10) NOT NULL);

CREATE TABLE matriculas (
matriculaId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
dtMatricula DATE NOT NULL,
nota INT NOT NULL,
alunoId INT NOT NULL,
disciplinaId INT NOT NULL,
CONSTRAINT fk_alunos FOREIGN KEY (alunoId) REFERENCES alunos (alunoId),
CONSTRAINT fk_disciplinas FOREIGN KEY (disciplinaId) REFERENCES disciplinas (disciplinaId));