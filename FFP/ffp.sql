create database FFP;
use FFP;
create table member(member_id int primary key,member_code int,first_name varchar(30),last_name varchar(30),
DOB date,email varchar(40),phno int,pswd varchar(15),points int,Hno varchar(10),street varchar(40),village varchar(30),
city varchar(30),state varchar(30),pincode int,createdAt varchar(30),createdBy varchar(30),updatedAt varchar(30),
updatedBy varchar(30),isActive varchar(30));
create table Airports(port_id int primary key,port_name varchar(60),port_city varchar(40));
create table destination(dest_id int primary key,origin varchar(60),destination varchar(60),kms int);
create table travel_info(member_id int,ticket_id int primary key,dest_id int,date date,points int,
foreign key(member_id) references member(member_id),foreign key(dest_id) references destination(dest_id));
create table store(store_id int primary key,store_name int);
create table Ordert(order_id int primary key,store_id int,member_id int,cost int,date date,status boolean,
foreign key(store_id) references store(store_id),foreign key(member_id) references member(member_id));
create table order_details(order_id int,item_name varchar(20),quantity int,price int,date date);
select * from member;


