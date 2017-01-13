#!/bin/bash

if [ $# -ne 1 ]; then
  echo 'Error: Must specify one work directory in argument'
  exit 1
fi

workdir=$1


cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh


convert_sql()
{
  echo "`date '+[%F %T %z]'`: Migrating sql $1..."
  mysql -u$user -p$passwd < $1.sql
  echo "`date '+[%F %T %z]'`: Migrating sql $1 Finished"
  echo '--------------------------------------------------------------------------------'
}


convert_py()
{
  echo "`date '+[%F %T %z]'`: Migrating py $1..."
  ./$1.py $user $passwd
  echo "`date '+[%F %T %z]'`: Migrating py $1 Finished"
  echo '--------------------------------------------------------------------------------'
}


cd $workdir


#convert_py AccountingDB

run_on_all_db convert_sql
