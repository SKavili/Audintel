create user dbffp_user;

Grant ALL on FFP to dbffp_user;


INSERT INTO travel_info (member_id, ticket_id, dest_id, date)
VALUES
(1, 101, 1, '2024-01-07'),
(2, 102, 5, '2024-01-08'),
(3, 103, 8, '2024-01-09'),
(4, 104, 12, '2024-01-10'),
(5, 105, 15, '2024-01-11'),
(6, 106, 19, '2024-01-12'),
(7, 107, 23, '2024-01-13');

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

CREATE TRIGGER after_travel_info_insert
AFTER INSERT ON travel_info
FOR EACH ROW
BEGIN
    DECLARE calculated_points INT;

    SELECT kms INTO calculated_points
    FROM destination
    WHERE dest_id = NEW.dest_id;

    SET calculated_points = calculated_points / 2;

    INSERT INTO points (member_id, ticket_id, points)
    VALUES (NEW.member_id, NEW.ticket_id, calculated_points);

    UPDATE member
    SET points = points + calculated_points
    WHERE member_id = NEW.member_id;
END;
//

DELIMITER ;



select * from points;
create table level


