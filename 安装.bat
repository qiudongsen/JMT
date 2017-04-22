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
echo 步骤一、正在添加临时JRE环境变量
set JRE_HOME=%~dp0jre
echo %JRE_HOME%
echo.
echo 步骤二、正在安装MySQL服务
call %~dp0mysql\bin\mysqld -install mysql
net start mysql
echo 步骤三、正在安装Tomcat服务
set CATALINA_HOME=%~dp0tomcat
call %~dp0tomcat\bin\service.bat install tomcat
echo.
echo 步骤四、正在启动Tomcat服务
sc config tomcat start= auto >nul
net start tomcat
echo 安装完毕！窗口将在5秒后自动关闭. . . 
for /l %%i in (5,-1,0) do (
	ping 127.1 -n 2 >nul
)
exit

