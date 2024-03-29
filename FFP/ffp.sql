create database FFP;
use FFP;
create table member(member_id int primary key,member_code int,first_name varchar(30),last_name varchar(30),
DOB date,email varchar(40),phno int,pswd varchar(15),points int,Hno varchar(10),street varchar(40),village varchar(30),
city varchar(30),state varchar(30),pincode int,createdAt varchar(30),createdBy varchar(30),updatedAt varchar(30),
updatedBy varchar(30),isActive varchar(30));
create table Airports(port_id int primary key,port_name varchar(60),port_city varchar(40));
create table Destination(dest_id int primary key,origin varchar(60),destination varchar(60),kms int);
create table travel_info(member_id int,ticket_id int primary key,dest_id int,date date,
foreign key(member_id) references member(member_id),foreign key(dest_id) references destination(dest_id));
create table store(store_id int primary key,store_name int);
create table Ordert(order_id int primary key,store_id int,member_id int,cost int,date date,status boolean,
foreign key(store_id) references store(store_id),foreign key(member_id) references member(member_id));
create table order_details(id int auto_increment primary key,order_id int,item_name varchar(20),
quantity int,price int,date date,foreign key(order_id) references ordert(order_id));
create index idx_memberid on member(member_id);
ALTER TABLE member modify COLUMN phno varchar(40);
ALTER TABLE store modify COLUMN store_name varchar(40);
ALTER TABLE order_details modify COLUMN item_name varchar(60);
ALTER TABLE travel_info DROP COLUMN points;
Create table points(member_id int,ticket_id int,points int);
create table total_distance(id int auto_increment key,total_distance long,code int default 0, member_id int,
foreign key(member_id) references member(member_id));
ALTER TABLE travel_info
ADD COLUMN total_members int CHECK(total_members<=6);
ALTER TABLE travel_info
modify COLUMN date datetime;
ALTER TABLE points
ADD COLUMN points_id int primary key;
ALTER TABLE points
MODIFY COLUMN points_id int auto_increment primary key;
Drop table total_distance;


