@echo off
setlocal enabledelayedexpansion

set a=1999999999
for /l %%i in (0,1,100000000) do (
	echo !a!
	set /a a=!a!+100000
	if %errorlevel%==1 goto end
)
:end
pause