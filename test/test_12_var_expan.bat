@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="test" goto test
goto eof
 
:main
	call %~f0 void test data.txt
	echo %~dp0
goto eof

:test
	echo %~f3
goto eof

:eof