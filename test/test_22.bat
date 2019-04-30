@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)

goto eof

:main
set list_s="Mouse","Mouse_2","notmouse","nomouse_2"
set list_i="1","2","3","4","5","6"
for %%i in (!list_i!) do (
	echo in first for,now i value: %%~i
	for %%i in (!list_s!) do (
		echo in secoend for,now i value:%%~i
	)
)
pause


goto eof



:eof