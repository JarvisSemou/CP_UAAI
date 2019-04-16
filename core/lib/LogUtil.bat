@echo off
if "%2"=="" setlocal enableDelayedExpansion
rem Save log to the log file and name the log file with date

if "%2"=="log" goto log
goto eof

rem save log to file witch name with date
rem
rem return void
rem parm_3 bat file name,use to explanation whitch bat file print the log
rem parm_4 log content
:log
rem set dateTmp=""
rem for /f "tokens=2" %%t in ("%date%") do set dateTmp=%%t
rem set logFileName=%logPath%!dateTmp:~0,4!-!dateTmp:~5,2!-!dateTmp:~8,2!.log
set logFileName=%logPath%%date:~3,4%-%date:~8,2%-%date:~11,2%.log
set logContent="%time% %3: %~4"
echo %logContent:~1,-1%>>%logFileName%
goto eof

:eof