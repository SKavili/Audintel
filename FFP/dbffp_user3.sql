create user dbffp_user3;
select * from travel_info;
select * from member;
select * from destination;
select * from points;
select * from total_distance;

truncate table points;
truncate table travel_info;
truncate table total_distance;
delete from travel_info;
delete from points where ticket_id =103;
update member set points=10;