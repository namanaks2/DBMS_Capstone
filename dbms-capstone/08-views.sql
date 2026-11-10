USE soc_incident_db;

CREATE OR REPLACE VIEW Alert_Investigation_View AS
SELECT
    AL.alert_id,
    AL.alert_title,
    AL.severity,
    AL.alert_status,
    E.event_type,
    E.source_ip,
    E.event_time,
    A.asset_name,
    T.threat_name,
    AN.analyst_name
FROM Alerts AL
INNER JOIN Security_Events E
ON AL.event_id = E.event_id
INNER JOIN Assets A
ON E.asset_id = A.asset_id
LEFT JOIN Threats T
ON AL.threat_id = T.threat_id
LEFT JOIN Analysts AN
ON AL.analyst_id = AN.analyst_id;

SELECT *
FROM Alert_Investigation_View;

CREATE OR REPLACE VIEW Open_Critical_Alerts AS
SELECT
    alert_id,
    alert_title,
    severity,
    alert_status,
    created_at
FROM Alerts
WHERE severity = 'Critical'
AND alert_status IN ('Open','Assigned','In Progress');

SELECT *
FROM Open_Critical_Alerts;