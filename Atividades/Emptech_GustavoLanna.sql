create database if not exists EmpTech_GustavoLanna;
use EmpTech_GustavoLanna;

create table if not exists funcionarios(
codFunc int auto_increment primary key,
nomeFunc varchar(255) not null);

create table if not exists veiculos(
codVeic int auto_increment primary key,
modelo varchar(255) not null,
placas varchar(20) not null,
codFunc int);

create table atuacaoVendas (
codAtuacao int auto_increment primary key,
descricao varchar (255) not null,
codFunc int,
foreign key (codFunc) references Funcionarios (codFunc) );

create table indicacoes (
codIndicador int,
codIndicado int,
primary key (codIndicador, codIndicado),
foreign key (codIndicador) references Funcionarios (codFunc),
foreign key (codIndicado) references Funcionarios(codFunc));


insert into funcionarios (nomeFunc) values 
('João Silva'), ('Maria Oliveira'), ('Pedro Santos'), ('Ana Costa'), ('Lucas Almeida'), ('Fernanda Lima'),
#novos itens
('Gustavo Lanna'), ('Yasmin Pires'), ('Ana Flávia');

insert into veiculos (Modelo, Placas, codFunc) values 
('Fiat Uno', 'ABCD123', 1), ('Honda Civic', 'XYZ2E34', 1), ('Toyota Corolla', 'LMN3F45', 2), ('Chevrolet Onix', 'OPQ4G56', 3),
('VW Gol', 'UVM6I78', 5), ('Peugeot 208', 'YZA7J89', null),
#novos itens
('BMW 320i', 'CHAMAS1', 7), ('Camaro', 'ABCD134', 8), ('BMW 320i', 'HLK2D34', 9);

insert into atuacaoVendas (descricao) values 
('Vendas de veículos novos'), ('Vendas de veículos usados'), ('Manutenção e reparo de veículos'), ('Serviços de pós-vendas'), ('Vendas de veículos novos'),('Consultoria de Vendas'), ('Programações e eventos especiais'),
#novos itens
('Devolução de veículos'), ('Troca de câmbio'), ('Troca de óleo'); 

insert into indicacoes (codIndicador, codIndicado) values (1,2),(1,3),(2,4),(2,5),(4,6),
#novos itens
(2,1),(4,5),(3,2);

SELECT 
    f.nomeFunc,COUNT(v.codVeic) AS totalVeiculos
FROM funcionarios f
LEFT JOIN veiculos v 
ON f.codFunc = v.codFunc
GROUP BY f.codFunc, f.nomeFunc
ORDER BY f.nomeFunc;
    
/*1 - Função e Procedure (A)
a) Crie uma função chamada 'GetFuncionarioVeiculoCount' que recebe o código de um funcionário e retorna o número de veículos associados a esse funcionário
*/
delimiter //
create function GetFuncionarioVeiculoCount(codFunc int) returns int
begin
declare veiculoCount int;
select count(*) into veiculoCount from veiculos v
where v.codFunc = codFunc;
return veiculoCount;
end //
delimiter ;
select GetFuncionarioVeiculoCount (7);

/*b) Crie um procedimento armazenado chamado "AddVenda" que insere uma nova atuação de vendas na tabela 'AtuaçãoVendas'. 
O procedimento deve receber uma descrição e adicionar a nova atuação de vendas*/
delimiter //
create procedure AddVenda(in descricao varchar(255))
begin
insert into atuacaoVendas (descricao) values (descricao);
end //
delimiter ;
call AddVenda('Turbo');
select * from atuacaoVendas;


/* TRIGGER a. Crie um gatilho chamado `BeforeInsertIndicacao` que verifica se o 
funcionário indicado já foi indicado por outro funcionário. Se o funcionário já 
tiver uma indicação, o gatilho deve lançar um erro e impedir a inserção.*/

delimiter //
create trigger BeforeInsertIndicacao 
before insert on indicacoes
for each row
begin
    declare msg text;
    if exists (select 1 from indicacoes where codIndicado = new.codIndicado) 
		then
		set msg = 'Impossível inserir uma nova indicação se o funcionário indicado já tem indicação.';
        signal sqlstate '45000' set message_text = msg;
    end if ;
end //
delimiter ;

#3. View e Joins
/*a. Crie uma visão chamada `FuncionarioVeiculoAtuacao` que exibe todos os 
funcionários, seus veículos e as atuações de vendas associadas. A visão 
deve mostrar os campos: código do funcionário, nome do funcionário, 
modelo do veículo, placas do veículo e descrição da atuação de vendas.*/

create view FuncionarioVeiculoAtuacao as
select 
    f.codFunc as "ID",
    f.nomeFunc as "Nome",
    v.modelo as "Modelo Veiculo",
    v.placas as "Placa Veiculo",
    a.descricao as "Descricao Atuação"
from funcionarios f left join veiculos v on f.codFunc = v.codFunc
left join atuacaoVendas a on f.codFunc = a.codFunc;

##CRIAR COD FUNC
select * from FuncionarioVeiculoAtuacao;

/*b. Execute uma consulta para mostrar a lista completa de funcionários, 
indicando se eles têm veículos e quais atuações de vendas estão associadas 
a cada veículo, usando um `LEFT JOIN` para incluir todos os funcionários, 
mesmo aqueles sem veículos ou atuações de vendas.*/

select 
    f.codFunc as 'ID',
    f.nomeFunc as 'Nome',
    v.modelo as 'Modelo Veiculo',
    v.placas as 'Placa Veiculo',
    a.descricao as 'Descricao Atuação'
from funcionarios f
left join veiculos v on f.codFunc = v.codFunc
left join atuacaoVendas a on v.codFunc = a.codFunc
order by f.codFunc, v.codVeic, a.codAtuacao;
