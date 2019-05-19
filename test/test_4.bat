@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
if "%~2"=="" goto main
goto eof

:main
start /b .\test_4_1.bat void run
:main_l_1
echo I'am test_4.bat
choice /d y /t 3 /n 1>nul
goto main_l_1
goto eof

:eof