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
	@rem ��ǰ������·��
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
	echo �ű������С�����
	cd /d %rootPath%
	@rem ���·���Ƿ�����ո�
	call %~n0 boolean isPathLegitimate
	if "!boolean!"=="false" (
		echo ��ǰ·�� ��%~dp0�� �����ո��뽫�˽ű�Ӧ�÷ŵ��޿ո��·���������С�
		echo 1>nul
		echo 1>nul
		echo 1>nul
		echo 1>nul
		echo 1>nul
		echo 1>nul
		echo ��������˳�
		pause 1>nul
		goto eof
	)
	call %~n0 boolean restartAdb
	@rem ���� 3 �ιر� adb
	if "!boolean!"=="false" call %~n0 boolean restartAdb
	if "!boolean!"=="false" call %~n0 boolean restartAdb
	if "!boolean!"=="false" call %~n0 boolean restartAdb
	if "!boolean!"=="false" call %~n0 boolean restartAdb
	if "!boolean!"=="false" (
		echo �����ű�ʱ�޷����� adb �������飺
		echo 	1��adb �� 5037 �˿��Ƿ�ռ�ã����ܱ�� adb �����������У�
		echo	2���Ƿ����˸�����å�ֻ��ܼ�
		echo  
		echo ��������˳�
		pause >nul
		goto eof
	)
	if exist "%tmpdir%" rd /s /q "%tmpdir%" >nul
	mkdir %tmpdir%
	mkdir %listtmp%
	@rem ������̨�豸����߳�
	start /b %~nx0 void detectDevice
	cls
	call %~n0 void showDefaultPage
	@rem �����豸����̵߳�״̬���½���
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


@rem ================= �� =====================================================
	@rem :main_loop_1
	@rem ÿ��ˢ�������豸�б�
	cls
	echo ------------------------------------------------------------------------
	echo ----------------------------- ��ǰ�豸�б� -----------------------------
	set array_temp_serial=null
	set array_devices_serial=null
	set tmp_int_1=0
	if "!array_processing_serial!" neq "null" (
		for %%t in (!array_processing_serial!) do set /a tmp_int_1=!tmp_int_1!+1
	) 
	echo ��ǰ���������豸������ !tmp_int_1!
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
		@rem  ����ʵʱ���豸�б�
		echo %%~i	!tmp_string_1!
		if "!array_devices_serial!" neq "null" (
			set array_devices_serial=!array_devices_serial!,"%%~i"
		) else (
			set array_devices_serial="%%~i"
		)
		@rem ��־�豸�Ƿ�Ϊ�¼�����豸��true ��ʶ�豸���¼�����豸��false Ϊ���ڴ����е��豸��Ĭ��Ϊ true
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
	@rem �ȴ�һ��
	choice /d y /t 1 /n 1>nul
	goto main_loop_1
	
goto eof

@rem Show default page
@rem 
@rem return void
:showDefaultPage
	echo ------------------------------------------------------------------------
	echo ----------------------------- ��ǰ�豸�б� -----------------------------
	echo ��ǰ���������豸������ 0
goto eof

@rem Detect device and notic main thread update page
@rem 
@rem return void
:detectDevice
	@rem ��ǰ���ڴ�����豸�����к��б�
	set array_processing_serial=null
	@rem ��ǰ���ӵ����Ե��豸���к��б�����״̬��
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
			@rem  ����ʵʱ���豸�б�
			echo %%~i	!tmp_string_1!
			if "!array_devices_serial!" neq "null" (
				set array_devices_serial=!array_devices_serial!,"%%~i"
			) else (
				set array_devices_serial="%%~i"
			)
			@rem ��־�豸�Ƿ�Ϊ�¼�����豸��true ��ʶ�豸���¼�����豸��false Ϊ���ڴ����е��豸��Ĭ��Ϊ true
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
		@rem �ȴ�һ��
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
	@rem ǿ�йرն���� adb 
	taskkill /f /im adb.exe 1>nul 2>nul
	@rem ���¿��� adb ����
	adb.exe start-server 1>nul 2>nul
	if %errorlevel% geq 1 (
		set result=false
	)
	set %~1=!result!
goto eof

@rem Set device option satu
@rem The option satu was:
@rem 	unauthorized	δ��֤
@rem	device			������
@rem	offline			������
@rem	script_running	�ű�������
@rem	complete		���
@rem	faild			ʧ��
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
			set result=���ڻ�ȡ״̬������
			goto getSatuMappedName_b_1
		)
		if "%~3"=="unauthorized" ( 
			set result=δ��֤
			goto getSatuMappedName_b_1
		)
		if "%~3"=="device" (
			set result=������
			goto getSatuMappedName_b_1
		)
		if "%~3"=="offline" (
			set result=������
			goto getSatuMappedName_b_1
		)
		if "%~3"=="script_running" (
			set result=�ű�������
			goto getSatuMappedName_b_1
		)
		if "%~3"=="complete" (
			set result=���
			goto getSatuMappedName_b_1
		)
		if "%~3"=="faild" (
			set result=ʧ��
			goto getSatuMappedName_b_1
		)
		if "%~3" neq "" (
			set result=
			goto getSatuMappedName_b_1==================================ûд��,��ʾ���߳�д����Զ�������
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
	echo ---------- �豸��%~3 ----------
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
	@rem Ҫ��װ������
	@rem set tmp_int_1=0
	@rem Ŀǰ��װ������
	set tmp_int_2=0
	set tmp_int_3=0
	@rem for %%t in (.\app\*.apk) do (
	@rem 	set /a tmp_int_1= !tmp_int_1! + 1
	@rem )
	echo ׼����ʼ��װӦ�á�������
	adb.exe -s %~3 shell rm /data/local/tmp/*
	for %%t in (.\app\*.apk) do (
		set /a tmp_int_3= !tmp_int_3! + 1
		adb.exe -s %~3 push ".\app\%%~nxt" /sdcard/%%~nxt
		@rem start /min %~n0 void installApp_t_1 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt" "/sdcard/%%~nxt"
		@rem start /min %~n0 void installApp_t_2 %~3 !tmp_int_3! "/data/local/tmp/%%~nxt"
		adb.exe -s %~3 shell pm install /sdcard/%%~nxt
		echo �� !tmp_int_3! ��Ӧ�� %%~nxt ��װ���
	)
	@rem :installApp_l_1
	@rem set tmp_int_3=0
	@rem for /f %%i in ('adb.exe -s %~3 shell ls /data/local/tmp/installApp_install_*_done') do (
	@rem 	set /a tmp_int_3= !tmp_int_3! + 1
	@rem )
	@rem if "!tmp_int_3!"=="!tmp_int_1!" goto :installApp_b_1
	@rem set tmp_int_2=!tmp_int_3!
	@rem echo �Ѱ�װ !tmp_int_1! ��Ӧ��
	@rem choice /d y /t 2 /n 1>nul
	@rem goto installApp_l_1
	@rem echo %%~t !tmp_int_1! ��Ӧ�ð�װ���
	@rem :installApp_b_1
	set %~1=!result!
goto eof

@rem ���̣߳������ƻ���ʱĿ¼��Ӧ�õ� /sdcard ·��
@rem 
@rem return void
@rem param_3 string Device serial number
@rem param_4 int ��ǰ�ļ����
@rem param_5 string ԭʼ·��
@rem param_6 string Ŀ��·��
@rem :installApp_t_1
	@rem adb.exe -s %~3 shell cp %~5 %~6
	@rem adb.exe -s %~3 shell touch /data/local/tmp/installApp_appcopy_%~4_done
	@rem goto close
@rem goto eof

@rem ���̣߳���װ�ƻ���ʱĿ¼�µ�Ӧ�ò��ж�Ӧ���Ƿ�ɹ�����ʱĿ¼���Ƶ� /sdcard ·��
@rem 
@rem return void 
@rem param_3 string Device serial number
@rem param_4 int ��ǰ�ļ����
@rem param_5 string ��װ��·��
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
		echo �������͵� !tmp_int_1! ���ļ���
		echo %%~t
		adb.exe -s %~3 push "%%~t" /sdcard/%%~nxt
		if %errorlevel% geq 1 (
			echo %%~t ����ʧ��
			set result=false
			goto pushFiles_b_1
		)
		echo %%~t �������
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
			echo %%~t ����ִ��ʧ��
			set result=false
			goto applicationOperation_b_1
		)
		echo %%~t ����ִ�����
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
	echo �ԵȽű�����״̬������
	echo ����Ļ�ָ���ɫ���ε� USB �߼��������������
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