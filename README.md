# **CP_UAAI**

---

## 功能

1. 安装 .\app 目录下的所有安卓应用程序
2. 推送 .\files 目录下的所有文件到 /sdcard 目录
3. 执行 .\opt 目录下的自定义插件

## 系统兼容性

&emsp;&emsp;兼容 win10 和 win7，对于 win8 和 winxp 没有测试

## 用法

&emsp;&emsp;将对应文件放到对应文件夹，再运行 StartUP.bat 就行。对于插件开发模板及配置方式，参考 [example.bat] 插件模板文件以及 [plugin_config.txt] 插件配置文件

### 注意

1. 在我的 win 10 电脑上，当脚本窗口失去焦点或被鼠标点击时，脚本会暂停，这时候只需要用鼠标点击脚本窗口，然后按 enter 键，脚本就能继续运行了
2. 当前版本脚本会不断读写 %tmp% 目录，对磁盘性能消耗较大

## 生命周期说明

|生命周期|生命周期作用|
|:-:|:-|
| onScriptFirstStart | 在脚本初始化完成，且还没开始循环执行业务逻辑时被调用，只会执行一次|
|onCoreStart|在开始执行业务逻辑时被调用，对于每台设备只会执行一次,可通过返回 false 阻止这些生命周期执行：<br/>onStartInstallApp、<br/>onBeforeInstallingApp、<br/>onAfterInstallingApp、<br/>onInstallAppCompleted、<br/>onStartPushFile、<br/>onBeforePushingFile、<br/>onAfterPushingFile、<br/>onPushFileCompleted、<br/>onCoreLogicFinish|
| onStartInstallApp | 在开始执行应用安装逻辑时执行一次，可以通过返回 false 阻止整个应用安装生命周期，即：<br/>onBeforeInstallingApp、<br/>onAfterInstallingApp、<br/>onInstallAppCompleted|
| onBeforeInstallingApp | 在开始安装一个应用前被调用，每迭代到 .\app 目录下的一个应用的时候就调用一次，对于每台设备一般会被多次调用，可以通过返回 false 跳过当前应用的安装，但不会阻止应用安装逻辑，会阻止 onAfterInstallingApp 生命周期的执行|
| onAfterInstallingApp | 在结束安装一个应用的安装时被调用，可以被 onBeforeInstallingApp 生命周期阻止执行。只在当前应用安装完成后被调用，对于每台设备一般会多次调用|
| onInstallAppCompleted | 在结束应用安装逻辑后被调用，对于每台设备只会被调用一次|
| onStartPushFile | 在开始执行文件推送逻辑时执行一次，可以通过返回 false 阻止整个文件推送逻辑生命周期，即：<br/>onBeforePushingFile、<br/>onAfterPushingFile、<br/>onPushFileCompleted|
| onBeforePushingFile | 在开始推送一个文件时被调用，每迭代到 .\files 目录下的一个文件的时候就调用一次，对于每台设备一般会被多次调用，可以通过返回 false 跳过当前文件的推送，但不会阻止文件推送逻辑，会阻止 onAfterPushingFile 生命周期的执行|
| onAfterPushingFile | 在结束推送一个文件的推送时被调用，可以被 onBeforeInstallingApp 生命周期阻止执行。只在当前文件推送完成后被调用，对于每台设备一般会多次调用|
| onPushFileCompleted | 在结束文件推送逻辑后被调用，对于每台设备只会被调用一次|
| onCoreLogicFinish | 在结束业务逻辑时被调用，可以被 onCoreStart 生命周期阻止执行|
| onCoreFinish | 在业务逻辑执行完成时被调用，不可以被 onCoreStart 生命周期阻止执行，对于每台设备只会执行一次|

## 更新历史

---

### 2.2.4

1. 增加插件扩展功能，目前插件有如下生命周期
    + onScriptFirstStart
    + onCoreStart
    + onStartInstallApp
    + onBeforeInstallingApp
    + onAfterInstallingApp
    + onInstallAppCompleted
    + onStartPushFile
    + onBeforePushingFile
    + onAfterPushingFile
    + onPushFileCompleted
    + onCoreLogicFinish
    + onCoreFinish

---

### 2.2.3

1. 临时版本，对 win7 系统做出让步支持

---

### 2.2.2

1. 用了多线程的概念使得脚本支持同时给多台设备安装软件，不限数量，无需等待所有设备连接完成

---

### 2.1.2

1. 使 cmd 命令行支持 UTF-8 字符集
2. 修复脚本首次启动时由于 adb 服务启动导致开启两个无效 cmd 窗口的 bug

---

### 2.1.1

1. 修复安装完应用后提示“系统找不到指定的批处理标签 - push_system_package”的问题

---

### 2.1.0

1. 只拥有循环和不用修改脚本的特性

---

[example.bat]: .\opt\example.bat
[plugin_config.txt]: .\opt\plugin_config.txt
