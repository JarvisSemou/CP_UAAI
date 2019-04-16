@echo on
if "%2"=="" setlocal enabledelayedexpansion

if "%2"=="testPath" goto testPath
goto main
goto eof

:main
set aaa=.\a\aaa.bat
call test_6.bat void testPath "^"%~f0^""
call %aaa%
pause
goto eof

:testPath
call %~f0 void testPath 1>nul 2>nul
echo 
if %errorlevel% geq 1 echo path 11111111111111111111111111111111111111
goto eof

:eof