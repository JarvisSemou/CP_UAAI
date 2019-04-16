setlocal enabledelayedexpansion
set a=aaa
set a=bbb
echo %a%
echo !a!
set a=ccc
echo %a%
echo !a!
pause