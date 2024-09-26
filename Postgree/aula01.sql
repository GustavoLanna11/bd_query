 --Traço Traço para comentário de linha!
create database nomeBanco;

--Criar Tabela
create table tipoProdutos(
	--serial é um dado inteiro e auto_increment
	idProd serial primary key,
	descricao varchar(100)
);

create table produtos(
	idProduto serial primary key,
	descricao varchar(100) not null,
	preco money not null, --tipo de dado exclusivo para moedas
	id_tipo_produto int references tipoProdutos(idProd)--criação de Foreign Key
);

/*Inserindo dados na tabela - Apenas com aspas simples*/
insert into tipoProdutos (descricao) values ('Computador'), ('Impressora');


insert into produtos (descricao, preco, id_tipo_produto) values 
	('Desktop', 1200.00, 1), ('Laptop', 3200.00, 1),
	('Impressora Jato de Tinta', 500.00, 2), ('Impressora Laser',1200.00, 2);

select * from produtos;
select * from produtos order by descricao desc;
select * from produtos order by preco asc;

select * from produtos where id_tipo_produto = 2;  
