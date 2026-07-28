create database ddl_dml;
use ddl_dml;

create table persons(
	id int auto_increment primary key,
    FirstName varchar(20) not null,
    LastName varchar(20) not null,
    Age int,
    City varchar(30),
    Email varchar(50)
);
desc persons;
