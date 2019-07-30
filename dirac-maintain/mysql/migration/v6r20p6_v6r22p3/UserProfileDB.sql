USE UserProfileDB;


ALTER TABLE `up_HashTags` MODIFY `UserId` int(11) NOT NULL;
ALTER TABLE `up_HashTags` MODIFY `GroupId` int(11) NOT NULL;

ALTER TABLE `up_ProfilesData` MODIFY `UserId` int(11) NOT NULL;
ALTER TABLE `up_ProfilesData` MODIFY `GroupId` int(11) NOT NULL;
