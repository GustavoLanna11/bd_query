#criando banco de dados
create database if not exists loja_online;
use loja_online;

create table if not exists categorias(
id int not null primary key auto_increment,
nome varchar(50) not null);
    
create table if not exists produtos (
id int not null primary key auto_increment,
nome varchar(100) not null, 
categoria_id int,
preco decimal(10,2),
quantidade_estoque int,
foreign key (categoria_id) references categorias(id));

#inserção de dados
insert into categorias (nome) values 
('Roupas'),('Calçados'),('Acessórios');

insert into produtos (nome, categoria_id, preco, quantidade_estoque) values
('Camiseta', 1, 29.99, 100),
('Calça Jeans', 1, 49.99, 75),
('Tênis Esportivo', 2, 89.99, 50),
('Relógio', 3, 199.99, 20),
('Óculos de sol', 3, 129.99, 30),
('Jaqueta', 1, 79.99, 40),
('Bota', 2, 119.99, 25),
('Mochila', 3, 59.99, 60),
('Camisa Polo', 1, 39.99, 80),
('Tênis Casual', 2, 69.99, 70);

select * from categorias;
select * from produtos;

#Ordenação de Dados
/*Order By: é uma clausula usada em SQL para ordenar o resultado de uma consulta podendo ordenar os resultados em ordem crescente (ASC - Padrão da ordenação) e ordem decrescente (desc)*/

#ordenar os produtos por preço em ordem crescente
select nome, preco from produtos order by preco ASC;
select nome, preco from produtos order by preco desc;

#Agrupamentos
/*Usada para agrupar linhas que tem valores iguais em colunas específicas em grupo. Normalmente é usada com função de agregação.*/
select categorias.nome as "Categoria", count(produtos.id) as "Total de Produtos" from produtos
join categorias on produtos.categoria_id = categorias.id
group by categorias.nome; 

#Calcular a média de preço dos produtos em cada categoria
select nome, preco, categoria_id from produtos order by categoria_id asc;

select categorias.nome as "Categoria", round(avg(produtos.preco),2) as "Valor Médio" from produtos
join categorias on produtos.categoria_id = categorias.id group by categorias.nome;

#Condição em Grupos (Having)
/*é usada para filtrar os resultados que usa GROUP By. Ela é similar ao WHERE, mas é aplicada após a agregação dos dados, permitindo filtrar grupos em vez de linhas individuais*/

#Encontrar categorias com mais de 3 produtos
select categorias.nome as "Categorias", count(produtos.id) as "Total de Produtos" from produtos 
join categorias on produtos.categoria_id = categorias.id group by categorias.nome
having count(produtos.id) > 3;

#encontrar categorias onde a média de preço é superior a 50
select categorias.nome as "Categoria", round(avg(produtos.preco),2) as "Valor Médio" from produtos
join categorias on produtos.categoria_id = categorias.id group by categorias.nome
having round(avg(produtos.preco),2) > 50;

#Paginação
/*Refere-se ao processo de dividir um conjunto de resultados em páginas menores, geralmente para melhorar a performance e a usabilidade em interfaces. Em SQL, isso é feito usando clausulas como LIMIT e OFSET
Limit -> Quantidade de registros a serem mostrados
OFFSET -> Quantidade de registros a serem pulados*/

#vamos mostrar 3 produtos por páginas
select * from produtos;
#Página 1:
select produtos.nome as "produto", produtos.preco as "Preço", categorias.nome as "Categoria" from produtos
join categorias on produtos.categoria_id = categorias.id
order by produtos.preco
limit 3 offset 0;

#Página 2
select produtos.nome as "produto", produtos.preco as "Preço", categorias.nome as "Categoria" from produtos
join categorias on produtos.categoria_id = categorias.id
order by produtos.preco
limit 3 offset 3;

#Página 3
select produtos.nome as "produto", produtos.preco as "Preço", categorias.nome as "Categoria" from produtos
join categorias on produtos.categoria_id = categorias.id
order by produtos.preco
limit 3 offset 6;

#Página 4
select produtos.nome as "produto", produtos.preco as "Preço", categorias.nome as "Categoria" from produtos
join categorias on produtos.categoria_id = categorias.id
order by produtos.preco
limit 3 offset 9;









