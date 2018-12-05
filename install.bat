::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::																	::
::		  					CP_UAAI									::
::																	::
::											Author: Mouse.JiangWei	::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO off
setlocal enableDelayedExpansion
rem 支持 UTF-8 字符集
chcp 65001>nul
rem 强行关闭多余的 adb 
taskkill /f /im adb.exe>nul>nul
rem 重新开启 adb 服务
adb start-server>nul>nul
rem 当前正在处理的设备的序列号
set "array_processing_serial="
copy /y nul array_processing_serial>nul 1>nul

:main_loop
for /l %%a in ( ) do (
	rem 每秒刷新连接设备列表
	cls
	set /p array_processing_serial=<array_processing_serial
	if defined array_processing_serial (
		echo 当前状态: 处理中...
	) else (
		echo 当前状态：等待设备连接中
	)
	echo ----------------------------- 当前设备列表 -----------------------------
	rem 折中方法，暂时通过将数组存到文件的方法解决遍历的问题
	copy /y nul array_new_serial>nul 1>nul
	copy /y nul array_temp_serial>nul 1>nul
	adb devices>array_new_serial
	for /f "skip=1 tokens=1,2 delims=	" %%i in (array_new_serial) do (
		rem 处理实时的设备列表
		echo %%i
		rem 标志设备是否为新加入的设备，true 标识设备是新加入的设备，false 为正在处理中的设备，默认为 true
		set "isNew=true"
		if "%%j"=="device" (
			echo %%i>>array_temp_serial
			if defined array_processing_serial (
				for /f %%o in (array_processing_serial) do if "%%i"=="%%o" set "isNew=false"
				if "!isNew!"=="true" start .\install-core.bat %%i
			) else (
				start .\install-core.bat %%i
			)
		)
	)
	copy /y array_temp_serial array_processing_serial>nul 1>nul
	rem 等待一秒
	ping -n 1 127.0.0.1>nul 1>nul
)