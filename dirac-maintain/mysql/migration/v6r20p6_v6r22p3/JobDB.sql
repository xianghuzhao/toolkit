USE JobDB;


ALTER TABLE `Jobs` MODIFY `Owner` varchar(64) NOT NULL DEFAULT 'Unknown';
