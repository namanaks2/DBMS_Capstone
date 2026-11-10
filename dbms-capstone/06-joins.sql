USE soc_incident_db;

SELECT
    E.event_id,
    E.event_type,
    A.asset_name,
    E.source_ip,
    E.severity
FROM Security_Events E
INNER JOIN Assets A
ON E.asset_id = A.asset_id;

SELECT
    AL.alert_id,
    AL.alert_title,
    T.threat_name,
    AN.analyst_name,
    AL.severity,
    AL.alert_status
FROM Alerts AL
LEFT JOIN Threats T
ON AL.threat_id = T.threat_id
LEFT JOIN Analysts AN
ON AL.analyst_id = AN.analyst_id;

SELECT
    A.asset_name,
    V.vulnerability_title,
    V.cvss_score,
    V.vulnerability_status
FROM Vulnerabilities V
RIGHT JOIN Assets A
ON V.asset_id = A.asset_id;

SELECT
    AL.alert_id,
    AL.alert_title,
    MA.action_no,
    MA.action_description,
    MA.action_status
FROM Alerts AL
INNER JOIN Mitigation_Actions MA
ON AL.alert_id = MA.alert_id;