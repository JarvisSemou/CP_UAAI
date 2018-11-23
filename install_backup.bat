::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::																	::
::		  					CP_UAAI									::
::																	::
::											Author: Mouse.JiangWei	::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO off
setlocal enableDelayedExpansion
::支持 UTF-8 字符集
chcp 65001
::强行关闭多余的 adb 
taskkill /f /im adb.exe>nul>nul
::重新开启 adb 服务
adb start-server>nul>nul
::安装状态
::set install_state=0
::当前正在处理的设备的序列号
set "array_processing_serial="

:main_loop
for /l %%a in ( ) do (
	::每秒刷新连接设备列表
	cls
	if defined array_processing_serial (
		echo 当前状态：!array_processing_serial!
	) else (
		echo 当前状态：等待设备连接中
	)
	echo ----------------------------- 当前设备列表 -----------------------------
	set "array_temp_serial="
	for /f "skip=1 tokens=1 delims=	" %%i in ('%~dp0adb.exe devices') do (
		::处理实时的设备列表
		echo %%i
		::标志设备是否为新加入的设备，true 标识设备是新加入的设备，false 为正在处理中的设备，默认为 true
		set "isNew=true"
		set "array_temp_serial=!array_temp_serial!%%i "
		if defined array_processing_serial (
			for %%o in ("!array_processing_serial!") do (
				echo getting array_processing_serial item :%%~o
				if "%%i"=="%%~o" (
					set "isNew=false"
					echo changing isNew
				)
				echo !isNew!
			)
			if "!isNew!"=="true" start .\install-core.bat %%i
		
			set "array_temp_serial=%%i "
		) else (
			start .\install-core.bat %%i
		)
	)
	set "array_processing_serial=!array_temp_serial!"
	::等待一秒
	ping -n 5 127.0.0.1>nul 1>nul
)





		