@echo off
rem use to detach the device and run an executor for authenticated device

if "%2"=="" setlocal enableDelayedExpansion
rem 支持 UTF-8 字符集
chcp 65001>nul


rem 强行关闭多余的 adb 
taskkill /f /im adb.exe>nul>nul
rem 重新开启 adb 服务
%~dp0adb.exe start-server>nul>nul
rem 当前正在处理的设备的序列号
set "array_processing_serial="
rem set newline=^



:main_loop
for /l %%a in ( ) do (
	rem 每秒刷新连接设备列表
	cls
	if defined array_processing_serial (
		echo 当前状态: 处理中...
	) else (
		echo 当前状态：等待设备连接中
	)
	echo ----------------------------- 当前设备列表 -----------------------------
	set "array_temp_serial="
	for /f "skip=1 tokens=1,2 delims=	" %%i in ('%~dp0adb.exe devices') do (
		rem 处理实时的设备列表
		echo %%i
		rem 标志设备是否为新加入的设备，true 标识设备是新加入的设备，false 为正在处理中的设备，默认为 true
		set "isNew=true"
		if "%%j"=="device" (
			rem if defined array_temp_serial (
			rem	set "array_temp_serial=!array_temp_serial!!newline!%%i"
			rem ) else (
			rem	set "array_temp_serial=%%i"
			rem )
			set "array_temp_serial=!array_temp_serial!%%i "
			if defined array_processing_serial (
				for %%o in (!array_processing_serial!) do if "%%i"=="%%o" set "isNew=false"
				if "!isNew!"=="true" start .\install-core.bat %%i
			) else (
				start .\install-core.bat %%i
			)
		)
	)
	set "array_processing_serial=!array_temp_serial!"
	rem 等待一秒
	ping -n 1 127.0.0.1>nul 1>nul
)

:eof