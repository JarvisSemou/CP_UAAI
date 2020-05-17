# **CP_UAAI**

---

## **功能**

1. 安装 `.\app` 目录下的所有安卓应用程序
2. 推送 `.\files` 目录下的所有文件到 `/sdcard` 目录
3. 执行 `.\opt` 目录下的自定义插件

## **系统兼容性**

&emsp;&emsp;兼容 win10 和 win7，对于 win8 和 winxp 没有测试

## **用法**

&emsp;&emsp;将对应文件放到对应文件夹，再运行 StartUP.bat 就行。对于插件开发模板及配置方式，参考 [example.bat] 插件模板文件以及 [plugin_config.txt] 插件配置文件

### 注意

1. 在我的 win 10 电脑上，当脚本窗口失去焦点或被鼠标点击时，脚本会暂停，这时候只需要用鼠标点击脚本窗口，然后按 enter 键，脚本就能继续运行了
2. 当前版本脚本会不断读写 `%tmp%` 目录，对磁盘性能消耗较大

## **生命周期说明**

|生命周期|生命周期作用|
|:-:|:-|
| onScriptFirstStart | 在脚本初始化完成，且还没开始循环执行业务逻辑时被调用，只会执行一次|
|onCoreStart|在开始执行业务逻辑时被调用，对于每台设备只会执行一次,可通过返回 `false` 阻止这些生命周期执行：<br/>`onStartInstallApp`<br/>`onBeforeInstallingApp`<br/>`onAfterInstallingApp`<br/>`onInstallAppCompleted`<br/>`onStartPushFile`<br/>`onBeforePushingFile`<br/>`onAfterPushingFile`<br/>`onPushFileCompleted`<br/>`onCoreLogicFinish`|
| onStartInstallApp | 在开始执行应用安装逻辑时执行一次，可以通过返回 `false` 阻止整个应用安装生命周期，即：<br/>`onBeforeInstallingApp`<br/>`onAfterInstallingApp`<br/>`onInstallAppCompleted`|
| onBeforeInstallingApp | 在开始安装一个应用前被调用，每迭代到 `.\app` 目录下的一个应用的时候就调用一次，对于每台设备一般会被多次调用，可以通过返回 false 跳过当前应用的安装，但不会阻止应用安装逻辑，会阻止 `onAfterInstallingApp` 生命周期的执行|
| onAfterInstallingApp | 在结束安装一个应用的安装时被调用，可以被 `onBeforeInstallingApp` 生命周期阻止执行。只在当前应用安装完成后被调用，对于每台设备一般会多次调用|
| onInstallAppCompleted | 在结束应用安装逻辑后被调用，对于每台设备只会被调用一次|
| onStartPushFile | 在开始执行文件推送逻辑时执行一次，可以通过返回 `false` 阻止整个文件推送逻辑生命周期，即：<br/>`onBeforePushingFile`<br/>`onAfterPushingFile`<br/>`onPushFileCompleted`|
| onBeforePushingFile | 在开始推送一个文件时被调用，每迭代到 `.\files` 目录下的一个文件的时候就调用一次，对于每台设备一般会被多次调用，可以通过返回 `false` 跳过当前文件的推送，但不会阻止文件推送逻辑，会阻止 `onAfterPushingFile` 生命周期的执行|
| onAfterPushingFile | 在结束推送一个文件的推送时被调用，可以被 `onBeforeInstallingApp` 生命周期阻止执行。只在当前文件推送完成后被调用，对于每台设备一般会多次调用|
| onPushFileCompleted | 在结束文件推送逻辑后被调用，对于每台设备只会被调用一次|
| onCoreLogicFinish | 在结束业务逻辑时被调用，可以被 `onCoreStart` 生命周期阻止执行|
| onCoreFinish | 在业务逻辑执行完成时被调用，不可以被 `onCoreStart` 生命周期阻止执行，对于每台设备只会执行一次|

## **一些开发规则**

1. 基本变量类型有 `void`、`int`、`boolean`、`string`、`vo` （Value Object，单纯的数据类型，以 “vo_” 开头），除了 `void` 不用写默认值外，其他基本类型的默认值不做特别约束。
2. 临时变量的变量名以 “tmp_” 开头。当前有 6 种临时变量：`tmp_any`、`tmp_int`、`tmp_boolean`、`tmp_string`、`tmp_vo`、`result`。<br/>除了 `result`，每种临时变量又有 4 个子临时变量，以下是每种临时变量的说明：
    - tmp_any ：能存任意值，可能是 string，可能是 int 或 boolean，vo
        - 子变量：tmp_any_1、tmp_any_2、tmp_any_3、tmp_any_4
    - tmp_int ：存储你想要的数值
        - 子变量：tmp_int_1、tmp_int_2、tmp_any_3、tmp_any_4
    - tmp_boolean ：存 boolean 值
        - 子变量：tmp_boolean_1、tmp_boolean_2、tmp_boolean_3、tmp_boolean_4
    - tmp_string ：存字符串
        - 子变量：tmp_string_1、tmp_string_2、tmp_string_3、tmp_string_4
    - tmp_vo ：存任意数据
        - 子变量：tmp_vo_1、tmp_vo_2、tmp_vo_3、tmp_vo_4
    - result ：这是指定用来临时存储返回值的临时变量
3. 自定义的变量的变量名采用 camel 命名法；数组变量以“array”开头，且变量名中单词用下划线分隔开，单词统一用小写字母。
4. 数组元素用英文逗号分隔，元素必须用英文双引号括住。<br/>例如：在数组“array_myList”中，里面的元素这样存储：`"item_1","item_2","item_3",...,"item_n"`。当数组没有元素时，值为不加双引号的“`null`”。
5. 脚本必须打开延迟变量开关（`setlocal enableDelayedExpansion`）。
6. 统一使用 `GB2312` 字符集。
7. 注释格式统一用 “`@rem 注释内容`”
8. 方法内部标签格式：
    - `:方法名_b_编号`  用于作为流程中断时跳转的目标
    - `:方法名_l_编号`  用于作为普通流程中的跳转目标
9. 方法格式：

        @rem 方法描述
        @rem
        @rem return 返回类型   对返回的数据的描述
        @rem param_3 数据类型  参数描述
        :方法名
            @rem 跳转到一个方法内标签
            gogo :方法名_l_1
            :方法名_l_1
            echo 已进行跳转
            @rem 使用 param_3 参数的代码例子
            set result=%~3
            @rem 返回数据的代码例子
            set %~1=!result!
        @rem 方法结束
        goto eof

10. 脚本格式：

        @echo off
        @rem 在这里面进行一些原始的只运行一次的初始化操作
        if "!RUN_ONCE!" neq "%RUN_ONCE%" (
            @rem 设置是否显示调试信息，true 为显示调试信息，false 反之，默认为 false
            set DEBUG=false
            setlocal enableDelayedExpansion
            goto initStaticValue
        )
        @rem 在这里判断方法名并跳转到相应的方法流程分支
        :methodBrach
            @rem if "%~2"=="close" goto close
            if "!DEBUG!"=="true" echo 方法 "%~2" 不存在
        goto eof

        :initStaticValue
            @rem 在这里初始化静态变量
            @rem 返回方法判断流程分支
            goto methodBrach
        goto main

        @rem 主方法（脚本入口）
        :main
            @rem 填写主逻辑
            @rem 调用方法的格式（参数要加双引号）
            @rem 格式：call %~n0 返回值 方法名 "参数1" "参数2" ... "参数n"
            @rem 例子（假设存在返回值为 void 的 print 方法）：
            @rem call %~n0 void print "Hello World"
        goto eof

        @rem 脚本出口
        :eof

## 更新历史

---

### 2.3.0

1. 将开发约束说明移动到 README.md 文件中。
2. 使用传输号代替序列号识别设备。
3. 更新回调插件的接口参数，新接口传 4 个参数(多了传输号)，按顺序分别是：生命周期名字、序列号、传输号、文件的绝对路径。旧的插件在不使用“文件的绝对路径”这个参数的情况下，能兼容新此版本的回调接口。
    |参数|参数类型|参数意义|
    |:-:|:-:|:-|
    |param_3|string|生命周期名字|
    |param_4|string|序列号|
    |param_5|int|传输号(新加入)|
    |param_6|string|文件的绝对路径|
4. 能显示自定义的设备状态。
5. 对一些不严谨的文字描述进行修改。

---

### 2.2.4

1. 增加插件扩展功能，目前插件有如下生命周期
    - onScriptFirstStart
    - onCoreStart
    - onStartInstallApp
    - onBeforeInstallingApp
    - onAfterInstallingApp
    - onInstallAppCompleted
    - onStartPushFile
    - onBeforePushingFile
    - onAfterPushingFile
    - onPushFileCompleted
    - onCoreLogicFinish
    - onCoreFinish

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
