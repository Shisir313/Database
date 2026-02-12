show databases;
use dbemp;
create table employee1(
employee_id int primary key,
department_name varchar(100),
department_id int
);

create table department(
department_id int,
department_name varchar(100)
);

insert into employee1 values
(1 ,' Homer Simpson' , 4),
(2 ,' Ned  Fanders' , 1),
(3,'Barney Gumble' , 5),
(4,'Clancy Wiggum' , 3),
(5 ,' Moe Syzslak' , null);

insert into department values
(1 ,'Sales'),
(2 ,'Enginerring'),
(3 ,'Human Resources'),
(4 ,'Customer Service'),
(5 ,'Research And Development');

#inner join
 select * from  employee1 e inner join department d on e.department_id= d.department_id;
 
 #left join
 select * from employee1 e left join department d on e.department_id= d.department_id;
 
 #right join
 select * from employee1 e right join department d on e.department_id= d.department_id;
 
 #full join
 select * from employee1 e full join department d on e.department_id= d.department_id;
 
 #cross join
 select * from employee1 e cross join department d on e.department_id= d.department_id;
 



