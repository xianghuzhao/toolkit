#!/bin/bash

if [ $# -ne 1 ]; then
  echo 'Error: Must specify one host in argument'
  exit 1
fi

host=$1


cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh


grant()
{
  echo "`date '+[%F %T %z]'`: Granting $1..."
  echo "CREATE DATABASE IF NOT EXISTS \`$1\`" | mysql -u$user -p$passwd
  echo "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,REFERENCES,INDEX,ALTER,LOCK TABLES,CREATE VIEW,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,TRIGGER ON \`$1\`.* TO 'Dirac'@'$host'" | mysql -u$user -p$passwd
  echo "`date '+[%F %T %z]'`: Granting $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

run_on_all_db grant
