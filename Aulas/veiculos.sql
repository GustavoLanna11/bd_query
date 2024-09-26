#Criação de banco de dados caso não exista
create database if not exists emptech;
use emptech;

create table if not exists funcionarios(
codFunc int auto_increment primary key,
nomeFunc varchar(255) not null);

create table if not exists veiculos(
codVeic int auto_increment primary key,
modelo varchar(255) not null,
placas varchar(20) not null,
codFunc int);

insert into funcionarios (nomeFunc) values 
('João Silva'), ('Maria Oliveira'), ('Pedro Santos'), ('Ana Costa'), ('Lucas Almeida'), ('Fernanda Lima'),
#novos itens
('Gustavo Lanna'), ('Yasmin Pires'), ('Ana Flávia');

insert into veiculos (Modelo, Placas, codFunc) values 
('Fiat Uno', 'ABCD123', 1), ('Honda Civic', 'XYZ2E34', 1), ('Toyota Corolla', 'LMN3F45', 2), ('Chevrolet Onix', 'OPQ4G56', 3),
('VW Gol', 'UVM6I78', 5), ('Peugeot 208', 'YZA7J89', null),
#novos itens
('BMW 320i', 'CHAMAS1', 4), ('Camaro', 'ABCD134', 3), ('BMW 320i', 'HLK2D34', 5);

create table atuacaoVendas (
codAtuacao int auto_increment primary key,
descricao varchar (255) not null);

insert into atuacaoVendas (descricao) values 
('Vendas de veículos novos'), ('Vendas de veículos usados'), ('Manutenção e reparo de veículos'), ('Serviços de pós-vendas'), ('Vendas de veículos novos'),('Consultoria de Vendas'), ('Programações e eventos especiais'),
#novos itens
('Devolução de veículos'), ('Troca de câmbio'), ('Troca de óleo'); 

create table indicacoes (
codIndicador int,
codIndicado int,
primary key (codIndicador, codIndicado),
foreign key (codIndicador) references Funcionarios (codFunc),
foreign key (codIndicado) references Funcionarios(codFunc));

insert into indicacoes (codIndicador, codIndicado) values (1,2),(1,3),(2,4),(2,5),(4,6),
#novos itens
(2,4),(4,5),(1,2);





#Inner join
select funcionarios.nomeFunc as Nome, veiculos.modelo from veiculos
join funcionarios on veiculos.codFunc = funcionarios.codFunc;

#Equi join - mesma coisa do inner join porem escrito diferente
#usa um nome comum entre dois relacionamentos
select f.nomeFunc as Nome, v.modelo from veiculos v 
join funcionarios f using (codFunc);

#left join
/*Retorna todos os campos do lado esquerdo do Join que se relaciona com o lado direito do join, mais os registros que não se relacionam com o lado direito e que sejam do lado esquerdo*/
select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc);

#Right join 
/*Retorna todos os campos do lado direito do join que se relaciona com o lado esquerdo do joinm mais os registros que não se relacionam com o lado esquerdo e que sejam do lado direito*/
select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

#full join
select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc)
union
select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

#View - Estrutura de seleção que encapsula querys complexas para simplificar o uso ao usuario e facilitar as chamadas em aplicações externas
create view func_veiculos as
select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc)
union
select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

select * from func_veiculos;

#Cross Join
/*Este join iria criar relatiorio onde irão fazer todas as combinações possíveis entre as tabelas.
ex: se cruzarmos as tabelas funcionario, veiculos e atuacaoVendas onde teremos tabela funcionarios com 6 registros, tabela veiculos com 7 registros e tabela atuacaovendas com 6 vendas, iremos num resultado de combinacao 6 X 7 X 6 que totalizara 252 combinacaoes*/
select f.codFunc, f.nomeFunc, v.modelo, v.placas, a.descricao from funcionarios f
cross join veiculos v
cross join atuacaoVendas a;

#Self Join
/*Gera um resultado de relacionamento de dados de uma tabela com ela mesma, ou seja, um auto-relacionamento. */
select i1.codIndicador as 'IndicadorID', f1.nomeFunc as 'Nome Indicador', 
i1.codIndicado as 'ID Indicado', f2.nomeFunc as 'Nome Indicado' from indicacoes i1 
join funcionarios f1 on i1.codIndicador = f1.codFunc
join funcionarios f2 on i1.codIndicado = f2.codFunc;



