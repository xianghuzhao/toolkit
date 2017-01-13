USE PilotAgentsDB;


-- Table JobToPilotMapping

RENAME TABLE JobToPilotMapping TO JobToPilotMapping_old;

CREATE TABLE `JobToPilotMapping` (
  `PilotID` int(11) unsigned NOT NULL,
  `JobID` int(11) unsigned NOT NULL,
  `StartTime` datetime NOT NULL,
  KEY `JobID` (`JobID`),
  KEY `PilotID` (`PilotID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE JobToPilotMapping DISABLE KEYS;
INSERT INTO JobToPilotMapping (PilotID,JobID,StartTime) SELECT PilotID,JobID,StartTime FROM JobToPilotMapping_old; 
ALTER TABLE JobToPilotMapping ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE JobToPilotMapping_old;


-- Table PilotAgents

RENAME TABLE PilotAgents TO PilotAgents_old;

CREATE TABLE `PilotAgents` (
  `PilotID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `InitialJobID` int(11) unsigned NOT NULL DEFAULT '0',
  `CurrentJobID` int(11) unsigned NOT NULL DEFAULT '0',
  `TaskQueueID` int(11) unsigned NOT NULL DEFAULT '0',
  `PilotJobReference` varchar(255) NOT NULL DEFAULT 'Unknown',
  `PilotStamp` varchar(32) NOT NULL DEFAULT '',
  `DestinationSite` varchar(128) NOT NULL DEFAULT 'NotAssigned',
  `Queue` varchar(128) NOT NULL DEFAULT 'Unknown',
  `GridSite` varchar(128) NOT NULL DEFAULT 'Unknown',
  `Broker` varchar(128) NOT NULL DEFAULT 'Unknown',
  `OwnerDN` varchar(255) NOT NULL,
  `OwnerGroup` varchar(128) NOT NULL,
  `GridType` varchar(32) NOT NULL DEFAULT 'LCG',
  `GridRequirements` blob,
  `BenchMark` double NOT NULL DEFAULT '0',
  `SubmissionTime` datetime DEFAULT NULL,
  `LastUpdateTime` datetime DEFAULT NULL,
  `Status` varchar(32) NOT NULL DEFAULT 'Unknown',
  `StatusReason` varchar(255) NOT NULL DEFAULT 'Unknown',
  `ParentID` int(11) unsigned NOT NULL DEFAULT '0',
  `OutputReady` enum('True','False') NOT NULL DEFAULT 'False',
  `AccountingSent` enum('True','False') NOT NULL DEFAULT 'False',
  PRIMARY KEY (`PilotID`),
  KEY `PilotJobReference` (`PilotJobReference`),
  KEY `Status` (`Status`),
  KEY `Statuskey` (`GridSite`,`DestinationSite`,`Status`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE PilotAgents DISABLE KEYS;
INSERT INTO PilotAgents (PilotID,InitialJobID,CurrentJobID,TaskQueueID,PilotJobReference,PilotStamp,DestinationSite,Queue,GridSite,Broker,OwnerDN,OwnerGroup,GridType,BenchMark,SubmissionTime,LastUpdateTime,Status,StatusReason,ParentID,OutputReady,AccountingSent) SELECT PilotID,InitialJobID,CurrentJobID,TaskQueueID,PilotJobReference,PilotStamp,DestinationSite,Queue,GridSite,Broker,OwnerDN,OwnerGroup,GridType,BenchMark,SubmissionTime,LastUpdateTime,Status,StatusReason,ParentID,OutputReady,AccountingSent FROM PilotAgents_old; 
ALTER TABLE PilotAgents ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE PilotAgents_old;


-- Table PilotOutput

RENAME TABLE PilotOutput TO PilotOutput_old;

CREATE TABLE `PilotOutput` (
  `PilotID` int(11) unsigned NOT NULL,
  `StdOutput` mediumblob,
  `StdError` mediumblob,
  PRIMARY KEY (`PilotID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE PilotOutput DISABLE KEYS;
INSERT INTO PilotOutput (PilotID,StdOutput,StdError) SELECT PilotID,StdOutput,StdError FROM PilotOutput_old; 
ALTER TABLE PilotOutput ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE PilotOutput_old;


-- Table PilotRequirements

RENAME TABLE PilotRequirements TO PilotRequirements_old;

CREATE TABLE `PilotRequirements` (
  `PilotID` int(11) unsigned NOT NULL,
  `Requirements` blob,
  PRIMARY KEY (`PilotID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE PilotRequirements DISABLE KEYS;
INSERT INTO PilotRequirements (PilotID,Requirements) SELECT PilotID,Requirements FROM PilotRequirements_old; 
ALTER TABLE PilotRequirements ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE PilotRequirements_old;
