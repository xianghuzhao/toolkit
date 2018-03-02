#!/bin/bash

days_to_keep=60
ldsb_days_to_keep=7

logfile='output.log'

cd $(dirname "$0")

clean_site() {
  echo Cleaning site: $1

  file_number=$(ssh $1 "find $2/submission -maxdepth 1 -type f -mtime +$days_to_keep -print -exec rm -f {} \;" | wc -l)
  echo "- Deleted submission file number: $file_number"

  file_number=$(ssh $1 "find $2/output -maxdepth 1 -type f -mtime +$days_to_keep -print -exec rm -f {} \;" | wc -l)
  echo "- Deleted output file number: $file_number"

  ssh $1 "find $2/output -name LDSB.* -maxdepth 1 -type f -mtime +$ldsb_days_to_keep -exec ls -l {} \;"
  file_number=$(ssh $1 "find $2/output -name LDSB.* -maxdepth 1 -type f -mtime +$ldsb_days_to_keep -print -exec rm -f {} \;" | wc -l)
  echo "- Deleted LDSB file number: $file_number"

  echo ''
}

(
echo '================================================================================'
date '+Start  at: %Y-%m-%d %H:%M:%S.%N %z %Z'

clean_site dirac@bl-1-1.physics.sjtu.edu.cn /home/dirac/condor
clean_site dirac@ui01.lcg.ustc.edu.cn /home/dirac/condor_new
clean_site cepcdirac@hepui034.phys.sinica.edu.tw /prousr/cepcdirac/condor_dirac
clean_site cepcdirac@hepui023.phys.sinica.edu.tw /raid6/cepcdirac/condor_dirac
clean_site dirac@bes3s1.spa.umn.edu /home/user1/dirac/dirac_condor_new
clean_site dirac@man.hpc.neu.edu.tr /besfs/homes/dirac/condor

date '+Finish at: %Y-%m-%d %H:%M:%S.%N %z %Z'
echo ''
) >> $logfile 2>&1
