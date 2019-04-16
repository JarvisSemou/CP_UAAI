
setlocal enabledelayedexpansion

goto main
goto eof

:main
set _value="aaa","bbb","bbb","ccc","ddd"
for %%i in (%_value%) do (
	echo %%~i
)
pause
goto eof

:eof