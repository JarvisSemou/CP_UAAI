
setlocal enabledelayedexpansion

goto main
goto eof

:main
set _value_01=%~dp0Object.bat
call %_value_01% vo getObjectType
echo !vo!
call %_value_01% vo getObjectName _value_01
echo !vo!
pause
goto eof

:eof