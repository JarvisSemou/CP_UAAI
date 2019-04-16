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

rem ȫ�ֶ����б�
set globalObjectList=null

rem �ж�ȫ�ֶ����б��Ƿ�Ϊ��
rem
rem return ���Ϊ�շ��� true ����֮���� false
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

rem �ж϶���·���Ƿ���ȷ
rem 
rem return �����ȷ�򷵻� true����֮���� false
rem param_3 Ҫ�жϵĳ���·��
:isObjectPathRight
if exist "%~3" (
	set %1=true
) else (
	set %1=false
)
goto eof

rem ���ݶ��������½�һ������
rem 
rem return object �¶�������,�������·�������򷵻� null
rem param_3 ��������
rem param_4 �����ļ�·��
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