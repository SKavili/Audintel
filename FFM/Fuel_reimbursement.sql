use ffm;
create table Fuel_reimbursement(emp_id int, From_latitude int,To_latitude int,distance_travelled int);

drop function if exists fuel_reimbursement
DELIMITER $$
create function fuel_reimbursement( empid int ) returns int
begin
declare cost int;
declare c int;
set cost= (select  sum(distance_travelled)*3 d from fuel_reimbursement where emp_id=empid group by emp_id );

return cost;
end$$

delimiter ;
SET GLOBAL log_bin_trust_function_creators = 1;

select fuel_reimbursement(101);

