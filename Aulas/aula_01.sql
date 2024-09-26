create database bd_fatec;
use bd_fatec;

#criando tabela
create table alunos (
idAluno int auto_increment primary key,
nome varchar(100),
cpf  varchar(14)); 

#inserindo dados
insert into alunos (nome,cpf) values
("pedro","123.456.789-01"),
("lucas","111.222.333.44"),
("barbara","555.666.777.88");

 # Seleção de todos os registros
select * from alunos;

#adicionar campos na tabela
alter table alunos add column rg varchar(13);
alter table alunos add column tel varchar(14);
select * from alunos;

#troca nome da tabela
alter table alunos change tel celular varchar(14);

#excluir
alter table alunos drop column rg;

#apelido de campo
select idAluno as ID, cpf as CPF, celular as Telefone, nome as Nome from alunos;




