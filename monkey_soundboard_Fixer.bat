@echo off
set "VERSION=3.4"
title Monkey Song Fixer v%VERSION%
color 0D
setlocal enabledelayedexpansion

:: === Settings ===
set EXT_LIST=mp3 wav ogg

:main
cls
echo =============================================
echo         Monkey Song Fixer Version %VERSION%
echo =============================================
echo Script is running from: %~dp0
echo(
echo This Script Will FIX Your Soundboard By Renaming All .mp3, .wav, And .ogg Files In This Folder
echo To A More Likable Script For IDKS Mod Menu, It Will Keep The Original File Name.
echo(
echo Special Thx To:
echo iiDK And .prohecker On Discord. Made by ytcone_89400 On Discord!
echo(
echo   [1] View System Info
echo   [2] View Wi-Fi Info
echo   [3] Create Backup
echo   [4] Start Renaming Files
echo   [b] Open Backup Folder
echo   [g] Open GitHub
echo   [Q] Exit
echo(
set /p choice=Enter your choice: 

if /i "%choice%"=="1" goto systeminfo
if /i "%choice%"=="2" goto wifiinfo
if /i "%choice%"=="3" goto createbackup
if /i "%choice%"=="4" goto renamefiles
if /i "%choice%"=="b" goto openfolder
if /i "%choice%"=="g" goto opengithub
if /i "%choice%"=="q" exit /b

echo Invalid choice. Please try again.
pause
goto main

:systeminfo
cls
echo =============================================
echo            System Information
echo =============================================
echo Computer Name : %COMPUTERNAME%
echo Username      : %USERNAME%
echo OS Version    : %OS%
echo Processor     : %PROCESSOR_IDENTIFIER%
echo Architecture  : %PROCESSOR_ARCHITECTURE%
for /f "skip=1 tokens=* delims= " %%R in ('wmic computersystem get TotalPhysicalMemory') do (
    set "rawRAM=%%R"
    goto :gotram
)
:gotram
set "rawRAM=%rawRAM: =%"
if defined rawRAM (
    set /a RAM_MB=%rawRAM% / 1000000
    echo RAM (MB)      : %RAM_MB%
) else (
    echo RAM (MB)      : Unknown
)
echo(
pause
goto main

:wifiinfo
cls
echo =============================================
echo             Wi-Fi Information
echo =============================================
netsh wlan show interfaces | findstr /R "^ *SSID|^ *Signal|^ *Receive rate|^ *Transmit rate" > tempwifi.txt
if %ERRORLEVEL% NEQ 0 (
    echo No Wi-Fi connection found.
) else (
    type tempwifi.txt
)
del tempwifi.txt
echo(
pause
goto main

:createbackup
cls
echo Creating backup folder...
mkdir "_backup" 2>nul
copy *.mp3 "_backup\" >nul 2>&1
copy *.wav "_backup\" >nul 2>&1
copy *.ogg "_backup\" >nul 2>&1
echo Backup complete. Files saved in "_backup" folder.
echo(
pause
goto main

:renamefiles
cls
echo(
echo Processing files in: %cd%
echo(
for %%E in (%EXT_LIST%) do (
    for %%F in (*%%E) do (
        set "name=%%~nF"
        set "bareext=%%~xF"
        set "bareext=!bareext:~1!"

        :: Check if filename already ends with .ext
        echo !name! | findstr /i "\.!bareext!$" >nul
        if errorlevel 1 (
            ren "%%F" "%%~nF%%~xF%%~xF" 2>nul
            echo ✔ Renamed: %%F → %%~nF%%~xF%%~xF
        ) else (
            echo Skipped: %%F (already ends with extension)
        )
    )
)
echo(
echo ==========================================
echo   Script ran at: %DATE% %TIME%
echo ==========================================
echo Version %VERSION%
echo(
echo All done!
echo monkey can now play sounds!
echo(
pause
goto main

:openfolder
cls
echo Opening backup folder...
start "" "%~dp0_backup\"
echo(
pause
goto main

:opengithub
cls
echo Opening GitHub page...
start "" "https://github.com/ThatCone/monke_soundbored_fix"
echo(
pause
goto main
