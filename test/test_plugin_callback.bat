@echo off
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ::	version: v0.0.3													::
@rem ::	author: Mouse.JiangWei											::
@rem ::	date: 2020.5.12													::
@rem ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@rem ������ƣ�StartUP.bat ����ص��ӿڲ��Բ��
@rem ����汾��0.0.1
@rem ����������������� StartUP.bat �Բ���Ļص��ӿ��Ƿ�����
@rem �������ڣ�onScriptFirstStart��onCoreStart��onStartInstallApp��onBeforeInstallingApp��
@rem            onAfterInstallingApp��onInstallAppCompleted��onStartPushFile��
@rem            onBeforePushingFile��onAfterPushingFile��onPushFileCompleted��
@rem            onCoreLogicFinish��onCoreFinish
@rem ������ܣ�
@rem	1������ StartUp.bat �����лص��ӿ��Ƿ��������ص�
@rem 	2������ StartUp.bat �����лص��ӿڴ����Ƿ���ȷ
@rem ---------------------------------------------------------------------
@rem ע���Ժ�ʹ�ô���Ŵ������к�ʶ��ͬ�豸
@rem ---------------------------------------------------------------------
if "%~2"=="" (
	setlocal enabledelayedexpansion
)
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
    if "!test_plugin_callback_count!"=="" (
        set test_plugin_callback_count=1
        echo ��ʼִ�� StartUp.bat �������ڻص��ӿڲ���
    )
    echo #######################################
	echo �� !test_plugin_callback_count! �λص����
	echo ��������: %~3
    echo ���кţ�%~4
    echo ����ţ�%~5
    echo �ļ�����·����%~6
    echo ����ص������������������Ƿ���ȷ�������������
    echo #######################################
    pause 1>nul
    echo ��ɻص��ӿڲ���
    set /a test_plugin_callback_count=!test_plugin_callback_count! + 1
goto eof

:eof