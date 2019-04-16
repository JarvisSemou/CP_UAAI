
echo %~n0
echo %~f0
echo %~f1
if "%~1"=="" call %~n0 .\%~n0
pause