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
	goto main
)
if "%~2"=="isPathLegitimate" goto isPathLegitimate
if "%~2"=="restartAdb" goto restartAdb
if "%~2"=="setDeviceOptSatu" goto setDeviceOptSatu
if "%~2"=="getDeviceOptSatu" goto getDeviceOptSatu
if "%~2"=="getSatuMappedName" goto getSatuMappedName
if "%~2"=="coreEntry" goto coreEntry
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
@rem ��ǰ������·��
set rootPath=%~dp0
cd /d %rootPath%
set path=%rootpath%bin;!path!
set tmpdir=%temp%\tmpdir
set listtmp=%tmpdir%\list
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
@rem ��ǰ���ڴ�����豸�����к��б�
set array_processing_serial=null
@rem ��ǰ���ӵ����Ե��豸���к��б�����״̬��
set array_devices_serial=null
:main_loop_1
	@rem ÿ��ˢ�������豸�б�
	cls
	echo ------------------------------------------------------------------------
	echo ----------------------------- ��ǰ�豸�б� -----------------------------
	set array_temp_serial=null
	set array_devices_serial=null
	adb.exe devices >%tmpdir%\devices
	for /f "skip=1 tokens=1,2 delims=	" %%i in (%tmpdir%\devices) do (
		call %~n0 void setDeviceOptSatu %%~i %%~j
		call %~n0 string getDeviceOptSatu %%~i
		set tmp_string_1=null
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
		set resutl=�ű�������
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
)
:getSatuMappedName_b_1
set %~1=!result!
goto eof

@rem
@rem return void
@rem param_3 string Serial number
:coreEntry
title [%~3]

goto close
goto eof

:close
exit
goto eof

:eof