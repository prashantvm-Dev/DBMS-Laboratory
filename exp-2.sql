create database EmployeeDB_1;
use EmployeeDB_1;

create table employees (
	emp_id int auto_increment primary key,
    emp_name varchar(50),
    dept varchar(30),
    salary decimal(10,2),
    city varchar(30),
    join_date date
);

create database CompanyEmpDB;

rename table EmployeeDB_1.employees to CompanyEmpDB.employees_01;

drop database EmployeeDB_1;

use CompanyEmpDB;

show tables;

drop database CompanyEmpDB;
