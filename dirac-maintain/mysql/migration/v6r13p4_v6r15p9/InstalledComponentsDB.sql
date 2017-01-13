USE InstalledComponentsDB;


-- Table InstalledComponents

ALTER TABLE `InstalledComponents` ADD COLUMN `UnInstalledBy` varchar(32) DEFAULT NULL AFTER `UnInstallationTime`;
ALTER TABLE `InstalledComponents` ADD COLUMN `InstalledBy` varchar(32) DEFAULT NULL AFTER `UnInstallationTime`;
