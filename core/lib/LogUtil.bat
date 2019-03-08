rem Save log to the log file and name the log file with date

if "%2%"=="log" goto log
goto eof

rem save log to file witch name with
rem
rem return void
rem parm_3 bat file name,use to explanation whitch bat file print the log
rem parm_4 log content
:log
echo "%time% %3: %~4">>%logPath%%date:~0,4%-%date:~5,2%-%date:~8,2%.log
goto eof

:eof