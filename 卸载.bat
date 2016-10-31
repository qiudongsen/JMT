@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (

    echo 请求管理员权限...

    goto UACPrompt

) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"

    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"

    exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

    pushd "%CD%"

    CD /D "%~dp0"
echo.
echo 步骤一、正在卸载tomcat服务
net stop tomcat
sc delete tomcat >nul
echo 步骤二、正在卸载MySQL服务
net stop mysql
sc delete mysql >nul
echo 执行完毕！窗口将在5秒后自动关闭. . . 
for /l %%i in (5,-1,0) do (
	ping 127.1 -n 2 >nul
)
exit
