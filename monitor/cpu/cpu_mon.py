#!/usr/bin/env python

import os
import sys
import time

pid = 8757
#pid = 18193

JIFFIES_PER_SEC = os.sysconf('SC_CLK_TCK')

class CPUMonitor:
    def __init__(self, pid):
        self.pid = pid
        self.stat_fn = '/proc/%s/stat' % self.pid

        self.lastWallTime = self.getWallTime()
        self.lastCPUTime = self.getCPUTime()

    def getWallTime(self):
        return time.time() * JIFFIES_PER_SEC

    def getCPUTime(self):
        f = open(self.stat_fn)
        stat = f.read().split()
        f.close()

        utime = int(stat[13])
        stime = int(stat[14])
        cutime = int(stat[15])
        cstime = int(stat[16])
        starttime = int(stat[21])

        cputime = utime + stime + cutime + cstime

        return cputime

    def getCPUEff(self):
        currentWallTime = self.getWallTime()
        currentCPUTime = self.getCPUTime()
        eff = (currentCPUTime - self.lastCPUTime) / (currentWallTime - self.lastWallTime)
        self.lastWallTime = currentWallTime
        self.lastCPUTime = currentCPUTime
        return eff


def main():
    pid_infos = []
    for pid in sys.argv[1:]:
        cpu_monitor = CPUMonitor(int(pid))
        file = open('out/%s' % pid, 'w')
        pid_infos.append((cpu_monitor, file))

    while True:
        time.sleep(10)
        for pid_info in pid_infos:
            eff = pid_info[0].getCPUEff()*100
            print '%10.1f%%  ' % eff,
            print >>pid_info[1], eff
        print ''

if __name__=='__main__':
    main()
