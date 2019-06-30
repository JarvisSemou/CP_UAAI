@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
echo ^!
pause 1>nul
goto eof


:eof