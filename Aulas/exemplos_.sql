create database bd_fatec;
use bd_fatec;

create table alunos (
idAluno int auto_increment primary key,
nome varchar(100),
cpf  varchar(14)
); 

insert into alunos (nome,cpf) values
("pedro","123.456.789-01"),
("lucas","111.222.333.44"),
("barbara","555.666.777.88");

 # Seleção de todos os registros
select * from alunos;

 # atualizando dados em tabela
 update alunos set cpf="111.222.333.55" where idAluno=2;
 
 # adicionar colunas na tabela
alter table alunos add column rg varchar(15);
alter table alunos add column tel varchar(14);

# mudar nome da coluna
alter table alunos change tel celular varchar(14);

# remover coluna
alter table alunos drop column rg; 

# apelido de coluna
select idAluno as ID, nome as "Nome do aluno", cpf as CPF, celular as "Telefones" from alunos;

#apelido de tabela 
select a.nome, a.cpf from alunos a;

create table disciplinas(
idDisc int auto_increment primary key,
nomeDisc varchar(100));

insert into disciplinas (nomeDisc) values
("Banco de dados"),
("Desenvolvimento Web"),
("Design digital");

create table matricula(
idMatricula int auto_increment primary key,
aluno int,
disciplina int,

#criar chave estrangeira
constraint fk_aluno_disciplina foreign key (aluno) references alunos(idAluno),
foreign key(disciplina) references disciplinas(idDisc)
);

insert into matricula (aluno, disciplina) values
(1,1),
(1,2),
(1,3),
(2,1),
(2,3),
(3,1);

#relacionamento entre tabelas usando INNER JOIN
select a.nome as "Nome do aluno", d.nomeDisc as "Disciplinas" from matricula
inner join alunos a on matricula.aluno = a.idAluno
inner join disciplinas d on matricula.disciplina = d.idDisc where matricula.Aluno = 1;





























