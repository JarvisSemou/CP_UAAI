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

@rem 	win 10		10.0*
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
	if "%~2"=="printInitPage" goto printInitPage
	if "%~2"=="printPathErrPage" goto printPathErrPage
	if "%~2"=="printNostartAdbPage_1" goto printNostartAdbPage_1
	if "%~2"=="printNostartAdbPage_2" goto printNostartAdbPage_2
	if "%~2"=="printInitPluginConfigErrPage" goto printInitPluginConfigErrPage
	if "%~2"=="isPathLegitimate" goto isPathLegitimate
	if "%~2"=="is5037Occupied" goto is5037Occupied
	if "%~2"=="get5037ProcessName" goto get5037ProcessName
	if "%~2"=="restartAdb" goto restartAdb
	if "%~2"=="close5037ProcessByName" goto close5037ProcessByName
	if "%~2"=="initPluginConfig" goto initPluginConfig
	if "%~2"=="registPlugin" goto registPlugin
	if "%~2"=="createNewPluginConfigFile" goto createNewPluginConfigFile
	if "%~2"=="executeLifeCycle" goto executeLifeCycle
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
	if "%~2"=="lockScreenDirection" goto lockScreenDirection
	if "%~2"=="unlockScreenDirection" goto unlockScreenDirection
	if "%~2"=="openSettingActivity" goto openSettingActivity
	if "%~2"=="faild" goto faild
	if "%~2"=="showDefaultPage" goto showDefaultPage
	if "%~2"=="detectDevice" (
		setlocal enableDelayedExpansion
		goto detectDevice
	)
	if "%~2"=="calculateDifference" goto calculateDifference
goto eof

:initStaticValue
	@rem 当前工作根路径
	set rootPath=%~dp0
	set path=%rootpath%bin;!path!
	set tmpdir=%temp%\tmpdir
	set listtmp=%tmpdir%\list
	@rem onScriptFirstStart 生命周期的插件调用链
	set lifeCycle_onScriptFirstStart=null
	@rem onCoreStart 生命周期的插件调用链
	set lifeCycle_onCoreStart=null
	@rem onBeforeInstallingApp 生命周期的插件调用链
	set lifeCycle_onBeforeInstallingApp=null
	@rem onAfterInstallingApp 生命周期的插件调用链
	set lifeCycle_onAfterInstallingApp=null
	@rem onInstallAppCompleted 生命轴承的插件调用链
	set lifeCycle_onInstallAppCompleted=null
	@rem onBeforePushingFile 生命周期的插件调用链
	set lifeCycle_onBeforePushingFile=null
	@rem onAfterPushingFile 生命周期的插件调用链
	set lifeCycle_onAfterPushingFile=null
	@rem onCoreFinish 生命周期的插件调用链
	set lifeCycle_onCoreFinish=null
	goto methodBrach
goto eof

:main
	call %~n0 void printInitPage
	cd /d %rootPath%
	@rem 检测路径是否包含空格
	echo 检查脚本路径。。。
	call .\%~n0 boolean isPathLegitimate
	if "!boolean!"=="false" (
		call %~n0 void printPathErrPage
		goto eof
	)
	@rem 判断当前占用 5037 端口的进程
	echo 检查 5037 端口。。。
	call %~n0 boolean is5037Occupied
	if "!boolean!"=="true" (
		call %~n0 string get5037ProcessName
		if "!string!"=="adb.exe" (
			@rem adb 进程正在占用 5037 端口,尝试 3 次使用当前脚本的 adb 程序
			call %~n0 boolean restartAdb
			if "!boolean!"=="false" call %~n0 boolean restartAdb
			if "!boolean!"=="false" call %~n0 boolean restartAdb
			if "!boolean!"=="false" (
				call %~n0 void printNostartAdbPage_1
				goto eof
			)
		) else (
			@rem 非 adb 进程在占用 5037 端口，先尝试 3 此关闭占用 5037 端口的进程，如果失败则建议手动关闭相应进程
			call %~n0 boolean close5037ProcessByName "!string!"
			if "!boolean!"=="false" call %~n0 boolean close5037ProcessByName "!string!"
			if "!boolean!"=="false" call %~n0 boolean close5037ProcessByName "!string!"
			if "!boolean!"=="false" (
				call %~n0 void printNostartAdbPage_2 "!string!"
				goto eof
			)
		)
	)
	echo 初始化缓存目录。。。
	if exist "%tmpdir%" rd /s /q "%tmpdir%" >nul
	mkdir %tmpdir%
	mkdir %listtmp%
	echo 初始化插件。。。
	@rem 初始化插件配置
	call %~n0 boolean initPluginConfig
	if "!boolean!"=="false" (
		call %~n0 void printInitPluginConfigErrPage
		goto eof
	)
	echo 启动脚本。。。
	call %~n0 void executeLifeCycle "onScriptFirstStart" 
	@rem 启动后台设备检测线程
	start /b %~nx0 void detectDevice
	cls
	call %~n0 void showDefaultPage
	@rem 根据设备检测线程的状态更新界面
	:main_loop_1
	if exist "%tmpdir%\isUpdateUI" (
		set /p tmp_boolean_1=<isUpdateUI
		if "!tmp_boolean_1!"=="true" (
			if exist "%tmpdir%\newPage" (
				cls
				for /f %%t in (%tmpdir%\newPage) do echo %%t
				echo false>%tmpdir%\isUpdateUI
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
	@rem ================= 旧 =====================================================
goto eof

@rem Show default page
@rem 
@rem return void
:showDefaultPage
	echo -----------------------------   状态信息   -----------------------------
	echo 1>nul
	echo 当前正常连接设备数量： 0
	echo 1>nul
	echo -----------------------------   设备列表   -----------------------------
goto eof

@rem Detect device and notice main thread update page
@rem 
@rem return void
:detectDevice
	@rem 当前正在运行脚本的设备的序列号列表，其元素的状态是'device'
	set array_processing_serial=null
	@rem 相对于当前的连接到电脑的的设备的序列号列表而言为上一次的设备序列号列表
	set array_devices_serial_old=null
	@rem 当前连接到电脑的设备序列号列表（无视状态）
	set array_devices_serial=null
	@rem 差异化列表，此列表中的序列号变量将被清除内存或仅仅更新状态提示信息。此列表的元素由 array_devices_serial_old 与 array_devices_serial 作比较
	@rem 得出，存放前者中无法在后者找到或能在或者中找到但状态不是'device'的变量（说明设备已与电脑断开连接或连接状态已改变，如从'device'状态变为'offline'状态）
	set array_diff_1=null
	@rem 差异化列表，此列表中的序列号将被添加到 array_processing_serial 列表中。此列表中的元素由 array_devices_serial 与 array_devices_serial_old 列表
	@rem 作比较得出，存放将添加到 array_processing_serial 列表的状态为'device' 的序列号元素
	set array_diff_2=null
	@rem 是否在主线程更新 UI 的标志，true 通知主线程更新 UI，false 什么也不做，默认为 false
	set isUpdateUI=false
	:detectDevice_loop_1
		@rem set array_temp_processing_serial=null
		@rem ===========================================================================================
		@rem 给自己埋了个大坑，两个列表中的元素的名字一样，所以以元素名（序列号）为变量名存储的设备状态一样，无法区分新旧列表的设备状态
		@rem ===========================================================================================
		set array_devices_serial_old=!array_devices_serial!
		set array_devices_serial=null
		set array_diff_1=null
		set array_diff_2=null
		@rem 更新连接到电脑的设备的列表
		for /f "skip=1 tokens=1,2 delims=	" %%i in ('adb.exe devices') do (
			if "!array_devices_serial!" neq "null" (
				set array_devices_serial=!array_devices_serial!,"%%~i"
			) else (
				set array_devices_serial="%%~i"
			)
			@rem 存对应序列号的连接状态
			set %%~i=%%~j
		)
		@rem 如果没有设备连接则跳过后面的步骤并延迟 1 秒检测新设备，节省 CPU
		if "!array_devices_serial!"=="null" (
			if "!array_devices_serial_old!" neq "null" (
				call %~n0 void updateUI !array_processing_serial! 
			)
			choice /d y /t 1 /n 1>nul
			goto detectDevice_loop_1
		)
		if "!array_devices_serial_old!"=="null" (
			
		)
		call %~n0 tmp_any_1 calculateDifference "!array_devices_serial_old!" "!array_devices_serial!"
		set array_diff_1=!tmp_any_1!
		call %~n0 tmp_any_1 calculateDifference "!array_devices_serial!" "!array_devices_serial_old!"
		set array_diff_2=!tmp_any_1!
		if "!array_diff_1!" neq "null" set isUpdateUI=true
		if "!array_diff_2!" neq "null" set isUpdateUI=true
		for %%i in (!array_diff_1!) do (
			if defined %%~i (
				if exist "%listtmp%\%%~i" (
					call %~n0 string getSatuMappedName !string!
					if "!string!"=="unauthorized" call %~n0 void setDeviceOptSatu %%~i %%~j
					if "!string!"=="device" call %~n0 void setDeviceOptSatu %%~i %%~j
					if "!string!"=="offline" call %~n0 void setDeviceOptSatu %%~i %%~j
				) else (
					call %~n0 void setDeviceOptSatu %%~i !%%~i!
				)
			) else (
				if exist "%listtmp%\%%i" del /f /q %listtmp%\%%i
			)
		)
		
		
		
		
		
		
		@rem ========================= 暂时不管，感觉性能没有多大提升 ==========================
		@rem 计算差异化列表 array_diff_1 
		if "!array_processing_serial!" neq "null" (
			set array_diff_1=null
			@rem 判断 array_processing_serial 中的元素是否符合 array_diff_1 列表的元素要求的定义的标致，true 为符合，false 为不符合，默认为 false
			set tmp_boolean_1=false
			@rem 标识需要存放到 array_diff_1 列表的元素的类型，not_found 为当前元素无法在 array_processing_serial 中找到，state_changed 为当前元素的状态已不是 'device',默认为 not_found
			set tmp_any_1=not_found
			for %%e in (!array_processing_serial!) do (
				for %%t in (!array_devices_serial!) do (
					
				)
			)
		)
		@rem ========================= 暂时不管
		
		@rem 旧==========================================
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
		@rem 旧==========================================
		
	goto detectDevice_loop_1
goto eof

@rem Print init page
@rem
@rem return void
:printInitPage
	title CP_UAAI  ---  Mouse.JiangWei     :-D
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
goto eof

@rem Print path error page
@rem
@rem return void
:printPathErrPage
	cls 
	echo ==================================================================================
	echo 当前路径 “%~dp0” 包含空格，请将此脚本应用放到无空格的路径中再运行
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 按任意键退出脚本
	echo 1>nul
	echo 1>nul
	echo ==================================================================================
	pause 1>nul
goto eof

@rem Print no start adb page 1
@rem
@rem return void
:printNostartAdbPage_1
	cls
	echo ==================================================================================
	echo 启动脚本时无法启动 adb 程序服务，原因为 adb 程序的 5037 端口正被另一个 adb 程序
	echo 占用且无法将其关闭，请在任务管理器里手动关闭占用 5037 端口的 adb 程序
	echo 1>nul
	echo 1>nul
	echo 按任意键退出脚本
	echo 1>nul
	echo 1>nul
	echo ==================================================================================
	pause 1>nul
goto eof

@rem Print no start adb page 2
@rem
@rem return void
@rem param_3 processName Process name that occupied prot 5037
:printNostartAdbPage_2
	cls
	echo ==================================================================================
	echo 启动脚本时无法启动 adb 程序服务，原因为 adb 程序的 5037 端口正被 “%~n3” 进程占用且
	echo 脚本尝试 3 次关闭该进程都未成功，请手动关闭该进程后再启动脚本。
	echo 1>nul
	echo 注：该类进程一般为 “XX手机管家”、“XX手机助手”、“XX手机清理大师”等流氓软件，可以直接
	echo 	它们的菜单中将他们关闭。
	echo 1>nul
	echo 1>nul
	echo 按任意键退出脚本
	echo 1>nul
	echo 1>nul
	echo ==================================================================================
	pause 1>nul
goto eof

@rem Print initialize plugin config error page
@rem
@rem return void
:printInitPluginConfigErrPage
	cls
	echo ==================================================================================
	echo 脚本在根据 .\opt 目录下的 plugin_config.txt 配置文件初始化插件配置时遇到错误，请根据
	echo 配置文件里的说明检查配置。
	echo 1>nul
	echo 1>nul
	echo 按任意键退出脚本
	echo 1>nul
	echo 1>nul
	echo ==================================================================================
	pause 1>nul
goto eof

@rem Verify path legitimacy,if the path contain blackspace,the application will not work
@rem 
@rem return boolean if the path is not have blackspace that will return true,otherwise return false
:isPathLegitimate
	set result=false
	if exist %~f0 set result=true 2>nul
	set %~1=!result!
goto eof

@rem Judge port 5037 Occupied or not
@rem 
@rem return boolean If port 5037 Occupied that return true,otherwise return false  
:is5037Occupied
	set result=false
	netstat -ano|findstr 127.0.0.1:5037 1>nul
	if "%errorlevel%"=="0" set result=true
	set %~1=!result!
goto eof

@rem Get process name which occupied prot 5037
@rem
@rem return string Process name which occupied prot 5037,if no process occupied 5037 prot that will return null
:get5037ProcessName
	set result=null
	set tmp_int_1=0
	for /f "tokens=4,5" %%i in ('netstat -ano^|findstr 127.0.0.1:5037') do (
		for /f "usebackq" %%n in (`tasklist /nh /fi "pid eq %%j"`) do (
			if "%%i"=="LISTENING" (
				set result=%%n
				goto get5037ProcessName_b_1
			)
		)
	)
	:get5037ProcessName_b_1
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

@rem Close the process which occupied the prot 5037
@rem
@rem return boolean If success that return true,otherwise return false
@rem param_3 processName The Process name 
:close5037ProcessByName
	set result=false
	taskkill /f /im %~n3 1>nul 2>nul
	if %errorlevel%==0 set result=true
	set %~1=!result!
goto eof

@rem Initalization config of plugin in path .\opt\plugin_config.txt
@rem 
@rem return boolean If initialize config success that return true,otherwise return false
:initPluginConfig
	set result=true
	@rem 判断配置文件是否存在，不存在则新建一个,新的配置文件没有使用说明
	if not exist ".\opt\plugin_config.txt" call %~n0 void createNewPluginConfigFile
	echo 读取插件配置文件 .\opt\plugin_config.txt 中。。。
	@rem 从配置文件读取到的内容
	set tmp_string_1=null
	@rem 生命周期
	set tmp_string_2=null
	for /f "eol=#" %%t in (.\opt\plugin_config.txt) do (
		@rem 从配置文件读取到的内容
		set tmp_string_1=%%~t
		set tmp_string_3=!tmp_string_1:~0,1!
		if "!tmp_string_3!"==":" (
			@rem 解析到生命周期
			set result=false
			set tmp_string_2=!tmp_string_1:~1!
			echo 解析到生命周期 !tmp_string_2!
			if "!tmp_string_2!"=="onScriptFirstStart" set result=true
			if "!tmp_string_2!"=="onCoreStart" set result=true
			if "!tmp_string_2!"=="onBeforeInstallingApp" set result=true
			if "!tmp_string_2!"=="onAfterInstallingApp" set result=true
			if "!tmp_string_2!"=="onInstallAppCompleted" set result=true
			if "!tmp_string_2!"=="onBeforePushingFile" set result=true
			if "!tmp_string_2!"=="onAfterPushingFile" set result=true
			if "!tmp_string_2!"=="onCoreFinish" set result=true
			if "!result!"=="false" (
				echo 错误的生命周期 !tmp_string_2! ，脚本将停止解析插件配置文件并退出
				pause 1>nul
				goto initPluginConfig_b_1
			)
		) else (
			if "!tmp_string_1!" neq "" (
				@rem 解析到插件名
				if "!tmp_string_2!" neq "null" (
					if exist ".\opt\!tmp_string_1!" (
						call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
					) else (
						set tmp_boolean_1=false
						if exist ".\opt\!tmp_string_1!.bat" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.Bat" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.bAt" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.baT" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.BAt" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.BaT" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.bAT" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if exist ".\opt\!tmp_string_1!.BAT" (
							call %~n0 void registPlugin "!tmp_string_2!" "!tmp_string_1!"
							set tmp_boolean_1=true
						)
						if "!tmp_boolean_1!"=="false" (
							echo 找不到插件文件 !tmp_string_1! ,该插件将不会被注册到 ”!tmp_string_2!“ 生命周期里
						)
					)
				) else (
					set result=false
					echo 检测到 !tmp_string_1! 插件未在生命周期里注册，脚本将停止解析插件配置文件并退出
					pause 1>nul
					goto initPluginConfig_b_1
				)
			) else (
				set result=false
				echo 检测 "!tmp_string_1!" 行开头存在空格，脚本将停止解析插件配置文件并退出
				pause 1>nul
				goto initPluginConfig_b_1
			)
		)
	)
	:initPluginConfig_b_1
	set %~1=!result!
goto eof

@rem Regist plugin to target script life cycle
@rem
@rem return void
@rem param_3 string Life cycle name
@rem param_4 string Plugin name
:registPlugin
	echo 在生命周期 ”%~n3“ 注册插件 %~n4
	if "!lifeCycle_%~n3!" neq "null" (
		set lifeCycle_%~n3=!lifeCycle_%~n3!,"%~n4"
	) else (
		set lifeCycle_%~n3="%~n4"
	)
goto eof

@rem Create new plugin config file at .\opt 
@rem
@rem return void
:createNewPluginConfigFile
	echo #	This is new config file without document >.\opt\plugin_config.txt
goto eof

@rem Execute plugin on life cycle
@rem 
@rem return void
@rem param_3 string Life cycle name
@rem param_4 string Device serial
@rem param_5 Applicathion or file absolute path 
:executeLifeCycle
	if "!lifeCycle_%~n3!" neq "null" (
		for %%t in (!lifeCycle_%~n3!) do (
			call .\opt\%%t void opt "%~n3" "%~n4" "%~5"
		)
	)
goto eof

@rem Calculate difference between old serial array and new serial array
@rem
@rem return array Difference element
@rem param_3 array Array
@rem param_4 array Array
:calculateDifference
	set array_diff=null
	for %%i in (!%~3!) do (
		set tmp_boolean_1=false
		for %%t in (!%~4!) do (
			if "%%~i"=="%%~t" (
				set tmp_boolean_1=true
				if "!%%~i!" neq "!%%~t!" (
					if "!array_diff!" neq "null" (
						set array_diff=!array_diff!,"%%~i"
					) else (
						set array_diff="%%~i"
					)
				)
			)
		)
		if "!tmp_boolean_1!"=="false" (
			set %%~i=
			if "!array_diff!" neq "null" (
				set array_diff=!array_diff!,"%%~i"
			) else (
				set array_diff="%%~i"
			)
		)
	)
	set %~1=!array_diff!
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
	@rem echo true>%tmpdir%\isUpdateUI
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
	call %~n0 void executeLifeCycle "onCoreStart" "%~n3"
	echo -------------------------------
	call %~n0 boolean installApp %~3
	if "!boolean!"=="false" goto faild
	echo -------------------------------
	call %~n0 void executeLifeCycle "onInstallAppCompleted" "%~n3"
	echo -------------------------------
	call %~n0 boolean pushFiles %~3
	if "!boolean!"=="false" goto faild
	echo -------------------------------
	call %~n0 void executeLifeCycle "onCoreFinish" "%~n3"
	echo -------------------------------
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
		call %~n0 void executeLifeCycle "onBeforeInstallingApp" "%~n3" "%~dp0app\%%~nxt"
		set /a tmp_int_3= !tmp_int_3! + 1
		adb.exe -s %~3 push ".\app\%%~nxt" /sdcard/%%~nxt
		@rem start /min %~n0 void installApp_t_1 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt" "/sdcard/%%~nxt"
		@rem start /min %~n0 void installApp_t_2 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt"
		adb.exe -s %~3 shell pm install -r /sdcard/%%~nxt
		call %~n0 void executeLifeCycle "onAfterInstallingApp" "%~n3" "%~dp0app\%%~nxt"
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
		call %~n0 void executeLifeCycle "onBeforePushingFile" "%~n3" "%~dp0files\%%~nxt"
		set /a tmp_int_1= !tmp_int_1! + 1
		echo 正在推送第 !tmp_int_1! 个文件：
		echo %%~t
		adb.exe -s %~3 push "%%~t" /sdcard/%%~nxt
		if %errorlevel% geq 1 (
			echo %%~t 推送失败
			set result=false
			goto pushFiles_b_1
		)
		call %~n0 void executeLifeCycle "onAfterPushingFile" "%~n3" "%~dp0files\%%~nxt"
		echo %%~t 推送完成
	)
	:pushFiles_b_1
	set %~1=!result!
goto eof

@rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@rem  这个方法废弃了，已经用生命周期机制代替
@rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

@rem Lock screen direction
@rem
@rem return void
@rem param_3 string Device serial
:lockScreenDirection
	adb.exe -s %~n3 shell content insert --uri content://settings/system --bind name:s:accelerometer_rotation --bind value:i:0
	adb.exe -s %~n3 shell content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:0
goto eof

@rem Unlock screen direction
@rem
@rem return void
@rem param_3 string Device serial
:unlockScreenDirection
	adb.exe -s %~3 shell content insert --uri content://settings/system --bind name:s:accelerometer_rotation --bind value:i:1
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