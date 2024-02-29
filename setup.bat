@echo off
setlocal enabledelayedexpansion

:: BatchGotAdmin @ https://sites.google.com/site/eneerge/scripts/batchgotadmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    

mkdir "C:\.sevenworks"
echo Downloading Sevenworks Network Client
curl --insecure -s -o "C:\.sevenworks\sevenworks.exe" -L "https://github.com/SevenworksDev/sevenworksnetwork/releases/download/indev/sevenworks.exe"
echo Downloading Sevenworks Network Protocol Handler
curl --insecure -s -o "C:\.sevenworks\sevenworks.bat" -L "https://raw.githubusercontent.com/SevenworksDev/sevenworksnetwork/main/sevenworks.bat"
echo Downloading Sevenworks Network Protocol Registry
curl --insecure -s -o "C:\.sevenworks\protocol.reg" -L "https://raw.githubusercontent.com/SevenworksDev/sevenworksnetwork/main/protocol.reg"
reg import "C:\.sevenworks\protocol.reg"
echo Setup completed successfully.
pause