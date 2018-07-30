use TaskQueueDB;

ALTER TABLE `TaskQueueDB`.`tq_Jobs` CHANGE COLUMN `JobId` `JobId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_Jobs` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TaskQueues` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `TaskQueueDB`.`tq_TQToSites` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToGridCEs` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToGridMiddlewares` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToBannedSites` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToPlatforms` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToPilotTypes` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToSubmitPools` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToJobTypes` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;
ALTER TABLE `TaskQueueDB`.`tq_TQToTags` CHANGE COLUMN `TQId` `TQId` int(11) UNSIGNED NOT NULL;

ALTER TABLE `TaskQueueDB`.`tq_Jobs` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);

ALTER TABLE `TaskQueueDB`.`tq_TQToSites` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToSites` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToGridCEs` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToGridCEs` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToGridMiddlewares` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToGridMiddlewares` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToBannedSites` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToBannedSites` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToPlatforms` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToPlatforms` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToPilotTypes` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToPilotTypes` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToSubmitPools` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToSubmitPools` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToJobTypes` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToJobTypes` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
ALTER TABLE `TaskQueueDB`.`tq_TQToTags` ADD PRIMARY KEY (`TQId`, `Value`);
ALTER TABLE `TaskQueueDB`.`tq_TQToTags` ADD FOREIGN KEY (`TQId`) REFERENCES `TaskQueueDB`.`tq_TaskQueues` (`TQId`);
