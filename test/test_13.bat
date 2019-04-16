@echo off
rem xing neng ce shi 
if "%~2"=="test_call" goto test_call
setlocal enabledelayedexpansion
set list="Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_2","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_2","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_2","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_2","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_1","Mouse","Mouse_2"
set tmp_any="null"
set count=0
set start_time=%time%
rem da xun huan
for /l  %%t in (1,1,100) do (
	echo "============================================"
	set /a count=!count!+1
	echo start time: !start_time!
	echo start: !time!
	echo count: !count!
	rem mo ni cha xun 
	for %%i in (!list!) do (
		if "%%i"=="Mouse_2"  set %%i=
	)
	rem mo ni lie biao xiu gai 
	for %%i in (!list!) do (
		if "%%i" neq "Mouse_2" (
			if "%%i"==null (
				set tmp_any="%%i"
			) else (
				set tmp_any=!tmp_any!,"%%i"
			)
		)
	)
	for %%i in (!list!) do (
		if "%%~i"=="Mouse_2"  (
			echo %%i|findstr "^Mouse_"
			if %errorlevel%==0 (
				echo true
			) else (
				echo false
			)
		)
	)
	set tmp_any=null
	echo end:  !time!
	echo "============================================"
)
echo start to test call
set start_time=!time!
set count=0
pause >nul
for /l  %%t in (1,1,100) do (
	echo "============================================"
	set /a count=!count!+1
	echo start time: !start_time!
	echo start: !time!
	echo count: !count!
	for /l %%i in (1,1,30) do (
		call %~n0 boolean test_call null null null null null
	)
	echo end:  !time!
	echo "============================================"
)
goto eof

:test_call
for %%i in (!list!) do (
	if "%%i"=="Mouse_2"  set %%i=
)
set %~1=true
goto eof

:eof