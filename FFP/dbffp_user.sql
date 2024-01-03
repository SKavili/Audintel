create user dbffp_user;

Grant ALL on FFP to dbffp_user;


Drop procedure  if exists CalculatePoints;


DELIMITER //
CREATE PROCEDURE CalculatePointsForTicket(IN ticketIdParam INT)
BEGIN
    DECLARE Var_memberid INT;
    DECLARE Var_destid INT;
    DECLARE Var_kms INT;
    DECLARE Var_points INT;

    DECLARE d INT DEFAULT 0;

    DECLARE curr CURSOR FOR
        SELECT ti.member_id, ti.dest_id, d.kms
        FROM travel_info ti
        JOIN destination d ON ti.dest_id = d.dest_id
        WHERE ti.ticket_id = ticketIdParam;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET d = 1;

    OPEN curr;

    travelLoop: LOOP
        FETCH curr INTO Var_memberid, Var_destid, Var_kms;

        IF d THEN
            LEAVE travelLoop;
        END IF;

        SET Var_points = Var_kms / 2;

        UPDATE travel_info
        SET points = Var_points
        WHERE member_id = Var_memberid AND dest_id = Var_destid AND ticket_id = ticketIdParam;
    END LOOP;

    CLOSE curr;
END //
DELIMITER ;




