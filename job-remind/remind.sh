#!/bin/sh

source /opt/dirac/bashrc

min_number=1000
user='byzhang'
mail='byzhang@ihep.ac.cn'
admin_mail='zhaoxh@ihep.ac.cn'

cd $(dirname "$0")

logfile='waiting-remind.log'

(
echo '================================================================================'
date '+%Y-%m-%d %H:%M:%S.%N %z %Z'

waiting_number=$(./check_job.py $user Waiting)

echo "Current waiting job number is $waiting_number"


if [ "$waiting_number" -lt "$min_number" ]; then
  echo "User $user has only $waiting_number waiting jobs now"

  mail_subject="Waiting DIRAC job number is less than $min_number"
  mail_content=$(cat <<EOF
Hi $user,

There are only $waiting_number waiting jobs now.
You can reschedule failed or submit new jobs.

This mail is sent by DIRAC server automatically.
Please do not reply this mail.

dirac.ihep.ac.cn
EOF
)

  echo "Sending remind email to $mail"
  echo -e "$mail_content" | mail -s "$mail_subject" "$mail" "$admin_mail"
fi


date '+%Y-%m-%d %H:%M:%S.%N %z %Z'
echo ''
) >> $logfile 2>&1
