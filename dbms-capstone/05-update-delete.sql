USE soc_incident_db;

UPDATE Alerts
SET alert_status = 'In Progress'
WHERE alert_id = 1;

SELECT *
FROM Alerts
WHERE alert_id = 1;

START TRANSACTION;

INSERT INTO Mitigation_Actions
(alert_id, action_no, action_description, priority, action_status)
VALUES
(6, 99, 'Temporary demonstration record', 'Low', 'Pending');

SELECT *
FROM Mitigation_Actions
WHERE alert_id = 6 AND action_no = 99;

DELETE FROM Mitigation_Actions
WHERE alert_id = 6 AND action_no = 99;

SELECT *
FROM Mitigation_Actions
WHERE alert_id = 6 AND action_no = 99;

ROLLBACK;

SELECT *
FROM Mitigation_Actions
WHERE alert_id = 6 AND action_no = 99;