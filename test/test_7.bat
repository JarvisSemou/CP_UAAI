@echo off
rem ���Ա�ǩ�������Ľ������Ŀɶ���
if "%1"=="" setlocal enabledelayedexpansion
if "%1"=="setName" goto setName
goto main
goto eof


:main
echo main
call %0 setName boolean myData data1
echo now called setName,the result:%boolean%
pause
goto eof

:setName boolean:object obj,string name
set %~3=%~4
set %~2=true
goto eof

:eof