@echo off
setlocal enableDelayedExpansion
rem 支持 UTF-8 字符集
chcp 65001>nul
if "%1"=="" exit 
rem 存储当前脚本路径
set "myPath=%~dp0"
rem 保存代码段执行成功与否状态，true 为执行成功，false 为执行失败，默认为 true
set "isSuccess=true"
rem 保存当前代码段位置,应该在进入代码段之后马上设置
set "nowStep="
rem 保存最后一次执行出错的代码段的位置
set "errorStep="
:start
set "nowStep=start"
cls
echo 设备：%1
if !isSuccess!==false (
	cd %myPath%
	color cf
	%myPath%\adb.exe -s %1 wait-for-usb-device
	color 07
	set "isSuccess=true"
	goto !errorStep!
)

:install_optional
set "nowStep=install_optional"
echo ------------------------------------------------------------
rem echo 准备安装可选应用
rem echo 准备安装应用
cd .\app\optional
if not exist *.apk (
	echo 未在 app\optional 目录学发现应用,跳过安装
	echo 注：不能使用中文名，且名字中不含空格，错误的文件名会使脚本出错
	@echo.
	@echo.
	@echo.
	@echo.
	@echo 按任意键退出安装
	pause >nul
	goto exit
)
set "i_o_tra=0"
for %%t in (*.apk) do (
	set /a "i_o_tra= !i_o_tra! + 1"
	echo 正在安装第 !i_o_tra! 个应用： %%t
	%myPath%\adb.exe -s %1 install -r %%t
	if errorlevel 1 (
		set "errorStep=!nowStep!"
		goto failed
	)
	echo %%t 安装完成
)
%myPath%\adb.exe -s %1 shell input keyevent KEYCODE_WAKEUP
%myPath%\adb.exe -s %1 shell input touchscreen swipe 300 460 300 0 150
%myPath%\adb.exe -s %1 shell am start -n com.android.settings/com.android.settings.Settings
echo 完成可选应用安装
goto exit

:failed
set "nowStep=failed"
set "isSuccess=false"
cls
color 4f
echo 连接设备 %1 异常，按任意键重新开始
pause>nul
goto start

:exit
color 2f
ping -n 5 127.0.0.1>nul 1>nul
exit