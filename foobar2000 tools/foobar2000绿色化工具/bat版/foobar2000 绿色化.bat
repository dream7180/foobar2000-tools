@echo off
color 0a
:MENU
CLS
>nul 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>nul
    Exit /b
)
ECHO.
ECHO.==== foobar2000 绿色化 ====
ECHO.
ECHO. 1 注册相关组件 (ShellExt交互外壳以及sacd解码组件)
ECHO. 2 创建桌面快捷方式
ECHO.---------------------------
ECHO. 3 注销已注册的相关组件
ECHO. 4 删除桌面快捷方式
ECHO.---------------------------
ECHO. 5 退出
ECHO.
echo. 请输入选择项目的序号：
set /p ID=
if "%ID%"=="1" call :cmd1
if "%ID%"=="2" call :cmd2
if "%ID%"=="3" call :cmd3
if "%ID%"=="4" call :cmd4
if "%ID%"=="5" call exit
set "ID="

:cmd1
if exist "%~dp0ShellExt32.dll" (regsvr32.exe "%~dp0ShellExt32.dll")
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (if exist "%~dp0ShellExt64.dll" (regsvr32.exe "%~dp0ShellExt64.dll"))
if exist "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder.dll" (regsvr32.exe "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder.dll")
if exist "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder_x64.dll" (if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (regsvr32.exe "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder_x64.dll"))
echo 按任意键返回菜单
goto backtomenu

:cmd3
if exist "%~dp0ShellExt32.dll" (regsvr32.exe /u "%~dp0ShellExt32.dll")
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (if exist "%~dp0ShellExt64.dll" (regsvr32.exe /u "%~dp0ShellExt64.dll"))
if exist "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder.dll" (regsvr32.exe /u "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder.dll")
if exist "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder_x64.dll" (if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (regsvr32.exe /u "%~dp0profile\user-components\foo_input_sacd\dsd_transcoder_x64.dll"))
echo 按任意键返回菜单
goto backtomenu

:cmd2
set scname=foobar2000.lnk
set scpath=%~dp0
set scexec=%~dp0foobar2000.exe
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\%scname%""):b.TargetPath=""%scexec%"":b.WorkingDirectory=""%scpath%"":b.Save:close")
echo 已创建桌面快捷方式，按任意键返回菜单
goto backtomenu

:cmd4
ping -n 2 127.1>nul
del /f /q "%userprofile%"\Desktop\"foobar2000.lnk"
::del /f /q "%userprofile%"\桌面\"foobar2000.lnk"
echo 已删除桌面快捷方式，按任意键返回菜单
goto backtomenu

:backtomenu
PAUSE >NUL
GOTO MENU