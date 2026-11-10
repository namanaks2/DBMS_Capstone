USE soc_incident_db;

SELECT
    E.source_ip,
    COUNT(*) AS event_count,
    COUNT(DISTINCT E.asset_id) AS affected_assets,
    MAX(E.event_time) AS latest_event_time
FROM Security_Events E
GROUP BY E.source_ip
HAVING COUNT(*) >= 1
ORDER BY event_count DESC;

SELECT
    A.asset_name,
    COUNT(E.event_id) AS total_events,
    SUM(E.severity = 'Critical') AS critical_events
FROM Assets A
LEFT JOIN Security_Events E
ON A.asset_id = E.asset_id
GROUP BY A.asset_id, A.asset_name
ORDER BY critical_events DESC, total_events DESC;

SELECT
    AL.alert_id,
    AL.alert_title,
    AL.severity,
    AL.alert_status,
    AN.analyst_name,
    CASE
        WHEN AL.severity = 'Critical' THEN 'Immediate response'
        WHEN AL.severity = 'High' THEN 'High priority'
        WHEN AL.severity = 'Medium' THEN 'Standard priority'
        ELSE 'Monitor'
    END AS response_priority
FROM Alerts AL
LEFT JOIN Analysts AN
ON AL.analyst_id = AN.analyst_id
ORDER BY FIELD(AL.severity,'Critical','High','Medium','Low');

SELECT
    alert_id,
    alert_title,
    severity,
    ROW_NUMBER() OVER (
        PARTITION BY severity
        ORDER BY created_at DESC
    ) AS severity_rank
FROM Alerts;

SELECT
    AL.alert_id,
    AL.alert_title,
    COUNT(MA.action_no) AS total_actions,
    SUM(MA.action_status = 'Completed') AS completed_actions
FROM Alerts AL
LEFT JOIN Mitigation_Actions MA
ON AL.alert_id = MA.alert_id
GROUP BY AL.alert_id, AL.alert_title;