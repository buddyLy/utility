function convert_one
{
	sed -i 's/\r//g' $1
}

function convert_all
{
	datapushercommon="data_pusher_common.sh"
	datapusher="data_pusher.sh"
	datapushermain="data_pusher_main.sh"
	vdssdatapush="vdss_data_push.sh"
	datapushertemplate="data_pusher_template.cfg"
	monprocess="mon_process_time.sh"
	testscript="test_data_pusher.sh"
	installcfg="install.cfg"
	installscript="install.sh"
	
	sed -i 's/\r//g' $datapushercommon
	sed -i 's/\r//g' $datapusher
	sed -i 's/\r//g' $datapushermain
	sed -i 's/\r//g' $vdssdatapush
	sed -i 's/\r//g' $datapushertemplate
	sed -i 's/\r//g' $monprocess
	sed -i 's/\r//g' $testscript
	sed -i 's/\r//g' $installcfg
	sed -i 's/\r//g' $installscript
}

if [[ $1 = "all" ]];then
		convert_all
else
		convert_one $1
fi