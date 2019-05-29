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


INSERT INTO AnomalyClass(Name) VALUES('Safe');
INSERT INTO AnomalyClass(Name) VALUES('Euclid');
INSERT INTO AnomalyClass(Name) VALUES('Keter');
INSERT INTO AnomalyClass(Name) VALUES('Thaumiel');
INSERT INTO AnomalyClass(Name) VALUES('Neutralized');

INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId) Values('Mihael', '', 5, 1);
INSERT INTO SCP(Name, Description, SecurityClearanceNeeded, ClassId) Values('Kabinet 11', '', 3, 3);

