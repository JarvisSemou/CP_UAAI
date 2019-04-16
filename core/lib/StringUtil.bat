@echo off
if "%~2"=="" setlocal enableDelayedExpansion
@rem Provide string processing support
if not defiend %~0 (
	call %ObjectUtil% string newObject %~n0 "%~f0" 
	goto initStaticValue
)
:methodBranch
if "%~2"=="startWith" goto startWith
if "%~2"=="endWith" goto endWith
if "%~2"=="length" goto length
goto eof


:initStaticValue

goto methodBranch

@rem Determine if a string start with a specific character
@rem 
@rem return boolean Return true if string start with specific character,otherwise return false
@rem param_3 string The string to be judged
@rem param_4 string Begining of string
:startWith
set %~1=false
echo %~3|findstr /r /b "^%~4" 1>nul 2>nul && set %~1=true
goto eof

@rem Determine if a string end with a specific character
@rem 
@rem return boolean Return true if string end with specific character,otherwise return false
@rem param_3 string The string to be judged
@rem param_4 string Ending of string 
:endWith
set %~1=false
echo %~3|findstr /r /e "%~4$" 1>nul 2>nul && set %~1=true
goto eof

@rem Get a specific string length
@rem
@rem return int Length of specific string
@rem param_3 string String....
:length
set tmp_string_1=%~3
set length=0
:length_l_1
set tmp_string_1=%tmp_string_1:~0,-1%
set /a length=!length!+1
if "!tmp_string_1!" neq "" goto length_l_1
set %~1=!length!
goto eof

:eof