@ECHO OFF
adb kill-server
adb start-server
setlocal enableDelayedExpansion
set install_state=0
:start
cls
if "%install_state%"=="0" (
	echo �ȴ� usb �豸��ʼ��װ���
	set install_state=4
)
adb devices>devices_serial
set tra=1
set serial_1=
set serial_2=
set serial_3=
set serial_4=
for /f "skip=1 tokens=1 delims=	" %%i in (devices_serial) do (
	if !tra!==1 (
		set serial_1=%%i
		set tra=2
	) else (
		if !tra!==2 (
			set serial_2=%%i
			set tra=3
		) else (
			if !tra!==3 (
				set serial_3=%%i
				set tra=4
			) else (
				set serial_4=%%i
				set tra=1
			) 
		)
	)
)
echo serial_1:"!serial_1!"
echo serial_2:"!serial_2!"
echo serial_3:"!serial_3!"
echo serial_4:"!serial_4!"
echo ---------------------------
start .\install_2.0-core.bat !serial_1!
start .\install_2.0-core.bat !serial_2!
start .\install_2.0-core.bat !serial_3!
start .\install_2.0-core.bat !serial_4!
echo �������豸�������������ʼ��һ������
pause
goto start