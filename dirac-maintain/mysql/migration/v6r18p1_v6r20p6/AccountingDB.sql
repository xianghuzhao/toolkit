USE AccountingDB;


ALTER TABLE `ac_in_CAS_Production_DataOperation` MODIFY `ExecutionSite` varchar(256) NOT NULL;
ALTER TABLE `ac_key_CAS_Production_DataOperation_ExecutionSite` MODIFY `value` varchar(256) NOT NULL;


ALTER TABLE `ac_in_CAS_Production_Job` MODIFY `ProcessingType` varchar(256) NOT NULL;
ALTER TABLE `ac_key_CAS_Production_Job_ProcessingType` MODIFY `value` varchar(256) NOT NULL;


ALTER TABLE `ac_in_CAS_Production_WMSHistory` MODIFY `ApplicationStatus` varchar(256) NOT NULL;
ALTER TABLE `ac_key_CAS_Production_WMSHistory_ApplicationStatus` MODIFY `value` varchar(256) NOT NULL;
