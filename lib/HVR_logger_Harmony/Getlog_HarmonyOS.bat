@echo off
:: ================================ 修订记录 =======================================
:: 2014-01-20  3.1
::                *  中文全部替换成英文
::                *  add screencap 
::                *  remove ping cmd when get d sysrq 
::                *  add colors 
::                *  add new modem log
::                *  add screencap 
::                *  add delete option
::                *  add adb detect
:: 2014-01-27  3.2
::                *  fix ls list /sdcard directory fail
::                *  add modem_state log
::                *  add k3v3 sec os log
:: 2014-01-27  3.3
::                *  delete logservice log
::                *  add delete options for product line
:: 2014-02-19  3.4
::                *  support recovery mod
::                *  move logserver log to new directory
::                *  remove nvme
:: 2014-02-25  3.5
::                *  support new modem_state
::                *  get all modem_om/balong_om/log
::
:: 2014-03-10  3.6
::                *  get via modem log
::                *  get all log from /sdcard/log /data/log
::                *  support all init service status print
:: 2014-03-24  3.7
::                * add /data/modemlog/Log
::                * add /data/hifi log
::                * add etb log 
::                * change modem_om/balong/log to /modem_om /modem_log
:: 2014-04-10  3.8
::                * fix user phone get log failed, delete ls directory 
::                * add hifi log trigger
::                * add unified log directory
:: 2014-04-15  3.9
::                * remove secos log
::                * add delete hwzd_logs hisi_logs
:: 2014-04-26  3.10
::                * add k3v3 boardid
::                * delete all modem log
:: 2014-05-19  3.11
::                *  support boardid & boardname & modemid
:: 2014-07-12  3.12
::                *  auto renname folder for serial no
:: 2014-12-02  3.13
::                *  add hifi log
:: 2014-12-09  3.15
::                *  support hdb
:: 2015-02-25  3.18
::                *  add beta club
:: 2015-03-02  3.19
::                *  enhance hdb compatibility
:: 2015-03-12  3.20
::                *  support grab tcp dump
:: 2015-04-08  3.21
::                *  grab bugreport concurrently
:: 2015-05-03  3.22
::                *  support austin 
:: 2015-06-11  3.23
::                *  support hisi dump
:: 2015-06-15  3.24 
::                *  add sensorhub log
:: 2015-06-15  3.25 
::                *  adapt bl31 new dump addression
:: 2015-07-01  3.26
::                *  add dump modem_dt.bin
:: 2015-07-30  3.27
::                *  adapt new modem address
::                *  add sec log
:: 2015-08-29  3.28
:: 		  *  change dump mem addr
:: 		  *  hisi_logs to top
:: 		  *  add pstore
:: 2015-09-11  3.29
::                *  fix bugreport timeout issue
:: 2015-11-23  3.30
::                *  support product and serialno for folder name
:: 2015-11-24  3.31
::                *  add ims log
:: 2016-03-07  3.32
::                *  add new ims log
:: 2016-04-06  3.33
::                *  update dump config, add chicago dump
::                *  delete hdb
:: 2016-05-16  3.34
::                *  fastboot get log support Chicago platform
:: 2016-05-30  3.35
::                *  rename logserver-log
:: 2016-06-17  3.36
::                *  update dump to latest version, fastboot log support clock and regulator tracing
:: 2016-06-23  3.37
::                *  update bl31 dump to latest version
:: 2016-06-23  3.50
::                *  using HiBbox to get fastboot ddr dump and parse blackbox.
::                *  HiBbox version : V2.0.4 - 6/16
:: 2016-07-13  3.51
::                *  support dump hifi log
:: 2016-08-11  3.52
::                *  update HiBbox to v2.0.6 - 7/20
set ver_str=3.52

:: echo Current: %time% 即 %time:~0,2%点%time:~3,2%分%time:~6,2%秒%time:~9,2%厘秒@
echo ####Current: %date% %time%
set date_time="%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
set Folder="Logs_%ver_str%_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
echo ####start to get log to (%CD%\%Folder%)...
mkdir %Folder%

:: fastboot dumpkernel
set fastboot_cmd=configs\\fastboot64
if not exist %fastboot_cmd%.exe (
  echo !!!!!!!!!!!!!!!!!cant find fastboot64 cmd!!!!!!!!!!!!1!!!
  goto USE_HDB
)

set bbox_cmd=HiBbox
if not exist %bbox_cmd%.exe (
    echo !!!!!!!!!!!!!!!!!cant find HiBbox.exe!!!!!!!!!!!!!!!!
    goto USE_HDB
)

%fastboot_cmd% devices|findstr /e fastboot
if %errorlevel% EQU 1 (
  goto USE_HDB
)

echo =============================================
echo ====in fastboot mode, first dump DDR DUMP====
echo =============================================

mkdir %Folder%\00_ddrdump

%fastboot_cmd% getvar product 2>pro.txt
for /f "tokens=2 delims= " %%i in ('findstr product pro.txt') do set platform=%%i
del pro.txt

echo platform = %platform%

call :Detect_plat %platform%

for %%a in (hi3660,hi3650,hi6250) do if "%platform%" == "%%a" (
    if "%platform%" == "hi6250" (
	  call :dump_accord_plat Dallas
	)
	if "%platform%" == "hi3650" (
	  call :dump_accord_plat Austin
	)
	if "%platform%" == "hi3660" (
	  call :dump_accord_plat Chicago
	)
)
  
%fastboot_cmd% -i 0x12d1 oem boot

echo ======================parse blackbox        =====================
call %bbox_cmd% parse %Folder%\00_ddrdump

echo ======================please wait for reboot=====================
ping 127.0.0.1 -n 40 >nul

echo ======================Will get adb logs     =====================
ping 127.0.0.1 -n 10 >nul


:: hdb check
:USE_HDB
set LOGCAT_CMD=adb
for /F "delims=" %%i in ("%LOGCAT_CMD%.exe") do if not exist %%~$PATH:i (
  echo can't find hdb command, try adb 
  goto USE_ADB
)
%LOGCAT_CMD% start-server
echo =====================GetLog version %ver_str% ================================

%LOGCAT_CMD% shell date
if %errorlevel% NEQ 0 (
  echo ####find devices ................start hdb failed ......................
  goto USE_ADB
)
%LOGCAT_CMD% devices|findstr /e device
if %errorlevel% EQU 0 (
  echo ####find devices ................ [hdb device] .........................
  goto START
)
%LOGCAT_CMD% devices|findstr /e recovery
  if %errorlevel% EQU 0 (
  echo ####find devices ................ [hdb recovery] .........................
  goto START
)

:USE_ADB
echo ####change to adb port for logcat
set LOGCAT_CMD=adb
for /F "delims=" %%i in ("%LOGCAT_CMD%.exe") do if not exist %%~$PATH:i (
  echo can't find adb command 
  goto USE_ADB
)
%LOGCAT_CMD% start-server
%LOGCAT_CMD% devices|findstr /e device
if %errorlevel% EQU 0 (
  echo ####find devices ................ [adb device] .........................
  goto START
)
%LOGCAT_CMD% devices|findstr /e recovery
if %errorlevel% EQU 0 (
  echo ####find devices ................ [adb recovery] .........................
  goto START
)


echo  !!!!!!!!!!!!!!!!!Can't find device!!!!!!!!!!!!!!!!!!!
goto END

:dump_accord_plat
echo start getting [%1] dump.
set sn=
for /f "tokens=1" %%i in ('%fastboot_cmd% devices') do (
  set sn=%%i
)
%fastboot_cmd% oem ddrdump show > %Folder%\00_ddrdump\ddrdump_SN%sn%.txt 2>&1
copy %Folder%\00_ddrdump\ddrdump_SN%sn%.txt ddrdump_SN%sn%.txt
for /f "skip=1 tokens=3,5,7 delims=:, " %%i in (ddrdump_SN%sn%.txt) do (
  if not "%%k" equ "" (%fastboot_cmd% oem memupload %%i %%j %Folder%\00_ddrdump\%%k.bin)
)
del ddrdump_SN%sn%.txt
%fastboot_cmd% oem dump-emmc dfx %Folder%\00_ddrdump\dfx.bin
echo check whether remainder memory is low.
call %bbox_cmd% wholeDDR %Folder%
goto :eof

REM =====detect plat======
:Detect_plat
set plat=hi6210hi6220hi3635hi3650hi3660
:error_again
echo %plat%|findstr %1>nul&&goto start_dump
echo %plat%|findstr %1>nul||echo on which plat are you running?&&echo 1.Austin&&echo 2.Seattle&&echo 3.Portland&&echo 4.Chicago&&set /p plat_form=
if "%plat_form%" == "1" (
  set platform=hi3650
) else (
    if "%plat_form%" equ "2" (
	  set platform=hi3635
    ) else (
        if "%plat_form%" equ "3" (
		  set platform=hi6220
        ) else (
            if "%plat_form%" equ "4" (
              set platform=hi3660
            ) else (
            echo error input,select again.
            goto :error_again
            )
        )
    )
)
:start_dump
goto :eof

:START

for /f "delims=" %%a in ('%LOGCAT_CMD% shell getprop ro.product.model') do set model=%%a
for /f "delims=" %%b in ('%LOGCAT_CMD% shell getprop ro.serialno') do set serialno=%%b
set newFolder="Logs_%ver_str%_%model%_BSN_%serialno%_Logs_%ver_str%_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
echo "111111111111111111111111111111111111111111111111111111111111111111111111111" 
echo %Folder% 
echo %newFolder%
REN %Folder% %newFolder%
set Folder=%newFolder%
echo %Folder% 
::======================capture bugreport===================================
echo ####get bugreport to .\bugreport.txt at background
%LOGCAT_CMD% shell rm -rf /sdcard/bugreport.txt
start /b %LOGCAT_CMD% shell "mkdir -p /sdcard/bugreport_tmp/ && bugreport > /sdcard/bugreport_tmp/bugreport.txt && mv /sdcard/bugreport_tmp/bugreport.txt /sdcard/ && rm -rf /sdcard/bugreport_tmp/"

::======================board id============================================
:: get board id
echo ####get boardid to boardid.txt
echo boardid sequence:                       boardid_0  boardid_1  boardid_2 > %Folder%/boardid.txt
%LOGCAT_CMD% shell cat /dev/boardconfig_fs | findstr "hisi,boardid" >> %Folder%/boardid.txt
echo ####get boardname to boardname.txt
%LOGCAT_CMD% shell cat /dev/boardconfig_fs | findstr "hisi,boardname" > %Folder%/boardname.txt
echo ####get modemid to modemid.txt
%LOGCAT_CMD% shell cat /dev/boardconfig_fs | findstr "hisi,modem_id" > %Folder%/modemid.txt
%LOGCAT_CMD% pull /proc/device-tree/hisi,boardid %Folder%\26_boardid.txt
%LOGCAT_CMD% shell cat /proc/device-tree/hisi,boardname > %Folder%\29_boardname.txt
:: =====================Enable sensorhub log================================
%LOGCAT_CMD% shell "echo 1 > /sys/devices/platform/huawei_sensorhub_logbuff/logbuff_config"

::======================Android light log===================================
:: common logs from android
%LOGCAT_CMD% shell cat /sys/devices/amba.0/e804e000.hifidsp/dspdumplog
%LOGCAT_CMD% shell cat /sys/devices/amba.0/0.hifidsp/dspdumplog
%LOGCAT_CMD% shell cat /proc/hifidebug/dspdumplog
%LOGCAT_CMD% shell "echo 15 > /proc/hi64xxdbg/hi64xxdebug"
echo ####get dmesg to dmesg.txt ...
%LOGCAT_CMD% shell  dmesg > %Folder%\dmesg.txt
echo ####get ps list to ps.txt ...
%LOGCAT_CMD% shell  ps -p -P -c > %Folder%\ps.txt
echo ####get ps thread list to ps_t.txt ...
%LOGCAT_CMD% shell  ps -p -P -c -t > %Folder%\ps_t.txt
echo ####get properties to prop.txt ...
%LOGCAT_CMD% shell  getprop > %Folder%\prop.txt
echo ####get cmdline to cmdline.txt ...
%LOGCAT_CMD% shell  cat /proc/cmdline > %Folder%\cmdline.txt
echo ####get main logcat to logcat.txt ...
%LOGCAT_CMD% shell  logcat -v threadtime -d -t 1000 > %Folder%\logcat.txt
echo ####get main logcat to logcat.txt ...
%LOGCAT_CMD% shell  logcat -v threadtime -b events -d -t 1000 > %Folder%\logcat_events.txt
echo ####get dontpanic to .\dontpanic ...
%LOGCAT_CMD% pull   /data/dontpanic/  %Folder%\dontpanic\
echo ####get pstore to .\pstore
%LOGCAT_CMD% pull   /sys/fs/pstore  %Folder%\pstore\
echo ####get dropbox to .\dropbox ...
%LOGCAT_CMD% pull   /data/system/dropbox/  %Folder%\dropbox\
echo ####get tombstones to .\tombstones ...
%LOGCAT_CMD% pull   /data/tombstones/  %Folder%\tombstones\
echo ####get data file list to .\userdata_check.txt ...
%LOGCAT_CMD% shell ls -lR /data  > %Folder%/userdata_check.txt
echo ####get system file list to .\system_check.txt
%LOGCAT_CMD% shell ls -lR /system > %Folder%/system_check.txt
echo ####get D state process to dmesg_sysrq.txt ...
%LOGCAT_CMD% shell "echo 1 > /proc/sys/kernel/sysrq"
%LOGCAT_CMD% shell "echo w > /proc/sysrq-trigger"
%LOGCAT_CMD% shell  dmesg > %Folder%/dmesg_sysrq.txt
echo ####get all init service status to .\dmesg_service.txt
%LOGCAT_CMD% shell setprop sys.printservice all
%LOGCAT_CMD% shell dmesg > %Folder%/demsg_service.txt
echo ####get balong_power modem_state to .\modem_state.txt
%LOGCAT_CMD% shell ls /sys/devices/platform/balong_power/ | findstr /X modem_state
if %errorlevel% EQU 0 (
  %LOGCAT_CMD% shell cat /sys/devices/platform/balong_power/modem_state > %Folder%\modem_state.txt
) else (
  %LOGCAT_CMD% shell cat /sys/devices/platform/balong_power/state > %Folder%\modem_state.txt
)
%LOGCAT_CMD%  shell cat /sys/block/mmcblk0/device/name > %Folder%\emmc_manufacture.txt
:: ======================TERMINL LOG========================================
:: get huawei persist log 
echo ####get android_logs to .\android_logs ...
::%LOGCAT_CMD% pull   /data/log/android_logs/ %Folder%/android_logs/
%LOGCAT_CMD% pull   /data/log/hilogs/ %Folder%/android_logs/

::判断是否出现应用ANR
SET findAppANR=0
setlocal enabledelayedexpansion
if exist %Folder%\anr\traces.txt (
  SET findAppANR=1
)
for /f %%d in ('dir /b/d/o-d %dropbox_folder%\*.txt.gz') do (
  SET file_name=%%d
  if "!file_name:~0,14!"=="system_app_anr" (
    SET findAppANR=1
  )
)
for /f %%d in ('dir /b/d/o-d %dropbox_folder%\*.txt') do (
  SET file_name=%%d
  if "!file_name:~0,14!"=="system_app_anr" (
    SET findAppANR=1
  )
)
if %findAppANR%==1 (
  echo ※※※※※※System Application ANR had happended.※※※※※※
)

::判断是否出现应用crash
SET findAppCrash=0
setlocal enabledelayedexpansion
for /f %%d in ('dir /b/d/o-d %dropbox_folder%\*.txt.gz') do (
  SET file_name=%%d
  if "!file_name:~0,16!"=="system_app_crash" (
    SET findAppCrash=1
  )
)
for /f %%d in ('dir /b/d/o-d %dropbox_folder%\*.txt') do (
  SET file_name=%%d
  if "!file_name:~0,16!"=="system_app_crash" (
    SET findAppCrash=1
  )
)

if %findAppCrash%==1 (
  echo ◇◇◇◇◇◇Application crash had happended.◇◇◇◇◇◇
)

echo ====================history.log========================
::adb shell cat /data/log/hisi_logs/history.log

set CURRENT_PATH=%~dp0
if not exist %CURRENT_PATH%\out md %CURRENT_PATH%\out

python log_all_in_one.py

rd /s /q %Folder%
:END
pause