USE ResourceStatusDB;


-- Table ComponentHistory

ALTER TABLE `ComponentHistory` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `ComponentHistory` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table ComponentLog

ALTER TABLE `ComponentLog` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `ComponentLog` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table ComponentStatus

ALTER TABLE `ComponentStatus` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';


-- Table NodeHistory

ALTER TABLE `NodeHistory` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `NodeHistory` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table NodeLog

ALTER TABLE `NodeLog` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `NodeLog` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table NodeStatus

ALTER TABLE `NodeStatus` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';


-- Table ResourceHistory

ALTER TABLE `ResourceHistory` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `ResourceHistory` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table ResourceLog

ALTER TABLE `ResourceLog` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `ResourceLog` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table ResourceStatus

ALTER TABLE `ResourceStatus` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';


-- Table SiteHistory

ALTER TABLE `SiteHistory` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `SiteHistory` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table SiteLog

ALTER TABLE `SiteLog` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
ALTER TABLE `SiteLog` MODIFY COLUMN `ID` bigint(20) NOT NULL AUTO_INCREMENT;


-- Table SiteStatus

ALTER TABLE `SiteStatus` MODIFY COLUMN `TokenExpiration` varchar(255) NOT NULL DEFAULT '9999-12-31 23:59:59';
