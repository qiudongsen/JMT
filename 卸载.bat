@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (

    echo �������ԱȨ��...

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
echo ����һ������ж��tomcat����
net stop tomcat
sc delete tomcat >nul
echo �����������ж��MySQL����
net stop mysql
sc delete mysql >nul
echo ִ����ϣ����ڽ���5����Զ��ر�. . . 
for /l %%i in (5,-1,0) do (
	ping 127.1 -n 2 >nul
)
exit
