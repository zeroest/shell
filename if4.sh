#! /bin/sh
fname=/lib/systemd/system/cron.service
if [ -f $fname ]
then
	head -5 $fname
else
	echo "cron server is not setuped"
fi
exit 0

