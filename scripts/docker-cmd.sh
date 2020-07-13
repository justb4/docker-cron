#!/bin/sh
set -e

if [ ! -z "$CRON_TAIL" ]
then
	# crond running in background and log file reading every second by tail to STDOUT
	crond -s /var/spool/cron/crontabs -b -L /var/log/cron.log -l $CRON_DEBUG_LEVEL "$@" && tail -f /var/log/cron.log
else
	# crond running in foreground. log files can be retrive from /var/log/cron mount point
	crond -s /var/spool/cron/crontabs -f -L /var/log/cron.log -l $CRON_DEBUG_LEVEL "$@"
fi

# Now launch cron in then foreground.
# crontab /cronfile

# crond -fbS -l N -d N -L LOGFILE -c DIR
#
#        -f      Foreground
#        -b      Background (default)
#        -S      Log to syslog (default)
#        -l N    Set log level. Most verbose:0, default:8
#        -d N    Set log level, log to stderr
#        -L FILE Log to FILE
#        -c DIR  Cron dir. Default:/var/spool/cron/crontabs

# /usr/sbin/crond -f -l 0 -d 0
