USE soc_incident_db;

SELECT * FROM Assets;

SELECT * FROM Analysts;

SELECT * FROM Threats;

SELECT * FROM Security_Events;

SELECT * FROM Vulnerabilities;

SELECT * FROM Alerts;

SELECT * FROM Mitigation_Actions;

SELECT alert_id, alert_title, severity, alert_status
FROM Alerts
WHERE severity IN ('High','Critical');

SELECT event_id, event_type, event_time, severity
FROM Security_Events
ORDER BY event_time DESC;

SELECT severity, COUNT(*) AS total_alerts
FROM Alerts
GROUP BY severity;

SELECT alert_status, COUNT(*) AS total_alerts
FROM Alerts
GROUP BY alert_status;

SELECT severity, COUNT(*) AS total_alerts
FROM Alerts
GROUP BY severity
HAVING COUNT(*) >= 1;

SELECT COUNT(*) AS total_events
FROM Security_Events;

SELECT AVG(cvss_score) AS average_cvss
FROM Vulnerabilities;

SELECT MAX(cvss_score) AS highest_cvss
FROM Vulnerabilities;

SELECT MIN(cvss_score) AS lowest_cvss
FROM Vulnerabilities;