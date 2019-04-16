@echo off
if "%2"=="" setlocal enableDelayedExpansion
rem Provide system command support like taskkill,rename

if "%2"=="taskkillByProcessName" goto taskkillByProcessName
if "%2"=="taskkillByProcessId" goto taskkillByProcessId
if "%2"=="renameFile" goto renameFile
goto eof

rem Force kill process by given process name 
rem
rem return errorlevel
rem	pram_3 process name like "adb.exe"
:taskkillByProcessName
taskkill /f /im %3
set %1=%errorlevel%
call %_LogUtil% void log %0 "called taskkillByProcessName,the errorlevel is %errorlevel%"
goto eof

rem Force kill process by given process id
rem
rem return errorlevel 
rem param process id like 123
:taskkillByProcessId
taskkill /f /pid %3
set %1=%errorlevel%
call %_LogUtil% void log %0 "called taskkillByProcessId,the errorlevel is %errorlevel%"
goto eof

rem Rename the target file
rem
rem return newName new file name with absolute path
rem param_3 file path
rem param_4 original name
rem param_5 target name
:renameFile
rename "%3\%4" "%3\%5"
set %1=%5
call %_LogUtil% void log %0 "called renameFile,the errorlevel is %errorlevel%"
goto eof

:eof
