@echo off
@rem ������ƣ�ģ����
@rem �������������һ��ģ������
@rem �������ڣ�onStartInstallApp��onStartPushFile        ����������ָʾ��ǰ���ͨ�������ļ�ע�����ĸ����������
@rem ������ܣ�
@rem	1�������ڡ�onStartInstallApp����������ʱ������������к�Ϊ��11111111�����豸����
@rem 	ģ�ⰴ�µ�Դ����Ȼ��� ��300��460�����꿪ʼģ����ָ������ ��300��0�� ���꣬
@rem 	��ʱ 150 ���룬Ȼ���ϵͳ���ý���
@rem 	2��ȡ���������豸���� files Ŀ¼�������ļ����߼�
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
if "%~2"=="opt" goto opt
goto eof

@rem return boolean
@rem param_3 ��������
@rem param_4 ���к�
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