@echo off
setlocal enabaleDelayedExpansion
if "%1"=="" exit 
set mypath=%~dp0
set isUpdateSystem=false
set isSuccess=true
set errorStep=
:start
cls
echo 设备：%1
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
echo 准备安装可选应用
cd .\app\optional
if not exist *.apk (
	echo 未发现可选应用,跳过安装
	cd %mypath%
	goto push_system_package
)
for %%t in (*apk) do (
	echo 正在安装 %%t
	%mypath%\adb.exe -s %1 install -r %%t
	if errorlevel 1 (
		set errorStep=install_optional
		goto failed
	)
)
echo 完成可选应用安装
cd %mypath%
goto push_system_package

:failed
set isSuccess=false
color 4f
echo 连接设备 %1 异常，按任意键重新开始
pause
goto start