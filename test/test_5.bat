@echo on

if "%2"=="" setlocal enabledelayedexpansion
if "%2"=="getSuffix" goto getSuffix
if "%2"=="getFileName" goto getFileName
if "%2"=="getAbsPath" goto getAbsPath
goto main
goto eof

:main 
set file=".\aaa\bb  b\Mou sete st"
call test_5 suffix getSuffix !file!
echo !file!
echo suffix:!suffix!
call test_5 name getFileName !file!
echo fileName:!name!
call test_5 absPath getAbsPath !file!
echo absPath:!absPath!
pause
goto eof


rem get suffix of a file
rem
rem return string suffix
rem param_3 file name
:getSuffix
set %1=%~x3
goto eof

rem get file name
rem 
rem return string filename
rem param_3 file name
:getFileName
set %1=%~n3
goto eof

rem get absolute file path
rem
rem return string absolute file path
rem param_3 file name
:getAbsPath
set %1=%~dp3
goto eof

:eof