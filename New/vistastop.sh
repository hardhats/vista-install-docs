#!/bin/bash
# vistastop

#---------------------------------------------------------------------------
# K. Toppenberg, MD
# M. Toppenberg
# Edited 5/19/21
# This script is called from systemd, as configured by
#   /etc/systemd/system/vista.service
# Output of this script will be output to systemd log file, so no
#  need in here to output to log file directly.
#---------------------------------------------------------------------------

source |path/to/vista/instance|/env.vista

echo "In vistastart.sh, gtm_dist=$gtm_dist, vista_home=$vista_home"

$gtm_dist/mumps -run %XCMD "S U=\"^\" D GROUP^ZTMKU(\"SMAN(NODE)\"),GROUP^ZTMKU(\"SSUB(NODE)\"),STPACT^ZTMKU W \"Done shutting down

# Wait for TaskMan to stop
echo "Waiting for TaskMan to stop (2 sec)"
sleep 2

processes=$(pgrep mumps)
if [ -n "${processes}" ] ; then
  echo "Stopping any remaining M processes nicely"
  pgrep mumps | xargs --max-args=1 "mupip" stop
  sleep 2
fi

processes=$(pgrep mumps)
if [ -n "${processes}" ] ; then
  echo "M process are being shutdown forcefully!"
  ps -ef | grep mumps
  pkill -9 mumps
fi

echo "$(date) Server stop."
