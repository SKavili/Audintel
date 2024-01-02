create database cbs;

drop table account;

create table account (id numeric(30), accountid varchar(30), custid numeric(10), 
					  accounttype varchar(10), opendate date, closedate date,
					  category varchar(10))

insert into account values (1,'0310848383833',1,'SB', '01-01-2024', null, 1 );


create table accountext (isActive boolean )
INHERITS (account);
insert into accountext values (2,'0344444444',1,'Current', '01-01-2024', null, 1, true ); 

select * from account;
select * from accountext;

select * into account1 from account

insert into account1 select a.* from account a, account b, account1 c


insert into account1 select a.* from account a

select count(1) FROM account1



create  function  f1() returns int
return 10;
 
select f1();




create  procedure sp_getAcctCnt(cnt int) 
LANGUAGE 'sql'
AS $BODY$

$BODY$;

create  or replace procedure sp_getAcctCnt(cnt int) 
LANGUAGE 'sql'
AS $BODY$
select count(1) into cnt from account;
$BODY$;

create  procedure sp_getAcctCnt1(IN cnt int) 
LANGUAGE 'sql'
AS $BODY$
acct_cnt NUMBER(4);

CURSOR acct_cur is select count(*) cnt from account;

BEGIN
open acct_cur;
LOOP
   fetch acct_cur into acct_cnt;
DBMS_OUTPUT.PUT_LINE(acct_cnt)
end loop;
close acct_cur;
end
$BODY$;





create  or replace procedure sp_getAcctCnt( cnt int) 
LANGUAGE 'sql'
AS $BODY$
select count(1) into cnt from account;

 
$BODY$;



select accounttype, count(*) from account group by accounttype
explain select accounttype, count(*) from account group by accounttype order by accounttype

explain analyse  select accounttype, count(*) from account group by accounttype order by accounttype



create table test (id serial primary key, name text)

create table test1(id1 serial, testid int, constraint fk_test1_testid foreign key (testid) references
				   test(id))
				   
				   
DROP INDEX IF EXISTS public.idx_test1_id;

CREATE INDEX IF NOT EXISTS idx_test1_id
    ON public.test1 USING btree
    (testid);
	
	
	alter table test1 add column desc1 text;
	
	
	CREATE ROLE root1 WITH 
	PASSWORD 'root';
	
	
	
	CREATE OR REPLACE FUNCTION acctCnt() RETURNS
 void AS $vv$
DECLARE
 cnt_curr CURSOR IS
 SELECT count(*) FROM account;
 
 cnt int;
BEGIN
 
 FOR ct IN cnt_curr LOOP
  cnt := ct;
 END LOOP;
  
END;
$vv$ LANGUAGE plpgsql;

		CREATE OR REPLACE FUNCTION acctCnt() RETURNS
		 void AS $vv$
		DECLARE
		 cnt_curr CURSOR IS
		 SELECT count(*) as ct FROM account;
		 
		 cnt int;
		BEGIN
		 
		 Open cnt_curr;
		 LOOP
		 fetch cnt_curr into cnt;
			select cnt;
		 END LOOP;
		  
		END;
		$vv$ LANGUAGE plpgsql;

		select acctcnt();
		
		====================
		
		CREATE OR REPLACE FUNCTION cs_create_job(v_job_id integer) RETURNS
 void AS $BODY$
DECLARE
 a_running_job_count integer;
BEGIN
 LOCK TABLE cs_jobs IN EXCLUSIVE MODE;
 SELECT count(*) INTO a_running_job_count FROM cs_jobs WHERE
 end_stamp IS NULL;
 IF a_running_job_count > 0 THEN
 RAISE EXCEPTION 'Unable to create a new job: a job is
 currently running'; -- 1
 END IF;
 DELETE FROM cs_active_job;
 INSERT INTO cs_active_job(job_id) VALUES (v_job_id);
 BEGIN
 INSERT INTO cs_jobs (job_id, start_stamp) VALUES (v_job_id,
 now());
 EXCEPTION
 WHEN unique_violation THEN -- 2
 -- don't worry if it already exists
 END;
END;
$BODY$ LANGUAGE plpgsql;

select cs_create_job(0)
===============================

create user guest identified by 'root';

grant select on * to guest;
revoke select on * from guest;


select balance from account  where id=1;
BEGIN;
update account set balance=99999 where id=1;
rollback;



select balance from account  where id=1;
BEGIN;
update account set balance=0000 where id=1;
select balance from account  where id=1;
commit;



select balance from account  where id=1;
BEGIN;

update account set balance=11111 where id=1;
savepoint id2sp;
update account set balance=222222 where id=2;
select balance from account  where id in (1,2);

rollback to id2sp;
select balance from account  where id in (1,2);

SELECT * FROM world.countrylanguage where countrycode not in (select code from country);

SELECT * FROM world.country where code  in (select countrycode from countrylanguage);

SELECT * FROM world.country where  exists (select 1 from countrylanguage l where l.countrycode=country.code);

select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc limit 1;

select c.name from (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name having cnt=
(select b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc limit 1) b))c ;


select c.name from (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name having cnt=
(select cc.cnt from (
select distinct b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc) b
limit 5
) cc order by cc.cnt limit 1 ))c ;



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


with cte as (select 1 as cnt) 
select cte.cnt from cte;


with cte as (select 1 as cnt) ,
 cte1 as (select 2 as cnt1) 
select cte1.cnt1 from cte1;


with cte as (select 1 as cnt) ,
 cte1 as (select 2 as cnt1) 
select cte.cnt,cte1.cnt1 from cte,cte1;


with cte1 as (select distinct b.cnt from (
select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name order by cnt desc) b
limit 4,1) ,

 cte2 as (select c.name, count(*) cnt from country c, countrylanguage l where c.code=l.countrycode group by c.name) 
 
select cte2.name from cte1,cte2 where cte1.cnt=cte2.cnt;





