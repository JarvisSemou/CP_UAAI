@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
if "%~2"=="opt" goto opt
goto eof

:opt
adb.exe -s %~3 shell am force-stop com.android.settings
adb.exe -s %~3 shell input keyevent KEYCODE_WAKEUP
adb.exe -s %~3 shell input touchscreen swipe 300 460 300 0 150
adb.exe -s %~3 shell am start -n com.android.settings/com.android.settings.Settings

goto eof

:eof