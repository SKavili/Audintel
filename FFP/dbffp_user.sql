create user dbffp_user;

Grant ALL on FFP to dbffp_user;
SET SQL_SAFE_UPDATES = 1;

select * from travel_info;
INSERT INTO travel_info (member_id, ticket_id, dest_id, date,total_members,person_travelling)
VALUES
(1, 101, 1, '2024-01-07',3,true),
(2, 102, 5, '2024-01-08',4,false),
(3, 103, 8, '2024-01-09',1,true),
(4, 104, 12, '2024-01-10',6,true),
(5, 105, 15, '2024-01-11',4,true),
(6, 106, 19, '2024-01-12',5,false),
(7, 107, 23, '2024-01-13',2,true);

INSERT INTO store (store_id, store_name)
VALUES
(1, 'Store A'),
(2, 'Store B'),
(3, 'Store C'),
(4, 'Store D'),
(5, 'Store E');

INSERT INTO Ordert (order_id, store_id, member_id, cost, date, status)
VALUES
(101, 1, 1, 500, '2024-01-07', true),
(102, 2, 3, 750, '2024-01-08', false),
(103, 3, 5, 300, '2024-01-09', true),
(104, 1, 2, 1000, '2024-01-10', false),
(105, 4, 4, 600, '2024-01-11', true);

INSERT INTO order_details (order_id, item_name, quantity, price, date)
VALUES
(101, 'Item 1', 2, 100, '2024-01-07'),
(102, 'Item 2', 1, 250, '2024-01-08'),
(103, 'Item 3', 3, 50, '2024-01-09'),
(104, 'Item 4', 2, 500, '2024-01-10'),
(105, 'Item 5', 1, 600, '2024-01-11');




DROP TRIGGER IF EXISTS after_travel_info_insert;
DELIMITER //

-- Create the trigger
CREATE TRIGGER after_travel_info_insert
AFTER INSERT ON travel_info
FOR EACH ROW
BEGIN
    DECLARE calculated_points INT;
    DECLARE is_main_person BOOLEAN;
    DECLARE total_persons INT;
    declare Distance INT; 
    SET is_main_person = NEW.person_travelling;
    SELECT kms, total_persons INTO Distance, total_persons
    FROM destination
    WHERE dest_id = NEW.dest_id;
    IF is_main_person THEN
        SET calculated_points = Distance / 5 + (total_persons - 1) * Distance / 10;
    ELSE
        SET calculated_points = total_persons * Distance / 10;
    END IF;
    INSERT INTO points (member_id, ticket_id, points)
    VALUES (NEW.member_id, NEW.ticket_id, calculated_points);
    UPDATE member
    SET points = points + calculated_points
    WHERE member_id = NEW.member_id;
    UPDATE total_distance
    SET total_distance = total_distance + Distance
    WHERE id = NEW.member_id;
END;
//

DELIMITER ;

DROP TRIGGER IF EXISTS after_total_distance_update;
DELIMITER //

-- Create the trigger
CREATE TRIGGER after_total_distance_update
AFTER UPDATE ON total_distance
FOR EACH ROW
BEGIN
    DECLARE calculated_points INT;
    DECLARE total_distance INT;
    DECLARE code_value INT;

    -- Fetch the updated total distance and code value
    SELECT total_distance, code INTO total_distance, code_value
    FROM total_distance
    WHERE id = NEW.id;

    -- Check the code value and calculate bonus points accordingly
    IF code_value = 4 THEN
        -- Do not add bonus
        SET calculated_points = 0;
    ELSE
        -- Add bonus based on total distance
        SET calculated_points = CASE
            WHEN code_value = 3 AND total_distance >= 1000000 THEN 10000
            WHEN code_value = 2 AND total_distance >= 500000 THEN 3000
            WHEN code_value = 1 AND total_distance >= 100000 THEN 1000
            WHEN code_value = 1 AND total_distance >= 10000 THEN 500
            ELSE 0
        END;

        -- Increment the code value, stay at 4 if it reaches 4
        UPDATE total_distance
        SET code = CASE
            WHEN code_value < 4 THEN code_value + 1
            ELSE 4
        END
        WHERE id = NEW.id;
    END IF;

    -- Update points in the 'member' table based on the calculated bonus points
    UPDATE member
    SET points = points + calculated_points;
END;
//

DELIMITER ;


select * from points;
create table total_distance(id int primary key,total_distance long,code int default 0,
foreign key(id) references member(member_id));
Drop table total_distance;
ALTER TABLE travel_info
ADD COLUMN total_members int CHECK(total_members<=6);
ALTER TABLE travel_info
ADD COLUMN person_travelling boolean;


select * from total_distance;

