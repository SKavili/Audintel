drop function if exists getDailyInterest;

DELIMITER $$
create function getDailyInterest(currentdate datetime,accno integer)
returns float
BEGIN 
DECLARE interest float default 0;
DECLARE rate float;
declare bal float;
set rate = 6;
set bal = (select tx.balance from transaction tx where tx.accountno=accno and tx.tx_at < currentdate order by tx.tx_at desc limit 1);
set interest = (bal*rate)/(12000);
-- insert into transaction(tx_ref_no,accountno,type,amount,balance,tx_at,tx_from,tx_to,tx_mode,tx_status,interestamount)
-- values ("tx_ref_1",accno,'credit',interest,bal+interest,currentdate,'system',accno,'online','success',interest);
return interest;
end$$
delimiter ;


drop function if exists getQuarterlyInterest;
DELIMITER $$
create function getQuarterlyInterest(accno int,currdate datetime)
returns float
BEGIN
declare start_date date;
declare interest_sum integer default 0;
declare d integer default 0;
set start_date=DATE_SUB(date(currdate), INTERVAL 3 MONTH);

lbl: loop
if d=90 THEN
LEAVE lbl;
else 
set interest_sum = interest_sum+ getDailyInterest(start_date,accno);
set d=d+1;
set start_date = DATE_ADD(start_date,INTERVAL 1 DAY);
end if;
end loop;
return interest_sum;
END$$
DELIMITER ;

