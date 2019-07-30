USE FTS3DB;


ALTER TABLE Operations ADD INDEX `ix_Operations_rmsOpID` (`rmsOpID`);

ALTER TABLE `Files` ADD COLUMN `ftsGUID` varchar(255) DEFAULT NULL AFTER `error`;
