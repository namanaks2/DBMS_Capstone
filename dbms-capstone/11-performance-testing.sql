USE soc_incident_db;

EXPLAIN
SELECT *
FROM Security_Events
WHERE source_ip = '203.0.113.15'
AND event_time >= '2026-10-01 00:00:00';

EXPLAIN
SELECT *
FROM Security_Events
WHERE severity = 'Critical'
AND event_status = 'Investigating';

EXPLAIN
SELECT *
FROM Alerts
WHERE alert_status = 'Open'
AND severity = 'Critical';

ANALYZE TABLE Security_Events;

ANALYZE TABLE Alerts;

ANALYZE TABLE Vulnerabilities;