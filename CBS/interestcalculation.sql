drop function if exists getDailyInterest;

DELIMITER $$
create function getDailyInterest(currentdate date)
returns float
BEGIN 
DECLARE interest float default 0;
DECLARE rate float;
declare balance float;
set rate = 6;
set balance = (select tx.balance from transaction tx where day(tx.tx_at)= currentdate order by tx.tx_at limit 1);
set interest = (balance*rate)/(12000);
insert into transaction(tx_ref_no,accountno,type,amount,balance,tx_at,tx_from,tx_to,tx_mode,tx_status,interestamount)
values ("tx_ref_1",accountno,'credit',interest,balance+interest,currentdate,'system',accountno,'online','success',interest);
return interest;
end$$
delimiter ;