#!/bin/bash

cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh

drop()
{
  echo "`date '+[%F %T %z]'`: Droping $1..."
  echo "DROP DATABASE \`$1\`" | mysql -u$user -p$passwd
  echo "`date '+[%F %T %z]'`: Droping $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

run_on_all_db drop
