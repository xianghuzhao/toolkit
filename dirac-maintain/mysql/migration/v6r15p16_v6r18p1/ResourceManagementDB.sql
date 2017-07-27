USE ResourceManagementDB;


-- Table VOBOXCache

DROP TABLE `VOBOXCache`;


-- Table ErrorReportBuffer

ALTER TABLE `ErrorReportBuffer` MODIFY COLUMN `ID` int(11) NOT NULL AUTO_INCREMENT;


-- Table PolicyResultHistory

ALTER TABLE `PolicyResultHistory` MODIFY COLUMN `ID` int(11) NOT NULL AUTO_INCREMENT;


-- Table PolicyResultLog

ALTER TABLE `PolicyResultLog` MODIFY COLUMN `ID` int(11) NOT NULL AUTO_INCREMENT;


-- Table SpaceTokenOccupancyCache

ALTER TABLE `SpaceTokenOccupancyCache` MODIFY COLUMN `Endpoint` varchar(128) NOT NULL;


-- Table AccountingCache

RENAME TABLE AccountingCache TO AccountingCache_old;

CREATE TABLE `AccountingCache` (
  `Name` varchar(64) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `PlotName` varchar(64) NOT NULL,
  `Result` text NOT NULL,
  `DateEffective` datetime NOT NULL,
  `PlotType` varchar(16) NOT NULL,
  PRIMARY KEY (`Name`,`PlotName`,`PlotType`)
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE AccountingCache DISABLE KEYS;
INSERT INTO AccountingCache (Name,LastCheckTime,PlotName,Result,DateEffective,PlotType) SELECT Name,LastCheckTime,PlotName,Result,DateEffective,PlotType FROM AccountingCache_old; 
ALTER TABLE AccountingCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE AccountingCache_old;


-- Table DowntimeCache

RENAME TABLE DowntimeCache TO DowntimeCache_old;

CREATE TABLE `DowntimeCache` (
  `StartDate` datetime NOT NULL,
  `DowntimeID` varchar(64) NOT NULL,
  `Link` varchar(255) NOT NULL,
  `EndDate` datetime NOT NULL,
  `Name` varchar(64) NOT NULL,
  `DateEffective` datetime NOT NULL,
  `Description` varchar(512) NOT NULL,
  `Severity` varchar(32) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `Element` varchar(32) NOT NULL,
  `GOCDBServiceType` varchar(32) NOT NULL,
  PRIMARY KEY (`DowntimeID`)
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE DowntimeCache DISABLE KEYS;
INSERT INTO DowntimeCache (StartDate,DowntimeID,Link,EndDate,Name,DateEffective,Description,Severity,LastCheckTime,Element,GOCDBServiceType) SELECT StartDate,DowntimeID,Link,EndDate,Name,DateEffective,Description,Severity,LastCheckTime,Element,GOCDBServiceType FROM DowntimeCache_old; 
ALTER TABLE DowntimeCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE DowntimeCache_old;


-- Table JobCache

RENAME TABLE JobCache TO JobCache_old;

CREATE TABLE `JobCache` (
  `Status` varchar(16) NOT NULL,
  `Efficiency` double NOT NULL DEFAULT '0',
  `MaskStatus` varchar(32) NOT NULL,
  `Site` varchar(64) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `Failed` int(11) NOT NULL DEFAULT '0',
  `Waiting` int(11) NOT NULL DEFAULT '0',
  `Stalled` int(11) NOT NULL DEFAULT '0',
  `Completed` int(11) NOT NULL DEFAULT '0',
  `Running` int(11) NOT NULL DEFAULT '0',
  `Done` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Site`)
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE JobCache DISABLE KEYS;
INSERT INTO JobCache (Status,Efficiency,MaskStatus,Site,LastCheckTime,Failed,Waiting,Stalled,Completed,Running,Done) SELECT Status,Efficiency,MaskStatus,Site,LastCheckTime,Failed,Waiting,Stalled,Completed,Running,Done FROM JobCache_old; 
ALTER TABLE JobCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE JobCache_old;


-- Table PolicyResult

RENAME TABLE PolicyResult TO PolicyResult_old;

CREATE TABLE `PolicyResult` (
  `Status` varchar(16) NOT NULL,
  `PolicyName` varchar(64) NOT NULL,
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `Name` varchar(64) NOT NULL,
  `DateEffective` datetime NOT NULL,
  `StatusType` varchar(16) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL,
  `Element` varchar(32) NOT NULL,
  PRIMARY KEY (`PolicyName`,`Name`,`StatusType`,`Element`)
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE PolicyResult DISABLE KEYS;
INSERT INTO PolicyResult (Status,PolicyName,Reason,Name,DateEffective,StatusType,LastCheckTime,Element) SELECT Status,PolicyName,Reason,Name,DateEffective,StatusType,LastCheckTime,Element FROM PolicyResult_old; 
ALTER TABLE PolicyResult ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE PolicyResult_old;


-- Table TransferCache

RENAME TABLE TransferCache TO TransferCache_old;

CREATE TABLE `TransferCache` (
  `SourceName` varchar(64) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `Metric` varchar(16) NOT NULL,
  `Value` double NOT NULL DEFAULT '0',
  `DestinationName` varchar(64) NOT NULL,
  PRIMARY KEY (`SourceName`,`Metric`,`DestinationName`)
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE TransferCache DISABLE KEYS;
INSERT INTO TransferCache (SourceName,LastCheckTime,Metric,Value,DestinationName) SELECT SourceName,LastCheckTime,Metric,Value,DestinationName FROM TransferCache_old; 
ALTER TABLE TransferCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE TransferCache_old;
