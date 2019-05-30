@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="test" goto test
goto eof

:main
call %~n0 void test ""aa","bbb""  ""ccc","ddd""
pause 1>nul
goto eof

:test
echo %~3
echo %~4
goto eof


:eof