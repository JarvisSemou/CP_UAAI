@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
goto eof
 
:main
	if exist ".\*.bat" (
		echo Has bat file --- flow 1
		if exist ".\*.txt" (
			echo Has txt file --- flow 2
			for %%t in (.\*) do (
				echo Now file : %%t --- flow 3
				if "%%~xt"==".txt" (
					echo Fined txt file, now break for  --- flow 4
					goto l_1
				)
			)
			:l_1
			echo Break for ---- flow 5
		)
		echo ---- flow 6
	)
	echo ---- flow 7
	pause
goto eof


:eof