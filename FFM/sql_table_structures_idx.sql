create database ffm;
use ffm;

create table Employee(id int(10),empcode int(15),first_name varchar(30),last_name varchar(30),mobile_no int(10), dob date, doj date, login_id varchar(40), password varchar(20), address_line1 varchar(50),address_line2 varchar(50), street varchar(30), area varchar(30), mandal varchar(30), district varchar(30), state varchar(30),created_at date, created_by varchar(30),updated_at varchar(30), updated_by varchar(30), isactive boolean);
create index emp_idx on employee(empcode);

create table Dealer(id int,Dealer_id int,first_name varchar(30),last_name varchar(30),mobile_no int(10), address_line1 varchar(50),address_line2 varchar(50), street varchar(30), area varchar(30),mandal varchar(30), district varchar(30), state varchar(30));
create index dealer_idx on Dealer(Dealer_id);

create table task(id int,task_id int,task_desc varchar(100),task_assigned_to int,task_status varchar(20),assigned_dt date,completed_dt date,dealer_id int,category_name varchar(20));
create index task_idx on task(task_id);

create table Task_category(id int,category_name varchar(20));
create index cat_idx on Task_category(id);

create table Visit_info(id int,from_latitude varchar(50),from_longitude varchar(50),to_latitude varchar(50),to_longitude varchar(50),distance_travelled int);
create index visit_idx on Visit_info(id);

