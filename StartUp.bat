@echo off
rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::																	::
rem ::		  					CP_UAAI									::
rem ::																	::
rem ::											Author: Mouse.JiangWei	::
rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem 
rem Some rules of development:
rem 	1.Variable name using camel rule
rem 	2.Using double underline __ end of an array variable name,the 
rem 	  array element sparate with blackspace
rem 	3.Universalize to enable delayed expansion
rem 	4.Universalize to use UNICODE character set
rem		5.Universalize to explanation the script intent and meaning of parameter
rem		  what scritp accepted at scritp top unless script have not parameter
rem 
rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem Initalization of install scritp,it will call approptiate core according to 
rem system environment.Currently it just distinguish  win 10,win 8,win 7,win vista,
rem and win xp system.It will call 1.0.39 version adb tool for  win 10,win 8,win 7,
rem ,and call 1.0.31 version adb tool for win vista and win xp system.

rem win 10		10.0*
rem	win 8		6.[23]*
rem	win 7		6.1.*
rem	win vista	6.0
rem	win xp		5.[1-2]
rem	win 2000	5.0

setlocal enableDelayedExpansion
rem 支持 UTF-8 字符集
chcp 65001 1>nul

rem 当前工作根路径
set rootPath=%~dp0
rem bat 库文件路径
set libPath=%rootPath%core\lib\
rem 日志目录
set logPath=%rootPath%core\log\
rem impot core\lib\LogUtil.bat
set _LogUtil=%libPath%LogUtil.bat
rem 当前核心目录
set corePath=""
rem 当前二进制文件目录
set binPath=""
rem 当前插件目录
set pluginsPath=""
rem 用户文件夹，分别为 app、files。
set userDir__=app files
rem 当前系统版本
rem set sysVer=""

:main
cd /d %rootPath%
rem 检测是否是 win 10 系统
ver | findstr "10\.0\.[0-9]*" 1>nul 2>nul & if %errorlevel% equ 0 goto newCore
rem 检测是否是 win 8 系统
ver | findstr "6\.[23]\.*[0-9]*" 1>nul 2>nul & if %errorlevel% equ 0 goto newCore
rem 检测是否是 win 7 系统
ver | findstr "6\.1\.[0-9]*" 1>nul 2>nul & if %errorlevel% equ 0 goto newCore
rem 检测是否是 win vista 系统
ver | findstr "6\.0\.*[0-9]*" 1>nul 2>nul & if %errorlevel% equ 0 goto oldCore
rem 检测是否是 win xp 系统
ver | findstr "5\.[12]\.[0-9]*" 1>nul 2>nul & if %errorlevel% equ 0 goto oldCore
call %_LogUtil% void log %0 "unknow system version,application not running"
goto eof

rem 新 ADB 工具
:newCore
call %_LogUtil% void log %0 "use new core"
set corePath=%rootPath%core\win7-win10\
call %_LogUtil% void log %0 "core path:%corePath%"
set binPath=%corePath%bin\
call %_LogUtil% void log %0 "bin Path:%binPath%"
set pluginsPath=%corePath%plugins\
call %_LogUtil% void log %0 "plugins path:%pluginsPath%"
call %_LogUtil% void log %0 "starting new core..."
call %corePath%core.bat
goto eof

rem 旧 ADB 工具
:oldCore
rem call %_LogUtil% void log %0 "use old core"
rem set corePath=%rootPath%core\winXP\
rem call %_LogUtil% void log %0 "core path:%corePath%"
rem set binPath=%corePath%bin\
rem call %_LogUtil% void log %0 "bin Path:%binPath%"
rem set pluginsPath=%corePath%plugins\
rem call %_LogUtil% void log %0 "plugins path:%pluginsPath%"
rem call %_LogUtil% void log %0 "starting old core..."
rem call %corePath%core.bat
goto eof

:eof