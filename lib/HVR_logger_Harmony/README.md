# Huawei VR Glass HarmonyOS Logger

### Introduction: ###

This PC tool logs Huawei VR Glass performance in HarmonyOS phone.

### Hardware and Software Requirements: ###

Windows 10 PC (Python, Batch Script), Huawei VR Glass, VR Glass compatible & rooted Huawei devices (China models only) with HarmonyOS 2.0+.

### Steps: ###

1. Download logger scripts here: https://github.com/hms-ecosystem/OpenXR-SDK/blob/main/lib/HVR_logger_Harmony
2. Make sure Python is installed and path configured on Windows 10 PC.
3. PC Batch Script requires a specific date-time format to output the log files, please configure PC date & time according to the format below:

    ```
    Short date: yyyy/MM/dd
    Long date: yyyy'year'M'month'd'day'
    Short date: h:mm:ss
    Long time: h:mm:ss:tt
    First day of week: Monday
    ```

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/region.png)

    Steps to configure your PC date and time format:

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/date_time.png)

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/date_time_settings.png)

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/region_formats.png)

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/customize_format_date.png)

    ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/customize_format_time.png)

4. Run/test your VR apps, games on Huawei VR Glass and rooted Huawei phones.
5. After the tests, connect Huawei phones to the PC using USB-C cable. Make sure USB mode is set to Transfer Files and Developer mode is enabled on the phone.
6. Open Command Prompt on PC, cd to HVR_logger_Harmony directory, run Getlog_HarmonyOS.bat script.

    ```
    C:\Users\xxxxx\Downloads\HVR_logger_Harmony>Getlog_HarmonyOS.bat
		####Current: 2021/12/23 22:25:59.79
		####start to get log to (C:\Users\xxxxx\Downloads\HVR_logger_Harmony\"Logs_3.52_20211223_222559")...
		!!!!!!!!!!!!!!!!!cant find fastboot64 cmd!!!!!!!!!!!!1!!!
		adb server version (39) doesn't match this client (41); killing...
		* daemon started successfully
		=====================GetLog version 3.52 ================================
		Thu Dec 23 22:26:28 PST 2021
		JQV01111120000037        device
		####find devices ................ [hdb device] .........................
		"111111111111111111111111111111111111111111111111111111111111111111111111111"
		"Logs_3.52_20211223_222559"
		"Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605"
		"Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605"
		####get bugreport to .\bugreport.txt at background
		####get boardid to boardid.txt
		cat: /dev/boardconfig_fs: No such file or directory
		####get boardname to boardname.txt
		=============================================================================
		WARNING: flat bugreports are deprecated, use adb bugreport <zip_file> instead
		=============================================================================
    cat: /dev/boardconfig_fs: No such file or directory
		####get modemid to modemid.txt
		cat: /dev/boardconfig_fs: No such file or directory
		adb: error: failed to stat remote object '/proc/device-tree/hisi,boardid': Permission denied
		cat: /proc/device-tree/hisi,boardname: Permission denied
		/system/bin/sh: can't create /sys/devices/platform/huawei_sensorhub_logbuff/logbuff_config: Permission denied
		cat: /sys/devices/amba.0/e804e000.hifidsp/dspdumplog: No such file or directory
		cat: /sys/devices/amba.0/0.hifidsp/dspdumplog: No such file or directory
		cat: /proc/hifidebug/dspdumplog: No such file or directory
		/system/bin/sh: can't create /proc/hi64xxdbg/hi64xxdebug: No such file or directory
		####get dmesg to dmesg.txt ...
		dmesg: klogctl: Operation not permitted
		####get ps list to ps.txt ...
		ps: Unknown option c (see "ps --help")
		####get ps thread list to ps_t.txt ...
		ps: Unknown option c (see "ps --help")
		####get properties to prop.txt ...
		####get cmdline to cmdline.txt ...
		cat: /proc/cmdline: Permission denied
		####get main logcat to logcat.txt ...
		####get main logcat to logcat.txt ...
		####get dontpanic to .\dontpanic ...
		adb: error: failed to stat remote object '/data/dontpanic/': No such file or directory
		####get pstore to .\pstore
		/sys/fs/pstore/: 0 files pulled, 0 skipped.
		####get dropbox to .\dropbox ...
		adb: error: failed to stat remote object '/data/system/dropbox/': Permission denied
		####get tombstones to .\tombstones ...
		/data/tombstones/: 0 files pulled, 0 skipped.
		####get data file list to .\userdata_check.txt ...
		ls: /data: Permission denied
		####get system file list to .\system_check.txt
		ls: /system/bin/AGPService: Permission denied
        .......................
		ls: /system/lib64/bootstrap: Permission denied
		####get D state process to dmesg_sysrq.txt ...
		/system/bin/sh: can't create /proc/sys/kernel/sysrq: Permission denied
		/system/bin/sh: can't create /proc/sysrq-trigger: Permission denied
		dmesg: klogctl: Operation not permitted
		####get all init service status to .\dmesg_service.txt
		setprop: failed to set property 'sys.printservice' to 'all'
		dmesg: klogctl: Operation not permitted
		####get balong_power modem_state to .\modem_state.txt
		ls: /sys/devices/platform/balong_power//uevent: Permission denied
		ls: /sys/devices/platform/balong_power//modem_state: Permission denied
		ls: /sys/devices/platform/balong_power//driver_override: Permission denied
		ls: /sys/devices/platform/balong_power//state: Permission denied
		ls: /sys/devices/platform/balong_power//modalias: Permission denied
		cat: /sys/devices/platform/balong_power/state: Permission denied
		cat: /sys/block/mmcblk0/device/name: Permission denied
		####get android_logs to .\android_logs ...
		/data/log/hilogs/: 115 files pulled, 0 skipped. 28.3 MB/s (63286133 bytes in 2.130s)
		File Not Found
		File Not Found
		File Not Found
		File Not Found
		====================history.log========================
		./
		Logs:
		        ./Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605\android_logs\hiapplogcat-log.I204.20211222-172951.gz
		        ./Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605\android_logs\hiapplogcat-log.I205.20211222-172957.gz
              ............................
		        ./Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605\android_logs\hiapplogcat-log.I252.20211223-222608.gz
		        ./Logs_3.52_OCE-AN50_BSN_JQV01111120000037_Logs_3.52_20211223_222605\android_logs\hiapplogcat-log.I253.20211223-222616.gz
		 have been merged into:
		         C:\Users\xxxxx\Downloads\HVR_logger_Harmony\out\2021-12-23_22-26-10.txt
		Press any key to continue . . .
    ```
7. The logs will be available in out folder
   
   ![](https://raw.githubusercontent.com/hms-ecosystem/OpenXR-SDK/main/lib/HVR_logger_Harmony/screenshots/out.png)

### Notes: ###
1.	Huawei VR Glass will only with China Huawei device models such as NOH-AN01 (Mate 40 Pro), etc.
2.	The logger ADB shell in Batch files can only work on rooted Huawei devices.
3.	Please make sure the date and time format is properly configured.
