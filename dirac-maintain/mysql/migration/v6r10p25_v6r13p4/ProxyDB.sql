USE ProxyDB;


-- Table ProxyDB_Log

RENAME TABLE ProxyDB_Log TO ProxyDB_Log_old;

CREATE TABLE `ProxyDB_Log` (
  `TargetDN` varchar(255) NOT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `IssuerDN` varchar(255) NOT NULL,
  `IssuerGroup` varchar(255) NOT NULL,
  `Action` varchar(128) NOT NULL,
  `TargetGroup` varchar(255) NOT NULL,
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `Timestamp` (`Timestamp`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ProxyDB_Log DISABLE KEYS;
INSERT INTO ProxyDB_Log (TargetDN,Timestamp,IssuerDN,IssuerGroup,Action,TargetGroup) SELECT TargetDN,Timestamp,IssuerDN,IssuerGroup,Action,TargetGroup FROM ProxyDB_Log_old; 
ALTER TABLE ProxyDB_Log ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ProxyDB_Log_old;


-- Table ProxyDB_Proxies

RENAME TABLE ProxyDB_Proxies TO ProxyDB_Proxies_old;

CREATE TABLE `ProxyDB_Proxies` (
  `UserName` varchar(64) NOT NULL,
  `UserDN` varchar(255) NOT NULL,
  `Pem` blob,
  `PersistentFlag` enum('True','False') NOT NULL DEFAULT 'True',
  `UserGroup` varchar(255) NOT NULL,
  `ExpirationTime` datetime DEFAULT NULL,
  PRIMARY KEY (`UserDN`,`UserGroup`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ProxyDB_Proxies DISABLE KEYS;
INSERT INTO ProxyDB_Proxies (UserName,UserDN,Pem,PersistentFlag,UserGroup,ExpirationTime) SELECT UserName,UserDN,Pem,PersistentFlag,UserGroup,ExpirationTime FROM ProxyDB_Proxies_old; 
ALTER TABLE ProxyDB_Proxies ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ProxyDB_Proxies_old;


-- Table ProxyDB_VOMSProxies

RENAME TABLE ProxyDB_VOMSProxies TO ProxyDB_VOMSProxies_old;

CREATE TABLE `ProxyDB_VOMSProxies` (
  `UserName` varchar(64) NOT NULL,
  `VOMSAttr` varchar(255) NOT NULL,
  `UserDN` varchar(255) NOT NULL,
  `Pem` blob,
  `UserGroup` varchar(255) NOT NULL,
  `ExpirationTime` datetime DEFAULT NULL,
  PRIMARY KEY (`UserDN`,`UserGroup`,`VOMSAttr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET UNIQUE_CHECKS=0;
ALTER TABLE ProxyDB_VOMSProxies DISABLE KEYS;
INSERT INTO ProxyDB_VOMSProxies (UserName,VOMSAttr,UserDN,Pem,UserGroup,ExpirationTime) SELECT UserName,VOMSAttr,UserDN,Pem,UserGroup,ExpirationTime FROM ProxyDB_VOMSProxies_old; 
ALTER TABLE ProxyDB_VOMSProxies ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ProxyDB_VOMSProxies_old;
