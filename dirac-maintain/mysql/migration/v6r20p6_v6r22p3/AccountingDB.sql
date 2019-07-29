USE AccountingDB;


ALTER TABLE `ac_in_CAS_Production_Job` MODIFY `FinalMinorStatus` varchar(256) NOT NULL;
ALTER TABLE `ac_key_CAS_Production_Job_FinalMinorStatus` MODIFY `value` varchar(256) NOT NULL;
