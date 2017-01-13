USE UserProfileDB;


-- Table up_ProfilesData

RENAME TABLE up_ProfilesData TO up_ProfilesData_old;

CREATE TABLE `up_ProfilesData` (
  `Profile` varchar(255) NOT NULL,
  `ReadAccess` varchar(10) DEFAULT 'USER',
  `PublishAccess` varchar(10) DEFAULT 'USER',
  `Data` blob,
  `VarName` varchar(255) NOT NULL,
  `VOId` int(11) DEFAULT NULL,
  `UserId` int(11) NOT NULL DEFAULT '0',
  `GroupId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserId`,`GroupId`,`Profile`,`VarName`),
  KEY `UserKey` (`UserId`),
  KEY `ProfileKey` (`UserId`,`GroupId`,`Profile`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE up_ProfilesData DISABLE KEYS;
INSERT INTO up_ProfilesData (Profile,ReadAccess,Data,VarName,VOId,UserId,GroupId) SELECT Profile,ReadAccess,Data,VarName,VOId,UserId,GroupId FROM up_ProfilesData_old; 
ALTER TABLE up_ProfilesData ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE up_ProfilesData_old;
