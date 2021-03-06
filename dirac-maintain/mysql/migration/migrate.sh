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
  if [ ! -f $1.sql ]; then
    return
  fi

  echo "`date '+[%F %T %z]'`: Migrating sql $1..."
  mysql -u$user -p$passwd < $1.sql
  echo "`date '+[%F %T %z]'`: Migrating sql $1 Finished"
  echo '--------------------------------------------------------------------------------'
}


convert_py()
{
  if [ ! -f $1.py ]; then
    return
  fi

  echo "`date '+[%F %T %z]'`: Migrating py $1..."
  ./$1.py $user $passwd
  echo "`date '+[%F %T %z]'`: Migrating py $1 Finished"
  echo '--------------------------------------------------------------------------------'
}


convert_sh()
{
  if [ ! -f $1.sh ]; then
    return
  fi

  echo "`date '+[%F %T %z]'`: Migrating sh $1..."
  ./$1.sh $user $passwd
  echo "`date '+[%F %T %z]'`: Migrating sh $1 Finished"
  echo '--------------------------------------------------------------------------------'
}


cd $workdir


run_on_all_db convert_sql
run_on_all_db convert_py
run_on_all_db convert_sh
