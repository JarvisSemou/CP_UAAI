@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
set result=null
	set tmp_int_1=0
	for /f "tokens=5" %%i in ('netstat -ano^|findstr 5037') do (
		echo %%i
		for /f "usebackq" %%n in (`tasklist /nh /fi "pid eq %%i"`) do (
			echo %%n
		)
	)
pause 1>nul
goto eof


:eof