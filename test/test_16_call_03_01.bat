echo off
echo -------------------------------------------
echo delayed
echo -------------------------------------------
setlocal enabledelayedexpansion
echo -----  call test_16_call_03 -h
call test_16_call_03 -h
pause
echo -----  call test_16_call_03 void showSimpleDescription
call test_16_call_03 void showSimpleDescription
pause
echo -----  call test_16_call_03 int getNum
call test_16_call_03 int getNum
echo int result: %int%
pause
echo -----  call test_16_call_03 void setEnvValue
pause 
set 
pause
call test_16_call_03 void setEnvValue
set
pause
endlocal
set 
pause

echo -------------------------------------------
echo no delayed
echo -------------------------------------------
echo -----  call test_16_call_03 -h
call test_16_call_03 -h
pause
echo -----  call test_16_call_03 void showSimpleDescription
call test_16_call_03 void showSimpleDescription
pause
echo -----  call test_16_call_03 int getNum
call test_16_call_03 int getNum
echo int result: %int%
pause
echo -----  call test_16_call_03 void setEnvValue
pause 
set 
pause
call test_16_call_03 void setEnvValue
set
pause