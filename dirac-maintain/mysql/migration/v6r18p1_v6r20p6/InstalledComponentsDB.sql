USE InstalledComponentsDB;


ALTER TABLE `HostLogging` MODIFY COLUMN `DiskOccupancy` varchar(256) DEFAULT NULL;


ALTER TABLE `InstalledComponents` MODIFY COLUMN `Instance` varchar(64) NOT NULL;
