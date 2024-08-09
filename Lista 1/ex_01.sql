create database Logins;
use logins;

create table usuarios (
userId int primary key not null auto_increment,
nome varchar (100), 
email varchar (100),
senha varchar (10));

create table configuracoesContas(
configId int primary key not null auto_increment,
configIdioma varchar (100) not null,
configTema varchar (100),
notificacao varchar(256));