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
echo JRE = %JRE_HOME%
echo JAVA = %JAVA_HOME%
if "%JAVA_HOME%" == "" (if "%JRE_HOME%" == "" (goto gotJreHome) else (goto gotMysql)) else (goto gotMysql)
:gotJreHome
echo set JRE_HOME
set JRE_HOME=%~dp0jre
echo %JRE_HOME%
:gotMysql
echo check mysql service has been installed
sc query |find /i "mysql" >nul 2>nul
if not errorlevel 1 (goto mysqlexist) else goto notmysqlexist
:mysqlexist
echo mysql service has been installed
goto :startmysql
:notmysqlexist
echo mysql service has not been installed
echo install mysql service
call %~dp0mysql\bin\mysqld -install mysql
echo set mysql service auto start 
sc config mysql start= auto >nul
goto :startmysql
:startmysql
echo start mysql service
sc query mysql | find "STATE              : 4  RUNNING" > nul  
if %errorlevel% EQU 0 (echo mysql has been started) else (net start mysql)
echo check tomcat service has been installed
sc query |find /i "tomcat" >nul 2>nul
if not errorlevel 1 (goto tomcatexist) else goto nottomcatexist
:tomcatexist
echo tomcat service has been installed
goto :starttomcat
:nottomcatexist
echo tomcat service has not been installed
echo install tomcat service
set CATALINA_HOME=%~dp0tomcat
call %~dp0tomcat\bin\service.bat install tomcat
echo set tomcat service auto start 
sc config tomcat start= auto >nul
goto :starttomcat
:starttomcat
echo start tomcat service
sc query tomcat | find "STATE              : 4  RUNNING" > nul  
if %errorlevel% EQU 0 (echo tomcat has been started) else (net start tomcat)
echo Press any key to continue...
pause
exit