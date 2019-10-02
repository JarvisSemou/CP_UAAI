@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
	for %%t in (.\*) do echo %%~xt
	pause
goto eof


:eof