@echo off
echo ******************************************************************************* 
echo * * 
echo * Delete Service * 
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
set /p a=请输入服务名称:
SC delete %a%
echo Press any key to continue...
pause
exit