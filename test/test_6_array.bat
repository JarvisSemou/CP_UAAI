@echo off
if "%~2"=="" (
	setlocal enabledelayedexpansion
	goto main
)
if "%~2"=="newArray" goto newArray
goto eof

:main

pause 1>nul
goto eof


@rem 新建数组
@rem 数组格式如下
@rem "数组名字","数组名字长度+1"，数组内容（"数组名字_元素名字"）
@rem 例如：
@rem "Mouse","6","Mouse_element_1","Mouse_element_2"..."Mouse_element_n"
@rem 
@rem return array
@rem param_3 string 数组名
:newArray

goto eof

@rem 为数组添加元素
@rem
:addElement

goto eof

:eof