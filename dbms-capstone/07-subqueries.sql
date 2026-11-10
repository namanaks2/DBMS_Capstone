USE soc_incident_db;

SELECT *
FROM Vulnerabilities
WHERE cvss_score >
(
    SELECT AVG(cvss_score)
    FROM Vulnerabilities
);

SELECT *
FROM Security_Events
WHERE asset_id IN
(
    SELECT asset_id
    FROM Assets
    WHERE criticality = 'Critical'
);

SELECT *
FROM Alerts
WHERE analyst_id IN
(
    SELECT analyst_id
    FROM Analysts
    WHERE specialization = 'Incident Response'
);

SELECT
    asset_id,
    asset_name,
    criticality
FROM Assets A
WHERE EXISTS
(
    SELECT 1
    FROM Security_Events E
    WHERE E.asset_id = A.asset_id
    AND E.severity = 'Critical'
);