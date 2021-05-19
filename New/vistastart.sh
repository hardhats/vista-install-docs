#!/bin/bash
# vistastart

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

echo "In vistastart.sh:"
echo "gtm_dist=$gtm_dist"
echo "vista_home=$vista_home"
echo "running as user $USER ($EUID)"

if [ $EUID -eq 0 ]; then
  echo "Run as $vista_user, not as root."
  exit;
fi

rm -f ${HOME}/*.mj[oe]

# If a database is shutdown cleanly there shouldn't be anything in the
# journals to replay, so we can run this without worry
if [ -f ${vista_home}/j/mumps.mjl ]; then
  echo "Recovering old journals..."
  $gtm_dist/mupip journal -recover -backward $vista_home/j/mumps.mjl
fi
$gtm_dist/mupip rundown -region DEFAULT
$gtm_dist/mupip set -journal="enable,on,before,f=$vista_home/j/mumps.mjl" -file $vista_home/g/mumps.dat

echo "Starting TaskMan"
$gtm_path/mumps -run ZTMB

#remove old journal files
if (( $(find ${vista_home}/g -name '*_*' -mtime +3 -print | wc -l) > 0 )); then
  echo "Deleting old journals..."
  find ${vista_home}/g -name '*_*' -mtime +3 -print -delete
fi

echo "$(date) Server start."
