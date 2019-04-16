@echo on
cd /d %~dp0
setlocal enabledelayedexpansion
set ttttmp=null
for /f %%i in ( test_11.txt ) do (
	 set  ttttmp=%%i
	 echo !ttttmp!
	 ping -n 2 127.0.0.1 1>nul 
	
)
set /p ttttmp=<test_11.txt
echo !ttttmp!
set /p ttttmp=<test_11.txt
echo !ttttmp!
pause