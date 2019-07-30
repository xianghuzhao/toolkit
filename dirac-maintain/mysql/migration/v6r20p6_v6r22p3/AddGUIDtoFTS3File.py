# Procedure:
# * Stop (in this order): FTs3Agent, REA, FTS3Service
# * Update the Files table in the FTS3DB:
#   ALTER TABLE Files ADD COLUMN ftsGUID VARCHAR(255);
# * Deploy the v6r21 release
# * run this script (you need a proxy & the db configuration in your dirac.cfg. So best is if you run it on a server)
# Restart (in this order): FTS3Service, FTS3Agent, REA

from DIRAC.Core.Base.Script import parseCommandLine
parseCommandLine()

from DIRAC.DataManagementSystem.DB import FTS3DB
from DIRAC.DataManagementSystem.DB.FTS3DB import FTS3Job, FTS3Operation, FTS3File

import fts3.rest.client.easy as fts3
from sqlalchemy.sql import update, delete
from sqlalchemy.sql.expression import and_



db = FTS3DB.FTS3DB()
session = db.dbSession(expire_on_commit=False)

ftsJobsQuery = session.query(FTS3Job)\
          .filter(~FTS3Job.status.in_(FTS3Job.FINAL_STATES))
activeJobs = ftsJobsQuery.all()

#activeJobs = session.query(FTS3Job).filter(FTS3Job.jobID == 1787750).all()
session.commit()
session.expunge_all()
session.close()

fileID_jobGUID = {}
for job in activeJobs:
  #print job
  guid = job.ftsGUID
  fileStatus = job.monitor()['Value']
  for fID in fileStatus:
    fileID_jobGUID[fID] = guid

print fileID_jobGUID

for fileID, jobGUID in fileID_jobGUID.iteritems():
  session = db.dbSession(expire_on_commit=False)

  updateDict = {FTS3File.ftsGUID : jobGUID}
  upQuery = update(FTS3File).where(and_(FTS3File.fileID == fileID,
                             ~ FTS3File.status.in_(FTS3File.FINAL_STATES)
                                    )
                               )\
                        .values(updateDict)
  session.execute(upQuery)
  session.commit()
  session.expunge_all()
  session.close()
