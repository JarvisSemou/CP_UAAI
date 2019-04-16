@echo off
if "%~2"=="" setlocal enabledelayedexpansion
if "%~2"=="test" goto test
set list="Mouse_q","Mou_1","mouse_2","mo_2","MOuse_4","Mouse_222"
set boolean=false
for %%i in (!list!) do (
	echo %%~i|findstr /b "^Mouse" 1>nul 2>nul && set boolean=true
	if !boolean!==true (
		echo %%~i
	)
	set boolean=false
)
echo =====================
for %%i in (!list!) do (
	echo %%~i|findstr /e "2$" 1>nul 2>nul && set boolean=true
	if !boolean!==true (
		echo %%~i
	)
	set boolean=false
)
pause>nul
echo =====================
call %~n0 boolean test Mouse_222 Mouse
echo !boolean!
pause >nul
exit

:test
set %~1=false
echo %~3|findstr /b "^%~4" 1>nul 2>nul && set %~1=true
