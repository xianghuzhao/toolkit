USE TaskQueueDB;

-- Drop Tables

DROP TABLE IF EXISTS tq_TQToLHCbPlatforms;


-- Create New Tables

CREATE TABLE `tq_TQToTags` (
  `TQId` int(10) unsigned NOT NULL,
  `Value` varchar(64) NOT NULL,
  KEY `TaskIndex` (`TQId`),
  KEY `TagsIndex` (`Value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table tq_Jobs

RENAME TABLE tq_Jobs TO tq_Jobs_old;

CREATE TABLE `tq_Jobs` (
  `Priority` int(10) unsigned NOT NULL,
  `RealPriority` float NOT NULL,
  `TQId` int(10) unsigned NOT NULL,
  `JobId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`JobId`),
  KEY `TaskIndex` (`TQId`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE tq_Jobs DISABLE KEYS;
INSERT INTO tq_Jobs (Priority,RealPriority,TQId,JobId) SELECT Priority,RealPriority,TQId,JobId FROM tq_Jobs_old; 
ALTER TABLE tq_Jobs ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE tq_Jobs_old;
