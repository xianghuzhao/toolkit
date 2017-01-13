#!/bin/bash

cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $cur_dir/../start.sh

show()
{
  echo "`date '+[%F %T %z]'`: Showing $1..."
  echo "USE \`$1\`; SHOW TABLES" | mysql -u$user -p$passwd
  echo "`date '+[%F %T %z]'`: Showing $1 Finished"
  echo '--------------------------------------------------------------------------------'
}

run_on_all_db show
