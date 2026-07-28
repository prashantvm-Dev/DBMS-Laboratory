create database database1;
use database1;

create table employees (
	emp_id int auto_increment primary key,
    emp_name varchar(50),
    dept varchar(30),
    salary decimal(10,2),
    city varchar(30),
    join_date date
);
insert into employees (emp_name, dept, salary, city, join_date)
values
('Omm Prakash','CS',70000.00,'Hyderabad','2024-08-01'),
('Jitendra','IT',50000.00,'Bhubaneswar','2024-05-21'),
('Debashis','Sales',650000.00,'Chennai','2022-09-11'),
('Prashant','HR',69000.00,'Bangalore','2021-11-09'),
('Ayush','DS',45000.00,'Mumbai','2020-01-05');

select * from employees;

select * from employees where dept = 'CS' and salary > 50000;

select * from employees where dept = 'IT' or dept = 'HR';

select * from employees where city in ('Bhubaneswar','Hyderabad');

select * from employees where salary between 60000 and 70000;

select * from employees where emp_name like 'O%';
select * from employees where emp_name like '_i%';
select * from employees where emp_name like '%t';

select * from employees where not dept = 'Sales';

select * from employees where dept = 'IT' and salary > 40000 and city != 'Hyderabad';
