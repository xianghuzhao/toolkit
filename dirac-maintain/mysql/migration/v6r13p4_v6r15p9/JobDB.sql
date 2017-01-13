USE JobDB;


-- Table Jobs

ALTER TABLE `Jobs` MODIFY `JobGroup` varchar(128) NOT NULL DEFAULT '00000000';
