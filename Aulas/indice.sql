create database banco;
use banco;

create table clientes(
id int not null primary key auto_increment,
nome varchar(100),
email varchar(100));

create table contas(
id int auto_increment primary key,
cliente_id int,
saldo decimal (10,2),
foreign key (cliente_id) references clientes(id));

create table transacoes(
id int auto_increment primary key,
conta_id int,
valor decimal (10,2),
data_transacao datetime,
tipo_transacao enum("Deposito", "Saque", "Qual Operação") default ("Qual operação"),
foreign key (conta_id) references contas(id));

insert into clientes(nome, email) values 
('João Silva', 'joao@gmail.com'), ('Maria Santos', 'maria@gmail.com'),
('Carlos Pereira', 'carlos@gmail.com');

insert into contas(cliente_id, saldo) values
(1, 1000.00), (2,500.00), (3, 1200.00);

/*Indexes - Os índices em MySQL são usados para melhorar o desempenho das consultas, permitindo uma recuperação de dados mais rápida. Eles funcionam como índices em um livro, ajudando a localizar 
rapidamente as linhas sem ter que fazer uma busca completa.
- Um índice cria uma estrutura adicional que permite uma busca mais rápida, mas também ocupa espaço e pode desacelerar a inserção e atualização de dados.*/

#Exemplo 1: Index em coluna frequentemente utilizada
create index idx_cliente_nome on clientes(nome);
select * from clientes where nome = 'João Silva';

#Exemplo 2: Index em colunas para busca complexa
/*Se as consultas frequentemente busca, por combinações de saldo e cliente_id, criar um indice pode melhorar o desempenho.*/
create index idx_cliente_saldo on contas(cliente_id, saldo);
select * from contas where cliente_id = 1 and saldo > 500;

#Exemplo 3: Index para melhorar o order by
/*Ao usar a clausula ORDER BY em uma coluna específica, o uso de índices pode acelar o processo de ordenação*/
create index idx_transacoes_data on transacoes(data_transacao);
select * from transacoes order by data_transacao DESC;

#inserindo dados na tabela transações
insert into transacoes (conta_id, valor, tipo_transacao, data_transacao) values
(1.500, 'deposito', '2024-09-18 10:00:00'),
(1.200, 'saque', '2024-09-18 11:00:00'),
(2.300, 'deposito', '2024-09-18 12:00:00');

create index idx_transacoes_data on transacaoes (data_transacao);
select * from transacoes order by data_transacao DESC;

#Exclur index
drop index idx_cliente_nome on clientes;