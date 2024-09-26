CREATE DATABASE quaggio;
USE quaggio;
 
CREATE TABLE sistemas (
idSistema INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
funcionalidade VARCHAR(100) NOT NULL);
 
CREATE TABLE empresas (
idEmpresa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
cnpj VARCHAR (14) NOT NULL);

CREATE TABLE tiposUsuarios (
idTipoUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (100) NOT NULL);
 
CREATE TABLE usuarios (
idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
senha VARCHAR (20) NOT NULL,
email VARCHAR (100) NOT NULL,
idEmpresa INT NOT NULL,
idTipoUsuario INT NOT NULL,
CONSTRAINT fk_idEmpresa FOREIGN KEY (idEmpresa) REFERENCES empresas (idEmpresa),
CONSTRAINT fk_idTipoUsuario FOREIGN KEY (idTipoUsuario) REFERENCES tiposUsuarios (idTipoUsuario));

CREATE TABLE remessas(
idRemessa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
qtdQueijos INT NOT NULL,
dtCadastro DATE NOT NULL, 
descricao VARCHAR (100) NOT NULL,
idUsuario INT NOT NULL,
CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario));
 
CREATE TABLE queijos(
idQueijo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipoQueijo VARCHAR (100) NOT NULL,
tempoMaturacao INT NOT NULL);
 
CREATE TABLE producoes (
idProducao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idQueijo INT NOT NULL,
idRemessa INT NOT NULL,
CONSTRAINT fk_idQueijo FOREIGN KEY (idQueijo) REFERENCES queijos (idQueijo),
CONSTRAINT fk_idRemessa FOREIGN KEY (idRemessa) REFERENCES remessas (idRemessa));

/*CREATE TABLE acessos (
idAcesso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipoAcesso VARCHAR (100));*/
 
CREATE TABLE telefones (
idTelefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
telefone VARCHAR (14) NOT NULL,
idUsuario INT NOT NULL,
constraint fk_idUsuarioTel FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario));

/*,
idPermissao INT,
CONSTRAINT fk_idPermissao FOREIGN KEY (idPermissao) REFERENCES permissoes (idPermissao));
 
CREATE TABLE permissoes (
idPermissao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
permissao VARCHAR (100));*/
 
insert into sistemas (nome, funcionalidade) values ("Quaggio System", "Controle de qualidade de queijo de Búfala");
select * from sistemas;
 
insert into queijos (tipoQueijo, tempoMaturacao) values ("Burrata", "15"), ('Trança Lisa', '10'), ('Mussarela', '30'), ('Mussarela', '20');
select * from queijos;

insert into empresas (nome, cnpj) values ("Ollintech","56787021000153");
select * from empresas;

insert into tiposUsuarios (tipo) values ('Admin'), ('Funcionário');
select * from tiposUsuarios;

 insert into usuarios (nome, senha, email, idEmpresa, idTipoUsuario) values ('Gustavo', '123', 'gusta@gmail.com', 1, 1), ('Ana', '456', 'kunzen@gmail.com', 1, 2), ('Yasmin', '456', 'yas@gmail.com', 1, 2), ('Isabely', '545', 'isabely@gmail.com', 1, 2);
 select * from usuarios;
 
 insert into telefones (telefone, idUsuario) values ('13996992678', 1), ('13996995768', 2), ('13997775768', 3), ('13886995768', 4);
select * from telefones;

insert into remessas (qtdQueijos, dtCadastro, descricao, idUsuario) values (27, '2024-09-04', 'Primeira remessa.', 1), (10, '2024-07-05', 'Segunda Remessa', 2), (10, '2024-03-05', 'Terceira Remessa', 3), (10, '2024-02-05', 'Quarta Remessa', 4);
 select * from remessas;
 
insert into producoes (idQueijo, idRemessa) values (1,1), (2, 2), (3, 3), (4, 4);
select * from producoes;

 SELECT 
    u.nome AS 'Nome do Usuário',
    u.email AS 'Email',
    r.qtdQueijos AS 'Quantidade de queijos',
    r.dtCadastro AS 'Data de cadastro',
    r.descricao AS 'Descrição da remessa',
    q.tipoQueijo AS 'Tipo de queijo',
    q.tempoMaturacao AS 'Tempo de maturação'
FROM 
    usuarios u
JOIN remessas r ON u.idUsuario = r.idUsuario
JOIN producoes p ON r.idRemessa = p.idRemessa
JOIN queijos q ON p.idQueijo = q.idQueijo;

SELECT 
    u.idUsuario AS 'ID do Usuário',
    u.nome AS 'Nome do Usuário',
    u.email AS 'Email',
    u.senha AS 'Senha',
    u.idEmpresa AS 'ID da Empresa',
    e.nome AS 'Nome da Empresa',
    e.cnpj AS 'CNPJ da Empresa',
    u.idTipoUsuario AS 'ID do Tipo de Usuário',
    tu.tipo AS 'Tipo de Usuário',
    r.idRemessa AS 'ID da Remessa',
    r.qtdQueijos AS 'Quantidade de Queijos',
    r.dtCadastro AS 'Data de Cadastro',
    r.descricao AS 'Descrição da Remessa',
    q.idQueijo AS 'ID do Queijo',
    q.tipoQueijo AS 'Tipo de Queijo',
    q.tempoMaturacao AS 'Tempo de Maturação',
    p.idProducao AS 'ID da Produção',
    t.idTelefone AS 'ID do Telefone',
    t.telefone AS 'Telefone'
FROM 
    usuarios u
JOIN empresas e ON u.idEmpresa = e.idEmpresa
JOIN tiposUsuarios tu ON u.idTipoUsuario = tu.idTipoUsuario
JOIN remessas r ON u.idUsuario = r.idUsuario
JOIN producoes p ON r.idRemessa = p.idRemessa
JOIN queijos q ON p.idQueijo = q.idQueijo
LEFT JOIN telefones t ON u.idUsuario = t.idUsuario;