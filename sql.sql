--1. Database and Tables Creation (DDL); Populating with data (DML)
create database cbs;

drop table account;

create table account (id numeric(30), accountid varchar(30), custid numeric(10), 
					  accounttype varchar(10), opendate date, closedate date,
					  category varchar(10))

insert into account values (1,'0310848383833',1,'SB', '01-01-2024', null, 1 );
 
insert into accountext values (2,'0344444444',1,'Current', '01-01-2024', null, 1, true ); 

select * from account;
select * from accountext;

select * into account1 from account

insert into account1 select a.* from account a, account b, account1 c


insert into account1 select a.* from account a

select count(1) FROM account1

-- 2 Primary key and foreign key (Defines referential integrity)
create table test (id autoincrement primary key, name text)

create table test1(id1 serial, testid int, constraint fk_test1_testid foreign key (testid) references
				   test(id))
				   
-- 3 Index creation (Better response for select queries, use for frequently searched/filterd columns)			   
DROP INDEX IF EXISTS idx_test1_id;

CREATE INDEX IF NOT EXISTS idx_test1_id
    ON test1(testid);
	
	
	alter table test1 add column desc1 text;
	
--4 Create database users and grant permissions (DCL)
CREATE ROLE root1 WITH 
	PASSWORD 'root';
create user guest identified by 'root';

grant select on * to guest;
revoke select on * from guest;

--5 TCL - Transaction Control Language
select balance from account  where id=1;
BEGIN;
update account set balance=99999 where id=1;
rollback;
 --------
select balance from account  where id=1;
BEGIN;
update account set balance=0000 where id=1;
select balance from account  where id=1;
commit;
 --------
select balance from account  where id=1;
BEGIN;

update account set balance=11111 where id=1;
savepoint id2sp;
update account set balance=222222 where id=2;
select balance from account  where id in (1,2);

rollback to id2sp;

-- 6 Inner queries

create table emp (empid int,  fname varchar(22), managerid int);

insert into emp values 
(1,'Suresh',0),
(2,'Rohith',1);


select e1.empid,  e1.fname, (select m.fname from emp m where m.empid=e1.managerid) manager from emp e1;

select e1.empid,  e1.fname, (select m.fname from emp m where m.empid=e1.managerid) manager 
from emp e1;

select e1.empid,  e1.fname,   e2.fname from emp e1 left join emp e2 on e1.managerid=e2.empid ;

with cte1 as (select e1.empid,  e1.fname, e1.managerid from emp e1)
select cte1.*, m.fname from cte1, emp m where cte1.managerid=m.empid ;

--------
select balance from account  where id in (1,2);

SELECT * FROM world.countrylanguage where countrycode not in (select code from country);

SELECT * FROM world.country where code  in (select countrycode from countrylanguage);

SELECT * FROM world.country where  exists (select 1 from countrylanguage l where l.countrycode=country.code);
--7 Step by step build queries to fetch the countries with top number of languages speaking 
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc limit 1;

select c.name from (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name having cnt=
(select b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc limit 1) b))c ;

--8 Write inner queries to fetch the countries in 5th position in top number of languages speaking 
select c.name from (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name having cnt=
(select cc.cnt from (
select distinct b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc) b
limit 5
) cc order by cc.cnt limit 1 ))c ;

--8 Above query using limit4,1 (skip first 4 and then fetch one record after that), also formatted for better readability

select 
c.name 
from ( select 
            c.name, 
	   count(*) cnt 
	   from country c, 
	        countrylanguage l 
	   where c.code=l.countrycode 
	   group by c.name 
	   having cnt=
                  (select 
				        cc.cnt 
				   from (
                             select 
							       distinct b.cnt 
							 from (
                                    select 
									     c.name, 
									count(*) cnt 
									from country c, 
									     countrylanguage l 
									where 
									c.code=l.countrycode 
									group by c.name 
									order by cnt desc) b
                              limit 4,1
                        ) cc  
					)
	)c ;

--9  CTE- Common table expression queries, helps in building inline table format data for better managing the data fetches
-- Simple CTE
with cte as (select 1 as cnt) 
select cte.cnt from cte;

-- Two CTE's together
with cte as (select 1 as cnt) ,
 cte1 as (select 2 as cnt1) 
select cte1.cnt1 from cte1;


with cte as (select 1 as cnt) ,
 cte1 as (select 2 as cnt1) 
select cte.cnt,cte1.cnt1 from cte,cte1;

--10 Write CTE queries to fetch the countries in 5th position in top number of languages speaking 
with cte1 as (select distinct b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc) b
limit 4,1) ,
 cte2 as (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name) 
 
select cte2.name from cte1,cte2 where cte1.cnt=cte2.cnt;

--11 generating 1 crore records in 5 minits 

-- create account table, insert 200 records (prepare using excel sheet)

-- create a temp table from account
create table accounttemp SELECT *   FROM account;

-- insert into temp table by cartesian product of account table a, b i.e 200*200=40000 records
insert into accounttemp SELECT  a.*   FROM account a, account b;
-- create another temp table from the current temp table to get more number of records
create table accounttemp11 SELECT *   FROM accounttemp;
-- At different stages, execure the queries multiple times by that the record count will icnrease from 200 to 40,000 to 1 Lakh to 10 Lakh to 1 crore
--(aprx execure 20 times the different queries to pool 1 crore records)
insert into accounttemp SELECT  a.*   FROM accounttemp11 a;


insert into accounttemp values (1000,'0317000001',101,'FirstName1','LastName1'),
(1851,'031700000185',285,'Sai Teja','T'),
(1861,'031700000186',286,'Reddy','S'),
(1871,'031700000187',287,'Naveen','G'),
(1881,'031700000188',288,'Sampath','D'),
(1891,'031700000189',289,'Shyam','S'),
(1901,'031700000190',290,'Rao','W');

select count(*) from accounttemp;

select * from accounttemp where accountid='031700000190';

-- 12 without index above query took 7 seconds to fetch the record, with index it took 0.016 seconds which is 400 times lower than the non indexed query
create index idx_accounttemp_accountid on accounttemp(accountid);


-- 13 functions
create  function  f1() returns int
return 10;
 
select f1();
/* Sample  Usecases 
 
1. Retrieve the total number of accounts opened  in each year.
2. Retrieve the top 5 highest balance accounts from the accounts table
3. Retrieve the employee names and their corresponding managers from the "employees" table.
4. Retrieve the data using the mapping table (many to many relation) student and class; employee and project are examples
5. Retrieve the names of teachers and the total number of classes they are teaching .
6. Uing CTE Retrieve the accounts  who had  more than 5 transactions .
7. Design a sample database for BookMyShow application
8. Optimize the query
   SELECT customer_name FROM customers WHERE customer_id = (SELECT customer_id FROM orders WHERE order_id = 2);

9. Use EXISTS Instead of IN or NOT IN:
 
10. Format the query

with cte1 as (select distinct b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc) b
limit 4,1) ,
cte2 as (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name) 
 
select cte2.name from cte1,cte2 where cte1.cnt=cte2.cnt;


11. SQL query clauses and CONSTRAINTS
group by, having, where, in, order by, exists, select, from

not null, unique, check 
12. How many indexes we can create on a table

13. sql joins

14. Write sql to generate 10 Lakh records from a given single record

15. How to study large DB

16. complex queries

17. Find average and incrementing the above average records

18. Union and Union All

19 self referring the table find max number of times repeated lanaguage

20. biometric DB design and fetching the employee attendance details

*/

-- --14 mask production data -- update query
update  hrms.emp_info set father_name='Gandhi Raju' , mother_name='Rukmini Bai', pan_number='AKMPK6663M', 
emp_info.emergency_contact_name='Mother Mary', emp_info.mobile_number='9599393333', emp_info.emergency_phone='534334333' where emp_info_id >0;


 SELECT * FROM hrms.emp_info;
update  hrms.emp_info set first_name= replace(first_name, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set first_name= replace(first_name, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set last_name= replace(first_name, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set last_name= replace(first_name, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set first_name= replace(first_name, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info set first_name= replace(first_name, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info set last_name= replace(first_name, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info set last_name= replace(first_name, 'e', 'c') where emp_info_id >0;


update  hrms.emp_info set email_office= replace(email_office, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set email_office= replace(email_office, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set email1_personal= replace(email_office, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set email1_personal= replace(email_office, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set email_office= replace(email_office, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info set email_office= replace(email_office, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info set email1_personal= replace(email_office, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info set email1_personal= replace(email_office, 'e', 'c') where emp_info_id >0;

update  hrms.emp_info set user_id= replace(user_id, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 's', 'k') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info set user_id= replace(user_id, 'e', 'c') where emp_info_id >0;



SELECT * FROM hrms.emp_info_log;
update  hrms.emp_info_log set father_name='Gandhi Raju' , mother_name='Rukmini Bai', pan_number='AKMPK6663M', 
emp_info_log.emergency_contact_name='Mother Mary', emp_info_log.mobile_number='9599393333', emp_info_log.emergency_phone='534334333' where emp_info_id >0;


 SELECT * FROM hrms.emp_info_log;
update  hrms.emp_info_log set first_name= replace(first_name, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set first_name= replace(first_name, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set last_name= replace(first_name, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set last_name= replace(first_name, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set first_name= replace(first_name, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info_log set first_name= replace(first_name, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info_log set last_name= replace(first_name, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info_log set last_name= replace(first_name, 'e', 'c') where emp_info_id >0;


update  hrms.emp_info_log set email_office= replace(email_office, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set email_office= replace(email_office, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set email1_personal= replace(email_office, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set email1_personal= replace(email_office, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set email_office= replace(email_office, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info_log set email_office= replace(email_office, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info_log set email1_personal= replace(email_office, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info_log set email1_personal= replace(email_office, 'e', 'c') where emp_info_id >0;

update  hrms.emp_info_log set user_id= replace(user_id, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 'r', 'h') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 's', 'k') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 'a', 'u') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 'e', 'g') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 'a', 'r') where emp_info_id >0;
update  hrms.emp_info_log set user_id= replace(user_id, 'e', 'c') where emp_info_id >0;

SELECT * FROM hrms.orangehr_master;
update  hrms.orangehr_master set name= replace(name, 'r', 'h') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 's', 'k') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 'r', 'h') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 's', 'k') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 'a', 'u') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 'e', 'g') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 'a', 'r') where orangehr_master_id >0;
update  hrms.orangehr_master set name= replace(name, 'e', 'c') where orangehr_master_id >0;

alter table orangehr_master add primary key orangehr_master(orangehr_master_id);

-- --15 Compare in vs exists clauses  
 SELECT count(1) FROM accounttemp where id in (select 
 id from accounttemp11);
 
  SELECT * FROM accounttemp where  exists (select 
 * from accounttemp11 where accounttemp11.id=accounttemp.id );
 
 
 create index idx_accounttemp_id on accounttemp(id);
  create index idx_accounttemp11_id on accounttemp11(id);
  
  truncate account;
  insert into account select * from accounttemp1 where accounttemp1.id<>account.id;
  
  -- 16 DB query Execution Steps
  COMPILE
  Temporarly Cache the query
  Parse the paramerter data
  EXECUTE
  return
  
  create table table1 (id int, name varchar(22));
create table table2 (id int, name varchar(22));

insert into table1 values (1, 'A');
insert into table1 values (2, 'B');
insert into table1 values (3, 'C');


insert into table2 values (1, 'A');
insert into table2 values (2, 'B');
insert into table2 values (4, 'D');
  
  SET SQL_SAFE_UPDATES = 0;
  show status where `variable_name` = 'Threads_connected';
  
  --17 case
  select fname, case when fname='Suresh' then 'Manager'
             when fname='Rohit' then 'Employee'
             else 'Other'  
             end
             as Title
             
             from emp;
  
  --18 function
  
  SET GLOBAL log_bin_trust_function_creators = 1;
  drop function if exists f1;

DELIMITER $$
CREATE   FUNCTION f1 ()
RETURNS VARCHAR(20)
BEGIN
declare var integer;
select 1 into var;
RETURN "Hello World";
END$$
DELIMITER ;


select f1();

--------------basic example of procedure
drop procedure if exists f2;

DELIMITER $$
CREATE   procedure f2 ()
BEGIN
 
 
Select "Hello World" greetings;
END$$
DELIMITER ;
 

call f2;

-- extended procedure
drop procedure if exists f2;

DELIMITER $$
CREATE   procedure f2 ()
BEGIN
declare  empid1 int;
declare  name1 varchar(22);
 declare cur cursor 
 for select empid, fname from emp;

 OPEN cur;
	lbl: LOOP
    FETCH cur   into empid1, name1;
	select empid1, name1;
	END LOOP;
    CLOSE cur;
     
   END$$
 
 call f2;
 
 /* check for data rows present or not using
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET d=1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET d=1;
 */
 drop procedure if exists getManager;

DELIMITER $$
CREATE   procedure getManager (IN empname varchar(22)  )
BEGIN

declare  name1 varchar(22);
	DECLARE d INT DEFAULT 0;
 declare cur cursor 
 for select  fname from emp where empid=(select managerid from emp where fname=empname);
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET d=1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET d=1;
 OPEN cur;
	lbl: LOOP
    if (d=1) then
		LEAVE lbl;
    else 
		FETCH cur   into  name1;
				if (name1='Suresh') then
				
					select  concat('For Employee ', empname, ' Manager is ', name1) Manager;
				else 
					select  concat('For Employee ', empname, ' No Manager') Manager;
				end if; 
       end if;
	END LOOP;
     -- select  concat('For Employee ', empname, ' No Manager') Manager;
     
    CLOSE cur;
     select  concat('For Employee1 ', empname, ' No Manager') Manager;
  
   END$$
 
 call getManager ('Suresh') ;
 
 --- Usecases
 SELECT year (join_dt), count(*) FROM hrms.emp_info group by year (join_dt) order by year (join_dt)
 
 
 drop function if exists getProjects;

DELIMITER $$
CREATE   function getProjects (empid varchar(200) ) returns varchar(200) 
BEGIN
 declare projects varchar(200) DEFAULT '';
 declare d1 int DEFAULT 0;
  declare tempproj varchar(200);
 declare curr cursor for  select p.project_name
from emp_info e 
                join project_emp_mapping pe on pe.emp_id=e.emp_id 
                join project_info p on p.project_id=pe.project_id
                where e.emp_id=empid;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET d1=1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET d1=1;       
    open curr;
  lbl: loop 
  if(d1=1) then
  leave lbl;
  else 

		  fetch next from curr into tempproj;
          
		  select concat(projects, tempproj, ',') into projects;


  end if;
 end loop;
  close curr;
   select SUBSTRING_INDEX (projects,',',1) into projects;
return projects;
END$$
DELIMITER ;
 

select  getProjects('00000149');


select e.emp_id, e.first_name, e.last_name, d.designation_name, getProjects(e.emp_id)
from emp_info e join designations d on e.designation_id=d.designation_id 
                join project_emp_mapping pe on pe.emp_id=e.emp_id 
                join project_info p on p.project_id=pe.project_id;
				
				-------formatted query-----------
				
				with cte1 as (
            select 
                  distinct b.cnt 
			from (
                  select c.name, 
                         count(*) cnt 
				  from country c, 
                       countrylanguage l 
				  where c.code=l.countrycode 
                  group by c.name 
                  order by cnt desc
                  ) b
limit 4,1) ,
cte2 as (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name) 
 
select cte2.name from cte1,cte2 where cte1.cnt=cte2.cnt;

--- Check Constraint
alter table account add constraint chk_bal check (balance<100000);

-----
with cte as (select round((select count(*) from countrylanguage)/(select count(*) from country)) avg1),

     cte1 as (select c.code, c.name, count(*) cnt from cte, country c join countrylanguage l on c.code=l.CountryCode 
group by c.code, c.name )

select cte1.* from cte1, cte where cte1.cnt< cte.avg1;

---
with cte as (select round((select count(*) from countrylanguage)/(select count(*) from country)) avg1),

     cte1 as (select c.code, c.name, count(*) cnt from cte, country c join countrylanguage l on c.code=l.CountryCode 
group by c.code, c.name )

select cte1.* , cte1.cnt+1 from cte1, cte where cte1.cnt< cte.avg1;