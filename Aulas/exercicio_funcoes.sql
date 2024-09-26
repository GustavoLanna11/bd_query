create database sistemaVendasLivros;
use sistemaVendasLivros;

create table autores(
autorId int auto_increment primary key not null,
nome varchar (255),
pais varchar (50));

create table livros(
livroId int not null primary key auto_increment,
titulo varchar(255) not null,
preco decimal (10,2),
estoque int default 0,
autorId int,
constraint fk_autorId_autores foreign key (autorId) references autores(autorId));

create table vendas(
vendaId int auto_increment primary key,
livroId int,
dataVenda date, 
quantidade int,
valorTotal decimal,
constraint fk_livroId_vendas foreign key (livroId) references livros (livroId));


insert into autores (nome, pais) values 
('Machado de Assis', 'Brasil'),
('Clarisse Lispector', 'Brasil'),
('Jorge Amado', 'Brasil');

insert into Livros (titulo, autorId, preco, estoque) values 
('Dom Casmurro', 1, 34.90, 12),
('A hora da Estrela', 2, 29.90, 7),
('Capitães de Areia', 3, 39.90, 9);

insert into vendas (livroId, dataVenda, quantidade, valorTotal) values
(1, '2024-09-01', 3, 104.78),
(2, '2024-09-02', 2, 59.80),
(3, '2024-09-02', 1, 39.90);

select * from autores;
select * from livros;
select * from vendas;


###################################################################################
#Criando funções
# Mudar delimitador MySQL, que é o ; agora será o // e o ; será para funções
Delimiter // 
create function TotalVendas() returns decimal(10,2)
begin 
declare total decimal (10,2);
select sum(valorTotal) into total from vendas;
return ifnull(total, 0);
end //
Delimiter ;

#executar função
select totalVendas();

###################################################################################

###################################################################################
#função CalculaVenda
delimiter //
create function calculaVenda(ID int, Qtd int) returns decimal(10,2)
begin
-- Variaveis
declare valorTotal decimal (10,2);
declare precoUnit decimal (10,2);

-- buscar o preço unitário na tabela livros 
Select preco into precoUnit from livros where livros.livroId = ID limit 1;

-- verificar se o retorno é nulo
if precoUnit is null then 
return 0;
end if;

-- calcular o valor total do produto
set valorTotal = precoUnit * Qtd;
return valorTotal;
end//
delimiter ;

select * from livros;
select calculaVenda(3,3);
###################################################################################

# função calcula estoque
delimiter //
create function calculaEstoque(id int, qtd int) returns int
begin 
	declare estoqueAtual int;
    declare qtdVenda int;
    declare estoqueAtualizado int;
    
    select estoque into estoqueAtual from livros where livroId = id limit 1;
    set estoqueAtualizado = estoqueAtual - qtd;
    return estoqueAtualizado;
end//
delimiter ;

select * from livros;
select calculaEstoque(3,2);

###################################################################################

# procedure registrar venda
delimiter //
create procedure RegistraVenda (In id int, in qtd int)
begin 
	declare valorTotal decimal (10,2);
    set valorTotal = calculaVenda(id, qtd);
    insert into vendas (livroId, dataVenda, quantidade, valorTotal) values (id, curdate(), qtd, valorTotal);
end//
delimiter ;
#executar procedure
call RegistraVenda(3,2);

select * from vendas;

##############################################################################
Delimiter //
create procedure BaixarEstoque(in id int, in qtd int)
begin
	declare estoqueAtualizado int;
    set estoqueAtualizado = calculaEstoque(id, qtd);
    
    update livros set estoque = estoqueAtualizado where livroId = id;
end//
Delimiter ; 

call BaixarEstoque(2,5);

#Criar trigger
delimiter //
create trigger vender 
after insert on vendas
for each row 
begin 
	call baixarEstoque(new.LivroId, new.quantidade);
end//
delimiter ;


