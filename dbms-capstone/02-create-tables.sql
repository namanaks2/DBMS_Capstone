USE soc_incident_db;

CREATE TABLE IF NOT EXISTS Assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_name VARCHAR(120) NOT NULL,
    asset_type VARCHAR(60) NOT NULL,
    ip_address VARCHAR(45) UNIQUE,
    location VARCHAR(120),
    criticality ENUM('Low','Medium','High','Critical')
    NOT NULL DEFAULT 'Medium'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Analysts (
    analyst_id INT AUTO_INCREMENT PRIMARY KEY,
    analyst_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    specialization VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Threats (
    threat_id INT AUTO_INCREMENT PRIMARY KEY,
    threat_name VARCHAR(120) NOT NULL UNIQUE,
    threat_type VARCHAR(80) NOT NULL,
    threat_level ENUM('Low','Medium','High','Critical') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Security_Events (
    event_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    source_ip VARCHAR(45),
    event_type VARCHAR(100) NOT NULL,
    event_time DATETIME NOT NULL,
    severity ENUM('Low','Medium','High','Critical') NOT NULL,
    event_status ENUM('New','Investigating','Contained','Closed')
    NOT NULL DEFAULT 'New',
    description TEXT,
    FOREIGN KEY (asset_id)
        REFERENCES Assets(asset_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Vulnerabilities (
    vulnerability_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    cve_id VARCHAR(30) UNIQUE,
    vulnerability_title VARCHAR(180) NOT NULL,
    cvss_score DECIMAL(3,1) NOT NULL,
    vulnerability_status ENUM('Open','In Progress','Patched','Accepted')
    NOT NULL DEFAULT 'Open',
    discovered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (cvss_score BETWEEN 0.0 AND 10.0),
    FOREIGN KEY (asset_id)
        REFERENCES Assets(asset_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id BIGINT NOT NULL,
    threat_id INT,
    analyst_id INT,
    alert_title VARCHAR(180) NOT NULL,
    severity ENUM('Low','Medium','High','Critical') NOT NULL,
    alert_status ENUM('Open','Assigned','In Progress','Resolved','Closed')
    NOT NULL DEFAULT 'Open',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id)
        REFERENCES Security_Events(event_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (threat_id)
        REFERENCES Threats(threat_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (analyst_id)
        REFERENCES Analysts(analyst_id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Mitigation_Actions (
    alert_id INT NOT NULL,
    action_no INT NOT NULL,
    action_description VARCHAR(500) NOT NULL,
    priority ENUM('Low','Medium','High','Urgent')
    NOT NULL DEFAULT 'Medium',
    action_status ENUM('Pending','In Progress','Completed','Cancelled')
    NOT NULL DEFAULT 'Pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    completed_at DATETIME,
    PRIMARY KEY (alert_id, action_no),
    FOREIGN KEY (alert_id)
        REFERENCES Alerts(alert_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

SHOW TABLES;