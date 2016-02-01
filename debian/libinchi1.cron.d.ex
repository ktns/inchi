#
# Regular cron jobs for the libinchi1 package
#
0 4	* * *	root	[ -x /usr/bin/libinchi1_maintenance ] && /usr/bin/libinchi1_maintenance
