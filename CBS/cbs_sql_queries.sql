create database cbs;

use cbs;

create table customer (
id integer(10) primary key auto_increment ,
custid varchar(10) not null,
password varchar(16),
firstname varchar(50),
middlename varchar(50),
lastname varchar(50),
mobileno integer(10),
emailid varchar(50),
dob date,
fathername varchar(150),
mothername varchar(150),
pan varchar(10),
aadhaarid integer(16),
address text,
city varchar(20),
state varchar(20),
country varchar(20),
pin integer(6),
createdat datetime,
createdby varchar(150),
updatedat datetime,
updatedby varchar(150),
isactive boolean
);

select * from customer;

create table account (
id integer(10) primary key auto_increment,
accountno integer(16),
custid varchar(10),
ifsccode varchar(11),
branch varchar(20),
type varchar(20),
category varchar(10),
balance float,
upiid varchar(50),
nominee1 varchar(150),
nominee2 varchar(150),
enablednetbanking boolean,
createdat datetime,
createdby varchar(150),
closedat datetime,
closedby varchar(150),
last_tx_date datetime,
isactive boolean
);

select * from account;

create table transaction(
	id integer(10) PRIMARY KEY AUTO_INCREMENT,
    tx_ref_no varchar(16) NOT NULL,
    accountno integer(16),
    type varchar(20),
    amount float,
    balance float,
    tx_at datetime,
    tx_from integer(16),
    tx_to integer(16),
    tx_mode varchar(20),
    tx_status varchar(20),
    interestamount float 
);

select * from transaction;

create table employee(
id integer(10) primary key auto_increment,
empid integer(10),
password varchar(16),
firstname varchar(50),
middlename varchar(50),
lastname varchar(50),
mobileno integer(10),
emailid varchar(50),
dob date,
createdat datetime,
createdby varchar(150),
updatedat datetime,
updatedby varchar(150),
isactive boolean
);

select * from employee;

