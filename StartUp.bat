@echo off
if "%2"=="" setlocal enableDelayedExpansion
rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::																	::
rem ::		  					CP_UAAI									::
rem ::																	::
rem ::											Author: Mouse.JiangWei	::
rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem 
rem Some rules of development:
rem 	1.Variable name using camel rule,the object start with underline
rem 	2.Using double underline __ end of an array variable name,the 
rem 	  array element sparate with blackspace
rem 	3.StartUp script have to enable delayed expansion and other prohibition
rem 	4.Universalize to use UNICODE character set
rem		5.Universalize to explanation the script intent and meaning of parameter
rem		  what scritp accepted at scritp top unless script have not parameter
rem		6.Value object name start with vo_
rem		7.The base data type is void,int,boolean,string,vo
rem		8.Temporary value start with tmp_.Currently have 5 type:tmp_any,tmp_int,tmp_boolean,tmp_string,tmp_vo.
rem			There are four child temporary variables for each type.
rem
rem			tmp_any ---- can save any value,maybe string,maybe int or boolean,value object
rem					child variable:tmp_any_1,tmp_any_2,tmp_any_3,tmp_any_4
rem
rem			tmp_int ---- save int value what you want 
rem					child variable:tmp_int_1,tmp_int_2,tmp_any_3,tmp_any_4
rem
rem			tmp_boolean ---- save boolean value
rem					child variable:tmp_boolean_1,tmp_boolean_2,tmp_boolean_3,tmp_boolean_4
rem
rem			tmp_string ---- save string
rem 				child variable:tmp_string_1,tmp_string_2,tmp_string_3,tmp_string_4
rem
rem			tmp_vo ---- temporary value object
rem					child variable:tmp_vo_1,tmp_vo_2,tmp_vo_3,tmp_vo_4
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

rem 支持 UTF-8 字符集
chcp 65001 1>nul

if "%2"=="isPathLegitimate" goto isPathLegitimate

rem 当前工作根路径
set rootPath=%~dp0
rem bat 库文件路径
set libPath=%rootPath%core\lib\
rem 日志目录
set logPath=%rootPath%core\log\
rem impot core\lib\LogUtil.bat 日志工具
set _LogUtil=%libPath%LogUtil.bat
rem import core\lib\SystemCommandUtil 系统命令工具
set _SystemCommandUtil=%lib%SystemCommandUtil.bat
rem import core\lib\ObjectUtil 对象操作工工具
set _ObjectUtil=%lib%ObjectUtil.bat
rem import core\lib\StringUtil 字符串工具
set _StringUtil=%lib%StringUtil.bat
rem 当前核心目录
set corePath=""
rem 当前二进制文件目录
set binPath=""
rem 当前插件目录
set pluginsPath=""
rem 核心插件目录
set corePluginsPath=""
rem 用户文件夹，分别为 app、files。
set vo_userDir__=app files
rem 当前系统版本
rem set sysVer=""

goto main

:main
cd /d %rootPath%
rem 检测路径是否包含空格
call %~n0 boolean isPathLegitimate
if "!boolean!"=="false" (
	echo 当前路径 “%~dp0” 包含空格，请将此脚本应用放到无空格的路径中再运行
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 1>nul
	echo 按任意键退出。。。
	pause 1>nul
	goto eof
)
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
call %_LogUtil% void log %~n0 "unknow system version,application not running"
goto eof

rem Verify path legitimacy,if the path contain blackspace,the application will not work
rem 
rem return boolean if the path is not have blackspace that will return ture,otherwise return false
:isPathLegitimate
@call %~f0 boolean isPathLegitimate 1>nul 2>nul
set %1=true
if %errorlevel% geq 1 (
	set _LogUtil=.\core\lib\LogUtil.bat
	call !_LogUtil! void log %~n0 "Applicathin path:^"%~f0^" contain blackspace,application will not work."
	set %1=false
)
goto eof

rem 新 ADB 工具
:newCore
call %_LogUtil% void log %~n0 "use new core"
set corePath=%rootPath%core\win7-win10\
call %_LogUtil% void log %~n0 "core path:%corePath%"
set binPath=%corePath%bin\
call %_LogUtil% void log %~n0 "bin Path:%binPath%"
set pluginsPath=%corePath%plugins\
call %_LogUtil% void log %~n0 "plugins path:%pluginsPath%"
set corePluginsPath=%corePath%\corePluginsPath\
call %_LogUtil% void log %~n0 core plugins path:%corePluginsPath%"
call %_LogUtil% void log %~n0 "starting new core..."
rem call %corePath%core.bat
goto eof

rem 旧 ADB 工具
:oldCore
rem call %_LogUtil% void log %~n0 "use old core"
rem set corePath=%rootPath%core\winXP\
rem call %_LogUtil% void log %~n0 "core path:%corePath%"
rem set binPath=%corePath%bin\
rem call %_LogUtil% void log %~n0 "bin Path:%binPath%"
rem set pluginsPath=%corePath%plugins\
rem call %_LogUtil% void log %~n0 "plugins path:%pluginsPath%"
rem set corePluginsPath=%corePath%\corePluginsPath\
rem call %_LogUtil% void log %~n0 core plugins path:%corePluginsPath%"
rem call %_LogUtil% void log %~n0 "starting old core..."
rem call %corePath%core.bat
goto eof

:eof