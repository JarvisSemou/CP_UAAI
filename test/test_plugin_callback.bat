@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v0.0.3													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2020.5.12													::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem 插件名称：StartUP.bat 插件回调接口测试插件
@rem 插件版本：0.0.1
@rem 插件描述：用来测试 StartUP.bat 对插件的回调接口是否正常
@rem 生命周期：onScriptFirstStart、onCoreStart、onStartInstallApp、onBeforeInstallingApp、
@rem            onAfterInstallingApp、onInstallAppCompleted、onStartPushFile、
@rem            onBeforePushingFile、onAfterPushingFile、onPushFileCompleted、
@rem            onCoreLogicFinish、onCoreFinish
@rem 插件功能：
@rem	1、测试 StartUp.bat 的所有回调接口是否能正常回调
@rem 	2、测试 StartUp.bat 的所有回调接口传参是否正确
@rem ---------------------------------------------------------------------
@rem 注：以后将使用传输号代替序列号识别不同设备
@rem ---------------------------------------------------------------------
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
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
    if "!test_plugin_callback_count!"=="" (
        set test_plugin_callback_count=1
        echo 开始执行 StartUp.bat 生命周期回调接口测试
    )
    echo #######################################
	echo 第 !test_plugin_callback_count! 次回调插件
	echo 生命周期: %~3
    echo 序列号：%~4
    echo 传输号：%~5
    echo 文件绝对路径：%~6
    echo 请检查回调插件次数及插件参数是否正确，按任意键继续
    echo #######################################
    pause 1>nul
    echo 完成回调接口测试
    set /a test_plugin_callback_count=!test_plugin_callback_count! + 1
goto eof

:eof