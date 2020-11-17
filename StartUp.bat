@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::																	::
@rem ::		  					CP_UAAI									::
@rem ::																	::
@rem ::										Copyright: Mouse.JiangWei	::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v2.3.2													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2020.11.09													::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "!RUN_ONCE!" neq "%RUN_ONCE%" (
	for /f "tokens=1,2 delims= " %%r in ('echo %CMDCMDLINE%') do (
		@rem 设置是否显示调试信息，true 为显示调试信息，false 反之，默认为 false
        set DEBUG=false
		if "%%s"=="" (
			@rem 不开延时变量，需要明确调用 main 方法才能进入 main 方法
			if "%~2" neq "main" goto debugPoint else goto initStaticValue
		)
		@rem 开两层局部变量扩展保护 path 变量,path 在局部变量扩展下不受空格影响
		setlocal enableDelayedExpansion
		set path=%~dp0;!path!
		setlocal enableDelayedExpansion
		if "%%s"=="/K" (
			@rem void 为异步调用一个方法，否则异步执行脚本
			if "%~1" neq "void" goto initStaticValue else goto debugPoint
		)
    	if "%%s"=="/c" (
			@rem 直接启动脚本，正常初始化
			goto initStaticValue
		)
	)
) else (
	@rem 已开延时变量 call main 方法
	if "%~2"=="main" goto initStaticValue
)
:debugPoint
if "%DEBUG%"=="true" (
	echo 当前指令：
	echo %cmdcmdline% 
	echo.
	echo 当前参数：
	echo 参数 0：%0	参数 1：%1	参数 2：%2	参数 3：%3	参数 4：%4
	echo 参数 5：%5	参数 6：%6	参数 7：%7	参数 8：%8	参数 9：%9
	echo.
	if "!RUN_ONCE!" neq "%RUN_ONCE%" (
		echo 当前延时变量状态：延迟变量未开启
	) else (
		echo 当前延时变量状态：延迟变量已开启
	)
	echo 按任意键继续运行 --------------------》
	pause 1>nul
) 
:methodBrach
	if "%~2"=="initScript" goto initScript
	if "%~2"=="startMainLoop" goto startMainLoop
	if "%~2"=="isPathLegitimate" goto isPathLegitimate
	if "%~2"=="printNostartAdbPage_1" goto printNostartAdbPage_1
	if "%~2"=="printNostartAdbPage_2" goto printNostartAdbPage_2
	if "%~2"=="printInitPluginConfigErrPage" goto printInitPluginConfigErrPage
	if "%~2"=="is5037Occupied" goto is5037Occupied
	if "%~2"=="get5037ProcessName" goto get5037ProcessName
	if "%~2"=="restartAdb" goto restartAdb
	if "%~2"=="close5037ProcessByName" goto close5037ProcessByName
	if "%~2"=="initPluginConfig" goto initPluginConfig
	if "%~2"=="registPlugin" goto registPlugin
	if "%~2"=="createNewPluginConfigFile" goto createNewPluginConfigFile
	if "%~2"=="executeLifeCycle" goto executeLifeCycle
	if "%~2"=="setDeviceOptStatus" goto setDeviceOptStatus
	if "%~2"=="getDeviceOptSatus" goto getDeviceOptSatus
	if "%~2"=="getStatusMappedDescription" goto getStatusMappedDescription
	if "%~2"=="coreEntry" goto coreEntry
	if "%~2"=="installApp" goto installApp
	if "%~2"=="pushFiles" goto pushFiles
	if "%~2"=="lockScreenDirection" goto lockScreenDirection
	if "%~2"=="unlockScreenDirection" goto unlockScreenDirection
	if "%~2"=="openSettingActivity" goto openSettingActivity
	if "%~2"=="faild" goto faild
	if "!DEBUG!"=="true" echo 方法 "%~2" 不存在
goto eof

:initStaticValue
	@rem 当前工作根路径
	set tmpdir=%temp%\tmpdir
	set listtmp=%tmpdir%\list
	@rem onScriptFirstStart 生命周期的插件调用链
	set lifeCycle_onScriptFirstStart=null
	@rem onCoreStart 生命周期的插件调用链
	set lifeCycle_onCoreStart=null
	@rem onStartInstallApp 生命周期的插件调用链
	set lifeCycle_onStartInstallApp=null
	@rem onBeforeInstallingApp 生命周期的插件调用链
	set lifeCycle_onBeforeInstallingApp=null
	@rem onAfterInstallingApp 生命周期的插件调用链
	set lifeCycle_onAfterInstallingApp=null
	@rem onInstallAppCompleted 生命轴承的插件调用链
	set lifeCycle_onInstallAppCompleted=null
	@rem onStartPushFile 生命周期的插件调用链
	set lifeCycle_onStartPushFile=null
	@rem onBeforePushingFile 生命周期的插件调用链
	set lifeCycle_onBeforePushingFile=null
	@rem onAfterPushingFile 生命周期的插件调用链
	set lifeCycle_onAfterPushingFile=null
	@rem onPushFileCompleted 生命周期的插件调用链
	set lifeCycle_onPushFileCompleted=null
	@rem onCoreLogicFinish 生命周期的插件调用链
	set lifeCycle_onCoreLogicFinish=null
	@rem onCoreFinish 生命周期的插件调用链
	set lifeCycle_onCoreFinish=null
goto main

:main
	@rem 初始化脚本
	call %~n0 void initScript
	@rem 执行主循环
	call %~n0 void startMainLoop
goto eof

@rem Init script
@rem
@rem return void
:initScript
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
	choice /d y /t 2 /n 1>nul
	cd /d %~dp0
	set path=%~dp0bin;!path!
	set path=%~dp0opt;!path!
	@rem 检测路径是否包含空格
	call %~n0 boolean isPathLegitimate
	if "!boolean!"=="false" (
		echo 当前路径 “%~dp0” 包含空格，请将此脚本应用放到无空格的路径中再运行...
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo 按任意键退出
		pause 1>nul
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
	if exist "%tmpdir%" rd /s /q "%tmpdir%" >nul
	mkdir %tmpdir%
	mkdir %listtmp%
	@rem 初始化插件配置
	call %~n0 boolean initPluginConfig
	if "!boolean!"=="false" (
		call %~n0 void printInitPluginConfigErrPage
		goto eof
	)
	echo 插件初始化完成
	call %~n0 boolean executeLifeCycle "onScriptFirstStart" 
	if "!boolean!"=="false" (
		echo.
		echo ---------------------------------------------------------------------------
		echo.
		echo 在初始化脚本的过程中,执行 onScriptFirstStart 生命周期遇到错误，脚本将在 5 秒后自动结束运行
		echo.
		echo ---------------------------------------------------------------------------
		choice /d y /t 5 /n 1>nul
		goto eof
	)
	@rem 当前正在处理的设备的传输号列表
	set array_processing_transport=null
	@rem 当前连接到电脑的设备传输号列表（不管设备处于什么状态，都记录设备传输号）
	set array_devices_transport=null
goto eof

@rem Start main loop
@rem
@rem return void
:startMainLoop
	:main_loop_1
	@rem 每秒刷新连接设备列表
	cls
	echo ----------------------------- 当前连接状态 -----------------------------
	@rem 只记录处于 device 状态的设备的传输号
	set array_temp_transport=null
	set array_devices_transport=null
	set tmp_int_1=0
	@rem 统计连接的设备数量
	if "!array_processing_transport!" neq "null" (
		for %%t in (!array_processing_transport!) do set /a tmp_int_1=!tmp_int_1!+1
	)
	echo 当前正常连接设备数量： !tmp_int_1!
	echo ----------------------------- 当前设备列表 -----------------------------
	echo ------------------------------------------------------------------------
	echo	序列号		^|^|	传输号		^|^|	设备状态
	echo ------------------------------------------------------------------------
	adb.exe devices -l 1>%tmpdir%\devices
	for /f "skip=1 tokens=1,2,6" %%i in (%tmpdir%\devices) do (
		@rem 临时存设备状态
		set tmp_string_1=null
		@rem 临时存传输号
		set tmp_string_2=null
		@rem 临时存序列号
		set tmp_string_3=%%~i
		@rem 提取传输号 
		for /f "tokens=2 delims=:" %%x in ("%%~k") do set tmp_string_2=%%~x
		@rem 设置设备或显示设备状态
		if not exist "%listtmp%\!tmp_string_2!" (
			call %~n0 void setDeviceOptStatus !tmp_string_2! %%~j
		)
		call %~n0 void getDeviceOptSatus !tmp_string_2! tmp_any_1 tmp_string_1
		echo	%%~i		!tmp_string_2!			!tmp_string_1!
		@rem  实时遍历设备列表

		if "!array_devices_transport!" neq "null" (
			set array_devices_transport=!array_devices_transport!,"!tmp_string_2!"
		) else (
			set array_devices_transport="!tmp_string_2!"
		)
		@rem 标志设备是否为新加入的设备，true 标识设备是新加入的设备，false 为正在处理中的设备，默认为 true
		set isNew=true
		@rem 开始判断设备是否是新连接的设备
		if "%%~j"=="device" (
			if "!array_temp_transport!" neq "null" (
				set array_temp_transport=!array_temp_transport!,"!tmp_string_2!"
			) else (
				set array_temp_transport="!tmp_string_2!"
			)
			if "!array_processing_transport!" neq "null" (
				for %%o in (!array_processing_transport!) do (
					if "!tmp_string_2!"=="%%~o" set isNew=false
				)
				if "!isNew!"=="true" start /min %~n0 void coreEntry !tmp_string_3! !tmp_string_2!
			) else (
				start /min %~n0 void coreEntry !tmp_string_3! !tmp_string_2!
			)
		)
	)
	set array_processing_transport=!array_temp_transport!
	@rem 删除不必要的状态临时文件
	for %%i in (%listtmp%\*) do (
		set tmp_boolean_1=false
		for %%o in (!array_devices_transport!) do (
			if "%%~ni"=="%%~o" set tmp_boolean_1=true
		)
		if "!tmp_boolean_1!"=="false" del /f /q "%listtmp%\%%~ni"
	)
	@rem 等待一秒
	choice /d y /t 1 /n 1>nul
	goto main_loop_1
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
@rem return boolean if the path is not have blackspace that will return ture,otherwise return false
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
	netstat -ano|findstr "127.0.0.1:5037$" 1>nul
	if "%errorlevel%"=="0" set result=true
	set %~1=!result!
goto eof

@rem Get process name which occupied prot 5037
@rem
@rem return string Process name which occupied prot 5037,if no process occupied 5037 prot that will return null
@rem Get process name which occupied prot 5037
@rem
@rem return string Process name which occupied prot 5037,if no process occupied 5037 prot that will return null
:get5037ProcessName
	set result=null
	set tmp_int_1=0
	for /f "tokens=4,5" %%i in ('netstat -ano^|findstr 127.0.0.1:5037$') do (
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
			if "!tmp_string_2!"=="onStartInstallApp" set result=true
			if "!tmp_string_2!"=="onBeforeInstallingApp" set result=true
			if "!tmp_string_2!"=="onAfterInstallingApp" set result=true
			if "!tmp_string_2!"=="onInstallAppCompleted" set result=true
			if "!tmp_string_2!"=="onStartPushFile" set result=true
			if "!tmp_string_2!"=="onBeforePushingFile" set result=true
			if "!tmp_string_2!"=="onAfterPushingFile" set result=true
			if "!tmp_string_2!"=="onPushFileCompleted" set result=true
			if "!tmp_string_2!"=="onCoreLogicFinish" set result=true
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
							echo 找不到插件文件 !tmp_string_1! ,该插件将不会被注册到 “!tmp_string_2!” 生命周期里
						)
					)
				) else (
					set result=false
					echo 检测到 !tmp_string_1! 插件未在生命周期里注册，脚本将停止解析插件配置文件并退出
					pause 1>nul
					goto initPluginConfig_b_1
				)
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
	echo 在生命周期 “%~n3” 注册插件 %~n4
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
	echo #	This is new config file without document 1>.\opt\plugin_config.txt
	echo #	format version：0.0.3 1>.\opt\plugin_config.txt
	echo :onScriptFirstStart 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onCoreStart 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onStartInstallApp 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onBeforeInstallingApp 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onAfterInstallingApp 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onInstallAppCompleted 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onStartPushFile 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onBeforePushingFile 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onAfterPushingFile 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onPushFileCompleted 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onCoreLogicFinish 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo :onCoreFinish 1>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
	echo.>>.\opt\plugin_config.txt
goto eof

@rem Execute plugin on life cycle
@rem 
@rem return boolean Return false that no execute next life cycle,default is true
@rem param_3 string Life cycle name
@rem param_4 string Device serial number
@rem param_5 int	Device transport number
@rem param_6 string Applicathion or file absolute path 
:executeLifeCycle
	if "!lifeCycle_%~n3!" neq "null" (
		for %%t in (!lifeCycle_%~n3!) do (
			if "%~5" neq "" (
				call %~n0 void setDeviceOptStatus %~5 script_running "执行插件‘%%~t’中"
			)
			call .\opt\%%t boolean opt "%~n3" "%~n4" "%~n5" "%~6"
			if "%~5" neq "" (
				call %~n0 void setDeviceOptStatus %~4 script_running
			)
			if "!boolean!"=="" (
				set %~1=true
			) else (
				set %~1=!boolean!
			)
		)
	) else (
		set %~1=true
	)
goto eof

@rem Set device option satus
@rem The option satus was:
@rem 	unauthorized	未验证
@rem	device			已连接
@rem	offline			已离线
@rem	script_running	脚本运行中
@rem	complete		完成
@rem	faild			失败
@rem When on 'script_running' status,status description
@rem will replace script_running to show at terminal.
@rem
@rem return void
@rem param_3 string transport number
@rem param_4 string Status
@rem param_5 string Status description
:setDeviceOptStatus
	set tmp_string_4=null
	if "%~5"=="" (
		call %~n0 string getStatusMappedDescription %~4
		set tmp_string_4=!string!
	) else (
		set tmp_string_4=%~5
	)
	echo "%~4":"!tmp_string_4!"1>%listtmp%\%~3
goto eof

@rem Get device option satus and atatus description
@rem 
@rem return void
@rem param_3 int Transport number
@rem param_4 string Status description use to return to
@rem param_5 string Status description use to return to
:getDeviceOptSatus
	if exist "%listtmp%\%~3" (
		for /f "usebackq tokens=1,2 delims=:" %%i in ("%listtmp%\%~3") do (
			set %~4=%%~i
			set %~5=%%~j
		)
	)
goto eof

@rem Get status mapped description
@rem
@rem return string Mapped description
@rem param_3 string status
:getStatusMappedDescription
	set result=null
	if "%~3" neq "" (
		if "%~3"=="null" ( 
			set result=正在获取状态。。。
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="unauthorized" ( 
			set result=未验证
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="device" (
			set result=已连接
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="offline" (
			set result=已离线
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="script_running" (
			set result=脚本运行中
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="complete" (
			set result=完成
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="faild" (
			set result=失败
			goto getStatusMappedDescription_b_1
		)
	)
	:getStatusMappedDescription_b_1
	set %~1=!result!
goto eof

@rem
@rem return void
@rem param_3 string Serial number
@rem param_4 int Transport number
:coreEntry
	setlocal enableDelayedExpansion
	title 序列号：[%~3] ---- 传输号：[%~4] ---- script_running
	call %~n0 void setDeviceOptStatus %~4 script_running
	echo ---------- 设备：%~4  ----------
	call %~n0 boolean executeLifeCycle "onCoreStart" "%~n3" "%~n4"
	echo -------------------------------
	if "!boolean!"=="true" (
		echo -------------------------------
		call %~n0 boolean executeLifeCycle "onStartInstallApp" "%~n3" "%~n4"
		echo -------------------------------
		if "!boolean!"=="true" (
			call %~n0 boolean installApp %~3 %~4
			if "!boolean!"=="false" call %~n0 void faild "%~n3" "%~n4"
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onInstallAppCompleted" "%~n3" "%~n4"
			echo -------------------------------
		)
		echo -------------------------------
		call %~n0 boolean executeLifeCycle "onStartPushFile" "%~n3" "%~n4"
		echo -------------------------------
		if "!boolean!"=="true" (
			call %~n0 boolean pushFiles %~3 %~4
			if "!boolean!"=="false" call %~n0 void faild "%~n3" "%~n4"
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onPushFileCompleted" "%~n3" "%~n4"
			echo -------------------------------
		)
		echo -------------------------------
		call %~n0 boolean executeLifeCycle "onCoreLogicFinish" "%~n3" "%~n4"
		echo -------------------------------
	)
	echo -------------------------------
	call %~n0 boolean executeLifeCycle "onCoreFinish" "%~n3" "%~n4"
	echo -------------------------------
	call %~n0 void openSettingActivity %~4
	echo -------------------------------
	title 序列号：[%~3] ---- 传输号：[%~4] ---- complete
	color 2f
	call %~n0 void setDeviceOptStatus %~4 complete
	choice /d y /t 5 /n 1>nul
	goto close
goto eof

@rem Install application
@rem 
@rem return boolean If success that will return true,otherwise return false 
@rem param_3 string Device serial number
@rem param_4 int Device transport number
:installApp
	set result=true
	set tmp_int_3=0
	for %%t in (.\app\*.apk) do (
		echo -------------------------------
		call %~n0 boolean executeLifeCycle "onBeforeInstallingApp" "%~n3" "%~n4" "%~dp0app\%%~nxt"
		echo -------------------------------
		set /a tmp_int_3= !tmp_int_3! + 1
		if "!boolean!"=="true" (
			echo 正在安装第 !tmp_int_3! 个应用 %%~nxt 
			call %~n0 void setDeviceOptStatus %~4 script_running "安装应用：%%~nxt"
			adb.exe -t %~4 push ".\app\%%~nxt" "/sdcard/%%~nxt"
			adb.exe -t %~4 install -t -r ".\app\%%~nxt"
			call %~n0 void setDeviceOptStatus %~4 script_running
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onAfterInstallingApp" "%~n3" "%~n4" "%~dp0app\%%~nxt"
			echo -------------------------------
			echo 第 !tmp_int_3! 个应用 %%~nxt 安装完成
		) else (
			echo 跳过第 !tmp_int_3! 个应用的安装
		)
	)
	set %~1=!result!
goto eof

@rem Push files to the devices
@rem
@rem return boolean If success to push than return true,otherwise return false
@rem param_3 string Device serial number
@rem param_4 int Device transport number
:pushFiles
	set result=true
	set tmp_int_1=0
	for %%t in (.\files\*) do (
		echo -------------------------------
		call %~n0 boolean executeLifeCycle "onBeforePushingFile" "%~n3" "%~n4" "%~dp0files\%%~nxt"
		echo -------------------------------
		set /a tmp_int_1= !tmp_int_1! + 1
		if "!boolean!"=="true" (
			echo 正在推送第 !tmp_int_1! 个文件：%%~t
			call %~n0 void setDeviceOptStatus %~4 script_running "推送文件：%%~nxt"
			adb.exe -t %~4 push "%%~t" "/sdcard/%%~nxt"
			call %~n0 void setDeviceOptStatus %~4 script_running
			if %errorlevel% geq 1 (
				echo %%~t 推送失败
				set result=false
				goto pushFiles_b_1
			)
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onAfterPushingFile" "%~n3"  "%~n4" "%~dp0files\%%~nxt"
			echo -------------------------------
			echo 第 !tmp_int_1! 个文件：%%~t 推送完成
		) else (
			echo 跳过第 !tmp_int_1! 个文件 “%%~t” 的推送
		)
	)
	:pushFiles_b_1
	set %~1=!result!
goto eof

@rem Lock screen direction
@rem
@rem return void
@rem param_3 int Device transport number
:lockScreenDirection
	adb.exe -t %~3 shell content insert --uri content://settings/system --bind name:s:accelerometer_rotation --bind value:i:0
	adb.exe -t %~3 shell content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:0
goto eof

@rem Unlock screen direction
@rem
@rem return void
@rem param_3 int Device transport number
:unlockScreenDirection
	adb.exe -t %~3 shell content insert --uri content://settings/system --bind name:s:accelerometer_rotation --bind value:i:1
goto eof

@rem Open setting activity
@rem 
@rem return void
@rem param_3 int Device transport number
:openSettingActivity
	adb.exe -t %~3 shell am force-stop com.android.settings
	adb.exe -t %~3 shell input keyevent KEYCODE_WAKEUP
	adb.exe -t %~3 shell input touchscreen swipe 300 460 300 0 150
	adb.exe -t %~3 shell am start -n com.android.settings/com.android.settings.Settings
goto eof

@rem Script has error,than set consol mode
@rem
@rem return void
@rem param_3 string Device serial number
@rem param_4 int Device transport number
:faild
	title 序列号：[%~3] ---- 传输号：[%~4] ---- faild
	color 47
	call %~n0 void setDeviceOptStatus %~4 faild
	echo -------------------------------
	echo 设备 %~3  ^(%~4^) 出现错误，请断开设备与电脑的连接，
	echo 等待当前窗口关闭候重新将设备连接到电脑。
	choice /d y /t 5 /n 1>nul
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