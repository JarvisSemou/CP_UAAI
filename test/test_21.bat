@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="changeList" goto changeList
goto eof

:main
set list="Mouse","Mouse_2","notmouse","nomouse_2"
goto main_l_1
for %%i in (!list!) do (
	echo for _1,now list :!list!
	echo value i:%%i
	for %%i in (!list!) do (
		echo for _2,now list:!list!
		echo value i:%%i
		set list=!list!,"Mouse"
	)
)
echo =================================
pause
:main_l_1
set list="Mouse_1","Mouse_2","notmouse_3","nomouse_4","mmm_5","m_6"
for %%i in (!list!) do (
	echo In first for loop, value i is:  %%~i  , list value is:  !list!
	call %~n0 void changeList 
)


goto eof

:changeList
echo In "changeList" mehtod
set length=0
for %%i in (!list!) do (
	set /a length=!length!+1
)
echo list length:  !length!
if !length!==0 goto eof
set /a length=!length!
set tmp_i_1=1
set tmp_any_1=
for %%i in (!list!) do (
	if "!tmp_i_1!"=="!length!" goto changeList_l_1
	echo In Second for loop, value i is:  %%~i  , list value is:  !list!	
	if "!tmp_any_1!"=="" (
		set tmp_any_1="%%~i"
	) else (
		set tmp_any_1=!tmp_any_1!,"%%~i"
	)
	set /a tmp_i_1=!tmp_i_1!+1
)
:changeList_l_1
set list=!tmp_any_1!
echo "changeList" method result, list value:  !list!
goto eof

:eof