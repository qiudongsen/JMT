@echo off
echo ******************************************************************************* 
echo * * 
echo * JavaWeb and MySQL Publish* 
echo * * 
echo ******************************************************************************* 
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo request admin...
    goto UACPrompt
) else (goto gotAdmin)
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
echo set java JRE_HOME
set JRE_HOME=%~dp0jre
echo %JRE_HOME%
echo check mysql service has been installed
sc query |find /i "mysql" >nul 2>nul
if not errorlevel 1 (goto mysqlexist) else goto tomcat
:mysqlexist
sc query mysql | find "STATE              : 4  RUNNING" > nul  
if %errorlevel% EQU 0 (net stop mysql) else (echo mysql has not been started)
echo remove mysql install
call %~dp0mysql\bin\mysqld -remove mysql
:tomcat
echo check tomcat service has been installed
sc query |find /i "tomcat" >nul 2>nul
if not errorlevel 1 (goto tomcatexist) else goto nottomcatexist
:nottomcatexist
echo tomcat service has not been installed
:tomcatexist
echo tomcat service has been installed
sc query tomcat | find "STATE              : 4  RUNNING" > nul  
if %errorlevel% EQU 0 (net stop tomcat) else (echo tomcat has not been started)
echo remove tomcat install
sc delete tomcat >nul
:endl
echo Press any key to continue...
pause
exit