create database biblioteca;
use biblioteca;

create table livros (
cod_livros int not null primary key auto_increment,
ISBN bigint (13),
titulo varchar (255),
subTitulo varchar (255),
anoPublicacao int (4),
genero varchar (100),
breve_descricao varchar (255));

create table autores(
cod_autor int not null primary key auto_increment,
nome_completo varchar (255),
dtNasc date,
biografiaResumida varchar (255));

create table livrosXautores(
idx int auto_increment primary key,
cod_livros int,
cod_autor int,
constraint fk_codLivro foreign key (cod_livros) references livros (cod_livros),
constraint fk_codAutor foreign key (cod_autor) references autores (cod_autor));

create table usuarios (
codUsuario int not null primary key auto_increment,
nomeCompleto varchar (255),
endereco varchar (255),
bairro varchar(100),
cidade varchar(100),
estado varchar (2));

alter table usuarios add column assinatura enum ("Aluno", "Professor", "Funcionario") default "Aluno"; 
insert into usuarios (nomeCompleto, assinatura) values ("Luiz Claudio", "Professor");
select * from usuarios;
alter table usuarios change assinatura assinatura enum("Aluno","Professor","Funcionario","Diretor") default "Aluno";

create table telefones(
id_telefone int auto_increment primary key,
telefone int (11),
codUsuario int,
constraint foreign key (codUsuario) references usuarios(codUsuario));
 
create table emails(
id_email int auto_increment primary key,
codUsuario int,
email varchar(255),
constraint foreign key (codUsuario) references usuarios (codUsuario));

create table usuariosXtelefone(
idx int not null primary key auto_increment,
telefone bigint(11),
codUsuario int,
constraint fk_idUsuario_tel foreign key (codUsuario) references usuarios (codUsuario));

create table emprestimos(
id_emp int auto_increment primary key,
data_emp date not null,
data_devolucaoPrevista date not null,
data_devolucaoReal date,
codUsuario int,
constraint foreign key (codUsuario) references usuarios(codUsuario));

create table empXlivros(
id int auto_increment primary key,
cod_livros int,
id_emp int,
constraint foreign key (cod_livros) references livros (cod_livros),
constraint foreign key (id_emp) references emprestimos (id_emp));

create table usuariosXemails (
idx int not null primary key auto_increment,
codUsuario int,
email varchar (255),
constraint fk_idUsuario_emails foreign key (codUsuario) references usuarios (codUsuario));

/*create table categoriaUsuarios (
idx int not null primary key auto_increment,
assinatura enum ("Aluno", "Professor", "Funcionario") default "Aluno"
);*/

insert into livros (ISBN, titulo, subTitulo, anoPublicacao, genero, breve_descricao) values (9780140449136, 'A Odisséia', 'Traduzido por: João Pereira', 800, 'Épico', 'A história épica de 
Odisseu e sua jornada de volta para casa.');
insert into livros (ISBN, titulo, subTitulo, anoPublicacao, genero, breve_descricao) values(9780321125217, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 2008, 
'Tecnologia', 'Conselhos e melhores práticas para escrever código limpo e manutenível.');
insert into livros (ISBN, titulo, subTitulo, anoPublicacao, genero, breve_descricao) values(9780201616224, 'Design Patterns', 'Elements of Reusable Object-Oriented Software', 1994, 
'Tecnologia', 'Padrões de design de software e suas aplicações em programação orientada a 
objetos.');

insert into autores (nome_completo, dtNasc, biografiaResumida) values ('Homero', '0800-01-01', 'Poeta grego da Antiguidade, autor da Ilíada e da Odisséia.');
insert into autores (nome_completo, dtNasc, biografiaResumida) values ('Robert C. Martin', '1952-12-05', 'Engenheiro de software e autor conhecido por seu trabalho 
em princípios de design de software.');
insert into autores (nome_completo, dtNasc, biografiaResumida) values ('Erich Gamma', '1960-03-22', 'Um dos autores do famoso livro "Design Patterns", professor e 
consultor em design de software.');

insert into livrosXautores (cod_livros, cod_autor) values (1, 1);
insert into livrosXautores (cod_livros, cod_autor) values (2, 2);
insert into livrosXautores (cod_livros, cod_autor) values (3, 3);

INSERT INTO usuarios (nomeCompleto, endereco, bairro, cidade, estado, assinatura)
VALUES
('Ana Silva', 'Rua das Flores, 123', 'Jardim Primavera', 'São Paulo', 'SP', 'Aluno'),
('João Souza', 'Avenida Central, 456', 'Centro', 'Rio de Janeiro', 'RJ', 'Professor'),
('Maria Oliveira', 'Praça da Liberdade, 789', 'Liberdade', 'Belo Horizonte', 'MG', 'Funcionario');

INSERT INTO usuariosXtelefone (codUsuario, telefone)
VALUES
(1, 11987654321),
(2, 21987654321),
(3, 31987654321);

INSERT INTO usuariosXemails (codUsuario, email)
VALUES
(1, 'ana.silva@example.com'),
(2, 'joao.souza@example.com'),
(4, 'maria.oliveira@example.com');

INSERT INTO emprestimos (data_emp, data_devolucaoPrevista, data_devolucaoReal, codUsuario)
VALUES
('2024-08-01', '2024-08-15', NULL, 1),
('2024-08-05', '2024-08-20', NULL, 2),
('2024-08-10', '2024-08-25', NULL, 3);
insert into empXlivros (cod_livros, id_emp) values (1,1), (2,2), (3,3);

#Exercício 1
select cod_livros, ISBN, titulo from livros;  
 
#Exercício 2
select * from autores where DATE(dtNasc) <= '1974-01-01' ;

#Exercício 3
select * from usuarios where assinatura = 'Professor';

#Exercício 4
select * from emprestimos where DATE(data_devolucaoReal) is null;

#Exercício 5
SELECT l.titulo AS nome_livro, a.nome_completo AS nome_autor FROM livrosXautores lxa
INNER JOIN livros l ON lxa.cod_livros = l.cod_livros
INNER JOIN autores a ON lxa.cod_autor = a.cod_autor;

#Exercício 6
select livros.titulo, autores.nome_completo from livrosXautores
inner join livros on livrosXautores.cod_livros = livros.cod_livros
inner join autores on livrosXautores.cod_autor = autores.cod_autor; 

#Exercício 7
SELECT u.nomeCompleto, t.telefone
FROM usuarios u
JOIN usuariosXtelefone t ON u.codUsuario = t.codUsuario;

#Exercício 8
select e.email from usuarios u join usuariosXemails e on u.codUsuario = e.codUsuario
where u.assinatura = 'Funcionario';

#Exercício 9
select ISBN, titulo, subTitulo, anoPublicacao, genero, breve_descricao from livros
where anoPublicacao > 2000 order by anoPublicacao;

#Exercício 10
select nome_completo, biografiaResumida from autores where biografiaResumida LIKE '%design';

#Exercício 11
SELECT 
    e.id_emp,
    e.data_emp,
    e.data_devolucaoPrevista,
    e.data_devolucaoReal,
    u.nomeCompleto,
    u.endereco,
    u.bairro,
    u.cidade,
    u.estado
FROM emprestimos e
JOIN usuarios u
ON e.codUsuario = u.codUsuario
WHERE u.cidade = 'São Paulo';

#Exercício 12
SELECT genero, COUNT(*) AS quantidade_livros
FROM livros
GROUP BY genero;

#Exercício 13
SELECT a.nome_completo, COUNT(l.cod_livros) AS numero_livros
FROM livrosXautores la
JOIN autores a ON la.cod_autor = a.cod_autor
JOIN livros l ON la.cod_livros = l.cod_livros
GROUP BY a.cod_autor
ORDER BY numero_livros DESC LIMIT 1;

#Exercício 14
SELECT 
    u.codUsuario,
    u.nomeCompleto,
    u.endereco,
    u.bairro,
    u.cidade,
    u.estado,
    u.assinatura
FROM usuarios u
LEFT JOIN emprestimos e
ON u.codUsuario = e.codUsuario
WHERE e.id_emp IS NULL;

#Exercício 15
SELECT 
    l.ISBN,
    l.titulo,
    l.subTitulo,
    l.anoPublicacao,
    l.genero,
    l.breve_descricao
FROM emprestimos e
JOIN empXlivros el ON e.id_emp = el.id_emp
JOIN livros l ON el.cod_livros = l.cod_livros
WHERE e.data_devolucaoReal IS NULL;
