create user dbffp_user2;

Grant ALL on FFP to dbffp_user2;

DROP TRIGGER IF EXISTS after_travel_info_insert;
DELIMITER //
CREATE TRIGGER after_travel_info_insert
AFTER INSERT ON travel_info
FOR EACH ROW
BEGIN
    DECLARE calculated_points INT;
    DECLARE is_main_person BOOLEAN;
    DECLARE total_persons INT;
    DECLARE Distance INT; 
    SET is_main_person = NEW.person_travelling;

    SELECT d.kms, t.total_members INTO Distance, total_persons
    FROM destination d
    JOIN travel_info t ON d.dest_id = t.dest_id
    WHERE d.dest_id = NEW.dest_id;

    IF is_main_person THEN
        SET calculated_points = Distance / 5 + (total_persons - 1) * Distance / 10;
    ELSE
        SET calculated_points = total_persons * Distance / 10;
    END IF;

    INSERT INTO points (points_id,member_id, ticket_id, points)
    VALUES (NEW.member_id, NEW.ticket_id, calculated_points);
    UPDATE member
    SET points = points + calculated_points
    WHERE member_id = NEW.member_id;

    INSERT INTO total_distance (id, total_distance)
    VALUES (NEW.member_id, Distance)
    ON DUPLICATE KEY UPDATE total_distance = total_distance + Distance;
END;
//

DELIMITER ;

DROP TRIGGER IF EXISTS after_total_distance_update;
DELIMITER //
CREATE TRIGGER after_total_distance_update
AFTER UPDATE ON total_distance
FOR EACH ROW
BEGIN
    DECLARE calculated_points INT;
    DECLARE total_distance INT;
    DECLARE code_value INT;
    
    SELECT total_distance, code INTO total_distance, code_value
    FROM total_distance
    WHERE id = NEW.id;

    IF code_value = 4 THEN
        SET calculated_points = 0;
    ELSE
        SET calculated_points = CASE
            WHEN code_value = 3 AND total_distance >= 1000000 THEN 10000
            WHEN code_value = 2 AND total_distance >= 500000 THEN 3000
            WHEN code_value = 1 AND total_distance >= 100000 THEN 1000
            WHEN code_value = 0 AND total_distance >= 10000 THEN 500
            ELSE 0
        END;

        UPDATE total_distance
        SET code = CASE
            WHEN code_value < 4 THEN code_value + 1
            ELSE 4
        END
        WHERE id = NEW.id;
    END IF;

    UPDATE member
    SET points = points + calculated_points;
END;
//

DELIMITER ;


