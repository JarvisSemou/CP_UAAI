@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
	set aaa=mouse
	echo %aaa:~0,2%
	pause 1>nul
goto eof


:eof