@echo off
chcp 65001 1>nul
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v0.0.6													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2021.01.21													::
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
@rem 注：
@rem 	1、以后将使用传输号代替序列号识别不同设备
@rem	2、onScriptFirstStart 只接收 param_3 参数
@rem 	3、只有 onBeforeInstallingApp、onAfterInstallingApp、onBeforePushingFile、
@rem		onAfterPushingFile 能接收到 param_6 参数
@rem ---------------------------------------------------------------------
@rem 配置调试信息显示，true 为显示调试信息，false 反之，默认为 false
set DEBUG=false
@rem 配置 call 或命令行调用 main 方法时是否继承父进程的延时变量状态，true 为继承，false 反之，默认为 false
@rem 注：当值为 false 时，此常量的设置可以被 FORCE_ENTER_MAIN_WITH_NEW_DELAYED_EXPANSION 常量覆盖
set INHERIT_DELAYED_EXPANSION_STATE=false
@rem 配置 call 或命令行调用 脚本方法 时，是否默认进入 mian 方法，true 为默认进入，false 反之，默认为 false
set DEFAULT_ENTER_MAIN=false
@rem 配置 start 调用 脚本方法 时，是否默认进入 main 方法，true 为默认进入，false 反之，默认为 false
set DEFAULT_ENTER_START_MAIN=false
@rem 配置是否允许在已开启延时变量的情况下主动通过 call 调用 main 方法，true 为允许，false 反之，默认为 false
@rem 注：开启后可能会造成死递归
set FORCE_ENTER_MAIN_WITH_DELAYED_EXPANSION=false
@rem 配置 call 重复进入 main 方法时，是否开启新的延时变量拓展（用来隔离变量），true 为开启，false 反之，默认为 false
set FORCE_ENTER_MAIN_WITH_NEW_DELAYED_EXPANSION=false
@rem ==============================================================
if "%DEBUG%"=="true" (
    echo 当前指令：
    echo %cmdcmdline% 
    echo.
    echo 当前参数：
    echo 参数 0：%0 参数 1：%1  参数 2：%2  参数 3：%3  参数 4：%4
    echo 参数 5：%5 参数 6：%6  参数 7：%7  参数 8：%8  参数 9：%9
    echo.
    if "!RUN_ONCE!" neq "%RUN_ONCE%" (
        echo 当前延时变量状态：延迟变量未开启
    ) else (
        echo 当前延时变量状态：延迟变量已开启
    )
    echo 按任意键继续运行 --------------------》
    pause 1>nul
)
@rem ==============================================================
@rem 根据第一个参数判断脚本的启动方式（调用方法或启动脚本）。
@rem %~1 为 void、int、boolean、string、vo 时认为是调用方法，否则是启动脚本。
if "%~1"=="void" goto methodBrach
if "%~1"=="int" goto methodBrach
if "%~1"=="boolean" goto methodBrach
if "%~1"=="string" goto methodBrach
if "%~1"=="vo" goto methodBrach
goto beforeMain

@rem 在这里判断方法名并跳转到相应的方法流程分支
:methodBrach
if "%~2"=="opt" goto opt
goto afterMethodBrach

@rem 控制默认进入 main 方法
:afterMethodBrach
@rem ----------------------------------------------------------------
    @rem 尝试进入显式调用的 main 方法
    if "%~2"=="main" goto beforeMain
    @rem 判断是否默认进入 main 方法
    for /f "tokens=1,2" %%r in ('echo %CMDCMDLINE%') do (
        if "!RUN_ONCE!" neq "%RUN_ONCE%" (
            @rem 脚本方法以 start 方式调用（第一次启动）
            if "%%s"=="/K" (
                if "%DEFAULT_ENTER_START_MAIN%"=="true" goto beforeMain
            )
        )
        @rem call、直接或非第一次 start 方式调用脚本方法
        if "%DEFAULT_ENTER_MAIN%"=="true" goto beforeMain
    )
    if "%DEBUG%"=="true" echo 方法 %~2 不存在
@rem ----------------------------------------------------------------
goto eof

@rem 控制是否可以进入 main 方法
:beforeMain
@rem ----------------------------------------------------------------
    if "%FORCE_ENTER_MAIN_WITH_DELAYED_EXPANSION%"=="false" (
        if "!RUN_ONCE!"=="%RUN_ONCE%" (
            if "%DEBUG%"=="true" echo 延时变量已启用，已禁止重复进入 main 方法
            goto eof
        )
    )
@rem ----------------------------------------------------------------
@rem 进入 main 方法前开两层局部变量扩展保护 path 变量，第一层确保能用 !path!,
@rem 使 path 不受空格影响，第二层保护 path 变量。
    for /f "tokens=1,2" %%r in ('echo %CMDCMDLINE%') do (
        if "!RUN_ONCE!" neq "%RUN_ONCE%" (
            @rem 对于第一次 start 方式和直接启动脚本，总是打开延时变量
            if "%%s"=="/K" goto beforeMain_l_1
            if "%%s"=="/c" goto beforeMain_l_1
        )
        @rem 对于第一次的 call 和非第一次的 call、start、直接地调用脚本，根据配置设置延时变量状态
        if "%INHERIT_DELAYED_EXPANSION_STATE%"=="true" (
            @rem 继承延时变量状态
            goto beforeMain_l_2
        ) else (
            @rem 不继承延时变量状态，如果是第一次启动，就打开延时变量扩展保护
            if "!RUN_ONCE!"=="%RUN_ONCE%" (
                @rem 根据配置强制每次都开启延时变量拓展保护
                if "%FORCE_ENTER_MAIN_WITH_NEW_DELAYED_EXPANSION%"=="true" goto beforeMain_l_1
                goto beforeMain_l_2
            ) else (
                goto beforeMain_l_1
            )
        )
    )
    :beforeMain_l_1
    setlocal enableDelayedExpansion
    set path=%~dp0;!path!
    setlocal enableDelayedExpansion
    :beforeMain_l_2
@rem ----------------------------------------------------------------
goto initStaticValue

:initStaticValue
    
goto main

@rem 主方法（脚本入口）
:main

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