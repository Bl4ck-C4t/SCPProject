DROP DATABASE IF EXISTS SCP;

CREATE DATABASE SCP;

USE SCP;

CREATE TABLE SecurityClearance(
	Level INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(32) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE AnomalyClass(
	Id INTEGER PRIMARY KEY AUTOINCREMENT,
	Name VARCHAR(32) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE SCP(
	Id INTEGER PRIMARY KEY AUTOINCREMENT,
	Name VARCHAR(128) NOT NULL,
    Description TEXT,
	SecurityClearanceNeeded TINYINT NOT NULL,
    ClassId TINYINT NOT NULL,
    FOREIGN KEY(SecurityClearanceNeeded) REFERENCES SecurityClearance(Level),
    FOREIGN KEY(ClassId) REFERENCES AnomalyClass(Id)
);


INSERT INTO SecurityClearance(Level, Name) Values(1, 'For official use');
INSERT INTO SecurityClearance(Level, Name) Values(2, 'Confidential');
INSERT INTO SecurityClearance(Level, Name) Values(3, 'Restricted');
INSERT INTO SecurityClearance(Level, Name) Values(4, 'Secret');
INSERT INTO SecurityClearance(Level, Name) Values(5, 'Top-Secret');
INSERT INTO SecurityClearance(Level, Name) Values(6, 'Thaumiel');


INSERT INTO AnomalyClass(Id, Name) VALUES('Safe');
INSERT INTO AnomalyClass(Id, Name) VALUES('Euclid');
INSERT INTO AnomalyClass(Id, Name) VALUES('Keter');
INSERT INTO AnomalyClass(Id, Name) VALUES('Thaumiel');
INSERT INTO AnomalyClass(Id, Name) VALUES('Neutralized');

INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId) Values('Mihael', '', 5, 1);
INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId) Values('Kabinet 11', '', 3, 3);

SELECT scp.Id, scp.Name, scp.Description, sc.Name AS SecurityClearance, ac.Name as AnomalyClass
FROM SCP scp
INNER JOIN SecurityClearance sc ON sc.Level = scp.SecurityClearanceNeeded
INNER JOIN AnomalyClass ac ON ac.Id = scp.ClassId
WHERE scp.Id = 1;


SELECT * FROM SecurityClearance;

SELECT * FROM AnomalyClass;