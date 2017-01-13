USE AccountingDB;


-- Table ac_bucket_CAS_Production_DataOperation

RENAME TABLE ac_bucket_CAS_Production_DataOperation TO ac_bucket_CAS_Production_DataOperation_old;

CREATE TABLE `ac_bucket_CAS_Production_DataOperation` (
  `Protocol` int(11) NOT NULL,
  `TransferOK` decimal(30,10) NOT NULL,
  `RegistrationTime` decimal(30,10) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `RegistrationTotal` decimal(30,10) NOT NULL,
  `Destination` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `Source` int(11) NOT NULL,
  `TransferTime` decimal(30,10) NOT NULL,
  `User` int(11) NOT NULL,
  `OperationType` int(11) NOT NULL,
  `ExecutionSite` int(11) NOT NULL,
  `RegistrationOK` decimal(30,10) NOT NULL,
  `TransferTotal` decimal(30,10) NOT NULL,
  `TransferSize` decimal(30,10) NOT NULL,
  `FinalStatus` int(11) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`OperationType`,`User`,`ExecutionSite`,`Source`,`Destination`,`Protocol`,`FinalStatus`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_DataOperation DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_DataOperation (Protocol,TransferOK,RegistrationTime,bucketLength,RegistrationTotal,Destination,startTime,entriesInBucket,Source,TransferTime,User,OperationType,ExecutionSite,RegistrationOK,TransferTotal,TransferSize,FinalStatus) SELECT Protocol,TransferOK,RegistrationTime,bucketLength,RegistrationTotal,Destination,startTime,entriesInBucket,Source,TransferTime,User,OperationType,ExecutionSite,RegistrationOK,TransferTotal,TransferSize,FinalStatus FROM ac_bucket_CAS_Production_DataOperation_old; 
ALTER TABLE ac_bucket_CAS_Production_DataOperation ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_DataOperation_old;


-- Table ac_bucket_CAS_Production_DataTransfer

RENAME TABLE ac_bucket_CAS_Production_DataTransfer TO ac_bucket_CAS_Production_DataTransfer_old;

CREATE TABLE `ac_bucket_CAS_Production_DataTransfer` (
  `Protocol` int(11) NOT NULL,
  `TransferOK` decimal(30,10) NOT NULL,
  `Destination` int(11) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `Source` int(11) NOT NULL,
  `TransferTime` decimal(30,10) NOT NULL,
  `User` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `TransferSize` decimal(30,10) NOT NULL,
  `TransferTotal` decimal(30,10) NOT NULL,
  `FinalStatus` int(11) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`User`,`Source`,`Destination`,`Protocol`,`FinalStatus`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_DataTransfer DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_DataTransfer (Protocol,TransferOK,Destination,bucketLength,entriesInBucket,Source,TransferTime,User,startTime,TransferSize,TransferTotal,FinalStatus) SELECT Protocol,TransferOK,Destination,bucketLength,entriesInBucket,Source,TransferTime,User,startTime,TransferSize,TransferTotal,FinalStatus FROM ac_bucket_CAS_Production_DataTransfer_old; 
ALTER TABLE ac_bucket_CAS_Production_DataTransfer ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_DataTransfer_old;


-- Table ac_bucket_CAS_Production_Job

RENAME TABLE ac_bucket_CAS_Production_Job TO ac_bucket_CAS_Production_Job_old;

CREATE TABLE `ac_bucket_CAS_Production_Job` (
  `JobGroup` int(11) NOT NULL,
  `DiskSpace` decimal(30,10) NOT NULL,
  `InputDataSize` decimal(30,10) NOT NULL,
  `FinalMajorStatus` int(11) NOT NULL,
  `OutputDataSize` decimal(30,10) NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `InputSandBoxSize` decimal(30,10) NOT NULL,
  `OutputDataFiles` decimal(30,10) NOT NULL,
  `NormCPUTime` decimal(30,10) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `User` int(11) NOT NULL,
  `JobType` int(11) NOT NULL,
  `JobClass` int(11) NOT NULL,
  `ProcessingType` int(11) NOT NULL,
  `ExecTime` decimal(30,10) NOT NULL,
  `CPUTime` decimal(30,10) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `UserGroup` int(11) NOT NULL,
  `FinalMinorStatus` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `ProcessedEvents` decimal(30,10) NOT NULL,
  `OutputSandBoxSize` decimal(30,10) NOT NULL,
  `InputDataFiles` decimal(30,10) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`User`,`UserGroup`,`JobGroup`,`JobType`,`JobClass`,`ProcessingType`,`Site`,`FinalMajorStatus`,`FinalMinorStatus`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_Job DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_Job (JobGroup,DiskSpace,InputDataSize,FinalMajorStatus,OutputDataSize,entriesInBucket,InputSandBoxSize,OutputDataFiles,NormCPUTime,bucketLength,User,JobType,JobClass,ProcessingType,ExecTime,CPUTime,startTime,UserGroup,FinalMinorStatus,Site,ProcessedEvents,OutputSandBoxSize,InputDataFiles) SELECT JobGroup,DiskSpace,InputDataSize,FinalMajorStatus,OutputDataSize,entriesInBucket,InputSandBoxSize,OutputDataFiles,NormCPUTime,bucketLength,User,JobType,JobClass,ProcessingType,ExecTime,CPUTime,startTime,UserGroup,FinalMinorStatus,Site,ProcessedEvents,OutputSandBoxSize,InputDataFiles FROM ac_bucket_CAS_Production_Job_old; 
ALTER TABLE ac_bucket_CAS_Production_Job ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_Job_old;


-- Table ac_bucket_CAS_Production_Pilot

RENAME TABLE ac_bucket_CAS_Production_Pilot TO ac_bucket_CAS_Production_Pilot_old;

CREATE TABLE `ac_bucket_CAS_Production_Pilot` (
  `Jobs` decimal(30,10) NOT NULL,
  `Site` int(11) NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `GridResourceBroker` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `UserGroup` int(11) NOT NULL,
  `GridCE` int(11) NOT NULL,
  `GridStatus` int(11) NOT NULL,
  `GridMiddleware` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`User`,`UserGroup`,`Site`,`GridCE`,`GridMiddleware`,`GridResourceBroker`,`GridStatus`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_Pilot DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_Pilot (Jobs,Site,entriesInBucket,bucketLength,GridResourceBroker,startTime,UserGroup,GridCE,GridStatus,GridMiddleware,User) SELECT Jobs,Site,entriesInBucket,bucketLength,GridResourceBroker,startTime,UserGroup,GridCE,GridStatus,GridMiddleware,User FROM ac_bucket_CAS_Production_Pilot_old; 
ALTER TABLE ac_bucket_CAS_Production_Pilot ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_Pilot_old;


-- Table ac_bucket_CAS_Production_SRMSpaceTokenDeployment

RENAME TABLE ac_bucket_CAS_Production_SRMSpaceTokenDeployment TO ac_bucket_CAS_Production_SRMSpaceTokenDeployment_old;

CREATE TABLE `ac_bucket_CAS_Production_SRMSpaceTokenDeployment` (
  `UsedNearline` decimal(30,10) NOT NULL,
  `SpaceTokenDesc` int(11) NOT NULL,
  `Hostname` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `UsedSpace` decimal(30,10) NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `AvailableSpace` decimal(30,10) NOT NULL,
  `UsedOnline` decimal(30,10) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `TotalOnline` decimal(30,10) NOT NULL,
  `ReservedNearline` decimal(30,10) NOT NULL,
  `FreeNearline` decimal(30,10) NOT NULL,
  `FreeOnline` decimal(30,10) NOT NULL,
  `TotalNearline` decimal(30,10) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`Site`,`Hostname`,`SpaceTokenDesc`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_SRMSpaceTokenDeployment DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_SRMSpaceTokenDeployment (UsedNearline,SpaceTokenDesc,Hostname,Site,UsedSpace,entriesInBucket,bucketLength,AvailableSpace,UsedOnline,startTime,TotalOnline,ReservedNearline,FreeNearline,FreeOnline,TotalNearline) SELECT UsedNearline,SpaceTokenDesc,Hostname,Site,UsedSpace,entriesInBucket,bucketLength,AvailableSpace,UsedOnline,startTime,TotalOnline,ReservedNearline,FreeNearline,FreeOnline,TotalNearline FROM ac_bucket_CAS_Production_SRMSpaceTokenDeployment_old; 
ALTER TABLE ac_bucket_CAS_Production_SRMSpaceTokenDeployment ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_SRMSpaceTokenDeployment_old;


-- Table ac_bucket_CAS_Production_WMSHistory

RENAME TABLE ac_bucket_CAS_Production_WMSHistory TO ac_bucket_CAS_Production_WMSHistory_old;

CREATE TABLE `ac_bucket_CAS_Production_WMSHistory` (
  `Status` int(11) NOT NULL,
  `entriesInBucket` decimal(30,10) NOT NULL,
  `Jobs` decimal(30,10) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `JobSplitType` int(11) NOT NULL,
  `MinorStatus` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `Reschedules` decimal(30,10) NOT NULL,
  `ApplicationStatus` int(11) NOT NULL,
  `bucketLength` mediumint(8) unsigned NOT NULL,
  `User` int(11) NOT NULL,
  `JobGroup` int(11) NOT NULL,
  `UserGroup` int(11) NOT NULL,
  UNIQUE KEY `UniqueConstraint` (`startTime`,`Status`,`Site`,`User`,`UserGroup`,`JobGroup`,`MinorStatus`,`ApplicationStatus`,`JobSplitType`,`bucketLength`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_bucket_CAS_Production_WMSHistory DISABLE KEYS;
INSERT INTO ac_bucket_CAS_Production_WMSHistory (Status,entriesInBucket,Jobs,startTime,JobSplitType,MinorStatus,Site,Reschedules,ApplicationStatus,bucketLength,User,JobGroup,UserGroup) SELECT Status,entriesInBucket,Jobs,startTime,JobSplitType,MinorStatus,Site,Reschedules,ApplicationStatus,bucketLength,User,JobGroup,UserGroup FROM ac_bucket_CAS_Production_WMSHistory_old; 
ALTER TABLE ac_bucket_CAS_Production_WMSHistory ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_bucket_CAS_Production_WMSHistory_old;



-- Table ac_type_CAS_Production_DataOperation

RENAME TABLE ac_type_CAS_Production_DataOperation TO ac_type_CAS_Production_DataOperation_old;

CREATE TABLE `ac_type_CAS_Production_DataOperation` (
  `endTime` int(10) unsigned NOT NULL,
  `Protocol` int(11) NOT NULL,
  `TransferOK` int(10) unsigned NOT NULL,
  `RegistrationTime` float NOT NULL,
  `RegistrationTotal` int(10) unsigned NOT NULL,
  `Destination` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `Source` int(11) NOT NULL,
  `TransferTime` float NOT NULL,
  `User` int(11) NOT NULL,
  `OperationType` int(11) NOT NULL,
  `ExecutionSite` int(11) NOT NULL,
  `RegistrationOK` int(10) unsigned NOT NULL,
  `TransferTotal` int(10) unsigned NOT NULL,
  `TransferSize` bigint(20) unsigned NOT NULL,
  `FinalStatus` int(11) NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_DataOperation DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_DataOperation (endTime,Protocol,TransferOK,RegistrationTime,RegistrationTotal,Destination,startTime,Source,TransferTime,User,OperationType,ExecutionSite,RegistrationOK,TransferTotal,TransferSize,FinalStatus) SELECT endTime,Protocol,TransferOK,RegistrationTime,RegistrationTotal,Destination,startTime,Source,TransferTime,User,OperationType,ExecutionSite,RegistrationOK,TransferTotal,TransferSize,FinalStatus FROM ac_type_CAS_Production_DataOperation_old; 
ALTER TABLE ac_type_CAS_Production_DataOperation ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_DataOperation_old;


-- Table ac_type_CAS_Production_DataTransfer

RENAME TABLE ac_type_CAS_Production_DataTransfer TO ac_type_CAS_Production_DataTransfer_old;

CREATE TABLE `ac_type_CAS_Production_DataTransfer` (
  `Protocol` int(11) NOT NULL,
  `TransferOK` int(10) unsigned NOT NULL,
  `Destination` int(11) NOT NULL,
  `Source` int(11) NOT NULL,
  `TransferTime` float NOT NULL,
  `User` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `TransferSize` bigint(20) unsigned NOT NULL,
  `endTime` int(10) unsigned NOT NULL,
  `TransferTotal` int(10) unsigned NOT NULL,
  `FinalStatus` int(11) NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_DataTransfer DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_DataTransfer (Protocol,TransferOK,Destination,Source,TransferTime,User,startTime,TransferSize,endTime,TransferTotal,FinalStatus) SELECT Protocol,TransferOK,Destination,Source,TransferTime,User,startTime,TransferSize,endTime,TransferTotal,FinalStatus FROM ac_type_CAS_Production_DataTransfer_old; 
ALTER TABLE ac_type_CAS_Production_DataTransfer ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_DataTransfer_old;


-- Table ac_type_CAS_Production_Job

RENAME TABLE ac_type_CAS_Production_Job TO ac_type_CAS_Production_Job_old;

CREATE TABLE `ac_type_CAS_Production_Job` (
  `JobGroup` int(11) NOT NULL,
  `DiskSpace` bigint(20) unsigned NOT NULL,
  `InputDataSize` bigint(20) unsigned NOT NULL,
  `FinalMajorStatus` int(11) NOT NULL,
  `OutputDataSize` bigint(20) unsigned NOT NULL,
  `InputSandBoxSize` bigint(20) unsigned NOT NULL,
  `OutputDataFiles` int(10) unsigned NOT NULL,
  `NormCPUTime` int(10) unsigned NOT NULL,
  `User` int(11) NOT NULL,
  `JobType` int(11) NOT NULL,
  `JobClass` int(11) NOT NULL,
  `ProcessingType` int(11) NOT NULL,
  `ExecTime` int(10) unsigned NOT NULL,
  `CPUTime` int(10) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `UserGroup` int(11) NOT NULL,
  `FinalMinorStatus` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `ProcessedEvents` int(10) unsigned NOT NULL,
  `OutputSandBoxSize` bigint(20) unsigned NOT NULL,
  `InputDataFiles` int(10) unsigned NOT NULL,
  `endTime` int(10) unsigned NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_Job DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_Job (JobGroup,DiskSpace,InputDataSize,FinalMajorStatus,OutputDataSize,InputSandBoxSize,OutputDataFiles,NormCPUTime,User,JobType,JobClass,ProcessingType,ExecTime,CPUTime,startTime,UserGroup,FinalMinorStatus,Site,ProcessedEvents,OutputSandBoxSize,InputDataFiles,endTime) SELECT JobGroup,DiskSpace,InputDataSize,FinalMajorStatus,OutputDataSize,InputSandBoxSize,OutputDataFiles,NormCPUTime,User,JobType,JobClass,ProcessingType,ExecTime,CPUTime,startTime,UserGroup,FinalMinorStatus,Site,ProcessedEvents,OutputSandBoxSize,InputDataFiles,endTime FROM ac_type_CAS_Production_Job_old; 
ALTER TABLE ac_type_CAS_Production_Job ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_Job_old;


-- Table ac_type_CAS_Production_Pilot

RENAME TABLE ac_type_CAS_Production_Pilot TO ac_type_CAS_Production_Pilot_old;

CREATE TABLE `ac_type_CAS_Production_Pilot` (
  `Jobs` int(10) unsigned NOT NULL,
  `Site` int(11) NOT NULL,
  `GridResourceBroker` int(11) NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `UserGroup` int(11) NOT NULL,
  `GridCE` int(11) NOT NULL,
  `endTime` int(10) unsigned NOT NULL,
  `GridStatus` int(11) NOT NULL,
  `GridMiddleware` int(11) NOT NULL,
  `User` int(11) NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_Pilot DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_Pilot (Jobs,Site,GridResourceBroker,startTime,UserGroup,GridCE,endTime,GridStatus,GridMiddleware,User) SELECT Jobs,Site,GridResourceBroker,startTime,UserGroup,GridCE,endTime,GridStatus,GridMiddleware,User FROM ac_type_CAS_Production_Pilot_old; 
ALTER TABLE ac_type_CAS_Production_Pilot ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_Pilot_old;


-- Table ac_type_CAS_Production_SRMSpaceTokenDeployment

RENAME TABLE ac_type_CAS_Production_SRMSpaceTokenDeployment TO ac_type_CAS_Production_SRMSpaceTokenDeployment_old;

CREATE TABLE `ac_type_CAS_Production_SRMSpaceTokenDeployment` (
  `UsedNearline` bigint(20) unsigned NOT NULL,
  `SpaceTokenDesc` int(11) NOT NULL,
  `Hostname` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `UsedSpace` bigint(20) unsigned NOT NULL,
  `AvailableSpace` bigint(20) unsigned NOT NULL,
  `UsedOnline` bigint(20) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `TotalOnline` bigint(20) unsigned NOT NULL,
  `ReservedNearline` bigint(20) unsigned NOT NULL,
  `FreeNearline` bigint(20) unsigned NOT NULL,
  `endTime` int(10) unsigned NOT NULL,
  `FreeOnline` bigint(20) unsigned NOT NULL,
  `TotalNearline` bigint(20) unsigned NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_SRMSpaceTokenDeployment DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_SRMSpaceTokenDeployment (UsedNearline,SpaceTokenDesc,Hostname,Site,UsedSpace,AvailableSpace,UsedOnline,startTime,TotalOnline,ReservedNearline,FreeNearline,endTime,FreeOnline,TotalNearline) SELECT UsedNearline,SpaceTokenDesc,Hostname,Site,UsedSpace,AvailableSpace,UsedOnline,startTime,TotalOnline,ReservedNearline,FreeNearline,endTime,FreeOnline,TotalNearline FROM ac_type_CAS_Production_SRMSpaceTokenDeployment_old; 
ALTER TABLE ac_type_CAS_Production_SRMSpaceTokenDeployment ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_SRMSpaceTokenDeployment_old;


-- Table ac_type_CAS_Production_WMSHistory

RENAME TABLE ac_type_CAS_Production_WMSHistory TO ac_type_CAS_Production_WMSHistory_old;

CREATE TABLE `ac_type_CAS_Production_WMSHistory` (
  `Status` int(11) NOT NULL,
  `Jobs` int(10) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `JobSplitType` int(11) NOT NULL,
  `MinorStatus` int(11) NOT NULL,
  `Site` int(11) NOT NULL,
  `Reschedules` int(10) unsigned NOT NULL,
  `ApplicationStatus` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `JobGroup` int(11) NOT NULL,
  `UserGroup` int(11) NOT NULL,
  `endTime` int(10) unsigned NOT NULL
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE ac_type_CAS_Production_WMSHistory DISABLE KEYS;
INSERT INTO ac_type_CAS_Production_WMSHistory (Status,Jobs,startTime,JobSplitType,MinorStatus,Site,Reschedules,ApplicationStatus,User,JobGroup,UserGroup,endTime) SELECT Status,Jobs,startTime,JobSplitType,MinorStatus,Site,Reschedules,ApplicationStatus,User,JobGroup,UserGroup,endTime FROM ac_type_CAS_Production_WMSHistory_old; 
ALTER TABLE ac_type_CAS_Production_WMSHistory ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE ac_type_CAS_Production_WMSHistory_old;
