@echo off
rem 
setlocal enabledelayedexpansion
set num=0
set name=""
for %%t in (*.apk) do (
	echo find apk %%t
	rename %%t !num!.apk
	set name=!num!.apk
	for /f tokens^=2^ delims^=^" %%i in ('%~dp0aapt.exe dump xmltree !name! AndroidManifest.xml^|findstr package') do rename !name! %%i.apk
	set /a num=!num!+1
)
taskkill -f -im aapt.exe
pause