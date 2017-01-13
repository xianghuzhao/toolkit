#!/bin/bash

if [ $# -ne 1 ]; then
  echo 'Error: Must specify one work directory in argument'
  exit 1
fi

workdir=$1


cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh


import()
{
  echo "`date '+[%F %T %z]'`: Importing $1..."
  mysql -u$user -p$passwd < $1.sql
  echo "`date '+[%F %T %z]'`: Importing $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

cd $workdir

run_on_all_db import
