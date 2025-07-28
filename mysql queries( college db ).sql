CREATE DATABASE temp1;
DROP DATABASE temp1;
CREATE DATABASE college;
USE college;
CREATE TABLE student(
id int PRIMARY KEY, 
name varchar(50),
age int not null
);

INSERT INTO student VALUES(4,'balram',25),(3,'radha',20);
INSERT INTO student VALUES(2,'GOPAL',21);
SELECT * FROM student;
show databases;
show tables;
CREATE DATABASE XYZCOMPANY;
USE XYZCOMPANY;
CREATE TABLE employee(
id int primary key,
name varchar(50),
salary int
);
insert into employee values(1,'adam',25000),(2,'bob',30000),(3,'casey',40000);
select * from employee;
create table emp(
id int,
salary int default 25000);
insert into emp(id) values(101);
select * from emp;
drop database college;
-----------------------------------------------------------------------------------------------------------------
create database college;
use college;
create table student(
rollnumber int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20)
);
create table dept (
id int primary key,
name varchar(50)
);
insert into dept values(101,'english'),(102,'it');
select * from dept;

create table teacher(
id int primary key,
name varchar(50),
dept_id int,
foreign key(dept_id) references dept(id)
on update cascade
on delete cascade
);
insert into teacher
values
(101,"Adam",101),
(102,"Eve",102);
select * from teacher;
 


insert into student
(rollnumber , name , marks , grade , city)
values
(101,'anil',78,'C','Pune'),
(102,'bhumika',93,'A','Mumbai'),
(103,'chetan',85,'B','Mumbai'),
(104,'dhruv',96,'A','Delhi'),
(105,'emanuel',12,'F','Delhi'),
(106,'farah',82,'B','Delhi');

select * from student;
select name , marks  from student;
select city from student;
select distinct city from student;
select * from student where marks>80;
select * from student where city="Mumbai";
select * from student where marks>80 and city="Mumbai";
select * from student where marks+10>100;
select * from student where marks=93;
select * from student where marks>90 or city="Mumbai";
select * from student where marks between 80 and 90;
select * from student where city in ("Mumbai","Delhi","faridabad");
select * from student where city not in ("Mumbai","Delhi");
select * from student where marks > 70  limit 3;
select * from student order by city asc;
select * from student order by marks desc;
select * from student order by marks desc limit 3;
select max(marks) from student;
select min(marks) from student;
select avg(marks) from student;
select count(rollnumber) from student;
select city,count(rollnumber)
from student
group by city;
-- write the query to find avg marks in each city in ascending order
select city , avg(marks)
from student
group by city
order by city;
-- for the table, find the total payment according to each payment method;
select mode, count(customer) 
from payment 
group by mode;
-- how many students has got a,b,c,d grade?
select grade, count(rollnumber)
from student
group by grade
order by grade; -- by default arrange in ascending order
-- count number of students in each city where max marks cross 90
select city, count(rollnumber)
from student
group by city
having max(marks)>90;
-- update query(update grade of student to oo whoever has scored A grade)
set sql_safe_updates=0;-- come out of safe mode
update student
set grade='o'
where grade='A';
select * from student;
-- update marks of student to 82 whose rollnumber is 105
update student
set marks=82
where rollnumber=105;
select * from student;

update student
set grade='B'
where marks between 80 and 90;
select * from student;

update student
set marks = marks + 1;
select * from student;

update student
set marks=12
where rollnumber=105;
-- DELETE QUERY(delete data of student whose marks in less in 30)
delete from student 
where marks < 30;
select * from student;
-- cascading( by using cascading update and delete if we make change in parent table it is reflected in child table even though we havent wrote code to modify child table)
-- but note that change made in child table is not refelcted in parent table.
update dept
set id = 105
where id = 102;
select * from dept;
select * from teacher;
-- Alter Query(add column)
alter table student
add column age int not null default 19;
select * from student;
-- drop coloumn
alter table student
drop column age;
-- modify table
alter table student
modify column age varchar(2);
insert into student
(rollnumber,name,marks,age) 
values
(107,"gargi",68,100);-- when you execute this youll get an error as we have set varchar as 2 but age here is 3 digit , instead of this if we have used int then it would have accepted age 100
-- change column name
alter table student
change age stu_age int;
-- trucate
truncate table student;
-- in the student table , change the name of the column from name to full_name
alter table student
change name full_name varchar(50);
-- Delte all the students who scored marks less then 80
delete from student
where marks<80;
select * from student;
-- delete the coloumn for grades
alter table student
drop column grade;

-- JOINS
create table course(
id int primary key,
course varchar(50)
);
insert into course(id,course)
values
(102,'english'),
(105,'maths'),
(103,'science'),
(107,'computer science');

create table students(
id int primary key,
name varchar(50)
);
insert into students (id,name)
values
(101,'adam'),
(102,'bob'),
(103,'casey');

-- INNER JOIN
select *
from course
inner join students
on course.id = students.id;
-- left join
select *
from course
left join students
on course.id = students.id;
-- right join
select *
from course
right join students
on course.id = students.id;
-- full join
select *
from course
left join students
on course.id = students.id
union
select *
from course
right join students
on course.id = students.id;
-- left exclusive join
select *
from students as a
left join course as b
on a.id = b.id
where b.id is null
-- right exclusive join
select *
from students as a
right join course as b
on a.id = b.id
where a.id is null

-- self join

create table employee(
id int primary key,
name varchar(50),
manager_id int
);
insert into employee(id,name,manager_id)
values
(101,'adam',103),
(102,'bob',104),
(103,'casey',null),
(104,'donald',103);
select * from employee;

select *
from employee as a
join employee as b
on a.id=b.manager_id;
-- but we wnt names from both table
select a.name,b.name
from employee as a
join employee as b
on a.id=b.manager_id;
-- a table name is rewritten as manager_name
select a.name as manager_name ,b.name
from employee as a
join employee as b
on a.id=b.manager_id;
-- union(returns only unique values)
select name from employee
union
select name from employee;
-- union all ( return duplicates values as well)
select name from employee
union all
select name from employee;

-- sql subquerys
-- get names of all students who scored more then class avg
create table studentss(
rollnumber int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20)
);

insert into studentss
(rollnumber , name , marks , grade , city)
values
(101,'anil',78,'C','Pune'),
(102,'bhumika',93,'A','Mumbai'),
(103,'chetan',85,'B','Mumbai'),
(104,'dhruv',96,'A','Delhi'),
(105,'emanuel',12,'F','Delhi'),
(106,'farah',82,'B','Delhi');

select name,marks
from studentss
where marks > (select avg(marks) from student);

-- find the names of all students with even rollnumber.

select name,rollnumber
from studentss
where rollnumber in(
select rollnumber
from student
where rollnumber%2 = 0); 

-- find the max marks from the students of delhi
-- using subquery
select max(marks)
from(select * from student where city = 'Delhi') as temp;

-- doing normally
select max(marks)
from studentss
where city='Delhi';

-- view
create view view1 as
select rollnumber,marks,name from studentss;

select * from view1;

drop view view1;
