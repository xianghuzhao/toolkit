USE FileCatalogDB;


-- Table FC_DirectoryTree

RENAME TABLE FC_DirectoryTree TO FC_DirectoryTree_old;

CREATE TABLE `FC_DirectoryTree` (
  `DirID` int(11) NOT NULL AUTO_INCREMENT,
  `DirName` varchar(1024) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `Parent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`DirID`),
  KEY `Parent` (`Parent`),
  KEY `DirName` (`DirName`(767))
) ENGINE=InnoDB;

SET AUTOCOMMIT=0;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE FC_DirectoryTree DISABLE KEYS;
INSERT INTO FC_DirectoryTree (DirID,DirName,Parent) SELECT DirID,DirName,Parent FROM FC_DirectoryTree_old; 
ALTER TABLE FC_DirectoryTree ENABLE KEYS;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET AUTOCOMMIT=1;

DROP TABLE FC_DirectoryTree_old;
