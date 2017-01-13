#!/bin/bash

if [ $# -ne 1 ]; then
  echo 'Error: Must specify one work directory in argument'
  exit 1
fi

workdir=$1


cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh

dump()
{
  echo "`date '+[%F %T %z]'`: Dumping $1..."
  mysqldump -u$user -p$passwd -d $1 | sed 's/ AUTO_INCREMENT=[0-9]\+//' > $1.sql
  echo "`date '+[%F %T %z]'`: Dumping $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

mkdir -p $workdir
cd $workdir

run_on_all_db dump
