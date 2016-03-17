@echo off
echo PowerShell ExePolicy Version 1.0.0
echo Written by David B. Wilkerson
echo.
setlocal enableextensions
set PSEPkey="HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell"
set PSEPvlu=ExecutionPolicy
For /F "usebackq skip=2 tokens=1-3" %%x in (`reg query %PSEPkey% /v %PSEPvlu% 2^>nul`) do (
set PolicyTerm=%%x
set PlcyRegTyp=%%y
set PolicyStng=%%z
)
if defined PolicyTerm (
echo PowerShell Execution Local Policy Setting
echo -----------------------------------------
echo.
echo The current execution policy is %PolicyStng%
) else (
echo PowerShell Execution Local Policy Setting
echo -----------------------------------------
echo.
echo Policy is not currently set to anything.
)

:paramtr
if /i "%1"=="AllSigned" (
set newPolicy=AllSigned
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "AllSigned" /f 2> NUL
goto exit
)
if /i "%1"=="Restricted" (
set newPolicy=Restricted
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Restricted" /f 2> NUL
goto exit
)
if /i "%1"=="RemoteSigned" (
set newPolicy=RemoteSigned
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f 2> NUL
goto exit
)
if /i "%1"=="Unrestricted" (
set newPolicy=Unrestricted
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f 2> NUL
goto exit
)
if /i "%1"=="Bypass" (
set newPolicy=Bypass
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Bypass" /f 2> NUL
goto exit
)

:poloptn
echo.
echo To change the policy, enter the number to
echo the left of the desired policy setting.
echo -----------------------------------------
echo.
echo 1. AllSigned
echo 2. Restricted
echo 3. RemoteSigned
echo 4. Unrestricted
echo 5. Bypass
echo 6. Policy Definitions (Help)
echo 7. Exit
echo.
echo -----------------------------------------
set /p pseoption=Enter a option number: 
set pseoption=%pseoption:~0,1%
if %pseoption%==1 (
set newPolicy=AllSigned
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "AllSigned" /f 2> NUL
goto polrslt
)
if %pseoption%==2 (
set newPolicy=Restricted
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Restricted" /f 2> NUL
goto polrslt
)
if %pseoption%==3 (
set newPolicy=RemoteSigned
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f 2> NUL
goto polrslt
)
if %pseoption%==4 (
set newPolicy=Unrestricted
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f 2> NUL
goto polrslt
)
if %pseoption%==5 (
set newPolicy=Bypass
Reg Add "HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Bypass" /f 2> NUL
goto polrslt
)
if %pseoption%==6 (
cls
echo Powershell Policy Setting Definitions
echo.
echo --------------------------------------------------------------------------------
echo.
echo 1. AllSigned    - Require that all scripts and configuration files be signed
echo                   by a trusted publisher, including scripts that you write on
echo                   the local computer.
echo.
echo 2. Restricted   - Do not load configuration files or run scripts.
echo                   This is the default.
echo.
echo 3. RemoteSigned - Require that all scripts and configuration files downloaded
echo                   from the Internet be signed by a trusted publisher.
echo.
echo 4. Unrestricted - Load all configuration files and run all scripts.
echo                   If you run an unsigned script that was downloaded from the
echo                   internet, you are prompted for permission before it runs.
echo.
echo 5. Bypass       - Nothing is blocked and there are no warnings or prompts.
echo.
echo --------------------------------------------------------------------------------
goto poloptn
)
if %pseoption%==7 (
goto xit
)
echo.
echo Incorrect option chosen, please try again.
goto poloptn

:polrslt
if /i "%newPolicy%"=="%PolicyStng%" (
echo Oops, there must have been an error, the
echo policy was not changed.
echo.
echo Current policy setting is %newPolicy%.
echo.
pause
) else (
:exit
echo.
echo PowerShell Execution Local Policy Setting
echo -----------------------------------------------------
echo PowerShell execution policy was changed successfully!
echo.
:xit
echo Current policy setting is %newPolicy%.
)
echo.
ping 127.0.0.1 -n 2 > Nul & echo 5
ping 127.0.0.1 -n 2 > Nul & echo 4
ping 127.0.0.1 -n 2 > Nul & echo 3
ping 127.0.0.1 -n 2 > Nul & echo 2
ping 127.0.0.1 -n 2 > Nul & echo 1