USE SystemLoggingDB;


-- Table FixedTextMessages

ALTER TABLE `FixedTextMessages` MODIFY `FixedTextString` varchar(767) NOT NULL DEFAULT 'Unknown';


-- Table ClientIPs

ALTER TABLE `ClientIPs` MODIFY `ClientIPNumberString` varchar(45) NOT NULL DEFAULT '0.0.0.0';


-- Table MessageRepository

RENAME TABLE MessageRepository TO MessageRepository_old;

CREATE TABLE `MessageRepository` (
  `LogLevel` varchar(15) NOT NULL,
  `MessageTime` datetime NOT NULL,
  `FixedTextID` int(11) NOT NULL,
  `VariableText` varchar(255) NOT NULL,
  `UserDNID` int(11) NOT NULL,
  `MessageID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientIPNumberID` int(11) NOT NULL,
  PRIMARY KEY (`MessageID`),
  KEY `TimeStampsIDX` (`MessageTime`),
  KEY `FixTextIDX` (`FixedTextID`),
  KEY `IPsIDX` (`ClientIPNumberID`),
  KEY `UserIDX` (`UserDNID`),
  FOREIGN KEY (`ClientIPNumberID`) REFERENCES `ClientIPs` (`ClientIPNumberID`),
  FOREIGN KEY (`UserDNID`) REFERENCES `UserDNs` (`UserDNID`),
  FOREIGN KEY (`FixedTextID`) REFERENCES `FixedTextMessages` (`FixedTextID`)
) ENGINE=InnoDB;

SET UNIQUE_CHECKS=0;
ALTER TABLE MessageRepository DISABLE KEYS;
INSERT INTO MessageRepository (LogLevel,MessageTime,FixedTextID,VariableText,UserDNID,MessageID,ClientIPNumberID) SELECT LogLevel,MessageTime,FixedTextID,VariableText,UserDNID,MessageID,ClientIPNumberID FROM MessageRepository_old; 
ALTER TABLE MessageRepository ENABLE KEYS;
SET UNIQUE_CHECKS=1;

DROP TABLE MessageRepository_old;
