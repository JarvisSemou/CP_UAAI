@echo off
@rem 这是一个模板插件。
@rem 当前插件通过配置文件注册在下列生命周期里：onStartInstallApp、onStartPushFile
@rem 当前插件有两个行为：
@rem 1、当处于”onStartInstallApp“生命周期时，如果遇到序列号为”11111111“的设备，则
@rem 模拟按下电源键，然后从 （300，460）坐标开始模拟手指滑动到 （300，0） 坐标，
@rem 耗时 150 毫秒，然后打开系统设置界面
@rem 2、取消往所有设备推送 files 目录下所有文件的逻辑
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
if "%~2"=="opt" goto opt
goto eof

@rem return boolean
@rem param_3 周期名字
@rem param_4 序列号
:opt
	if "%~3"=="onStartInstallApp" (
		if "%~4"=="11111111" (
			adb.exe -s %~3 shell am force-stop com.android.settings
			adb.exe -s %~3 shell input keyevent KEYCODE_WAKEUP
			adb.exe -s %~3 shell input touchscreen swipe 300 460 300 0 150
			adb.exe -s %~3 shell am start -n com.android.settings/com.android.settings.Settings
		)
	)
	if "%~3"=="onStartPushFile" (
		set %~1=true
	)
goto eof

:eof