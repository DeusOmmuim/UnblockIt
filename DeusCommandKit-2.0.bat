@echo off
:: Elevate to admin if not already
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Requesting admin access...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

title DeusCMDV1 - Windows Administration Toolkit

:MENU
cls
echo =================================================
echo        DEUSCMDV1 - WINDOWS ADMIN TOOLKIT
echo =================================================
echo [1]  SYSTEM ADMINISTRATION
echo [2]  USER ACCOUNT MANAGEMENT  
echo [3]  SECURITY SETTINGS
echo [4]  NETWORK TOOLS
echo [5]  SYSTEM MAINTENANCE
echo [6]  QUICK ACCESS TOOLS
echo [7]  ADVANCED UTILITIES
echo =================================================
set /p choice=Choose an option: 

if "%choice%"=="1" goto SYSADMIN_MENU
if "%choice%"=="2" goto USER_MENU
if "%choice%"=="3" goto SECURITY_MENU
if "%choice%"=="4" goto NETWORK_MENU
if "%choice%"=="5" goto MAINTENANCE_MENU
if "%choice%"=="6" goto QUICKACCESS_MENU
if "%choice%"=="7" goto ADVANCED_MENU
goto MENU

:SYSADMIN_MENU
cls
echo ========== SYSTEM ADMINISTRATION ==========
echo [1]  Open Computer Management
echo [2]  System Info Dashboard
echo [3]  Launch Resource Monitor
echo [4]  Open Control Panel
echo [5]  Remove Common Bloatware
echo [6]  Restore Task Manager/Registry Editor
echo [7]  Open Remote Shutdown Tool
echo [8]  Remote Command Launcher
echo [0]  Back to Main Menu
echo ===========================================
set /p choice=Choose an option:

if "%choice%"=="1" goto OPENMGMT
if "%choice%"=="2" goto SYSINFO
if "%choice%"=="3" goto RESMON
if "%choice%"=="4" goto CONTROLPANEL
if "%choice%"=="5" goto BLOATREMOVE
if "%choice%"=="6" goto FIXTOOLS
if "%choice%"=="7" shutdown /i & goto SYSADMIN_MENU
if "%choice%"=="8" goto REMOTECMD
if "%choice%"=="0" goto MENU
goto SYSADMIN_MENU

:USER_MENU
cls
echo ========== USER ACCOUNT MANAGEMENT ==========
echo [1]  Create Stealth Admin Account
echo [2]  Enable Built-in Administrator Account
echo [3]  Take Ownership of File/Folder
echo [4]  Add "Take Ownership" to Right Click
echo [5]  Open Startup Folder
echo [6]  Add File to Startup Folder
echo [0]  Back to Main Menu
echo =============================================
set /p choice=Choose an option:

if "%choice%"=="1" goto STEALTHADMIN
if "%choice%"=="2" goto SUPERADMIN
if "%choice%"=="3" goto OWNERSHIP
if "%choice%"=="4" goto RCLICKOWN
if "%choice%"=="5" start shell:startup & goto USER_MENU
if "%choice%"=="6" goto ADDSTARTUP
if "%choice%"=="0" goto MENU
goto USER_MENU

:SECURITY_MENU
cls
echo ========== SECURITY SETTINGS ==========
echo [1]  Enable Developer Mode
echo [2]  Disable UAC
echo [3]  Re-enable UAC
echo [4]  View Saved Wi-Fi Passwords
echo [0]  Back to Main Menu
echo =======================================
set /p choice=Choose an option:

if "%choice%"=="1" goto DEV_MODE
if "%choice%"=="2" goto DISABLE_UAC
if "%choice%"=="3" goto ENABLE_UAC
if "%choice%"=="4" goto WIFI_PASS
if "%choice%"=="0" goto MENU
goto SECURITY_MENU

:NETWORK_MENU
cls
echo ========== NETWORK TOOLS ==========
echo [1]  Flush DNS Cache
echo [2]  Show Active Network Info
echo [3]  Ping a Website
echo [4]  Reset Network Stack
echo [0]  Back to Main Menu
echo ===================================
set /p choice=Choose an option:

if "%choice%"=="1" goto FLUSH_DNS
if "%choice%"=="2" goto SHOW_NETINFO
if "%choice%"=="3" goto PING_SITE
if "%choice%"=="4" goto RESET_NET
if "%choice%"=="0" goto MENU
goto NETWORK_MENU

:MAINTENANCE_MENU
cls
echo ========== SYSTEM MAINTENANCE ==========
echo [1]  Clear Temp and Recent Files
echo [2]  Create Scheduled Task
echo [3]  Enable God Mode
echo [0]  Back to Main Menu
echo ========================================
set /p choice=Choose an option:

if "%choice%"=="1" goto CLEARTEMP
if "%choice%"=="2" goto SCHEDTASK
if "%choice%"=="3" goto GODMODE
if "%choice%"=="0" goto MENU
goto MAINTENANCE_MENU

:QUICKACCESS_MENU
cls
echo ========== QUICK ACCESS TOOLS ==========
echo [1]  Open Windows Run Dialog
echo [2]  Run Custom Windows Command
echo [3]  Open File Explorer
echo [4]  Open Startup Folder
echo [0]  Back to Main Menu
echo ========================================
set /p choice=Choose an option:

if "%choice%"=="1" goto OPENRUN
if "%choice%"=="2" goto RUNCMD
if "%choice%"=="3" goto OPENEXPLORER
if "%choice%"=="4" start shell:startup & goto QUICKACCESS_MENU
if "%choice%"=="0" goto MENU
goto QUICKACCESS_MENU

:ADVANCED_MENU
cls
echo ========== ADVANCED UTILITIES ==========
echo [WARNING] Use with caution
echo [1]  Disable UAC
echo [2]  Enable Built-in Administrator Account
echo [3]  Create Stealth Admin Account
echo [4]  Remove Common Bloatware
echo [0]  Back to Main Menu
echo ========================================
set /p choice=Choose an option:

if "%choice%"=="1" goto DISABLE_UAC
if "%choice%"=="2" goto SUPERADMIN
if "%choice%"=="3" goto STEALTHADMIN
if "%choice%"=="4" goto BLOATREMOVE
if "%choice%"=="0" goto MENU
goto ADVANCED_MENU

:: ========== FUNCTION IMPLEMENTATIONS ==========

:OPENMGMT
compmgmt.msc
goto MENU

:DEV_MODE
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d 1
echo Developer mode enabled.
pause
goto MENU

:OWNERSHIP
set /p target="Enter full path of file or folder: "
takeown /f "%target%" /r /d y && icacls "%target%" /grant administrators:F /t
echo Ownership taken and permissions granted.
pause
goto MENU

:DISABLE_UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
echo UAC disabled. Reboot required.
pause
goto MENU

:ENABLE_UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f
echo UAC enabled. Reboot required.
pause
goto MENU

:STEALTHADMIN
set /p username="Enter stealth admin username: "
net user %username% Password123! /add
net localgroup administrators %username% /add
wmic useraccount where "name='%username%'" set PasswordExpires=FALSE
echo Stealth admin account '%username%' created.
pause
goto MENU

:SUPERADMIN
net user administrator /active:yes
echo Built-in Administrator account enabled.
pause
goto MENU

:RCLICKOWN
reg add "HKCR\*\shell\TakeOwnership\command" /f /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
reg add "HKCR\Directory\shell\TakeOwnership\command" /f /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
echo 'Take Ownership' added to right-click context menu.
pause
goto MENU

:FIXTOOLS
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /f >nul 2>&1
echo Task Manager and Registry Editor restored.
pause
goto MENU

:BLOATREMOVE
echo Removing common bloatware...
powershell "Get-AppxPackage *BingWeather* | Remove-AppxPackage"
powershell "Get-AppxPackage *XboxApp* | Remove-AppxPackage"  
powershell "Get-AppxPackage *ZuneMusic* | Remove-AppxPackage"
powershell "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
echo Common bloatware removed.
pause
goto MENU

:SYSINFO
cls
echo ========== SYSTEM INFORMATION ==========
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.
wmic cpu get name
echo.
wmic diskdrive get size,model
echo.
ipconfig | findstr "IPv4"
echo ========================================
pause
goto MENU

:WIFI_PASS
cls
echo ========== SAVED WIFI PASSWORDS ==========
for /f "skip=2 tokens=2,*" %%A in ('netsh wlan show profiles') do (
    for /f "tokens=2 delims=:" %%C in ('netsh wlan show profile "%%B" key^=clear ^| findstr "Key Content"') do (
        echo SSID: %%B
        echo Password: %%C
        echo --------------------
    )
)
pause
goto MENU

:RESMON
resmon
goto MENU

:REMOTECMD
set /p remotecomp="Enter remote computer name: "
set /p remotecmd="Enter command to run: "
wmic /node:"%remotecomp%" process call create "%remotecmd%"
echo Command sent to remote computer.
pause
goto MENU

:GODMODE
mkdir "%UserProfile%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 2>nul
if %ERRORLEVEL% EQU 0 (
    echo God Mode folder created on your Desktop.
) else (
    echo God Mode folder already exists or creation failed.
)
pause
goto MENU

:FLUSH_DNS
ipconfig /flushdns
echo DNS cache flushed.
pause
goto MENU

:SHOW_NETINFO
ipconfig /all | more
pause
goto MENU

:PING_SITE
set /p pingtarget=Enter website or IP to ping: 
ping %pingtarget%
pause
goto MENU

:RESET_NET
cls
echo Resetting network stack...
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo Done. Please restart your PC.
pause
goto MENU

:CLEARTEMP
echo Clearing temp and recent files...
del /q /f "%temp%\*.*" 2>nul
for /d %%x in ("%temp%\*") do rd /s /q "%%x" 2>nul
del /q /f "%AppData%\Microsoft\Windows\Recent\*.*" 2>nul
echo Done.
pause
goto MENU

:SCHEDTASK
set /p taskname=Enter task name: 
set /p filepath=Enter full path of the file/script to run: 
schtasks /create /tn "%taskname%" /tr "%filepath%" /sc onlogon /rl highest 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Scheduled task "%taskname%" created.
) else (
    echo Failed to create scheduled task. Check path and permissions.
)
pause
goto MENU

:ADDSTARTUP
set /p file=Enter full path of file to run at startup: 
if exist "%file%" (
    copy "%file%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" >nul
    echo File copied to startup folder.
) else (
    echo File not found: %file%
)
pause
goto MENU

:OPENRUN
start explorer.exe shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
goto MENU

:RUNCMD
cls
echo ========== QUICK COMMAND RUNNER ==========
set /p usercmd=Enter a Windows command (e.g. notepad, calc, cmd): 
start "" %usercmd%
pause
goto MENU

:CONTROLPANEL
start control
goto MENU

:OPENEXPLORER
start explorer.exe
goto MENU