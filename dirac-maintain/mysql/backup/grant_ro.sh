#!/bin/bash

if [ $# -ne 2 ]; then
  echo 'Error: Must specify username and host in argument'
  exit 1
fi

user_ro=$1
host=$2


cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh


grant()
{
  echo "`date '+[%F %T %z]'`: Granting $1..."
  echo "GRANT SELECT ON \`$1\`.* TO '$user_ro'@'$host'" | mysql -u$user -p$passwd
  echo "`date '+[%F %T %z]'`: Granting $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

run_on_all_db grant
