create database DepFuncionarios;
use depfuncionarios;

create table departamentos(
deptoId int auto_increment primary key not null,
deptoNome varchar (100),
deptoLocalizacao varchar (50));

create table funcionarios (
funcId int auto_increment primary key not null,
funcNome varchar (100),
funcCargo varchar (50),
funcDtContrat date,
funcSalario double(8,2),
deptoId int,
constraint fk_depto foreign key(deptoId) references departamentos(deptoId));