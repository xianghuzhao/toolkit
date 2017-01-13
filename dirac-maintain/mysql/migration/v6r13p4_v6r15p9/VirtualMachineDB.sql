USE VirtualMachineDB;


-- Table vm_Images

ALTER TABLE `vm_Images` DROP COLUMN `RunningPodID`;
ALTER TABLE `vm_Images` DROP KEY `Image`;


-- Table vm_Instances

ALTER TABLE `vm_Instances` MODIFY `Endpoint` varchar(255) NOT NULL;
ALTER TABLE `vm_Instances` MODIFY `UniqueID` varchar(255) NOT NULL DEFAULT ''
