@echo on

if "%2"=="" setlocal enabledelayedexpansion
if "%2"=="getSuffix" goto getSuffix
if "%2"=="getFileName" goto getFileName
goto main
goto eof

:main 
set a___=aaa
set |findstr a___
setlocal 
	set |findstr a___
	set a___=bbb
	set |findstr a___
	goto test
	:back
	set |findstr a___
endlocal
set |findstr a___
pause
goto eof

:test
set |findstr a___
endlocal
goto back

rem get suffix of a file
rem
rem return string suffix
rem param_3 file name
:getSuffix
set %1=%~x3
goto eof

rem get file name

:getFileName
set %1=%~n3
goto eof

:eof