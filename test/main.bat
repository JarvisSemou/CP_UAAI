@echo off

if "%2"=="getObjectName" goto getObjectName
goto main


:main
set object=.\Object.bat,object
echo "no call getObjectName-----------------"
set |findstr vo
call %~dp0Object.bat vo getObjectName object
echo "called getObjectName------------------"
set |findstr vo
pause
goto eof

:getObjectName
for /f "tokens=2 delims=:" %%i in ("!%~3!") do (
	echo %%i
	set %1=%%i
	echo "calling getObjectName---------------"
	set |findstr vo
)
goto eof

:eof