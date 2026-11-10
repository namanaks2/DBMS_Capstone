USE soc_incident_db;

CREATE INDEX idx_events_source_time
ON Security_Events(source_ip, event_time);

CREATE INDEX idx_events_severity_status
ON Security_Events(severity, event_status);

CREATE INDEX idx_alerts_status_severity
ON Alerts(alert_status, severity);

CREATE INDEX idx_vulnerabilities_cvss
ON Vulnerabilities(cvss_score);

SHOW INDEX FROM Security_Events;

SHOW INDEX FROM Alerts;

SHOW INDEX FROM Vulnerabilities;