@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
if "%~2"=="run" goto run
goto eof

:run
:run_l_1
echo I'am test_4_1.bat
choice /d y /t 1 /n 1>nul
goto run_l_1
goto eof

:eof