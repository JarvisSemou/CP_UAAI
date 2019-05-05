if "%~2"=="setV" goto setV
start /shared /b .\test_2.bat 
ping -2 127.0.0.1 >nul
set aaa
pause
goto eof

:setV
set aaa=%~3
goto eof

:eof