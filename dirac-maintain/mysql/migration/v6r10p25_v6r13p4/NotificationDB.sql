USE NotificationDB;


-- Table ntf_AlarmLog

RENAME TABLE ntf_AlarmLog TO ntf_AlarmLog_old;

CREATE TABLE `ntf_AlarmLog` (
  `Comment` blob,
  `Timestamp` datetime NOT NULL,
  `Modifications` varchar(255) DEFAULT NULL,
  `Author` varchar(64) NOT NULL,
  `AlarmId` int(10) unsigned NOT NULL,
  KEY `AlarmID` (`AlarmId`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ntf_AlarmLog DISABLE KEYS;
INSERT INTO ntf_AlarmLog (Comment,Timestamp,Modifications,Author,AlarmId) SELECT Comment,Timestamp,Modifications,Author,AlarmId FROM ntf_AlarmLog_old; 
ALTER TABLE ntf_AlarmLog ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ntf_AlarmLog_old;
