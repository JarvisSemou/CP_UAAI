@echo on

if not defined Object goto init
if "%2"=="" setlocal enableDelayedExpansion
if "%2"=="showName" goto showName
if "%2"=="getObjectName" goto getObjectName
if "%2"=="getObjectType" goto getObjectType
if "%2"=="newObject" goto newObject
if "%2"=="newValueObject" goto newValueObject
if "%2"=="isGlobalObjectListNull" goto isGlobalObjectListNull
if "%2"=="isObjectPathRight" goto isObjectPathRight
goto eof

:showName
echo %3
goto eof

:getObjectName
set %1=null
goto eof

:getObjectType
set %1=%0
goto eof

rem 全局对象列表
set globalObjectList=null

rem 判断全局对象列表是否为空
rem
rem return 如果为空返回 true ，反之返回 false
:isGlobalObjectListNull
if "!globalObjectList!"=="null" (
	set %1=true
	goto eof
)
if "!globalObjectList!"=="" (
	set %~1=true
	goto eof
)
set %1=false
goto eof

rem 判断对象路径是否正确
rem 
rem return 如果正确则返回 true，反之返回 false
rem param_3 要判断的程序路径
:isObjectPathRight
if exist "%~3" (
	set %1=true
) else (
	set %1=false
)
goto eof

rem 根据对象名称新建一个对象
rem 
rem return object 新对象名称,如果对象路径错误，则返回 null
rem param_3 对象名称
rem param_4 对象文件路径
:newObject 
call %0 boolean isObjectPathRight %~4
if "!boolean!"=="false" (
	set %1=null
	echo object path not right
	goto eof
)
call %0 boolean isObjectExist %~3
if !boolean!=="true" (
	set %1=null
	echo object %~3 is exist
	goto eof
)
set %~3=%~4
call %0 boolean isGlobalObjectListNull
if "!boolean!"=="true" (
	set globalObjectList="%~3"
) else (
	set globalObjectList=!globalObjectList!,"%~3"
)
echo the object %~3 was added on global object list 
echo !globalObjectList!
goto eof

:newValueObject

goto eof

:eof