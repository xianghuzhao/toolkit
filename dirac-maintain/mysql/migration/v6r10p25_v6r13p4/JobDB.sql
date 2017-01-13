USE JobDB;

-- Drop Tables

DROP TABLE IF EXISTS PrecursorJobs;
DROP TABLE IF EXISTS SubJobs;
DROP TABLE IF EXISTS TaskQueue;
DROP TABLE IF EXISTS TaskQueues;


-- Delete Old Items

DELETE FROM InputData WHERE JobID NOT IN (SELECT JobID FROM Jobs);
DELETE FROM JobParameters WHERE JobID NOT IN (SELECT JobID FROM Jobs);
DELETE FROM AtticJobParameters WHERE JobID NOT IN (SELECT JobID FROM Jobs);
DELETE FROM HeartBeatLoggingInfo WHERE JobID NOT IN (SELECT JobID FROM Jobs);
DELETE FROM OptimizerParameters WHERE JobID NOT IN (SELECT JobID FROM Jobs);
DELETE FROM JobCommands WHERE JobID NOT IN (SELECT JobID FROM Jobs);


-- Table JobJDLs

RENAME TABLE JobJDLs TO JobJDLs_old;

CREATE TABLE `JobJDLs` (
  `JobID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `JDL` mediumblob NOT NULL,
  `JobRequirements` blob NOT NULL,
  `OriginalJDL` mediumblob NOT NULL,
  PRIMARY KEY (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE JobJDLs DISABLE KEYS;
INSERT INTO JobJDLs (JobID,JDL,JobRequirements,OriginalJDL) SELECT JobID,JDL,JobRequirements,OriginalJDL FROM JobJDLs_old; 
ALTER TABLE JobJDLs ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE JobJDLs_old;


-- Table Jobs

RENAME TABLE Jobs TO Jobs_old;

CREATE TABLE `Jobs` (
  `JobID` int(11) unsigned NOT NULL DEFAULT '0',
  `JobType` varchar(32) NOT NULL DEFAULT 'user',
  `DIRACSetup` varchar(32) NOT NULL DEFAULT 'test',
  `JobGroup` varchar(32) NOT NULL DEFAULT '00000000',
  `JobSplitType` enum('Single','Master','Subjob','DAGNode') NOT NULL DEFAULT 'Single',
  `MasterJobID` int(11) unsigned NOT NULL DEFAULT '0',
  `Site` varchar(100) NOT NULL DEFAULT 'ANY',
  `JobName` varchar(128) NOT NULL DEFAULT 'Unknown',
  `Owner` varchar(32) NOT NULL DEFAULT 'Unknown',
  `OwnerDN` varchar(255) NOT NULL DEFAULT 'Unknown',
  `OwnerGroup` varchar(128) NOT NULL DEFAULT 'Unknown',
  `SubmissionTime` datetime DEFAULT NULL,
  `RescheduleTime` datetime DEFAULT NULL,
  `LastUpdateTime` datetime DEFAULT NULL,
  `StartExecTime` datetime DEFAULT NULL,
  `HeartBeatTime` datetime DEFAULT NULL,
  `EndExecTime` datetime DEFAULT NULL,
  `Status` varchar(32) NOT NULL DEFAULT 'Received',
  `MinorStatus` varchar(128) NOT NULL DEFAULT 'Unknown',
  `ApplicationStatus` varchar(255) DEFAULT 'Unknown',
  `ApplicationNumStatus` int(11) NOT NULL DEFAULT '0',
  `CPUTime` float NOT NULL DEFAULT '0',
  `UserPriority` int(11) NOT NULL DEFAULT '0',
  `SystemPriority` int(11) NOT NULL DEFAULT '0',
  `RescheduleCounter` int(11) NOT NULL DEFAULT '0',
  `VerifiedFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `DeletedFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `KilledFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `FailedFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `ISandboxReadyFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `OSandboxReadyFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `RetrievedFlag` enum('True','False') NOT NULL DEFAULT 'False',
  `AccountedFlag` enum('True','False','Failed') NOT NULL DEFAULT 'False',
  PRIMARY KEY (`JobID`),
  KEY `JobType` (`JobType`),
  KEY `DIRACSetup` (`DIRACSetup`),
  KEY `JobGroup` (`JobGroup`),
  KEY `JobSplitType` (`JobSplitType`),
  KEY `Site` (`Site`),
  KEY `Owner` (`Owner`),
  KEY `OwnerDN` (`OwnerDN`),
  KEY `OwnerGroup` (`OwnerGroup`),
  KEY `Status` (`Status`),
  KEY `MinorStatus` (`MinorStatus`),
  KEY `ApplicationStatus` (`ApplicationStatus`),
  KEY `StatusSite` (`Status`,`Site`),
  KEY `LastUpdateTime` (`LastUpdateTime`),
  FOREIGN KEY (`JobID`) REFERENCES `JobJDLs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE Jobs DISABLE KEYS;
INSERT INTO Jobs (JobID,JobType,DIRACSetup,JobGroup,JobSplitType,MasterJobID,Site,JobName,Owner,OwnerDN,OwnerGroup,SubmissionTime,RescheduleTime,LastUpdateTime,StartExecTime,HeartBeatTime,EndExecTime,Status,MinorStatus,ApplicationStatus,ApplicationNumStatus,CPUTime,UserPriority,SystemPriority,RescheduleCounter,VerifiedFlag,DeletedFlag,KilledFlag,FailedFlag,ISandboxReadyFlag,OSandboxReadyFlag,RetrievedFlag,AccountedFlag) SELECT JobID,JobType,DIRACSetup,JobGroup,JobSplitType,MasterJobID,Site,JobName,Owner,OwnerDN,OwnerGroup,SubmissionTime,RescheduleTime,LastUpdateTime,StartExecTime,HeartBeatTime,EndExecTime,Status,MinorStatus,ApplicationStatus,ApplicationNumStatus,CPUTime,UserPriority,SystemPriority,RescheduleCounter,VerifiedFlag,DeletedFlag,KilledFlag,FailedFlag,ISandboxReadyFlag,OSandboxReadyFlag,RetrievedFlag,AccountedFlag FROM Jobs_old; 
ALTER TABLE Jobs ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE Jobs_old;


-- Table AtticJobParameters

RENAME TABLE AtticJobParameters TO AtticJobParameters_old;

CREATE TABLE `AtticJobParameters` (
  `JobID` int(11) unsigned NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Value` blob NOT NULL,
  `RescheduleCycle` int(11) unsigned NOT NULL,
  PRIMARY KEY (`JobID`,`Name`,`RescheduleCycle`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE AtticJobParameters DISABLE KEYS;
INSERT INTO AtticJobParameters (JobID,Name,Value,RescheduleCycle) SELECT JobID,Name,Value,RescheduleCycle FROM AtticJobParameters_old; 
ALTER TABLE AtticJobParameters ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE AtticJobParameters_old;


-- Table HeartBeatLoggingInfo

RENAME TABLE HeartBeatLoggingInfo TO HeartBeatLoggingInfo_old;

CREATE TABLE `HeartBeatLoggingInfo` (
  `JobID` int(11) unsigned NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Value` blob NOT NULL,
  `HeartBeatTime` datetime NOT NULL,
  PRIMARY KEY (`JobID`,`Name`,`HeartBeatTime`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE HeartBeatLoggingInfo DISABLE KEYS;
INSERT INTO HeartBeatLoggingInfo (JobID,Name,Value,HeartBeatTime) SELECT JobID,Name,Value,HeartBeatTime FROM HeartBeatLoggingInfo_old; 
ALTER TABLE HeartBeatLoggingInfo ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE HeartBeatLoggingInfo_old;


-- Table InputData

RENAME TABLE InputData TO InputData_old;

CREATE TABLE `InputData` (
  `JobID` int(11) unsigned NOT NULL,
  `LFN` varchar(255) NOT NULL DEFAULT '',
  `Status` varchar(32) NOT NULL DEFAULT 'AprioriGood',
  PRIMARY KEY (`JobID`,`LFN`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE InputData DISABLE KEYS;
INSERT INTO InputData (JobID,LFN,Status) SELECT JobID,LFN,Status FROM InputData_old; 
ALTER TABLE InputData ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE InputData_old;


-- Table JobCommands

RENAME TABLE JobCommands TO JobCommands_old;

CREATE TABLE `JobCommands` (
  `JobID` int(11) unsigned NOT NULL,
  `Command` varchar(100) NOT NULL,
  `Arguments` varchar(100) NOT NULL,
  `Status` varchar(64) NOT NULL DEFAULT 'Received',
  `ReceptionTime` datetime NOT NULL,
  `ExecutionTime` datetime DEFAULT NULL,
  PRIMARY KEY (`JobID`,`Arguments`,`ReceptionTime`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE JobCommands DISABLE KEYS;
INSERT INTO JobCommands (JobID,Command,Arguments,Status,ReceptionTime,ExecutionTime) SELECT JobID,Command,Arguments,Status,ReceptionTime,ExecutionTime FROM JobCommands_old; 
ALTER TABLE JobCommands ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE JobCommands_old;


-- Table JobParameters

RENAME TABLE JobParameters TO JobParameters_old;

CREATE TABLE `JobParameters` (
  `JobID` int(11) unsigned NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Value` blob NOT NULL,
  PRIMARY KEY (`JobID`,`Name`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE JobParameters DISABLE KEYS;
INSERT INTO JobParameters (JobID,Name,Value) SELECT JobID,Name,Value FROM JobParameters_old; 
ALTER TABLE JobParameters ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE JobParameters_old;


-- Table OptimizerParameters

RENAME TABLE OptimizerParameters TO OptimizerParameters_old;

CREATE TABLE `OptimizerParameters` (
  `JobID` int(11) unsigned NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Value` mediumblob NOT NULL,
  PRIMARY KEY (`JobID`,`Name`),
  FOREIGN KEY (`JobID`) REFERENCES `Jobs` (`JobID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE OptimizerParameters DISABLE KEYS;
INSERT INTO OptimizerParameters (JobID,Name,Value) SELECT JobID,Name,Value FROM OptimizerParameters_old; 
ALTER TABLE OptimizerParameters ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE OptimizerParameters_old;


-- Table SiteMask

RENAME TABLE SiteMask TO SiteMask_old;

CREATE TABLE `SiteMask` (
  `Site` varchar(64) NOT NULL,
  `Status` varchar(64) NOT NULL,
  `LastUpdateTime` datetime NOT NULL,
  `Author` varchar(255) NOT NULL,
  `Comment` blob NOT NULL,
  PRIMARY KEY (`Site`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE SiteMask DISABLE KEYS;
INSERT INTO SiteMask (Site,Status,LastUpdateTime,Author,Comment) SELECT Site,Status,LastUpdateTime,Author,Comment FROM SiteMask_old; 
ALTER TABLE SiteMask ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE SiteMask_old;


-- Table SiteMaskLogging

RENAME TABLE SiteMaskLogging TO SiteMaskLogging_old;

CREATE TABLE `SiteMaskLogging` (
  `Site` varchar(64) NOT NULL,
  `Status` varchar(64) NOT NULL,
  `UpdateTime` datetime NOT NULL,
  `Author` varchar(255) NOT NULL,
  `Comment` blob NOT NULL,
  PRIMARY KEY (`Site`,`UpdateTime`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE SiteMaskLogging DISABLE KEYS;
INSERT INTO SiteMaskLogging (Site,Status,UpdateTime,Author,Comment) SELECT Site,Status,UpdateTime,Author,Comment FROM SiteMaskLogging_old; 
ALTER TABLE SiteMaskLogging ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE SiteMaskLogging_old;
