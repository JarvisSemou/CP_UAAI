@echo off
setlocal enabaleDelayedExpansion
if "%1"=="" exit 
set mypath=%~dp0
set isUpdateSystem=false
set isSuccess=true
set errorStep=
:start
cls
echo �豸��%1
if !isSuccess!==false (
	cd %mypath%
	color cf
	adb wait-for-usb-device
	color 07
	set isSuccess=true
	goto !errorStep!
)

:install_optional
echo ------------------------------------------------------------
echo ׼����װ��ѡӦ��
cd .\app\optional
if not exist *.apk (
	echo δ���ֿ�ѡӦ��,������װ
	cd %mypath%
	goto push_system_package
)
for %%t in (*apk) do (
	echo ���ڰ�װ %%t
	%mypath%\adb.exe -s %1 install -r %%t
	if errorlevel 1 (
		set errorStep=install_optional
		goto failed
	)
)
echo ��ɿ�ѡӦ�ð�װ
cd %mypath%
goto push_system_package

:failed
set isSuccess=false
color 4f
echo �����豸 %1 �쳣������������¿�ʼ
pause
goto start