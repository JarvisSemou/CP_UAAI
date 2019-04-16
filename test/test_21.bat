@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="changeList" goto changeList
goto eof

:main
set list="Mouse","Mouse_2","notmouse","nomouse_2"
for %%i in (!list!) do (
	echo for _1,now list :!list!
	echo value i:%%i
	for %%i in (!list!) do (
		echo for _2,now list:!list!
		echo value i:%%i
		set list=!list!,"Mouse"
	)
)
pause
for %%i in (!list!) do (
	pause
	echo now list value: !list!
	echo changing
	call %~n0 void changeList 
)


goto eof

:changeList
echo in "changeList" mehtod
echo set length
set length=0
echo for
for %%i in (!list!) do (
	set /a length=!length!+1
}
if !length!==0 goto eof
set /a length=!length!-1
set tmp_i_1=1
set tmp_any_1=
echo for 2
for %%i in (!list!) do (
	if "!tmp_i_1!"=="!length!" goto changeList_l_1
	if "!tmp_any_1!"=="" (
		set tmp_any_1="%%~i"
	) else (
		set tmp_any_1=!tmp_any_1!,"%%~i"
	)
	set /a tmp_i_1=!tmp_i_1!+1
)
:changeList_l_1
set list=!tmp_any_1!
echo list changed,now list value:!list!
goto eof

:eof