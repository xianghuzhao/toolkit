USE ResourceManagementDB;


DROP TABLE ErrorReportBuffer;
DROP TABLE PolicyResultHistory;
DROP TABLE PolicyResultLog;
DROP TABLE PolicyResultWithID;
DROP TABLE ResourceSAMStatus;
DROP TABLE ResourceSAMStatusLog;
DROP TABLE SAMResult;
DROP TABLE SAMResultLog;
DROP TABLE SiteSAMStatus;
DROP TABLE SiteSAMStatusLog;
DROP TABLE StorageCache;
DROP TABLE UserRegistryCache;
DROP TABLE WorkNodeCache;


-- Table AccountingCache

RENAME TABLE AccountingCache TO AccountingCache_old;

CREATE TABLE `AccountingCache` (
  `Name` varchar(64) NOT NULL,
  `PlotName` varchar(64) NOT NULL,
  `PlotType` varchar(16) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `Result` text NOT NULL,
  `DateEffective` datetime NOT NULL,
  PRIMARY KEY (`Name`,`PlotName`,`PlotType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE AccountingCache DISABLE KEYS;
INSERT INTO AccountingCache (Name,PlotName,PlotType,LastCheckTime,Result,DateEffective) SELECT Name,PlotName,PlotType,LastCheckTime,Result,DateEffective FROM AccountingCache_old; 
ALTER TABLE AccountingCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE AccountingCache_old;


-- Table DowntimeCache

RENAME TABLE DowntimeCache TO DowntimeCache_old;

CREATE TABLE `DowntimeCache` (
  `DowntimeID` varchar(64) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Element` varchar(32) NOT NULL,
  `GOCDBServiceType` varchar(32) DEFAULT NULL,
  `Severity` varchar(32) NOT NULL,
  `Description` varchar(512) NOT NULL,
  `Link` varchar(255) DEFAULT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `DateEffective` datetime NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`DowntimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE DowntimeCache DISABLE KEYS;
INSERT INTO DowntimeCache (DowntimeID,Name,Element,GOCDBServiceType,Severity,Description,Link,StartDate,EndDate,DateEffective,LastCheckTime) SELECT DowntimeID,Name,Element,GOCDBServiceType,Severity,Description,Link,StartDate,EndDate,DateEffective,LastCheckTime FROM DowntimeCache_old; 
ALTER TABLE DowntimeCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE DowntimeCache_old;


-- Table GGUSTicketsCache

RENAME TABLE GGUSTicketsCache TO GGUSTicketsCache_old;

CREATE TABLE `GGUSTicketsCache` (
  `GocSite` varchar(64) NOT NULL,
  `Tickets` varchar(1024) NOT NULL,
  `OpenTickets` int(11) NOT NULL DEFAULT '0',
  `Link` varchar(1024) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`GocSite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE GGUSTicketsCache DISABLE KEYS;
INSERT INTO GGUSTicketsCache (GocSite,Tickets,OpenTickets,Link,LastCheckTime) SELECT GocSite,Tickets,OpenTickets,Link,LastCheckTime FROM GGUSTicketsCache_old; 
ALTER TABLE GGUSTicketsCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE GGUSTicketsCache_old;


-- Table JobCache

RENAME TABLE JobCache TO JobCache_old;

CREATE TABLE `JobCache` (
  `Site` varchar(64) NOT NULL,
  `Status` varchar(16) NOT NULL,
  `Efficiency` float NOT NULL DEFAULT '0',
  `MaskStatus` varchar(32) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`Site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE JobCache DISABLE KEYS;
INSERT INTO JobCache (Site,Status,Efficiency,MaskStatus,LastCheckTime) SELECT Site,Status,Efficiency,MaskStatus,LastCheckTime FROM JobCache_old; 
ALTER TABLE JobCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE JobCache_old;


-- Table PilotCache

RENAME TABLE PilotCache TO PilotCache_old;

CREATE TABLE `PilotCache` (
  `Site` varchar(64) NOT NULL,
  `CE` varchar(64) NOT NULL,
  `Status` varchar(16) NOT NULL,
  `PilotJobEff` float NOT NULL DEFAULT '0',
  `PilotsPerJob` float NOT NULL DEFAULT '0',
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`Site`,`CE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE PilotCache DISABLE KEYS;
INSERT INTO PilotCache (XXXID,XXXStatus) SELECT XXXID,XXXStatus FROM PilotCache_old; 
ALTER TABLE PilotCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE PilotCache_old;


-- Table PolicyResult

RENAME TABLE PolicyResult TO PolicyResult_old;

CREATE TABLE `PolicyResult` (
  `PolicyName` varchar(64) NOT NULL,
  `StatusType` varchar(16) NOT NULL DEFAULT '',
  `Element` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Status` varchar(16) NOT NULL,
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`PolicyName`,`StatusType`,`Element`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE PolicyResult DISABLE KEYS;
INSERT INTO PolicyResult (PolicyName,StatusType,Element,Name,Status,Reason,DateEffective,LastCheckTime) SELECT PolicyName,StatusType,Element,Name,Status,Reason,DateEffective,LastCheckTime FROM PolicyResult_old; 
ALTER TABLE PolicyResult ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE PolicyResult_old;


-- Table SpaceTokenOccupancyCache

RENAME TABLE SpaceTokenOccupancyCache TO SpaceTokenOccupancyCache_old;

CREATE TABLE `SpaceTokenOccupancyCache` (
  `Endpoint` varchar(128) NOT NULL,
  `Token` varchar(64) NOT NULL,
  `Guaranteed` float NOT NULL DEFAULT '0',
  `Free` float NOT NULL DEFAULT '0',
  `Total` float NOT NULL DEFAULT '0',
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`Endpoint`,`Token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE SpaceTokenOccupancyCache DISABLE KEYS;
INSERT INTO SpaceTokenOccupancyCache (Endpoint,Token,Guaranteed,Free,Total,LastCheckTime) SELECT Endpoint,Token,Guaranteed,Free,Total,LastCheckTime FROM SpaceTokenOccupancyCache_old; 
ALTER TABLE SpaceTokenOccupancyCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE SpaceTokenOccupancyCache_old;


-- Table TransferCache

RENAME TABLE TransferCache TO TransferCache_old;

CREATE TABLE `TransferCache` (
  `SourceName` varchar(64) NOT NULL,
  `DestinationName` varchar(64) NOT NULL,
  `Metric` varchar(16) NOT NULL,
  `Value` float NOT NULL DEFAULT '0',
  `LastCheckTime` datetime NOT NULL,
  PRIMARY KEY (`SourceName`,`DestinationName`,`Metric`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE TransferCache DISABLE KEYS;
INSERT INTO TransferCache (SourceName,DestinationName,Metric,Value,LastCheckTime) SELECT SourceName,DestinationName,Metric,Value,LastCheckTime FROM TransferCache_old; 
ALTER TABLE TransferCache ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE TransferCache_old;
