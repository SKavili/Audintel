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

create user ffp_user;

Grant ALL on FFP to ffp_user;

create index idx_memberid on member(member_id);

alter table member modify column phno varchar(40);
alter table store modify column store_name varchar(40);
alter table order_details modify column item_name varchar(60);

INSERT INTO member (member_id, member_code, first_name, last_name, DOB, email, phno, pswd, points, Hno, street, village, city, state, pincode, createdAt, createdBy, updatedAt, updatedBy, isActive)
VALUES
(1, 12345, 'Vineeth', 'S G', '2001-01-25', 'vineeth@gmail.com', 9392983923, 'password1', 0, '12A', 'Main Street', 'Anytown', 'New York', 'NY', 10001, '2021-01-03', 'Admin', NULL, NULL, 'Yes'),
(2, 56789, 'Sandeep Reddy', 'B', '2001-06-12', 'sandeep@gmail.com', 7330731347, 'password2', 0, '34B', 'Park Avenue', 'Anyville', 'Los Angeles', 'CA', 90002, '2022-01-03', 'Admin', NULL, NULL, 'Yes'),
(3, 98765, 'Yagnesh', 'B', '2002-12-20', 'yagnesh@gmail.com', 8297278722, 'password3', 0, '56C', 'Oak Street', 'Anyplace', 'Chicago', 'IL', 60606, '2023-01-03', 'Admin', NULL, NULL, 'Yes'),
(4, 45612, 'Navneeth', 'N', '2000-03-08', 'navneeth@gmail.com', 9177729572, 'password4', 0, '78D', 'Elm Street', 'Anycity', 'Houston', 'TX', 77007, '2021-01-03', 'Admin', NULL, NULL, 'Yes'),
(5, 89523, 'Rohith Reddy', 'V', '2002-09-21', 'rohith@gmail.com', 9491487430, 'password5', 0, '90E', 'Maple Street', 'Anytown', 'Austin', 'TX', 78701, '2022-01-03', 'Admin', NULL, NULL, 'Yes'),
(6, 25468, 'Mahesh', 'B', '2000-07-04', 'mahesh@gmail.com', 9398254714, 'password6', 0, '11F', 'Pine Street', 'Anyville', 'Phoenix', 'AZ', 85004, '2024-01-03', 'Admin', NULL, NULL, 'Yes'),
(7, 75396, 'Sai Teja', 'M', '2001-11-15', 'saiteja@gmail.com', 6789012345, 'password7', 0, '33G', 'Cedar Street', 'Anyplace', 'San Antonio', 'TX', 78205, '2022-01-03', 'Admin', NULL, NULL, 'Yes');


CREATE TABLE Airports (
    port_id INT PRIMARY KEY,
    port_name VARCHAR(60),
    port_city VARCHAR(40)
);

INSERT INTO Airports (port_id, port_name, port_city)
VALUES
(1, 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta'),
(2, 'Beijing Capital International Airport', 'Beijing'),
(3, 'Dubai International Airport', 'Dubai'),
(4, 'Los Angeles International Airport', 'Los Angeles'),
(5, 'Tokyo International Airport (Haneda)', 'Tokyo'),
(6, 'O''Hare International Airport', 'Chicago'),
(7, 'London Heathrow Airport', 'London'),
(8, 'Hong Kong International Airport', 'Hong Kong'),
(9, 'Shanghai Pudong International Airport', 'Shanghai'),
(10, 'Paris Charles de Gaulle Airport', 'Paris'),
(11, 'Amsterdam Airport Schiphol', 'Amsterdam'),
(12, 'Frankfurt Airport', 'Frankfurt'),
(13, 'Incheon International Airport', 'Seoul'),
(14, 'Singapore Changi Airport', 'Singapore'),
(15, 'John F. Kennedy International Airport', 'New York City'),
(16, 'Dallas/Fort Worth International Airport', 'Dallas/Fort Worth'),
(17, 'Denver International Airport', 'Denver'),
(18, 'Guangzhou Baiyun International Airport', 'Guangzhou'),
(19, 'Madrid Barajas International Airport', 'Madrid'),
(20, 'Munich Airport', 'Munich'),
(21, 'Indira Gandhi International Airport', 'New Delhi'),
(22, 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai'),
(23, 'Kempegowda International Airport', 'Bangalore'),
(24, 'Rajiv Gandhi International Airport', 'Hyderabad'),
(25, 'Chennai International Airport', 'Chennai');


INSERT INTO destination (dest_id, origin, destination, kms)
VALUES
(1, 'New York City', 'London', 5575),
(2, 'Los Angeles', 'Tokyo', 8811),
(3, 'Paris', 'Singapore', 10546),
(4, 'Dubai', 'Sydney', 12546),
(5, 'New Delhi', 'Frankfurt', 6175),
(6, 'Beijing', 'San Francisco', 9543),
(7, 'Mumbai', 'New York City', 12535),
(8, 'London', 'Hong Kong', 9654),
(9, 'Singapore', 'Los Angeles', 14114),
(10, 'Sydney', 'Cape Town', 11065),
(11, 'Sao Paulo', 'Madrid', 8754),
(12, 'Toronto', 'Vancouver', 3354),
(13, 'Johannesburg', 'Amsterdam', 9547),
(14, 'Bangkok', 'Seoul', 4567),
(15, 'Istanbul', 'Moscow', 1754),
(16, 'Rome', 'Athens', 1546),
(17, 'Chicago', 'Mexico City', 2654),
(18, 'Miami', 'Buenos Aires', 7125),
(19, 'Shanghai', 'Melbourne', 7543),
(20, 'Hong Kong', 'Bangkok', 1543),
(21, 'Dubai', 'Johannesburg', 7543),
(22, 'London', 'New Delhi', 6543),
(23, 'Frankfurt', 'New York City', 6254),
(24, 'Singapore', 'Hong Kong', 2543),
(25, 'Sydney', 'Johannesburg', 11050);





INSERT INTO store (store_id, store_name)
VALUES
(1, 'FlyHigh Airlines'),
(2, 'SkyMiles Travel'),
(3, 'Rewards Emporium'),
(4, 'Points Palace'),
(5, 'Bonus Bazaar'),
(6, 'AirMall'),
(7, 'Emirates SkyStore');

INSERT INTO Ordert (order_id, store_id, member_id, cost, date, status)
VALUES
(1, 1, 2, 4500, '2024-01-04', true),
(2, 5, 4, 1200, '2024-01-08', false),
(3, 3, 6, 854, '2024-01-12', true),
(4, 2, 1, 950, '2024-01-20', true),
(5, 7, 5, 1850, '2024-01-25', false),
(6, 6, 3, 2540, '2024-01-30', true),
(7, 4, 7, 1500, '2024-02-03', true);

INSERT INTO order_details (order_id, item_name, quantity, price, date)
VALUES
(1, 'Flight ticket upgrade', 1, 4500, '2024-01-04'),
(2, 'Travel voucher', 2, 600, '2024-01-08'),
(3, 'Luggage set', 1, 854, '2024-01-12'),
(4, 'Noise-cancelling headphones', 1, 950, '2024-01-20'),
(5, 'In-flight entertainment package', 2, 925, '2024-01-25'),
(6, 'Airport lounge access pass', 2, 1270, '2024-01-30'),
(7, 'Priority boarding', 3, 500, '2024-02-03');












