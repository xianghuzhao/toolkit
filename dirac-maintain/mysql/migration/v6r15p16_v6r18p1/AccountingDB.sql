USE AccountingDB;


-- Table ac_catalog_Types

DELETE FROM `ac_catalog_Types` WHERE `name`='CAS_Production_SRMSpaceTokenDeployment';


-- Table *SRMSpaceTokenDeployment*

DROP TABLE `ac_bucket_CAS_Production_SRMSpaceTokenDeployment`;
DROP TABLE `ac_in_CAS_Production_SRMSpaceTokenDeployment`;
DROP TABLE `ac_key_CAS_Production_SRMSpaceTokenDeployment_Hostname`;
DROP TABLE `ac_key_CAS_Production_SRMSpaceTokenDeployment_Site`;
DROP TABLE `ac_key_CAS_Production_SRMSpaceTokenDeployment_SpaceTokenDesc`;
DROP TABLE `ac_type_CAS_Production_SRMSpaceTokenDeployment`;
