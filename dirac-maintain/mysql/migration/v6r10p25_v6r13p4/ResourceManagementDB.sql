USE ResourceManagementDB;


-- Table DowntimeCache

RENAME TABLE DowntimeCache TO DowntimeCache_old;

CREATE TABLE `DowntimeCache` (
  `Name` varchar(64) NOT NULL,
  `LastCheckTime` datetime NOT NULL,
  `Element` varchar(32) NOT NULL,
  `DowntimeID` varchar(64) NOT NULL,
  `GOCDBServiceType` varchar(32) NOT NULL,
  `Severity` varchar(32) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `Description` varchar(512) NOT NULL,
  `DateEffective` datetime NOT NULL,
  `Link` varchar(255) NOT NULL,
  PRIMARY KEY (`DowntimeID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE DowntimeCache DISABLE KEYS;
INSERT INTO DowntimeCache (Name,LastCheckTime,Element,DowntimeID,Severity,StartDate,EndDate,Description,DateEffective,Link) SELECT Name,LastCheckTime,Element,DowntimeID,Severity,StartDate,EndDate,Description,DateEffective,Link FROM DowntimeCache_old; 
ALTER TABLE DowntimeCache ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE DowntimeCache_old;
