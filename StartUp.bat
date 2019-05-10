@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::																	::
@rem ::		  					CP_UAAI									::
@rem ::																	::
@rem ::											Author: Mouse.JiangWei	::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem 
@rem Some rules of development:
@rem 	1.Variable name using camel rule,the object start with underline
@rem 	2.Using double underline __ end of an array variable name,the 
@rem 	  array element sparate with blackspace
@rem 	3.StartUp script have to enable delayed expansion and other prohibition
@rem 	4.Universalize to use UNICODE character set
@rem		5.Universalize to explanation the script intent and meaning of parameter
@rem		  what scritp accepted at scritp top unless script have not parameter
@rem		6.Value object name start with vo_
@rem		7.The base data type is void,int,boolean,string,vo
@rem		8.Temporary value start with tmp_.Currently have 5 type:tmp_any,tmp_int,tmp_boolean,tmp_string,tmp_vo.
@rem			There are four child temporary variables for each type.
@rem
@rem			tmp_any ---- can save any value,maybe string,maybe int or boolean,value object
@rem					child variable:tmp_any_1,tmp_any_2,tmp_any_3,tmp_any_4
@rem
@rem			tmp_int ---- save int value what you want 
@rem					child variable:tmp_int_1,tmp_int_2,tmp_any_3,tmp_any_4
@rem
@rem			tmp_boolean ---- save boolean value
@rem					child variable:tmp_boolean_1,tmp_boolean_2,tmp_boolean_3,tmp_boolean_4
@rem
@rem			tmp_string ---- save string
@rem 				child variable:tmp_string_1,tmp_string_2,tmp_string_3,tmp_string_4
@rem
@rem			tmp_vo ---- temporary value object
@rem					child variable:tmp_vo_1,tmp_vo_2,tmp_vo_3,tmp_vo_4
@rem 		resutl ---- This is a special tmp value,you can use it when return value
@rem 
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@rem Initalization of install scritp,it will call approptiate core according to 
@rem system environment.Currently it just distinguish  win 10,win 8,win 7,win vista,
@rem and win xp system.It will call 1.0.39 version adb tool for  win 10,win 8,win 7,
@rem ,and call 1.0.31 version adb tool for win vista and win xp system.

@rem win 10		10.0*
@rem	win 8		6.[23]*
@rem	win 7		6.1.*
@rem	win vista	6.0
@rem	win xp		5.[1-2]
@rem	win 2000	5.0

if "%~2"=="" (
	setlocal enableDelayedExpansion
	goto initStaticValue
)
:methodBranch
if "%~2"=="" goto main
if "%~2"=="isPathLegitimate" goto isPathLegitimate
if "%~2"=="restartAdb" goto restartAdb
if "%~2"=="setDeviceOptSatu" goto setDeviceOptSatu
if "%~2"=="getDeviceOptSatu" goto getDeviceOptSatu
if "%~2"=="getSatuMappedName" goto getSatuMappedName
if "%~2"=="coreEntry" (
	setlocal enableDelayedExpansion
	goto coreEntry
)
if "%~2"=="installApp" goto installApp
if "%~2"=="pushFiles" goto pushFiles
if "%~2"=="applicationOperation" goto applicationOperation
if "%~2"=="openSettingActivity" goto openSettingActivity
if "%~2"=="faild" goto faild
goto eof

:initStaticValue
@rem 当前工作根路径
set rootPath=%~dp0
set path=%rootpath%bin;!path!
set tmpdir=%temp%\tmpdir
set listtmp=%tmpdir%\list
goto methodBranch
goto eof

:main
echo [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[@
echo                                                                                      @
echo                                                                                      @
echo                                                                                      @
echo                                                                                      @
echo                                                                                      @
echo         ]@@@@@`  @@@@@\]`           ,@@@     /@@.     =@@@`        .@@@\      @@@    @
echo      ,@@@@@@@@@  @@@@@@@@@^^         =@@@     @@@.    ,@@@@@        /@@@@^^     @@@    @
echo     =@@@.        @@@   =@@@         =@@@     @@@.   .@@@=@@^^      =@@^^@@@.    @@@    @
echo     @@@^^         @@@  ,@@@/         =@@@     @@@.   /@@` @@@`    ,@@/ =@@\    @@@    @
echo     @@@^^         @@@@@@@/`          ,@@@     @@@.  =@@\]]/@@@.  .@@@]]]/@@^^   @@@    @
echo     =@@@`     .  @@@                 @@@^^   ,@@@  ,@@@@@@@@@@\  /@@@@@@@@@@`  @@@    @
echo      ,@@@@@@@@@  @@@                 ,@@@@@@@@@.  @@@`     @@@^^=@@@     =@@@  @@@    @
echo         .[[[[.   **,                    ,[[[`    ,**`      .`*`,*,.      ,*,. **,    @
echo                                                                                      @
echo                            \@@@@@@@^^                                                 @
echo                                                                                      @
echo                                                                                      @
echo                                                                                      @
echo                                                             Mouse.JiangWei           @
echo                                                                                      @
echo                                                                                      @
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo 脚本启动中。。。
cd /d %rootPath%
@rem 检测路径是否包含空格
call %~n0 boolean isPathLegitimate
if "!boolean!"=="false" (
	echo 当前路径 “%~dp0” 包含空格，请将此脚本应用放到无空格的路径中再运行
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 按任意键退出
	pause 1>nul
	goto eof
)
call %~n0 boolean restartAdb
@rem 尝试 3 次关闭 adb
if "!boolean!"=="false" call %~n0 boolean restartAdb
if "!boolean!"=="false" call %~n0 boolean restartAdb
if "!boolean!"=="false" call %~n0 boolean restartAdb
if "!boolean!"=="false" call %~n0 boolean restartAdb
if "!boolean!"=="false" (
	echo 启动脚本时无法启动 adb 程序，请检查：
	echo 	1、adb 的 5037 端口是否被占用（可能别的 adb 程序正在运行）
	echo	2、是否开启了各种流氓手机管家
	echo  
	echo 按任意键退出
	pause >nul
	goto eof
)
if exist "%tmpdir%" rd /s /q "%tmpdir%" >nul
mkdir %tmpdir%
mkdir %listtmp%
@rem 当前正在处理的设备的序列号列表
set array_processing_serial=null
@rem 当前连接到电脑的设备序列号列表（无视状态）
set array_devices_serial=null
:main_loop_1
	@rem 每秒刷新连接设备列表
	cls
	echo ------------------------------------------------------------------------
	echo ----------------------------- 当前设备列表 -----------------------------
	set array_temp_serial=null
	set array_devices_serial=null
	adb.exe devices >%tmpdir%\devices
	for /f "skip=1 tokens=1,2 delims=	" %%i in (%tmpdir%\devices) do (
		set tmp_string_1=null
		if not exist "%listtmp%\%%i" (
			call %~n0 void setDeviceOptSatu %%~i %%~j
		) else (
			call %~n0 string getSatuMappedName !string!
			if "!string!"=="unauthorized" call %~n0 void setDeviceOptSatu %%~i %%~j
			if "!string!"=="device" call %~n0 void setDeviceOptSatu %%~i %%~j
			if "!string!"=="offline" call %~n0 void setDeviceOptSatu %%~i %%~j
		)
		call %~n0 string getDeviceOptSatu %%~i
		call %~n0 string getSatuMappedName !string!
		set tmp_string_1=!string!
		@rem  处理实时的设备列表
		echo %%~i	!tmp_string_1!
		if "!array_devices_serial!" neq "null" (
			set array_devices_serial=!array_devices_serial!,"%%~i"
		) else (
			set array_devices_serial="%%~i"
		)
		@rem 标志设备是否为新加入的设备，true 标识设备是新加入的设备，false 为正在处理中的设备，默认为 true
		set isNew=true
		if "%%~j"=="device" (
			if "!array_temp_serial!" neq "null" (
				set array_temp_serial=!array_temp_serial!,"%%~i"
			) else (
				set array_temp_serial="%%~i"
			)
			if "!array_processing_serial!" neq "null" (
				for %%o in (!array_processing_serial!) do (
					if "%%~i"=="%%~o" set isNew=false
				)
				if "!isNew!"=="true" start /min %~n0 void coreEntry %%~i
			) else (
				start /min %~n0 void coreEntry %%~i
			)
		)
	)
	set array_processing_serial=!array_temp_serial!
	for %%i in (%listtmp%\*) do (
		set tmp_boolean_1=false
		for %%o in (!array_devices_serial!) do (
			if "%%~ni"=="%%~o" set tmp_boolean_1=true
		)
		if "!tmp_boolean_1!"=="false" del /f /q "%listtmp%\%%~ni"
	)
	@rem 等待一秒
	ping -n 1 127.0.0.1>nul 1>nul
goto main_loop_1
goto eof

@rem Verify path legitimacy,if the path contain blackspace,the application will not work
@rem 
@rem return boolean if the path is not have blackspace that will return ture,otherwise return false
:isPathLegitimate
@rem @call %~f0 boolean isPathLegitimate 1>nul 2>nul
@rem set %1=true
@rem if %errorlevel% geq 1 (
@rem 	set _LogUtil=.\core\lib\LogUtil.bat
@rem 	call !_LogUtil! void log %~n0 "Applicathin path:^"%~f0^" contain blackspace,application will not work."
@rem 	set %1=false
@rem )
set result=true
if not exist %~f0 set result=false
set %~1=!result!
goto eof

@rem Restart adb.exe
@rem 
@rem return boolean If restart adb.exe success that will return true,otherwise return false
:restartAdb
set result=true
@rem 强行关闭多余的 adb 
taskkill /f /im adb.exe 1>nul 2>nul
@rem 重新开启 adb 服务
adb.exe start-server 1>nul 2>nul
if %errorlevel% geq 1 (
	set result=false
)
set %~1=!result!
goto eof

@rem Set device option satu
@rem The option satu was:
@rem 	unauthorized	未验证
@rem	device			已连接
@rem	offline			已离线
@rem	script_running	脚本运行中
@rem	complete		完成
@rem	faild			失败
@rem 
@rem return void
@rem param_3 string Serial number
@rem param_4 string Statu
:setDeviceOptSatu
echo %~4>%listtmp%\%~3
goto eof

@rem Get device option satu
@rem 
@rem return string Statu
@rem param_3 string Serial number
:getDeviceOptSatu
set return=null
if exist "%listtmp%\%~3" (
	set /p result=<"%listtmp%\%~3"
)
set %~1=!result!
goto eof

@rem Get satu mapped name
@rem
@rem return string Mapped name
@rem param_3 string statu
:getSatuMappedName
set result=null
if "%~3" neq "" (
	if "%~3"=="null" ( 
		set result=正在获取状态。。。
		goto getSatuMappedName_b_1
	)
	if "%~3"=="unauthorized" ( 
		set result=未验证
		goto getSatuMappedName_b_1
	)
	if "%~3"=="device" (
		set result=已连接
		goto getSatuMappedName_b_1
	)
	if "%~3"=="offline" (
		set result=已离线
		goto getSatuMappedName_b_1
	)
	if "%~3"=="script_running" (
		set result=脚本运行中
		goto getSatuMappedName_b_1
	)
	if "%~3"=="complete" (
		set result=完成
		goto getSatuMappedName_b_1
	)
	if "%~3"=="faild" (
		set result=失败
		goto getSatuMappedName_b_1
	)
)
:getSatuMappedName_b_1
set %~1=!result!
goto eof

@rem
@rem return void
@rem param_3 string Serial number
:coreEntry
title [%~3] --- script_running
call %~n0 void setDeviceOptSatu %~3 script_running
echo ---------- 设备：%~3 ----------
call %~n0 boolean installApp %~3
if "!boolean!"=="false" goto faild
echo -------------------------------
call %~n0 boolean pushFiles %~3
if "!boolean!"=="false" goto faild
echo -------------------------------
call %~n0 boolean applicationOperation %~3
if "!boolean!"=="false" goto faild
echo -------------------------------
call %~n0 void openSettingActivity %~3
echo -------------------------------
title [%~3] --- complete
color 2f
call %~n0 void setDeviceOptSatu %~3 complete
ping -n 5 127.0.0.1 >nul 2>nul
goto close
goto eof

@rem Install application
@rem 
@rem return boolean If success that will return true,otherwise return false 
@rem param_3 string Device serial number
:installApp
set result=true
set tmp_int_1=0
for %%t in (.\app\*.apk) do (
	set /a tmp_int_1= !tmp_int_1! + 1
	echo 正在安装第 !tmp_int_1! 个应用：
	echo %%~t
	adb.exe -s %~3 install -r "%%~t"
	if %errorlevel% geq 1 (
		echo %%~t 安装失败
		set result=false
		goto installApp_b_1
	)
	echo %%~t 安装完成
)
:installApp_b_1
set %~1=!result!
:goto eof

@rem Push files to the devices
@rem
@rem return boolean If success to push than return true,otherwise return false
@rem param_3 string Device serial number
:pushFiles
set result=true
set tmp_int_1=0
for %%t in (.\files\*) do (
	set /a tmp_int_1= !tmp_int_1! + 1
	echo 正在推送第 !tmp_int_1! 个文件：
	echo %%~t
	adb.exe -s %~3 push "%%~t" /sdcard/%%~nxt
	if %errorlevel% geq 1 (
		echo %%~t 推送失败
		set result=false
		goto pushFiles_b_1
	)
	echo %%~t 推送完成
)
:pushFiles_b_1
set %~1=!result!
goto eof

@rem Applicathin operation for device by "input" command 
@rem Usage: input [<source>] <command> [<arg>...]
@rem 
@rem The sources are:
@rem       mouse
@rem       keyboard
@rem       joystick
@rem       touchnavigation
@rem       touchpad
@rem       trackball
@rem       stylus
@rem       dpad
@rem       touchscreen
@rem       gamepad
@rem 
@rem The commands and default sources are:
@rem       text <string> (Default: touchscreen)
@rem       keyevent [--longpress] <key code number or name> ... (Default: keyboard)
@rem       tap <x> <y> (Default: touchscreen)
@rem       swipe <x1> <y1> <x2> <y2> [duration(ms)] (Default: touchscreen)
@rem       press (Default: trackball)
@rem       roll <dx> <dy> (Default: trackball)
@rem
@rem 
@rem return boolean If success to excute operation file that return true,otherwise return false
@rem param_3 string Device serial number
:applicationOperation
adb.exe -s %~3 shell am force-stop com.android.settings
adb.exe -s %~3 shell input keyevent KEYCODE_WAKEUP
adb.exe -s %~3 shell input touchscreen swipe 300 460 300 0 150
set result=true
for %%t in (.\opt\*.bat) do (
	set tmp_string_1=%%~t
	call %%~ft void opt %~3
	if %errorlevel% geq 1 (
		echo %%~t 动作执行失败
		set result=false
		goto applicationOperation_b_1
	)
	echo %%~t 动作执行完成
)
:applicationOperation_b_1
set %~1=!result!
goto eof

@rem Open setting activity
@rem 
@rem return void
@rem param_3 string Device serial number
:openSettingActivity
adb.exe -s %~3 shell am force-stop com.android.settings
adb.exe -s %~3 shell input keyevent KEYCODE_WAKEUP
adb.exe -s %~3 shell input touchscreen swipe 300 460 300 0 150
adb.exe -s %~3 shell am start -n com.android.settings/com.android.settings.Settings
goto eof

@rem Script has error,than set consol mode
@rem
@rem return void
:faild
title [%~3] --- faild
color 7f
call %~n0 void setDeviceOptSatu %~3 faild
echo -------------------------------
echo 稍等脚本更新状态。。。
echo 待屏幕恢复黑色，拔掉 USB 线几秒后再重新连接
ping -n 5 127.0.0.1 >nul 2>nul
call %~n0 void setDeviceOptSatu %~3 device
color 0f
goto close
goto eof

@rem Close consol
@rem 
@rem return void
:close
exit
goto eof

:eof
