create database fazenda_palmitos_GustavoLanna;
use fazenda_palmitos_GustavoLanna;

create table palmito (
id_palmito int not null primary key auto_increment,
tipo_palmito varchar (255) not null,
preco_venda double not null,
estoque_atual int not null,
data_plantio date,
data_colheita date);

insert into palmito (tipo_palmito, preco_venda, estoque_atual, data_plantio, data_colheita) values 
('Pupunha', 15.50, 200, '2023-02-15', '2024-02-15'), ('Açaí', 10.50, 150, '2023-01-10', '2024-01-10'),
('Jussara', 18.75, 80, '2023-01-10', '2024-01-10'), ('Real', 20.00, 60, '2023-04-20', '2024-04-20'),
('Pupunha Premium', 25.00, 40, '2023-05-15', '2024-05-15'), ('Açaí Orgânico', 12.50, 100, '2023-06-10', '2024-06-10'),
('Jussara Orgânico', 19.00, 70, '2022-07-22', '2024-07-22'), ('Real Orgânico', 22.50, 30, '2023-08-01', '2024-08-01'),
('Pupunha Orgânico', 16.50, 50, '2023-09-05', '2024-09-05'), ('Açaí Premium', 13.50, 120, '2023-10-12', '2024-10-12');

select * from palmito;

##
create table fornecedor (
id_fornecedor int not null primary key auto_increment,
nome_fornecedor varchar (255) not null,
contato varchar(14) not null,
cidade varchar(255) not null);

insert into fornecedor (nome_fornecedor, contato, cidade) values 
('Fazenda Verde', '(11)98765-4321', 'São Paulo'), ('Agro Palm', '(21)91234-5678', 'Rio de Janeiro'),
('Orgânicos S.A.', '(47)99876-5432', 'Florianópolis'), ('EcoPlanta', '(31)92345-6789', 'Belo Horizonte'),
('Sustenta Verde', '(61)99999-9999', 'Brasília'), ('Horti Vida', '(81)97654-3210', 'Recife'),
('AgroPalmito', '(19)93210-5678', 'Campinas'), ('VerdeOrg', '(41)94321-7654', 'Curitiba'),
('PlantarBem', '(62)95432-1098', 'Goiânia'), ('BioPalm', '(85)98765-1324', 'Fortaleza');    

select * from fornecedor;

##
create table compra (
id_compra int not null primary key auto_increment,
quantidade_comprada int not null,
data_compra date not null,
preco_total decimal not null,
id_palmito int,
constraint fk_id_palmito foreign key (id_palmito) references palmito(id_palmito));

insert into compra (id_palmito, quantidade_comprada, data_compra, preco_total) values 
(1, 100, '2024-01-05', 1550.00), (2, 50, '2024-01-12', 500.00),
(3, 40, '2024-01-18', 750.00), (4, 20, '2024-02-01', 400.00),
(5, 10, '2024-02-15', 250.00), (6, 80, '2024-02-20', 1000.00),
(7, 50, '2024-02-25', 950.00), (8, 30, '2024-03-10', 675.00),
(9, 40, '2024-03-10', 660.00), (10, 70, '2024-03-18', 945.00);

select * from compra;

##
create table venda(
id_venda int not null primary key auto_increment,
quantidade_vendida int not null,
data_venda date,
preco_total decimal,
id_palmito int,
constraint fk_id_palmitos foreign key (id_palmito) references palmito(id_palmito));

insert into venda (id_palmito, quantidade_vendida, data_venda, preco_total) values
(1, 50, '2024-03-10', 775.00), (2, 30, '2024-03-15', 300.00), (3, 20, '2024-03-20', 375.00), 
(4, 10, '2024-03-25', 200.00), (5, 5, '2024-04-05', 125.00), (6, 40, '2024-04-10', 500.00), 
(7, 35, '2024-04-12', 665.00), (8, 20, '2024-04-18', 450.00), (9, 25, '2024-04-20', 412.00), 
(10, 60, '2024-04-22', 810.00);

select * from venda;

# 1) Consultas usando Where, Order By, Group By, Having
#Consulta 1
select p.tipo_palmito, p.id_palmito, v.quantidade_vendida from venda v 
inner join palmito p on p.id_palmito = v.id_palmito where tipo_palmito = 'Pupunha'; 

#Consulta 2
create index idx_vendas_data on venda(data_venda);
select * from venda order by data_venda desc;

#Consulta 3 - Exibir o total de vendas por tipo de palmito, agrupando pelo id_palmito.
select 
	v.quantidade_vendida as 'Quantidade de Vendas', 
	p.tipo_palmito as 'Tipo de Palmito', p.id_palmito as 'Código' from venda v
join palmito p using (id_palmito) group by id_palmito;


/*Consulta 4 - Listar os tipos de palmito cuja venda total excedeu 500 unidades, 
utilizando Having. Verificar pq n aparece*/
select p.tipo_palmito as 'Tipo Palmito', SUM(v.quantidade_vendida) as 'Total Vendido' from venda v
join palmito p on v.id_palmito = p.id_palmito group by p.tipo_palmito 
having SUM(v.quantidade_vendida) > 500;


/* 2) Criação de funções, procedures e Triggers 
a - calcular o total de vendas de um palmito;
b - inserir uma nova venda e atualizar o estoque;
c - atualizar o estoque automaticamente ao inserir uma nova compra;
*/



/* 3) Criação de views*/
# a - mostrar a situação atual do estoque;
create view situacao_estoque as 
select tipo_palmito as 'Tipo Palmito', estoque_atual as 'Estoque Atual', 
preco_venda as 'Preço de venda' from palmito;
select * from situacao_estoque;

# b - exibir o histórico de vendas por tipo de palmito;
create view historico_vendas as
select p.id_palmito as 'ID',  p.tipo_palmito as 'Tipo Palmito', v.quantidade_vendida as 'Quantidade Vendida', v.data_venda as 'Data venda' from venda v
join palmito p on v.id_palmito = p.id_palmito;
select * from historico_vendas;
