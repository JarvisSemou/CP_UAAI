@echo off


if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)

goto eof

:main
call %Object%
set value="name_1:value_1","name_2:value_2","name_3:value_3","name_4:value_4"
for %%i in (!value!) do (
	for /f "tokens=2 delims=:" %%t in (%%i) do (
		echo %%t
	)
)
pause >nul
goto eof


:eof