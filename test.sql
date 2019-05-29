DROP DATABASE IF EXISTS SCP;

CREATE DATABASE SCP;

USE SCP;

CREATE TABLE SecurityClearance(
	Level TINYINT AUTO_INCREMENT,
    Name VARCHAR(32) NOT NULL UNIQUE,
    Description TEXT,
    PRIMARY KEY(LEVEL)
);

CREATE TABLE AnomalyClass(
	Id TINYINT AUTO_INCREMENT,
	Name VARCHAR(32) NOT NULL UNIQUE,
    Description TEXT,
    PRIMARY KEY(Id)
);

CREATE TABLE SCP(
	Id INTEGER AUTO_INCREMENT,
	Name VARCHAR(128) NOT NULL,
    Description TEXT,
	SecurityClearanceNeeded TINYINT NOT NULL,
    ClassId TINYINT NOT NULL,
    FOREIGN KEY(SecurityClearanceNeeded) REFERENCES SecurityClearance(Level),
    FOREIGN KEY(ClassId) REFERENCES AnomalyClass(Id),
    PRIMARY KEY(Id)
);


INSERT INTO SecurityClearance(Level, Name) Values(1, 'For official use');
INSERT INTO SecurityClearance(Level, Name) Values(2, 'Confidential');
INSERT INTO SecurityClearance(Level, Name) Values(3, 'Restricted');
INSERT INTO SecurityClearance(Level, Name) Values(4, 'Secret');
INSERT INTO SecurityClearance(Level, Name) Values(5, 'Top-Secret');
INSERT INTO SecurityClearance(Level, Name) Values(6, 'Thaumiel');


INSERT INTO AnomalyClass(Id, Name) VALUES(1, 'Safe');
INSERT INTO AnomalyClass(Id, Name) VALUES(2, 'Euclid');
INSERT INTO AnomalyClass(Id, Name) VALUES(3, 'Keter');
INSERT INTO AnomalyClass(Id, Name) VALUES(4, 'Thaumiel');
INSERT INTO AnomalyClass(Id, Name) VALUES(5, 'Neutralized');

INSERT INTO SCP(Id, Name, Description, SecurityClearanceNeeded, ClassId) Values(1, 'Mihael', '', 5, 1);
INSERT INTO SCP(Id, Name, Description, SecurityClearanceNeeded, ClassId) Values(2, 'Kabinet 11', '', 3, 3);

SELECT * FROM SCP;