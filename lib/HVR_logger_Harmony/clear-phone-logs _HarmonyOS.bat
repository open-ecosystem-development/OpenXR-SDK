echo "press any key to clear logs! ! !"
pause
set LOGCAT_CMD=adb
%LOGCAT_CMD% remount
%LOGCAT_CMD% shell "rm -rf /data/log/hilogs/*"
%LOGCAT_CMD% shell "rm -rf /data/dontpanic/*"
%LOGCAT_CMD% shell "rm -rf /data/system/dropbox/*"
%LOGCAT_CMD% shell "rm -rf /data/tombstones/*"
%LOGCAT_CMD% shell "rm -rf /data/anr/*"
%LOGCAT_CMD% shell "rm -rf /data/hifi/*"
%LOGCAT_CMD% shell "rm -rf /data/ap-log/*"
%LOGCAT_CMD% shell "rm -rf /data/cp-log/*"
%LOGCAT_CMD% shell "rm -rf /data/hifi-log/*"
%LOGCAT_CMD% shell "rm -rf /data/log/archive/*"
%LOGCAT_CMD% shell "rm -rf /data/log/backup/*"
%LOGCAT_CMD% shell "rm -rf /sdcard/log/archive/*"
%LOGCAT_CMD% shell "rm -rf /sdcard/log/backup/*"
%LOGCAT_CMD% shell "rm -rf /sdcard/log/modem/*"
%LOGCAT_CMD% shell "rm /sdcard/log/modem/balong_track.txt"
%LOGCAT_CMD% shell "rm /data/klog/*.log"
%LOGCAT_CMD% shell "rm -rf /data/memorydump/*"
%LOGCAT_CMD% shell "rm -rf /sdcard/log/manual-AP/*"
%LOGCAT_CMD% shell "rm -rf /data/adb/*"
%LOGCAT_CMD% shell "rm -rf /data/dumplog/*"
%LOGCAT_CMD% shell "rm -rf /data/rdr/*"
%LOGCAT_CMD% shell "rm -rf /data/factory-modemlog/*"
%LOGCAT_CMD% shell "rm -rf /sdcard/log.png"
%LOGCAT_CMD% shell "rm -rf /sdcard/LogService/*"
%LOGCAT_CMD% shell "rm -rf /storage/sdcard1/LogService/*"
%LOGCAT_CMD% shell "rm -rf /data/hisi_logs/*"
%LOGCAT_CMD% shell "rm -rf /data/hwzd_logs/*"
%LOGCAT_CMD% logcat -c
pause

