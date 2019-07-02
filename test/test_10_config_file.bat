@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
	for /f "eol=# delims=;" %%i in ( .\test_10_config_file.txt ) do (
		echo %%i
	)
pause 1>nul
goto eof


:eof