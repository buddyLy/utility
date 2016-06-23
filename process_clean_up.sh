#!/bin/sh

for processid in $(ps -ef | grep 'mon_process_time.sh\|data_pusher_common.sh\|vdss_data_push.sh\|data_pusher_main.sh\|data_pusher.sh\|vdss_data_push.sh' | grep -v 'grep\|view\|vi' | awk '{print $2}')
do
	echo "Killing process id: $processid"
done