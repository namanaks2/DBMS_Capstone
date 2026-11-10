USE soc_incident_db;

INSERT INTO Assets
(asset_name, asset_type, ip_address, location, criticality)
VALUES
('Primary Web Server','Server','10.0.0.10','Data Centre','Critical'),
('Employee Laptop 01','Endpoint','10.0.0.21','Head Office','Medium'),
('Customer Database','Database','10.0.0.30','Data Centre','Critical'),
('Mail Gateway','Network Appliance','10.0.0.40','Cloud Region 1','High'),
('Finance Workstation','Workstation','10.0.0.51','Finance Department','High');

INSERT INTO Analysts
(analyst_name, email, specialization)
VALUES
('Aarav Mehta','aarav.mehta@example.com','Network Security'),
('Diya Sharma','diya.sharma@example.com','Malware Analysis'),
('Kabir Verma','kabir.verma@example.com','Incident Response');

INSERT INTO Threats
(threat_name, threat_type, threat_level)
VALUES
('Credential Phishing','Social Engineering','High'),
('Ransomware Activity','Malware','Critical'),
('Port Scanning','Reconnaissance','Medium'),
('SQL Injection','Web Application Attack','Critical');

INSERT INTO Security_Events
(asset_id, source_ip, event_type, event_time, severity, event_status, description)
VALUES
(1,'203.0.113.15','Multiple failed login attempts','2026-10-01 09:15:00','High','Investigating','Repeated authentication failures detected'),
(2,'198.51.100.22','Suspicious email attachment','2026-10-02 11:30:00','Critical','Contained','Endpoint security detected a malicious attachment'),
(3,'203.0.113.44','Unusual database query','2026-10-03 14:05:00','Critical','Investigating','Unexpected query pattern detected'),
(4,'198.51.100.77','Suspicious inbound email','2026-10-04 08:45:00','Medium','New','Email gateway flagged a suspicious message'),
(5,'192.0.2.88','Unusual outbound traffic','2026-10-05 16:20:00','High','New','Workstation generated unusual outbound traffic'),
(1,'203.0.113.91','Port scan detected','2026-10-06 19:10:00','Medium','Closed','External port scan was detected and logged');

INSERT INTO Vulnerabilities
(asset_id, cve_id, vulnerability_title, cvss_score, vulnerability_status, discovered_at)
VALUES
(1,'CVE-2025-10001','Web server remote code execution risk',9.2,'Open','2026-09-20 10:00:00'),
(3,'CVE-2025-10002','Database privilege escalation weakness',8.1,'In Progress','2026-09-22 12:00:00'),
(2,'CVE-2025-10003','Endpoint software outdated component',5.4,'Patched','2026-09-25 09:30:00'),
(4,NULL,'Mail gateway configuration weakness',6.8,'Open','2026-09-27 15:45:00');

INSERT INTO Alerts
(event_id, threat_id, analyst_id, alert_title, severity, alert_status, created_at)
VALUES
(1,1,1,'Possible credential attack on web server','High','Assigned','2026-10-01 09:20:00'),
(2,2,2,'Ransomware behaviour on employee endpoint','Critical','In Progress','2026-10-02 11:35:00'),
(3,4,3,'Possible SQL injection against database','Critical','Open','2026-10-03 14:10:00'),
(4,1,1,'Potential phishing email detected','Medium','Resolved','2026-10-04 08:50:00'),
(5,2,2,'Unusual outbound traffic from workstation','High','Open','2026-10-05 16:25:00'),
(6,3,3,'Reconnaissance activity detected','Medium','Closed','2026-10-06 19:15:00');

INSERT INTO Mitigation_Actions
(alert_id, action_no, action_description, priority, action_status, created_at, completed_at)
VALUES
(1,1,'Enforce password reset for affected accounts','High','Completed','2026-10-01 09:30:00','2026-10-01 10:00:00'),
(1,2,'Enable multi-factor authentication','High','In Progress','2026-10-01 09:35:00',NULL),
(2,1,'Isolate endpoint from the corporate network','Urgent','Completed','2026-10-02 11:40:00','2026-10-02 11:50:00'),
(2,2,'Run malware analysis and remove malicious files','Urgent','In Progress','2026-10-02 11:45:00',NULL),
(3,1,'Review database query logs and block malicious input','Urgent','Pending','2026-10-03 14:20:00',NULL),
(4,1,'Quarantine suspicious email and block sender','Medium','Completed','2026-10-04 09:00:00','2026-10-04 09:15:00'),
(5,1,'Investigate destination IP and restrict outbound traffic','High','Pending','2026-10-05 16:35:00',NULL);

SELECT 'Assets' AS table_name, COUNT(*) AS total_records FROM Assets
UNION ALL
SELECT 'Analysts', COUNT(*) FROM Analysts
UNION ALL
SELECT 'Threats', COUNT(*) FROM Threats
UNION ALL
SELECT 'Security_Events', COUNT(*) FROM Security_Events
UNION ALL
SELECT 'Vulnerabilities', COUNT(*) FROM Vulnerabilities
UNION ALL
SELECT 'Alerts', COUNT(*) FROM Alerts
UNION ALL
SELECT 'Mitigation_Actions', COUNT(*) FROM Mitigation_Actions;