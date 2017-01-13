#!/usr/bin/env python

import os
import re

SC_CLK_TCK = os.sysconf('SC_CLK_TCK')
SC_PAGE_SIZE = os.sysconf('SC_PAGE_SIZE')

################################################################################

def memory_stat():
    mem = {}
    f = open("/proc/meminfo")
    lines = f.readlines()
    f.close()
    for line in lines:
        if len(line) < 2: continue
        name = line.split(':')[0]
        var = line.split(':')[1].split()[0]
        mem[name] = long(var)
    mem['MemUsed'] = mem['MemTotal'] - mem['MemFree'] - mem['Buffers'] - mem['Cached']
    mem['SwapUsed'] = mem['SwapTotal'] - mem['SwapFree']
    return mem

def cpu_info():
    cpu = []
    cpuinfo = {}
    f = open("/proc/cpuinfo")
    lines = f.readlines()
    f.close()
    for line in lines:
        if line == '\n':
            cpu.append(cpuinfo)
            cpuinfo = {}
        if len(line) < 2: continue
        name = line.split(':')[0].rstrip()
        var = line.split(':')[1]
        cpuinfo[name] = var
    return cpu

def load_stat():
    loadavg = {}
    f = open("/proc/loadavg")
    con = f.read().split()
    f.close()
    loadavg['lavg_1']=float(con[0])
    loadavg['lavg_5']=float(con[1])
    loadavg['lavg_15']=float(con[2])
    loadavg['nr']=con[3]
    loadavg['last_pid']=con[4]
    return loadavg

def uptime_stat():
    uptime = {}
    f = open("/proc/uptime")
    con = f.read().split()
    f.close()
    all_sec = float(con[0])
    MINUTE,HOUR,DAY = 60,3600,86400
    uptime['day'] = int(all_sec / DAY )
    uptime['hour'] = int((all_sec % DAY) / HOUR)
    uptime['minute'] = int((all_sec % HOUR) / MINUTE)
    uptime['second'] = int(all_sec % MINUTE)
    uptime['Free rate'] = float(con[1]) / float(con[0])
    uptime['all_sec'] = int(all_sec)
    return uptime

def net_stat():
    net = {}
    f = open("/proc/net/dev")
    lines = f.readlines()
    f.close()
    for line in lines[2:]:
        con = re.split(':* *', line.strip().rstrip())
        interface = con[0]
        intf = dict(
            zip(
                ( 'ReceiveBytes','ReceivePackets',
                  'ReceiveErrs','ReceiveDrop','ReceiveFifo',
                  'ReceiveFrames','ReceiveCompressed','ReceiveMulticast',
                  'TransmitBytes','TransmitPackets','TransmitErrs',
                  'TransmitDrop', 'TransmitFifo','TransmitFrames',
                  'TransmitCompressed','TransmitMulticast' ),
                ( int(con[1]),int(con[2]),
                  int(con[3]),int(con[4]),int(con[5]),
                  int(con[6]),int(con[7]),int(con[8]),
                  int(con[9]),int(con[10]),int(con[11]),
                  int(con[12]),int(con[13]),int(con[14]),
                  int(con[15]),int(con[16]), )
            )
        )

        net[interface] = intf
    return net

def disk_stat(directory='/'):
    hd = {}
    disk = os.statvfs(directory)
    hd['available'] = disk.f_bsize * disk.f_bavail
    hd['capacity'] = disk.f_bsize * disk.f_blocks
    hd['used'] = disk.f_bsize * disk.f_bfree
    return hd

def cpu_stat():
    cpu = {}
    stat = {}
    f = open("/proc/stat")
    lines = f.readlines()
    f.close()
    for line in lines:
        con = line.split()
        if line.startswith('cpu'):
            cpuname = con[0]
            cputime = dict(
                zip(
                    ( 'user','nice','system','idle','iowait','irq','softirq' ),
                    ( int(con[1]),int(con[2]), int(con[3]),int(con[4]),int(con[5]),int(con[6]),int(con[7]) )
                )
            )
            cputime['total'] = cputime['user'] + cputime['nice'] + cputime['system'] + cputime['idle'] + cputime['iowait'] + cputime['irq'] + cputime['softirq'];

            cpu[cpuname] = cputime
        else:
            if len(con) == 2:
                stat[con[0]] = con[1]
    return {'cpu': cpu, 'stat': stat}

################################################################################

def pid_stat(pid):
    try:
        f = open("/proc/%s/stat" % pid)
    except:
        return {}
    line = f.read()
    f.close()
    con = line.split()
    cputime = dict(
        zip(
            ( 'ppid','utime','stime','cutime','cstime','starttime','rss' ),
            ( int(con[3]),int(con[13]),int(con[14]), int(con[15]),int(con[16]),int(con[21]), int(con[23]) )
        )
    )
    return cputime

def pid_status(pid):
    status = {}
    try:
        f = open("/proc/%s/status" % pid)
    except:
        return status
    lines = f.readlines()
    f.close()
    for line in lines:
        name = line.split(':')[0]
        var = line.split(':')[1].strip()
        status[name] = var
    return status

def pid_io(pid):
    io = {}
    try:
        f = open("/proc/%s/io" % pid)
    except:
        return io
    lines = f.readlines()
    f.close()
    for line in lines:
        name = line.split(':')[0]
        var = line.split(':')[1].strip()
        io[name] = int(var)
    return io

def pid_cmdline(pid):
    try:
        f = open("/proc/%s/cmdline" % pid)
    except:
        return []
    line = f.read()
    f.close()
    return line.rstrip('\x00').split('\x00')

################################################################################

import urllib2
import time
import socket

from DIRAC import S_OK, S_ERROR, gConfig

from DIRAC.Core.Base import Script
Script.parseCommandLine( ignoreErrors = False )

from DIRAC.Core.DISET.RPCClient                      import RPCClient

from DIRAC.Core.Utilities        import Network

vm = RPCClient('WorkloadManagement/VirtualMachineManager')
info = RPCClient('Info/BadgerInfo')

def getAmazonVMId():
  try:
    fd = urllib2.urlopen("http://instance-data.ec2.internal/latest/meta-data/instance-id", timeout=30)
  except urllib2.URLError:
    print "Can not connect to EC2 URL. Trying address 169.254.169.254 directly..."
    try:
      fd = urllib2.urlopen("http://169.254.169.254/latest/meta-data/instance-id", timeout=30)
    except urllib2.URLError, e:
      return S_ERROR( "Could not retrieve amazon instance id: %s" % str( e ) )
  iD = fd.read().strip()
  fd.close()
  return S_OK( iD )

def getOcciVMId():
  # opennebula metadata it is not standar installation in most sites, trying different means of context:
  try:
    fd = open( os.path.join( '/etc', 'VMID' ), 'r' )
    iD = fd.read().strip()
    fd.close()
    return S_OK( iD )
  except Exception, e:
    pass

  # interacting with VMDIRAC with the VMDIRAC instanceID, to get the opennebula uniqueID
  try:
    fd = open( os.path.join( '/root', 'VMDIRAC_instanceID' ), 'r' )
    vmdirac_instanceID = fd.read().strip()
    fd.close()
    res = vm.getUniqueID( vmdirac_instanceID )
    return res
  except Exception, e:
    return S_ERROR( "Could not retrieve occi instance id: %s" % str( e ) )

def getNovaVMId():

  metadataUrl = 'http://169.254.169.254/openstack/2012-08-10/meta_data.json'
  opener      = urllib2.build_opener()

  try:
    request  = urllib2.Request( metadataUrl )
    jsonFile = opener.open( request )
    jsonDict = simplejson.load( jsonFile )

    return S_OK( jsonDict[ 'uuid' ] )

  except:
    pass

  try:
    fd = open( os.path.join( '/etc', 'VMID' ), 'r' )
    iD = fd.read().strip()
    fd.close()
    return S_OK( iD )
  except Exception, e:
    return S_ERROR( "Could not retrieve nova instance id: %s" % str( e ) )

def getCloudStackVMId():
  try:
    iD    = commands.getstatusoutput( '/bin/hostname' )
    idStr = iD[1].split( '-' )
    return S_OK( idStr[2] )
  except Exception, e:
    return S_ERROR( "Could not retrieve CloudStack instance id: %s" % str( e ) )

def getGenericVMId():
  fd = open( "/proc/stat" )
  lines = fd.readlines()
  fd.close()
  btime = False
  for line in lines:
    fields = List.fromChar( line, " " )
    if fields[0] == "btime":
      btime = fields[1]
      break
  if not btime:
    return S_ERROR( "Could not find btime in /proc/stat" )
  md5Hash = md5()
  md5Hash.update( btime )
  netData = Network.discoverInterfaces()
  for iface in sorted( netData ):
    if iface == "lo":
      continue
    md5Hash.update( netData[ iface ][ 'mac' ] )
  return S_OK( md5Hash.hexdigest() )


def findPidBoss(option):
    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            cmdline = pid_cmdline(pid)
            if len(cmdline) == 2 and cmdline[0] == 'boss.exe' and cmdline[1] == option:
                return pid
    return 0

def findRecPid():
    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            cmdline = pid_cmdline(pid)
            if len(cmdline) == 2 and cmdline[0] == 'boss.exe' and cmdline[1] == 'recoptions.opts':
                return pid
    return 0

def findPidRantrg():
    pppid = 0
    ppid = 0
    cpid = 0
    tpid = 0
    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            cmdline = pid_cmdline(pid)
            if len(cmdline) >= 2 and cmdline[0] == 'python' and cmdline[1].endswith('besdirac-dms-rantrg-get'):
                pppid = pid
                break
    if pppid == 0:
        return ppid, cpid

    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            stat = pid_stat(pid)
            if stat and stat['ppid'] == pppid:
                ppid = pid
                for task in os.listdir('/proc/%s/task'%ppid):
                    tid = int(task)
                    if tid != ppid:
                        tpid = tid
                break
    if ppid == 0:
        return ppid, cpid

    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            stat = pid_stat(pid)
            if stat and stat['ppid'] == ppid and pid != tpid:
                cpid = pid
                break
    return ppid, cpid

def findCurrentJobID():
    jobID = 0
    for dir in os.listdir('/proc'):
        if dir.isdigit():
            pid = int(dir)
            cmdline = pid_cmdline(pid)
            if len(cmdline) == 2:
                mat = re.match('.*jobAgent-\\d+/job/Wrapper/Job(\\d+)', cmdline[1])
                if mat:
                    jobID = int(mat.group(1))
                    break
    return jobID


class LogInstance:
    id = 0
    uniqueID = 'unknown'
    instanceID = 0
    runningPod = 'unknown'
    ip = '0.0.0.0'
    hostname = 'unknown'

    def prepare(self):
        result = self.getVMUniqueID()
        if result['OK']:
            self.uniqueID = result['Value']
            result = self.getVMInfo(self.uniqueID)
            if result['OK']:
                self.instanceID, self.runningPod = result['Value']

        self.ip = self.getVMIP()
        self.hostname = self.getVMHostName()

    def vminfo(self):
        return self.instanceID, self.runningPod

    def output(self):
        print 'Instance: ', (self.instanceID, self.runningPod, self.uniqueID, self.ip, self.hostname)

    def write(self):
        result = info.addVMInstance(self.instanceID, self.runningPod, self.uniqueID, self.ip, self.hostname)
        if not result['OK']:
            print result['Message']
        if 'lastRowId' in result:
            self.id = result['lastRowId']

    def getVMUniqueID(self):
        cloudDriver = gConfig.getValue( "/LocalSite/CloudDriver", "" ).lower()
        if cloudDriver == 'generic':
          result = getGenericVMId()
        elif cloudDriver == 'amazon':
          result = getAmazonVMId()
        elif (cloudDriver == 'occi-0.9' or cloudDriver == 'occi-0.8' or cloudDriver == 'rocci-1.1' ):
          result = getOcciVMId()
        elif cloudDriver == 'cloudstack':
          result = getCloudStackVMId()
        elif cloudDriver == 'nova-1.1':
          result = getNovaVMId()
        else:
          return S_ERROR( "Unknown cloudDriver %s" % cloudDriver )
        if not result[ 'OK' ]:
          return S_ERROR( "Could not generate VM id: %s" % result[ 'Message' ] )
        vmId = str(result[ 'Value' ])

        return S_OK(vmId)

    def getVMInfo(self, uniqueID):
        result = vm.getAllInfoForUniqueID(uniqueID)
        if not result['OK']:
            return result

        instanceInfo = result['Value']['Instance']
        instanceID = instanceInfo['InstanceID']
        runningPod = instanceInfo['RunningPod']

        return S_OK((instanceID, runningPod))

    def getVMIP(self):
        netData = Network.discoverInterfaces()
        ip = netData['eth0']['ip']
        return ip

    def getVMHostName(self):
        return socket.getfqdn()


class LogInfo:
    id = 0

    def __init__(self, instanceID, jobID):
        self.instanceID = instanceID
        self.jobID = jobID

    def beforePrepare(self):
        self.start_time = time.time()
        cpu = cpu_stat()
        net = net_stat()
        self.start_total = cpu['cpu']['cpu']['total']
        self.start_run = cpu['cpu']['cpu']['total'] - cpu['cpu']['cpu']['idle'] - cpu['cpu']['cpu']['iowait']
        self.start_iowait = cpu['cpu']['cpu']['iowait']
        self.start_send = net['eth0']['TransmitBytes']
        self.start_recv = net['eth0']['ReceiveBytes']

    def prepare(self):
        end_time = time.time()
        cpu = cpu_stat()
        net = net_stat()
        end_total = cpu['cpu']['cpu']['total']
        end_run = cpu['cpu']['cpu']['total'] - cpu['cpu']['cpu']['idle'] - cpu['cpu']['cpu']['iowait']
        end_iowait = cpu['cpu']['cpu']['iowait']
        end_send = net['eth0']['TransmitBytes']
        end_recv = net['eth0']['ReceiveBytes']

        self.cpu = cpu
        self.net = net
        self.cpuEff = float(end_run - self.start_run) / float(end_total - self.start_total)
        self.iowait = float(end_iowait - self.start_iowait) / float(end_total - self.start_total)
        self.sendSpeed = int(float(end_send - self.start_send) / float(end_time - self.start_time))
        self.recvSpeed = int(float(end_recv - self.start_recv) / float(end_time - self.start_time))


        load = load_stat()
        uptime = uptime_stat()
        memory = memory_stat()
        disk = disk_stat('.')

        self.load = load['lavg_1']
        self.uptime = uptime['all_sec']
        self.memUsed = memory['MemUsed']
        self.swapUsed = memory['SwapUsed']
        self.running = int(cpu['stat']['procs_running'])
        self.blocked = int(cpu['stat']['procs_blocked'])
        self.diskSpace = disk['available']

    def output(self):
        print 'Info: ', (self.instanceID, self.jobID, self.load, self.uptime, self.memUsed, self.swapUsed,
            self.cpuEff, self.iowait, self.running, self.blocked, self.diskSpace, self.sendSpeed, self.recvSpeed)

    def write(self):
        result = info.addVMLogging(self.instanceID, self.jobID, self.load, self.uptime, self.memUsed, self.swapUsed,
            self.cpuEff, self.iowait, self.running, self.blocked, self.diskSpace, self.sendSpeed, self.recvSpeed)
        if not result['OK']:
            print result['Message']
        if 'lastRowId' in result:
            self.id = result['lastRowId']


class LogProc():
    id = 0

    def __init__(self, procType, pid):
        self.procType = procType
        self.pid = pid

    def beforePrepare(self):
        if not self.pid:
            return
        stat = pid_stat(self.pid)

        if not stat:
            self.pid = 0
            return

        self.startUptime = uptime_stat()['all_sec']
        self.startCputime = stat['utime'] + stat['stime'] + stat['cutime'] + stat['cstime']
        self.startStarttime = stat['starttime']

    def prepare(self):
        if not self.pid:
            return
        stat = pid_stat(self.pid)
        status = pid_status(self.pid)
        io = pid_io(self.pid)
        endUptime = uptime_stat()['all_sec']

        if not (stat and status and io):
            self.pid = 0
            return

        endCputime = stat['utime'] + stat['stime'] + stat['cutime'] + stat['cstime']
        endStarttime = stat['starttime']

        self.state = status['State']
        self.cpuEff = float(endCputime - self.startCputime) / SC_CLK_TCK / float(endUptime - self.startUptime)
        self.ioRead = io['read_bytes']
        self.ioWrite = io['write_bytes']
        self.rss = stat['rss'] * SC_PAGE_SIZE
        self.starttime = int(endUptime - float(stat['starttime'])/SC_CLK_TCK)

    def output(self):
        if not self.pid:
            return
        print 'Process: ', (self.procType, self.state, self.cpuEff, self.ioRead, self.ioWrite, self.rss, self.starttime)

    def write(self, vmLoggingInfoID):
        if not self.pid:
            return
        result = info.addVMProc(vmLoggingInfoID, self.procType, self.state, self.cpuEff, self.ioRead, self.ioWrite, self.rss, self.starttime)
        if not result['OK']:
            print result['Message']
        if 'lastRowId' in result:
            self.id = result['lastRowId']


class LogJob:
    jobIDs = []
    id = 0

    def __init__(self, instanceID, vmJobWrappersLocation):
        self.instanceID = instanceID
        self.vmJobWrappersLocation = vmJobWrappersLocation

    def prepare(self):
        self.jobIDs = []
        if not os.path.isdir( self.vmJobWrappersLocation ):
          return

        for entry in os.listdir( self.vmJobWrappersLocation ):
          if entry.startswith( "jobAgent-" ):
            entryPath = os.path.join( self.vmJobWrappersLocation, entry )
            for jobAgentEntry in os.listdir(entryPath):
              jdlPos = jobAgentEntry.find( ".jdl" )
              if jdlPos >= 0:
                self.jobIDs.append(int(jobAgentEntry[:jdlPos]))

    def output(self):
        print 'Job IDs: ', self.jobIDs

    def write(self):
        result = info.addVMJob(self.instanceID, self.jobIDs)
        if not result['OK']:
            print result['Message']
        if 'lastRowId' in result:
            self.id = result['lastRowId']


def main():
    logInstance = LogInstance()
    logInstance.prepare()
    logInstance.output()
    logInstance.write()
    print ''
    instanceID, runningPod = logInstance.vminfo()

    configPath = "/Resources/VirtualMachines/RunningPods/%s/JobWrappersLocation" % runningPod
    vmJobWrappersLocation = gConfig.getValue(configPath, '/tmp')

    countIdle = 0
    while True:
        jobID = findCurrentJobID()
        print 'Current job ID: %s' % jobID

        if jobID:
            countIdle = 0
        else:
            countIdle += 1
            if countIdle > 1:
                countIdle %= 10
                time.sleep(60)
                continue


        logInfo = LogInfo(instanceID, jobID)
        logJob = LogJob(instanceID, vmJobWrappersLocation)

        pidSim = findPidBoss('options.opts')
        pidRec = findPidBoss('recoptions.opts')
        ppidRantrg, cpidRantrg = findPidRantrg()
        print 'pids: ', pidSim, pidRec, ppidRantrg, cpidRantrg

        logProcSim     = LogProc('sim', pidSim)
        logProcRec     = LogProc('rec', pidRec)
        logProcRantrgp = LogProc('rantrg_p', ppidRantrg)
        logProcRantrgc = LogProc('rantrg_c', cpidRantrg)


        logInfo.beforePrepare()

        logProcSim.beforePrepare()
        logProcRec.beforePrepare()
        logProcRantrgp.beforePrepare()
        logProcRantrgc.beforePrepare()

        time.sleep(1)

        logInfo.prepare()

        logProcSim.prepare()
        logProcRec.prepare()
        logProcRantrgp.prepare()
        logProcRantrgc.prepare()

        logJob.prepare()


        logInfo.output()
        logInfo.write()

        logProcSim.output()
        logProcRec.output()
        logProcRantrgp.output()
        logProcRantrgc.output()
        vmLoggingInfoID = logInfo.id
        if vmLoggingInfoID:
            logProcSim.write(vmLoggingInfoID)
            logProcRec.write(vmLoggingInfoID)
            logProcRantrgp.write(vmLoggingInfoID)
            logProcRantrgc.write(vmLoggingInfoID)

        logJob.output()
        logJob.write()

        print ''
        time.sleep(59)


if __name__ == '__main__':
    main()
