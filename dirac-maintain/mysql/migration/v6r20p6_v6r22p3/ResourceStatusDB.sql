USE ResourceStatusDB;


-- Table NodeHistory

RENAME TABLE NodeHistory TO NodeHistory_old;

CREATE TABLE `NodeHistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE NodeHistory DISABLE KEYS;
INSERT INTO NodeHistory (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM NodeHistory_old; 
ALTER TABLE NodeHistory ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE NodeHistory_old;


-- Table NodeLog

RENAME TABLE NodeLog TO NodeLog_old;

CREATE TABLE `NodeLog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE NodeLog DISABLE KEYS;
INSERT INTO NodeLog (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM NodeLog_old; 
ALTER TABLE NodeLog ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE NodeLog_old;


-- Table NodeStatus

RENAME TABLE NodeStatus TO NodeStatus_old;

CREATE TABLE `NodeStatus` (
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`Name`,`StatusType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE NodeStatus DISABLE KEYS;
INSERT INTO NodeStatus (Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM NodeStatus_old; 
ALTER TABLE NodeStatus ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE NodeStatus_old;


-- Table ResourceHistory

RENAME TABLE ResourceHistory TO ResourceHistory_old;

CREATE TABLE `ResourceHistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE ResourceHistory DISABLE KEYS;
INSERT INTO ResourceHistory (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM ResourceHistory_old; 
ALTER TABLE ResourceHistory ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE ResourceHistory_old;


-- Table ResourceLog

RENAME TABLE ResourceLog TO ResourceLog_old;

CREATE TABLE `ResourceLog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE ResourceLog DISABLE KEYS;
INSERT INTO ResourceLog (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM ResourceLog_old; 
ALTER TABLE ResourceLog ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE ResourceLog_old;


-- Table ResourceStatus

RENAME TABLE ResourceStatus TO ResourceStatus_old;

CREATE TABLE `ResourceStatus` (
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`Name`,`StatusType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE ResourceStatus DISABLE KEYS;
INSERT INTO ResourceStatus (Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM ResourceStatus_old; 
ALTER TABLE ResourceStatus ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE ResourceStatus_old;


-- Table SiteHistory

RENAME TABLE SiteHistory TO SiteHistory_old;

CREATE TABLE `SiteHistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE SiteHistory DISABLE KEYS;
INSERT INTO SiteHistory (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM SiteHistory_old; 
ALTER TABLE SiteHistory ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE SiteHistory_old;


-- Table SiteLog

RENAME TABLE SiteLog TO SiteLog_old;

CREATE TABLE `SiteLog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE SiteLog DISABLE KEYS;
INSERT INTO SiteLog (ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT ID,Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM SiteLog_old; 
ALTER TABLE SiteLog ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE SiteLog_old;


-- Table SiteStatus

RENAME TABLE SiteStatus TO SiteStatus_old;

CREATE TABLE `SiteStatus` (
  `Name` varchar(64) NOT NULL,
  `StatusType` varchar(128) NOT NULL DEFAULT 'all',
  `Status` varchar(8) NOT NULL DEFAULT '',
  `Reason` varchar(512) NOT NULL DEFAULT 'Unspecified',
  `DateEffective` datetime NOT NULL,
  `TokenExpiration` datetime NOT NULL DEFAULT '9999-12-31 23:59:59',
  `ElementType` varchar(32) NOT NULL DEFAULT '',
  `LastCheckTime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `TokenOwner` varchar(16) NOT NULL DEFAULT 'rs_svc',
  PRIMARY KEY (`Name`,`StatusType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE SiteStatus DISABLE KEYS;
INSERT INTO SiteStatus (Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner) SELECT Name,StatusType,Status,Reason,DateEffective,TokenExpiration,ElementType,LastCheckTime,TokenOwner FROM SiteStatus_old; 
ALTER TABLE SiteStatus ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE SiteStatus_old;

