USE FileCatalogDB;

-- Drop Tables

-- NOT sure whether to delete this table because it is used by DIRAC/DataManagementSystem/DB/FileCatalogComponents/DirectoryFlatTree.py
DROP TABLE IF EXISTS DirectoryInfo;

-- This table should not be used but it still exsits in DIRAC/DataManagementSystem/DB/FileCatalogComponents/DirectoryMetadata.py
DROP TABLE IF EXISTS FC_MetaSets;

-- Do NOT delete this table because it is a normal backup table
-- DROP TABLE FC_DirectoryUsage_backup;


-- Change Key Name

ALTER TABLE FC_MetaDatasetFiles DROP KEY `DatasetID`, ADD UNIQUE KEY `DatasetID_FileID` (`DatasetID`,`FileID`);


-- Table FC_DirectoryLevelTree

RENAME TABLE FC_DirectoryLevelTree TO FC_DirectoryLevelTree_old;

CREATE TABLE `FC_DirectoryLevelTree` (
  `DirID` int(11) NOT NULL AUTO_INCREMENT,
  `DirName` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `Parent` int(11) NOT NULL DEFAULT '0',
  `Level` int(11) NOT NULL,
  `LPATH1` int(11) NOT NULL DEFAULT '0',
  `LPATH2` int(11) NOT NULL DEFAULT '0',
  `LPATH3` int(11) NOT NULL DEFAULT '0',
  `LPATH4` int(11) NOT NULL DEFAULT '0',
  `LPATH5` int(11) NOT NULL DEFAULT '0',
  `LPATH6` int(11) NOT NULL DEFAULT '0',
  `LPATH7` int(11) NOT NULL DEFAULT '0',
  `LPATH8` int(11) NOT NULL DEFAULT '0',
  `LPATH9` int(11) NOT NULL DEFAULT '0',
  `LPATH10` int(11) NOT NULL DEFAULT '0',
  `LPATH11` int(11) NOT NULL DEFAULT '0',
  `LPATH12` int(11) NOT NULL DEFAULT '0',
  `LPATH13` int(11) NOT NULL DEFAULT '0',
  `LPATH14` int(11) NOT NULL DEFAULT '0',
  `LPATH15` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`DirID`),
  UNIQUE KEY `DirName` (`DirName`),
  KEY `Level` (`Level`),
  KEY `Parent` (`Parent`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE FC_DirectoryLevelTree DISABLE KEYS;
INSERT INTO FC_DirectoryLevelTree (DirID,DirName,Parent,Level,LPATH1,LPATH2,LPATH3,LPATH4,LPATH5,LPATH6,LPATH7,LPATH8,LPATH9,LPATH10,LPATH11,LPATH12,LPATH13,LPATH14,LPATH15) SELECT DirID,DirName,Parent,Level,LPATH1,LPATH2,LPATH3,LPATH4,LPATH5,LPATH6,LPATH7,LPATH8,LPATH9,LPATH10,LPATH11,LPATH12,LPATH13,LPATH14,LPATH15 FROM FC_DirectoryLevelTree_old; 
ALTER TABLE FC_DirectoryLevelTree ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE FC_DirectoryLevelTree_old;


-- Table FC_MetaDatasets

RENAME TABLE FC_MetaDatasets TO FC_MetaDatasets_old;

CREATE TABLE `FC_MetaDatasets` (
  `DatasetName` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `DatasetHash` char(36) NOT NULL,
  `TotalSize` bigint(20) unsigned NOT NULL,
  `NumberOfFiles` int(11) NOT NULL,
  `GID` tinyint(3) unsigned NOT NULL,
  `Mode` smallint(5) unsigned NOT NULL DEFAULT '509',
  `DirID` int(11) NOT NULL DEFAULT '0',
  `DatasetID` int(11) NOT NULL AUTO_INCREMENT,
  `Status` smallint(5) unsigned NOT NULL,
  `UID` smallint(5) unsigned NOT NULL,
  `MetaQuery` varchar(512) DEFAULT NULL,
  `ModificationDate` datetime DEFAULT NULL,
  `CreationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DatasetID`),
  UNIQUE KEY `DatasetName_DirID` (`DatasetName`,`DirID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE FC_MetaDatasets DISABLE KEYS;
INSERT INTO FC_MetaDatasets (DatasetName,DatasetHash,TotalSize,NumberOfFiles,GID,Mode,DirID,DatasetID,Status,UID,MetaQuery,ModificationDate,CreationDate) SELECT DatasetName,DatasetHash,TotalSize,NumberOfFiles,GID,Mode,DirID,DatasetID,Status,UID,MetaQuery,ModificationDate,CreationDate FROM FC_MetaDatasets_old; 
ALTER TABLE FC_MetaDatasets ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE FC_MetaDatasets_old;


-- Table FC_ReplicaInfo

RENAME TABLE FC_ReplicaInfo TO FC_ReplicaInfo_old;

CREATE TABLE `FC_ReplicaInfo` (
  `RepID` int(11) NOT NULL AUTO_INCREMENT,
  `RepType` enum('Master','Replica') NOT NULL DEFAULT 'Master',
  `CreationDate` datetime DEFAULT NULL,
  `ModificationDate` datetime DEFAULT NULL,
  `PFN` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`RepID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE FC_ReplicaInfo DISABLE KEYS;
INSERT INTO FC_ReplicaInfo (RepID,RepType,CreationDate,ModificationDate,PFN) SELECT RepID,RepType,CreationDate,ModificationDate,PFN FROM FC_ReplicaInfo_old; 
ALTER TABLE FC_ReplicaInfo ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE FC_ReplicaInfo_old;


-- Table FC_Replicas

RENAME TABLE FC_Replicas TO FC_Replicas_old;

CREATE TABLE `FC_Replicas` (
  `RepID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL,
  `SEID` int(11) NOT NULL,
  `Status` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`RepID`),
  UNIQUE KEY `FileID_2` (`FileID`,`SEID`),
  KEY `FileID` (`FileID`),
  KEY `SEID` (`SEID`),
  KEY `Status` (`Status`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE FC_Replicas DISABLE KEYS;
INSERT INTO FC_Replicas (RepID,FileID,SEID,Status) SELECT RepID,FileID,SEID,Status FROM FC_Replicas_old; 
ALTER TABLE FC_Replicas ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE FC_Replicas_old;
