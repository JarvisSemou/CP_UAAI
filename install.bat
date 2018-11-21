::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::																	::
::		  					CP_UAAI									::
::																	::
::											Author: Mouse.JiangWei	::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO on
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
set "array_processing_serial=0000000000"

:main_loop
for /l %%a in ( ) do (
	::每秒刷新连接设备列表
	cls
	echo !array_processing_serial!
	echo ----------------------------- 当前设备列表 -----------------------------
	for /f "skip=1 tokens=1 delims= " %%i in ('adb devices') do (
		::处理实时的设备列表
		echo %%i
		::标志设备是否为新加入设备，true 标识设备是新加入设备，false 为正在处理中的设备，默认为 true
		set "isNew=true"
		set "array_temp_serial= "
		if "!array_processing_serial!"=="" (
			set "array_temp_serial=%%i "
		) else (
			set array_temp_serial=!array_temp_serial!%%i 
			for %%o in ("!array_processing_serial%!") do (
				if "%%i"=="%%o" set "isNew=false"
			)
			if "!isNew!"=="true" start .\install-core.bat %%i
		)
	)
	set "array_processing_serial=!array_temp_serial!"
	::等待一秒
	ping -n 10 127.0.0.1>nul 1>nul
)





		