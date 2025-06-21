
@echo off
:: Elevate to admin if not already
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Requesting admin access...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

title DeusCMDV1 - F*ck Windows ToolKit

:MENU
cls
echo =================================================
echo        DEUSCMDV1 - F*CK WINDOWS TOOLKIT
echo =================================================
echo [1] Open Computer Management
echo [2] Enable Developer Mode
echo [3] Take Ownership of a File or Folder
echo [4] Disable UAC
echo [5] Re-enable UAC
echo [6] Create Stealth Admin Account
echo [7] Enable Built-in Administrator Account
echo [8] Add "Take Ownership" to Right Click
echo [9] Restore Task Manager and Registry Editor
echo [10] Remove Common Bloatware
echo -------------------------------------------------
echo [11] System Info Dashboard
echo [12] View Saved Wi-Fi Passwords
echo [13] Launch Resource Monitor
echo [14] Open Startup Folder
echo [15] Open Remote Shutdown Tool
echo [16] Remote Command Launcher
echo -------------------------------------------------
echo [17] Open Windows Run Dialog
echo [18] Run Custom Windows Command
echo [19] Open Control Panel
echo [20] Open File Explorer
echo -------------------------------------------------
echo [21] Enable God Mode
echo [22] Flush DNS Cache
echo [23] Show Active Network Info
echo [24] Ping a Website
echo [25] Reset Network Stack
echo [26] Clear Temp and Recent Files
echo [27] Create Scheduled Task
echo [28] Add File to Startup Folder
echo =================================================
set /p choice=Choose an option:

if "%choice%"=="1" goto OPENMGMT
if "%choice%"=="2" goto DEV_MODE
if "%choice%"=="3" goto OWNERSHIP
if "%choice%"=="4" goto DISABLE_UAC
if "%choice%"=="5" goto ENABLE_UAC
if "%choice%"=="6" goto STEALTHADMIN
if "%choice%"=="7" goto SUPERADMIN
if "%choice%"=="8" goto RCLICKOWN
if "%choice%"=="9" goto FIXTOOLS
if "%choice%"=="10" goto BLOATREMOVE
if "%choice%"=="11" goto SYSINFO
if "%choice%"=="12" goto WIFI_PASS
if "%choice%"=="13" goto RESMON
if "%choice%"=="14" start shell:startup & goto MENU
if "%choice%"=="15" shutdown /i & goto MENU
if "%choice%"=="16" goto REMOTECMD
if "%choice%"=="17" goto OPENRUN
if "%choice%"=="18" goto RUNCMD
if "%choice%"=="19" goto CONTROLPANEL
if "%choice%"=="20" goto OPENEXPLORER
if "%choice%"=="21" goto GODMODE
if "%choice%"=="22" goto FLUSH_DNS
if "%choice%"=="23" goto SHOW_NETINFO
if "%choice%"=="24" goto PING_SITE
if "%choice%"=="25" goto RESET_NET
if "%choice%"=="26" goto CLEARTEMP
if "%choice%"=="27" goto SCHEDTASK
if "%choice%"=="28" goto ADDSTARTUP
goto MENU

:: --- Existing Functions (truncated for brevity if you already have them) ---
:: Copy-paste previous blocks like :DEV_MODE, :WIFI_PASS, :RESMON, etc.
:: New blocks start here:

:GODMODE
mkdir "%UserProfile%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
echo God Mode folder created on your Desktop.
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
del /q /f "%temp%\*.*"
for /d %%x in ("%temp%\*") do rd /s /q "%%x"
del /q /f "%AppData%\Microsoft\Windows\Recent\*.*"
echo Done.
pause
goto MENU

:SCHEDTASK
set /p taskname=Enter task name:
set /p filepath=Enter full path of the file/script to run:
schtasks /create /tn "%taskname%" /tr "%filepath%" /sc onlogon /rl highest
echo Scheduled task "%taskname%" created.
pause
goto MENU

:ADDSTARTUP
set /p file=Enter full path of file to run at startup:
copy "%file%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
echo File copied to startup folder.
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
