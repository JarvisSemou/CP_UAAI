::aaaaa
::bbbbb
::ccccc
::ddddd
setlocal enabledelayedexpansion
set /p s_a=<%~nx0
set /p s_b=<%~nx0
set /p s_c=<%~nx0
set /p s_d=<%~nx0
set s_a
set s_b
set s_c
set s_d
set serial=1
set s_tmp=
for /f %%i in ( %~nx0 ) do (
	if !serial! geq 4 goto :break
	set s_tmp=%%i
	set s_tmp=%s_tmp:~2%
	set /p a_!serial!=!s_tmp!
	set /a serial=!serial!+1
) 
:break
set a_1
set a_2
set a_3
set a_4
pause