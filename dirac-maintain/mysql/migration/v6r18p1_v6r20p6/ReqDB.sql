use ReqDB;

ALTER TABLE Request MODIFY Error VARCHAR(2048);
ALTER TABLE Operation MODIFY Error VARCHAR(2048);
ALTER TABLE File MODIFY Error VARCHAR(2048);
