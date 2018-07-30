#!/usr/bin/env python

from DIRAC.Core.Base import Script
Script.parseCommandLine( ignoreErrors = False )
options = Script.getUnprocessedSwitches()
args = Script.getPositionalArgs()

from DIRAC.Core.DISET.RPCClient import RPCClient

jobMonitor = RPCClient('WorkloadManagement/JobMonitoring')


if len(args) < 2:
  print 'Need user name and status'

user = args[0]
status = args[1]


result = jobMonitor.getJobs( { 'Owner': user, 'Status': status } )
if not result['OK']:
  print 'getjobs error: %s' % result['Message']

print len(result['Value'])
