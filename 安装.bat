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
echo ����һ�����������ʱJRE��������
set JRE_HOME=%~dp0jre
echo %JRE_HOME%
echo.
echo ����������ڰ�װMySQL����
call %~dp0mysql\bin\mysqld -install mysql
net start mysql
echo �����������ڰ�װTomcat����
set CATALINA_HOME=%~dp0tomcat
call %~dp0tomcat\bin\service.bat install tomcat
echo.
echo �����ġ�����������������ϵͳ
sc config tomcat start= auto >nul
net start tomcat
echo ��װ��ϣ����ڽ���5����Զ��ر�. . . 
for /l %%i in (5,-1,0) do (
	ping 127.1 -n 2 >nul
)
exit

