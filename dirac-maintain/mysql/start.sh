# Get MySQL username and password
cur_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
auth_file="$cur_dir/auth"
auth_string=`cat $auth_file`
user=`echo $auth_string | awk -F ':' '{print $1}'`
passwd=`echo $auth_string | awk -F ':' '{print $2}'`

all_db="$cur_dir/databases"

run_on_all_db()
{
  for db in `cat $all_db`
  do
    if [[ ${db::1} != '#' ]];
    then
      $1 $db
    fi
  done
}
