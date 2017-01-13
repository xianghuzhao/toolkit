USE JobLoggingDB;

RENAME TABLE LoggingInfo TO LoggingInfo_old;

CREATE TABLE LoggingInfo (
    JobID INTEGER NOT NULL,
    SeqNum INTEGER NOT NULL DEFAULT 0,
    Status VARCHAR(32) NOT NULL DEFAULT '',
    MinorStatus VARCHAR(128) NOT NULL DEFAULT '',
    ApplicationStatus varchar(255) NOT NULL DEFAULT '',
    StatusTime DATETIME NOT NULL ,
    StatusTimeOrder DOUBLE(12,3) NOT NULL,
    StatusSource VARCHAR(32) NOT NULL DEFAULT 'Unknown',
    PRIMARY KEY (JobID, SeqNum)
) ENGINE = InnoDB;

CREATE TRIGGER SeqNumGenerator BEFORE INSERT ON LoggingInfo
FOR EACH ROW SET NEW.SeqNum= (SELECT IFNULL(MAX(SeqNum) + 1,1) FROM LoggingInfo WHERE JobID=NEW.JobID);

SET UNIQUE_CHECKS=0;
ALTER TABLE LoggingInfo DISABLE KEYS;
INSERT INTO LoggingInfo (JobID,Status,MinorStatus,ApplicationStatus,StatusTime,StatusTimeOrder,StatusSource) SELECT JobID,Status,MinorStatus,ApplicationStatus,StatusTime,StatusTimeOrder,StatusSource FROM LoggingInfo_old; 
ALTER TABLE LoggingInfo ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE LoggingInfo_old;
