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
		@rem �����Ƿ���ʾ������Ϣ��true Ϊ��ʾ������Ϣ��false ��֮��Ĭ��Ϊ false
        set DEBUG=false
		if "%%s"=="" (
			@rem ������ʱ��������Ҫ��ȷ���� main �������ܽ��� main ����
			if "%~2" neq "main" goto debugPoint else goto initStaticValue
		)
		@rem ������ֲ�������չ���� path ����,path �ھֲ�������չ�²��ܿո�Ӱ��
		setlocal enableDelayedExpansion
		set path=%~dp0;!path!
		setlocal enableDelayedExpansion
		if "%%s"=="/K" (
			@rem void Ϊ�첽����һ�������������첽ִ�нű�
			if "%~1" neq "void" goto initStaticValue else goto debugPoint
		)
    	if "%%s"=="/c" (
			@rem ֱ�������ű���������ʼ��
			goto initStaticValue
		)
	)
) else (
	@rem �ѿ���ʱ���� call main ����
	if "%~2"=="main" goto initStaticValue
)
:debugPoint
if "%DEBUG%"=="true" (
	echo ��ǰָ�
	echo %cmdcmdline% 
	echo.
	echo ��ǰ������
	echo ���� 0��%0	���� 1��%1	���� 2��%2	���� 3��%3	���� 4��%4
	echo ���� 5��%5	���� 6��%6	���� 7��%7	���� 8��%8	���� 9��%9
	echo.
	if "!RUN_ONCE!" neq "%RUN_ONCE%" (
		echo ��ǰ��ʱ����״̬���ӳٱ���δ����
	) else (
		echo ��ǰ��ʱ����״̬���ӳٱ����ѿ���
	)
	echo ��������������� --------------------��
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
	if "!DEBUG!"=="true" echo ���� "%~2" ������
goto eof

:initStaticValue
	@rem ��ǰ������·��
	set tmpdir=%temp%\tmpdir
	set listtmp=%tmpdir%\list
	@rem onScriptFirstStart �������ڵĲ��������
	set lifeCycle_onScriptFirstStart=null
	@rem onCoreStart �������ڵĲ��������
	set lifeCycle_onCoreStart=null
	@rem onStartInstallApp �������ڵĲ��������
	set lifeCycle_onStartInstallApp=null
	@rem onBeforeInstallingApp �������ڵĲ��������
	set lifeCycle_onBeforeInstallingApp=null
	@rem onAfterInstallingApp �������ڵĲ��������
	set lifeCycle_onAfterInstallingApp=null
	@rem onInstallAppCompleted ������еĲ��������
	set lifeCycle_onInstallAppCompleted=null
	@rem onStartPushFile �������ڵĲ��������
	set lifeCycle_onStartPushFile=null
	@rem onBeforePushingFile �������ڵĲ��������
	set lifeCycle_onBeforePushingFile=null
	@rem onAfterPushingFile �������ڵĲ��������
	set lifeCycle_onAfterPushingFile=null
	@rem onPushFileCompleted �������ڵĲ��������
	set lifeCycle_onPushFileCompleted=null
	@rem onCoreLogicFinish �������ڵĲ��������
	set lifeCycle_onCoreLogicFinish=null
	@rem onCoreFinish �������ڵĲ��������
	set lifeCycle_onCoreFinish=null
goto main

:main
	@rem ��ʼ���ű�
	call %~n0 void initScript
	@rem ִ����ѭ��
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
	echo �ű������С�����
	choice /d y /t 2 /n 1>nul
	cd /d %~dp0
	set path=%~dp0bin;!path!
	set path=%~dp0opt;!path!
	@rem ���·���Ƿ�����ո�
	call %~n0 boolean isPathLegitimate
	if "!boolean!"=="false" (
		echo ��ǰ·�� ��%~dp0�� �����ո��뽫�˽ű�Ӧ�÷ŵ��޿ո��·����������...
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo ��������˳�
		pause 1>nul
		goto eof
	)
	@rem �жϵ�ǰռ�� 5037 �˿ڵĽ���
	echo ��� 5037 �˿ڡ�����
	call %~n0 boolean is5037Occupied
	if "!boolean!"=="true" (
		call %~n0 string get5037ProcessName
		if "!string!"=="adb.exe" (
			@rem adb ��������ռ�� 5037 �˿�,���� 3 ��ʹ�õ�ǰ�ű��� adb ����
			call %~n0 boolean restartAdb
			if "!boolean!"=="false" call %~n0 boolean restartAdb
			if "!boolean!"=="false" call %~n0 boolean restartAdb
			if "!boolean!"=="false" (
				call %~n0 void printNostartAdbPage_1
				goto eof
			)
		) else (
			@rem �� adb ������ռ�� 5037 �˿ڣ��ȳ��� 3 �˹ر�ռ�� 5037 �˿ڵĽ��̣����ʧ�������ֶ��ر���Ӧ����
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
	@rem ��ʼ���������
	call %~n0 boolean initPluginConfig
	if "!boolean!"=="false" (
		call %~n0 void printInitPluginConfigErrPage
		goto eof
	)
	echo �����ʼ�����
	call %~n0 boolean executeLifeCycle "onScriptFirstStart" 
	if "!boolean!"=="false" (
		echo.
		echo ---------------------------------------------------------------------------
		echo.
		echo �ڳ�ʼ���ű��Ĺ�����,ִ�� onScriptFirstStart ���������������󣬽ű����� 5 ����Զ���������
		echo.
		echo ---------------------------------------------------------------------------
		choice /d y /t 5 /n 1>nul
		goto eof
	)
	@rem ��ǰ���ڴ�����豸�Ĵ�����б�
	set array_processing_transport=null
	@rem ��ǰ���ӵ����Ե��豸������б������豸����ʲô״̬������¼�豸����ţ�
	set array_devices_transport=null
goto eof

@rem Start main loop
@rem
@rem return void
:startMainLoop
	:main_loop_1
	@rem ÿ��ˢ�������豸�б�
	cls
	echo ----------------------------- ��ǰ����״̬ -----------------------------
	@rem ֻ��¼���� device ״̬���豸�Ĵ����
	set array_temp_transport=null
	set array_devices_transport=null
	set tmp_int_1=0
	@rem ͳ�����ӵ��豸����
	if "!array_processing_transport!" neq "null" (
		for %%t in (!array_processing_transport!) do set /a tmp_int_1=!tmp_int_1!+1
	)
	echo ��ǰ���������豸������ !tmp_int_1!
	echo ----------------------------- ��ǰ�豸�б� -----------------------------
	echo ------------------------------------------------------------------------
	echo	���к�		^|^|	�����		^|^|	�豸״̬
	echo ------------------------------------------------------------------------
	adb.exe devices -l 1>%tmpdir%\devices
	for /f "skip=1 tokens=1,2,6" %%i in (%tmpdir%\devices) do (
		@rem ��ʱ���豸״̬
		set tmp_string_1=null
		@rem ��ʱ�洫���
		set tmp_string_2=null
		@rem ��ʱ�����к�
		set tmp_string_3=%%~i
		@rem ��ȡ����� 
		for /f "tokens=2 delims=:" %%x in ("%%~k") do set tmp_string_2=%%~x
		@rem �����豸����ʾ�豸״̬
		if not exist "%listtmp%\!tmp_string_2!" (
			call %~n0 void setDeviceOptStatus !tmp_string_2! %%~j
		)
		call %~n0 void getDeviceOptSatus !tmp_string_2! tmp_any_1 tmp_string_1
		echo	%%~i		!tmp_string_2!			!tmp_string_1!
		@rem  ʵʱ�����豸�б�

		if "!array_devices_transport!" neq "null" (
			set array_devices_transport=!array_devices_transport!,"!tmp_string_2!"
		) else (
			set array_devices_transport="!tmp_string_2!"
		)
		@rem ��־�豸�Ƿ�Ϊ�¼�����豸��true ��ʶ�豸���¼�����豸��false Ϊ���ڴ����е��豸��Ĭ��Ϊ true
		set isNew=true
		@rem ��ʼ�ж��豸�Ƿ��������ӵ��豸
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
	@rem ɾ������Ҫ��״̬��ʱ�ļ�
	for %%i in (%listtmp%\*) do (
		set tmp_boolean_1=false
		for %%o in (!array_devices_transport!) do (
			if "%%~ni"=="%%~o" set tmp_boolean_1=true
		)
		if "!tmp_boolean_1!"=="false" del /f /q "%listtmp%\%%~ni"
	)
	@rem �ȴ�һ��
	choice /d y /t 1 /n 1>nul
	goto main_loop_1
goto eof

@rem Print no start adb page 1
@rem
@rem return void
:printNostartAdbPage_1
	cls
	echo ==================================================================================
	echo �����ű�ʱ�޷����� adb �������ԭ��Ϊ adb ����� 5037 �˿�������һ�� adb ����
	echo ռ�����޷�����رգ�����������������ֶ��ر�ռ�� 5037 �˿ڵ� adb ����
	echo 1>nul
	echo 1>nul
	echo ��������˳��ű�
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
	echo �����ű�ʱ�޷����� adb �������ԭ��Ϊ adb ����� 5037 �˿����� ��%~n3�� ����ռ����
	echo �ű����� 3 �ιرոý��̶�δ�ɹ������ֶ��رոý��̺��������ű���
	echo 1>nul
	echo ע���������һ��Ϊ ��XX�ֻ��ܼҡ�����XX�ֻ����֡�����XX�ֻ������ʦ������å���������ֱ��
	echo 	���ǵĲ˵��н����ǹرա�
	echo 1>nul
	echo 1>nul
	echo ��������˳��ű�
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
	echo �ű��ڸ��� .\opt Ŀ¼�µ� plugin_config.txt �����ļ���ʼ���������ʱ�������������
	echo �����ļ����˵��������á�
	echo 1>nul
	echo 1>nul
	echo ��������˳��ű�
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
	@rem ǿ�йرն���� adb 
	taskkill /f /im adb.exe 1>nul 2>nul
	@rem ���¿��� adb ����
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
	@rem �ж������ļ��Ƿ���ڣ����������½�һ��,�µ������ļ�û��ʹ��˵��
	if not exist ".\opt\plugin_config.txt" call %~n0 void createNewPluginConfigFile
	echo ��ȡ��������ļ� .\opt\plugin_config.txt �С�����
	@rem �������ļ���ȡ��������
	set tmp_string_1=null
	@rem ��������
	set tmp_string_2=null
	for /f "eol=#" %%t in (.\opt\plugin_config.txt) do (
		@rem �������ļ���ȡ��������
		set tmp_string_1=%%~t
		set tmp_string_3=!tmp_string_1:~0,1!
		if "!tmp_string_3!"==":" (
			@rem ��������������
			set result=false
			set tmp_string_2=!tmp_string_1:~1!
			echo �������������� !tmp_string_2!
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
				echo ������������� !tmp_string_2! ���ű���ֹͣ������������ļ����˳�
				pause 1>nul
				goto initPluginConfig_b_1
			)
		) else (
			if "!tmp_string_1!" neq "" (
				@rem �����������
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
							echo �Ҳ�������ļ� !tmp_string_1! ,�ò�������ᱻע�ᵽ ��!tmp_string_2!�� ����������
						)
					)
				) else (
					set result=false
					echo ��⵽ !tmp_string_1! ���δ������������ע�ᣬ�ű���ֹͣ������������ļ����˳�
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
	echo ���������� ��%~n3�� ע���� %~n4
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
	echo #	format version��0.0.3 1>.\opt\plugin_config.txt
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
				call %~n0 void setDeviceOptStatus %~5 script_running "ִ�в����%%~t����"
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
@rem 	unauthorized	δ��֤
@rem	device			������
@rem	offline			������
@rem	script_running	�ű�������
@rem	complete		���
@rem	faild			ʧ��
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
			set result=���ڻ�ȡ״̬������
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="unauthorized" ( 
			set result=δ��֤
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="device" (
			set result=������
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="offline" (
			set result=������
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="script_running" (
			set result=�ű�������
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="complete" (
			set result=���
			goto getStatusMappedDescription_b_1
		)
		if "%~3"=="faild" (
			set result=ʧ��
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
	title ���кţ�[%~3] ---- ����ţ�[%~4] ---- script_running
	call %~n0 void setDeviceOptStatus %~4 script_running
	echo ---------- �豸��%~4  ----------
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
	title ���кţ�[%~3] ---- ����ţ�[%~4] ---- complete
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
			echo ���ڰ�װ�� !tmp_int_3! ��Ӧ�� %%~nxt 
			call %~n0 void setDeviceOptStatus %~4 script_running "��װӦ�ã�%%~nxt"
			adb.exe -t %~4 push ".\app\%%~nxt" "/sdcard/%%~nxt"
			adb.exe -t %~4 install -t -r ".\app\%%~nxt"
			call %~n0 void setDeviceOptStatus %~4 script_running
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onAfterInstallingApp" "%~n3" "%~n4" "%~dp0app\%%~nxt"
			echo -------------------------------
			echo �� !tmp_int_3! ��Ӧ�� %%~nxt ��װ���
		) else (
			echo ������ !tmp_int_3! ��Ӧ�õİ�װ
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
			echo �������͵� !tmp_int_1! ���ļ���%%~t
			call %~n0 void setDeviceOptStatus %~4 script_running "�����ļ���%%~nxt"
			adb.exe -t %~4 push "%%~t" "/sdcard/%%~nxt"
			call %~n0 void setDeviceOptStatus %~4 script_running
			if %errorlevel% geq 1 (
				echo %%~t ����ʧ��
				set result=false
				goto pushFiles_b_1
			)
			echo -------------------------------
			call %~n0 boolean executeLifeCycle "onAfterPushingFile" "%~n3"  "%~n4" "%~dp0files\%%~nxt"
			echo -------------------------------
			echo �� !tmp_int_1! ���ļ���%%~t �������
		) else (
			echo ������ !tmp_int_1! ���ļ� ��%%~t�� ������
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
	title ���кţ�[%~3] ---- ����ţ�[%~4] ---- faild
	color 47
	call %~n0 void setDeviceOptStatus %~4 faild
	echo -------------------------------
	echo �豸 %~3  ^(%~4^) ���ִ�����Ͽ��豸����Ե����ӣ�
	echo �ȴ���ǰ���ڹرպ����½��豸���ӵ����ԡ�
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