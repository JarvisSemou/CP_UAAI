@echo off
if "%~2"=="" setlocal enableDelayedExpansion
@rem Provide control for object,usually set object value and get object,there are all use by value name.
@rem Caption!The object was globally of application,tha means the object just has one in the application,
@rem if change the object,that will effect every model in application.
if not defined %~n0 (
	set %~n0=%~f0
	goto initStaticValue
)
:methodBranch
if "%~2"=="isStaticValueExist" goto isStaticValueExist
if "%~2"=="isValueObjectExist" goto isValueObjectExist
if "%~2"=="newValueObject" goto newValueObject
if "%~2"=="isObjectExist" goto isObjectExist
if "%~2"=="newObject" goto newObject
if "%~2"=="deleteValueObject" goto deleteValueObject
if "%~2"=="deleteObject" goto deleteObject
goto eof

@rem static value
:initStaticValue
@rem This list format is: "","","",...,""
set globalObjectList=null
@rem This list format is: "","","",...,""
set globalValueObjectList=null
goto methodBranch

@rem Check the static value exist or not
@rem
@rem return boolean If static value exist that will return true,otherwise return false
@rem param_3 The object or value object who want to check the value
@rem param_4 The value want to check
@rem param_5 boolean If this flag setted and the param value equal true,the application will exit when the param_4 were exist
:isStaticValueExist
call %LogUtil% void log %~n0 "The %~3 want know the static value exist or not :%~4" 
if defined %~4 (
	call %LogUtil% void log %~n0 "The static value '%~4' was existed"
	if /i "%~5"=="true" exit
	set %~1=true
) else (
	call %LogUtil% void log %~n0 "The static value '%~4' was not existed"
	set %~1=false
)
goto eof

@rem Check the global value object exist or not
@rem
@rem return boolean If value object exist that will return true,otherwise return false
@rem param_3 Value object name that want to determine whether it exists
:isValueObjectExist
call %LogUtil% void log %~n0 "Determine the value object '%~3' it exists"
if "!globalValueObjectList!"=="null" (
	call %LogUtil% void log %~n0 "value object '%~3' was exist"
	set %~1=true
) else (
	call %LogUtil% void log %~n0 "value object '%~3' does not exist"
	set %~1=false
)
goto eof

@rem Create a new value object by name,if the object not exit or value object was exist,that will return null
@rem
@rem return string New value object name,if object does not exist or value object early exist that will return null
@rem param_3 string Object name
@rem param_4 string Value object name
:newValueObject
if "!globalObjectList!"=="null" (
	call %LogUtil% void log %~n0 "globalObjectList was null,object '%~3' does not exist, value object '%~4' will not create"
	set %~1=null
	goto eof
)
call %~n0 boolean isObjectExist %~3
if "!boolean!"=="false" (
	call %LogUtil% void log %~n0 "Object '%~3' does not exist, value object '%~4' will not create"
	set %~1=null
	goto eof
)
call %~n0 boolean isValueObjectExist %~4
if "!boolean!"=="true" (
	call %LogUtil% void log %~n0 "Value Object '%~4' was early exist ,'%~4' will not create again"
	set %~1=null
	goto eof
)
if "!globalValueObjectList!"=="null" (
	set globalValueObjectList="%~3_%~4"
) else (
	set globalValueObjectList=!globalValueObjectList!,"%~3_%~4"
)
set %~3_%~4=null
set %~1=%~3_%~4
goto eof

@rem Determine if object exists
@rem
@rem return boolean If object existed that will return true,otherwise return false
@rem param_3 string Object name
:isObjectExist
if "!globalObjectList!"="null" (
	call %LogUtil% void log %~n0 "Object '%~3' does not exist"
	set %~1=false
	goto eof
)
set tmp_boolean_1=false
for %%i in (!globalObjectList!) do (
	if "%~3"=="%%~i" set tmp_boolean_1=true
)
if "!tmp_boolean_1!"=="true" (
	call %LogUtil% void log %~n0 "Object '%~3' existed"
) else (
	call %LogUtil% void log %~n0 "Object '%~3' does not exist"
)
set %~1=!tmp_boolean_1!
goto eof

@rem Create a new Object
@rem 
@rem return string New Object name,if object early exist that will return null
@rem param_3 string Object name
@rem param_4 string Object real path
:newObject 
call %LogUtil% void log %~n0 "Want to create new object '%~3'"
call %~n0 boolean isObjectExist %~3
if "!boolean!"=="true" (
	call %LogUtil% void log %~n0 "Object '%~3' early exist,it will not create again"
	set %~1=null
	goto eof
)
if not exist %~4 (
	call %LogUtil% void log %~n0 "The file '%~4' corresponding to the current object '%~3' does not exist,object '%~3' will not create"
	set %~1=null
	goto eof
)
if "!globalObjectList!"=="null" (
	set globalObjectList=
	set globalObjectList="%~3"
) else (
	set globalObjectList="!globalObjectList!","%~3"
)
set %~3=%~f4
set %~1=%~3
goto eof

@rem Delete a value object.While calling this method,the target value object and it child value will been deleted
@rem
@rem return boolean Return true if success to delete a value object,otherwise return false
@rem param_3 string Name of Object
@rem param_4 string Name of Value Object
:deleteValueObject
call %~n0 boolean isObjectExist %~3
if "!boolean!"=="false" (
	call %LogUtil% void log %~n0 "Object '%~3' not exist,that will not delete anything"
	set %~1=false
	goto eof
)
call %~n0 boolean isValueObjectExist %~3 %~4
if "!boolean!"=="false" (
	call %LogUtil% void log %~n0 "Value Object '%~3_%~4' does not exist,that will not delete anything"
	set %~1=false
	goto eof
)
set tmp_any_1=null
for %%i in (!globalValueObjectList!) do (
	if "%%~i" neq "%~3_%~4" (
		if "!tmp_any_1!"=="null" (
			set tmp_any_1="%%~i"
		) else (
			set tmp_any_1=!tmp_any_1!,"%%~i"
		)
	)
)
set globalValueObjectList=!tmp_any_1!
for %%i in (!%~3_%~4!) do (
	set !%~3_%~4_%%~i!=
)
set %~3_%~4=
goto eof

@rem Delete an object,child Value Object also will be delete 
@rem
@rem return boolean Return true if succeess to delete an object,otherwise return false
@rem param_3 string Object Name
:deleteObject
call %~n0 boolean isObjectExist %~3
if "!boolean!"=="false" (
	call %LogUtil% void log %~n0 "Object '%~3' not exist,will not delete anything"
	set %~1=false
	goto eof
)
rem 还需要认真思考删除逻辑
for %%i in (!globalValueObjectList!) do (
	call %StringUtil% boolean startWith %%~i %~3_
	if "!boolean!"=="true" (
		call %~n0 boolean deleteValueObject %~3 %%~i
	)
)
set tmp_any_1=null
for %%i in (!globalObjectList!) do (
	if "%%~i" neq "%~3" (
		if "!tmp_any_1!"=="null" (
			set tmp_any_1="%~3"
		) else (
			set tmp_any_1=!tmp_any_1!,"%~3"
		)
	)
)
set globalObjectList=!tmp_any_1!
goto eof

:eof