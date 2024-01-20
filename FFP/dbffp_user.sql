create user dbffp_user;

Grant ALL on FFP to dbffp_user;
SET SQL_SAFE_UPDATES = 0;

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
