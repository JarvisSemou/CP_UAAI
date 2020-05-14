@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
	call .\test_15_call_02.bat
	echo 02 is exit
	pause
goto eof


:eof