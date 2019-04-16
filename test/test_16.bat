@echo off
if "%~2"=="" (
setlocal enabledelayedexpansion
goto main
)
if "%~2"=="length" goto length
goto eof

:main
set count=1
call %~n0 int length "Mouse"
goto eof

@rem param_3 int string
:length
setlocal enabledelayedexpansion
set tmp=%~3
if !count!==10 (
	set %~1=!count!
	goto eof
)
set /a count=!count!+1
echo !count!:!tmp!
call %~n0 int length !tmp!!count!
echo !count!:!tmp!     !int!
endlocal
goto eof

:eof 