@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v0.0.4													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2020.5.17													::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem 插件名称：模板插件
@rem 插件版本：0.0.2
@rem 插件描述：这是一个模板插件。
@rem 生命周期：onStartInstallApp、onStartPushFile        （指示当前插件通过配置文件注册在哪个生命周期里）
@rem 插件功能：
@rem	1、当处于”onStartInstallApp“生命周期时，如果遇到序列号为”11111111“的设备，则
@rem 	模拟按下电源键，然后从 （300，460）坐标开始模拟手指滑动到 （300，0） 坐标，
@rem 	耗时 150 毫秒，然后打开系统设置界面
@rem 	2、取消往所有设备推送 files 目录下所有文件的逻辑
@rem ---------------------------------------------------------------------
@rem 注：以后将使用传输号代替序列号识别不同设备
@rem ---------------------------------------------------------------------
if "!RUN_ONCE!" neq "%RUN_ONCE%" setlocal enableDelayedExpansion
if "%~2"=="opt" goto opt
goto eof

@rem 生命周期回调接口
@rem
@rem return boolean
@rem param_3 string 周期名字
@rem param_4 string 序列号
@rem param_5 int	传输号
@rem param_6 string 文件的绝对路径
:opt
	if "%~3"=="onStartInstallApp" (
		if "%~4"=="11111111" (
			adb.exe -t %~5 shell am force-stop com.android.settings
			adb.exe -t %~5 shell input keyevent KEYCODE_WAKEUP
			adb.exe -t %~5 shell input touchscreen swipe 300 460 300 0 150
			adb.exe -t %~5 shell am start -n com.android.settings/com.android.settings.Settings
		)
	)
	if "%~3"=="onStartPushFile" (
		set %~1=true
	)
goto eof

:eof