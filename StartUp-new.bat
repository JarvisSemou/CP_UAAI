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
:methodBrach
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
	@rem if "%~2"=="installApp_t_1" (
	@rem 	setlocal enableDelayedExpansion
	@rem 	goto installApp_t_1
	@rem )
	@rem if "%~2"=="installApp_t_2" (
	@rem 	setlocal enableDelayedExpansion
	@rem 	goto installApp_t_2
	@rem )
	if "%~2"=="pushFiles" goto pushFiles
	if "%~2"=="applicationOperation" goto applicationOperation
	if "%~2"=="openSettingActivity" goto openSettingActivity
	if "%~2"=="faild" goto faild
	if "%~2"=="showDefaultPage" goto showDefaultPage
	if "%~2"=="detectDevice" (
		setlocal enableDelayedExpansion
		goto detectDevice
	)
goto eof

:initStaticValue
	@rem 当前工作根路径
	set rootPath=%~dp0
	set path=%rootpath%bin;!path!
	set tmpdir=%temp%\tmpdir
	set listtmp=%tmpdir%\list
	goto methodBrach
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
	@rem 启动后台设备检测线程
	start /b %~nx0 void detectDevice
	cls
	call %~n0 void showDefaultPage
	@rem 根据设备检测线程的状态更新界面
	:main_loop_1
	if exist "%tmpdir%\bg_t_sata" (
		set /p tmp_boolean_1=<bg_t_sata
		if "!tmp_boolean_1!"=="true" (
			if exist "%tmpdir%\newPage" (
				cls
				for /f %%t in (%tmpdir%\newPage) do echo %%t
				echo false>%tmpdir%\bg_t_sata
			)
		)
	)
	choice /d y /t 1 /n 1>nul
goto main_loop_1


@rem ================= 旧 =====================================================
	@rem :main_loop_1
	@rem 每秒刷新连接设备列表
	cls
	echo ------------------------------------------------------------------------
	echo ----------------------------- 当前设备列表 -----------------------------
	set array_temp_serial=null
	set array_devices_serial=null
	set tmp_int_1=0
	if "!array_processing_serial!" neq "null" (
		for %%t in (!array_processing_serial!) do set /a tmp_int_1=!tmp_int_1!+1
	) 
	echo 当前正常连接设备数量： !tmp_int_1!
	for /f "skip=1 tokens=1,2 delims=	" %%i in ('adb.exe devices') do (
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
	choice /d y /t 1 /n 1>nul
	goto main_loop_1
	
goto eof

@rem Show default page
@rem 
@rem return void
:showDefaultPage
	echo ------------------------------------------------------------------------
	echo ----------------------------- 当前设备列表 -----------------------------
	echo 当前正常连接设备数量： 0
goto eof

@rem Detect device and notic main thread update page
@rem 
@rem return void
:detectDevice
	@rem 当前正在处理的设备的序列号列表
	set array_processing_serial=null
	@rem 当前连接到电脑的设备序列号列表（无视状态）
	set array_devices_serial=null
	:detectDevice_loop_1
		set array_temp_serial=null
		set array_devices_serial=null
		for /f "skip=1 tokens=1,2 delims=	" %%i in ('adb.exe devices') do (
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
		choice /d y /t 1 /n 1>nul
	goto detectDevice_loop_1
goto eof

@rem Verify path legitimacy,if the path contain blackspace,the application will not work
@rem 
@rem return boolean if the path is not have blackspace that will return true,otherwise return false
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

@rem Resata adb.exe
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
	echo true>%tmpdir%\isUpdateUI
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
		if "%~3" neq "" (
			set result=
			goto getSatuMappedName_b_1==================================没写完,显示子线程写入的自定义内容
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
	call %~n0 boolean applicationOperation %~3
	if "!boolean!"=="false" goto faild
	echo -------------------------------
	call %~n0 boolean installApp %~3
	if "!boolean!"=="false" goto faild
	echo -------------------------------
	@rem call %~n0 boolean pushFiles %~3
	@rem if "!boolean!"=="false" goto faild
	@rem echo -------------------------------
	@rem call %~n0 boolean applicationOperation %~3
	@rem if "!boolean!"=="false" goto faild
	@rem echo -------------------------------
	call %~n0 void openSettingActivity %~3
	echo -------------------------------
	title [%~3] --- complete
	color 2f
	call %~n0 void setDeviceOptSatu %~3 complete
	choice /d y /t 5 /n 1>nul
	goto close
goto eof

@rem Install application
@rem 
@rem return boolean If success that will return true,otherwise return false 
@rem param_3 string Device serial number
:installApp
	set result=true
	@rem 要安装的总数
	@rem set tmp_int_1=0
	@rem 目前安装的数量
	set tmp_int_2=0
	set tmp_int_3=0
	@rem for %%t in (.\app\*.apk) do (
	@rem 	set /a tmp_int_1= !tmp_int_1! + 1
	@rem )
	echo 准备开始安装应用。。。。
	adb.exe -s %~3 shell rm /data/local/tmp/*
	for %%t in (.\app\*.apk) do (
		set /a tmp_int_3= !tmp_int_3! + 1
		adb.exe -s %~3 push ".\app\%%~nxt" /sdcard/%%~nxt
		@rem start /min %~n0 void installApp_t_1 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt" "/sdcard/%%~nxt"
		@rem start /min %~n0 void installApp_t_2 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt"
		adb.exe -s %~3 shell pm install /sdcard/%%~nxt
		echo 第 !tmp_int_3! 个应用 %%~nxt 安装完成
	)
	@rem :installApp_l_1
	@rem set tmp_int_3=0
	@rem for /f %%i in ('adb.exe -s %~3 shell ls /data/local/tmp/installApp_install_*_done') do (
	@rem 	set /a tmp_int_3= !tmp_int_3! + 1
	@rem )
	@rem if "!tmp_int_3!"=="!tmp_int_1!" goto :installApp_b_1
	@rem set tmp_int_2=!tmp_int_3!
	@rem echo 已安装 !tmp_int_1! 个应用
	@rem choice /d y /t 2 /n 1>nul
	@rem goto installApp_l_1
	@rem echo %%~t !tmp_int_1! 个应用安装完成
	@rem :installApp_b_1
	set %~1=!result!
goto eof

@rem 子线程，复制掌机临时目录的应用到 /sdcard 路径
@rem 
@rem return void
@rem param_3 string Device serial number
@rem param_4 int 当前文件编号
@rem param_5 string 原始路径
@rem param_6 string 目标路径
@rem :installApp_t_1
	@rem adb.exe -s %~3 shell cp %~5 %~6
	@rem adb.exe -s %~3 shell touch /data/local/tmp/installApp_appcopy_%~4_done
	@rem goto close
@rem goto eof

@rem 子线程，安装掌机临时目录下的应用并判断应用是否成功从临时目录复制到 /sdcard 路径
@rem 
@rem return void 
@rem param_3 string Device serial number
@rem param_4 int 当前文件编号
@rem param_5 string 安装包路径
@rem :installApp_t_2
	@rem adb.exe -s %~3 shell pm install %~5
	@rem set tmp_boolean_1=false
	@rem :installApp_t_2_l_1
	@rem adb.exe -s %~3 shell ls /data/local/tmp/installApp_appcopy_%~4_done|findstr data/local/tmp/installApp_appcopy_%~4_done
	@rem if "%errorlevel%"=="0" goto installApp_t_2_l_2
	@rem choice /d y /t 1 /n 1>nul
	@rem goto installApp_t_2_l_1
	@rem :installApp_t_2_l_2
	@rem adb.exe -s %~3 shell touch /data/local/tmp/installApp_install_%~4_done
	@rem goto close
@rem goto eof

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
	choice /d y /t 5 /n 1>nul
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