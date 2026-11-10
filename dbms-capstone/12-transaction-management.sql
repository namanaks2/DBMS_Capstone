USE soc_incident_db;

START TRANSACTION;

UPDATE Alerts
SET alert_status = 'Resolved'
WHERE alert_id = 5;

SELECT
    alert_id,
    alert_title,
    alert_status
FROM Alerts
WHERE alert_id = 5;

ROLLBACK;

SELECT
    alert_id,
    alert_title,
    alert_status
FROM Alerts
WHERE alert_id = 5;

START TRANSACTION;

UPDATE Mitigation_Actions
SET action_status = 'Completed',
    completed_at = NOW()
WHERE alert_id = 1
AND action_no = 2;

COMMIT;

SELECT *
FROM Mitigation_Actions
WHERE alert_id = 1
AND action_no = 2;