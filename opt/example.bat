@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v0.0.4													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2020.5.17													::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ������ƣ�ģ����
@rem ����汾��0.0.2
@rem �������������һ��ģ������
@rem �������ڣ�onStartInstallApp��onStartPushFile        ��ָʾ��ǰ���ͨ�������ļ�ע�����ĸ����������
@rem ������ܣ�
@rem	1�������ڡ�onStartInstallApp����������ʱ������������к�Ϊ��11111111�����豸����
@rem 	ģ�ⰴ�µ�Դ����Ȼ��� ��300��460�����꿪ʼģ����ָ������ ��300��0�� ���꣬
@rem 	��ʱ 150 ���룬Ȼ���ϵͳ���ý���
@rem 	2��ȡ���������豸���� files Ŀ¼�������ļ����߼�
@rem ---------------------------------------------------------------------
@rem ע���Ժ�ʹ�ô���Ŵ������к�ʶ��ͬ�豸
@rem ---------------------------------------------------------------------
if "!RUN_ONCE!" neq "%RUN_ONCE%" setlocal enableDelayedExpansion
if "%~2"=="opt" goto opt
goto eof

@rem �������ڻص��ӿ�
@rem
@rem return boolean
@rem param_3 string ��������
@rem param_4 string ���к�
@rem param_5 int	�����
@rem param_6 string �ļ��ľ���·��
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