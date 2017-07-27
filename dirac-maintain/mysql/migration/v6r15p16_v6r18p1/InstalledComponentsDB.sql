USE InstalledComponentsDB;


-- Table HostLogging

ALTER TABLE `HostLogging` MODIFY COLUMN `CertificateDN` varchar(128) DEFAULT NULL;
ALTER TABLE `HostLogging` MODIFY COLUMN `CertificateIssuer` varchar(128) DEFAULT NULL;
