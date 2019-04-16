@echo on
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="decode" goto decode
goto eof

:main
call %~n0 int decode "Mouse   "
echo !int!
pause
goto eof


@rem Decode
@rem
@rem retuen string Msg
@rem param_3 string Msg
:decode
set result=
set start=
set length=0
set tmp_s_1=
if "%~3"=="" (
	set %~1=0
	goto eof
)
set tmp_s_1=%~3
:decode_loop_1
set tmp_s_1=!tmp_s_1:~0,-1!
set /a length=!length!+1
if "!tmp_s_1!" neq "" goto decode_loop_1
set %~1=!length!
goto eof

:eof