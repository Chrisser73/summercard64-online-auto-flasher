@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ===== Configuration =====
set "DEBUG=0"
set "DEPLOYER=sc64deployer.exe"
set "FIRMWARE_PATTERN=sc64-firmware-v*.bin"
set "GITHUB_API=https://api.github.com/repos/Polprzewodnikowy/SummerCart64/releases/latest"

echo [36m=== SummerCart64 Firmware Updater ===[0m
echo.

:: ===== Step 0: Check and update sc64deployer.exe =====
echo [[36mINFO[0m] Checking for sc64deployer updates...

if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set "DEP_ZIP_TAG=sc64-deployer-windows-32bit-v"
) else (
    set "DEP_ZIP_TAG=sc64-deployer-windows-v"
)

curl --ssl-no-revoke -s %GITHUB_API% -o _latest_release.json
if errorlevel 1 (
    echo [[31mERROR[0m] Could not fetch GitHub release data.
    goto :wait
)

:: Extract deployer info via PowerShell script
echo $json = Get-Content _latest_release.json -Raw ^| ConvertFrom-Json; > _get_deployer.ps1
echo $asset = $json.assets ^| Where-Object { $_.name -like '%DEP_ZIP_TAG%*.zip' }; >> _get_deployer.ps1
echo if ($asset) { >> _get_deployer.ps1
echo     Write-Output $json.tag_name; >> _get_deployer.ps1
echo     Write-Output $asset.browser_download_url >> _get_deployer.ps1
echo } >> _get_deployer.ps1

powershell -nologo -noprofile -ExecutionPolicy Bypass -File _get_deployer.ps1 > _deployer_info.tmp
del _get_deployer.ps1 >nul 2>&1
del _latest_release.json >nul 2>&1

set "depVersion="
set "depZipUrl="
set /a lineNum=0

for /f "usebackq delims=" %%a in ("_deployer_info.tmp") do (
    set /a lineNum+=1
    if !lineNum! equ 1 set "depVersion=%%a"
    if !lineNum! equ 2 set "depZipUrl=%%a"
)
del _deployer_info.tmp >nul 2>&1

set "depVersionNum=!depVersion:v=!"
set "depVersionStr=!depVersionNum:.=!"
set "depVerOnline=000000000!depVersionStr!"
set "depVerOnline=!depVerOnline:~-9!"

set "depLocalVer=0"
if exist "%DEPLOYER%" (
    "%DEPLOYER%" --version > _verout.tmp 2>nul
    for /f "tokens=2 delims=v" %%v in ('findstr /r "v[0-9]*\.[0-9]*\.[0-9]*" _verout.tmp') do (
        set "vLocal=%%v"
        set "vLocal=!vLocal:.=!"
        set "depLocalVer=000000000!vLocal!"
        set "depLocalVer=!depLocalVer:~-9!"
    )
    del _verout.tmp >nul 2>&1
)


if !depVerOnline! GTR !depLocalVer! (
    echo [[36mINFO[0m] New sc64deployer version available: v!depVersionNum!
    echo [[36mINFO[0m] Downloading from: !depZipUrl!

    set "depZipFile=deployer_update.zip"
    curl --ssl-no-revoke -L -o "!depZipFile!" "!depZipUrl!"
    if errorlevel 1 (
        echo [[31mERROR[0m] Failed to download sc64deployer ZIP.
        goto :wait
    )

    echo [[36mINFO[0m] Extracting ZIP...
    powershell -nologo -noprofile -Command "Expand-Archive -Force '%cd%\!depZipFile!' '%cd%'"
    if errorlevel 1 (
        echo [[31mERROR[0m] Failed to extract ZIP archive.
        goto :wait
    )

    del "!depZipFile!" >nul 2>&1
    echo [[32mSUCCESS[0m] sc64deployer updated successfully.
) else (
    echo [[36mINFO[0m] sc64deployer is already up to date.
)

:: ===== Prompt to continue =====
echo.
<nul set /p=[36m[INFO] Proceed with firmware update? (Y/N): [0m
set /p continueFlash=
if /i not "%continueFlash%"=="Y" (
    echo.
    echo [[32mINFO[0m] Firmware update cancelled by user.
    goto :wait
)

:: ===== Step 1: Locate latest local firmware =====
set "latestLocalVer=0"
set "latestLocalFile="

for %%f in (%FIRMWARE_PATTERN%) do (
    for /f "tokens=2 delims=-v" %%a in ("%%~nxf") do (
        set "verStr=%%a"
        set "verStr=!verStr:.=!"
        set "verNum=000000000!verStr!"
        set "verNum=!verNum:~-9!"
        if !verNum! GTR !latestLocalVer! (
            set "latestLocalVer=!verNum!"
            set "latestLocalFile=%%f"
        )
    )
)

if defined latestLocalFile (
    echo [[36mINFO[0m] Local firmware found: !latestLocalFile!
    echo [[36mINFO[0m] Version: !latestLocalVer!
) else (
    echo [[36mINFO[0m] No local firmware found.
)

:: ===== Step 2: Fetch latest firmware info =====
echo [[36mINFO[0m] Checking for latest firmware online...
curl --ssl-no-revoke -s %GITHUB_API% -o _latest_release.json
if errorlevel 1 (
    echo [[31mERROR[0m] Failed to fetch GitHub API data.
    goto :wait
)

:: PowerShell JSON parsing to file
echo $json = Get-Content _latest_release.json -Raw ^| ConvertFrom-Json; > _get_firmware.ps1
echo $asset = $json.assets ^| Where-Object { $_.name -like 'sc64-firmware-v*.bin' }; >> _get_firmware.ps1
echo if ($asset) { >> _get_firmware.ps1
echo     Write-Output $json.tag_name; >> _get_firmware.ps1
echo     Write-Output $asset.browser_download_url >> _get_firmware.ps1
echo } >> _get_firmware.ps1

powershell -nologo -noprofile -ExecutionPolicy Bypass -File _get_firmware.ps1 > _ps_output.tmp
del _get_firmware.ps1 >nul 2>&1
del _latest_release.json >nul 2>&1

set "versionTag="
set "downloadUrl="
set /a lineNum=0

for /f "usebackq delims=" %%a in ("_ps_output.tmp") do (
    set /a lineNum+=1
    if !lineNum! equ 1 set "versionTag=%%a"
    if !lineNum! equ 2 set "downloadUrl=%%a"
)
del _ps_output.tmp >nul 2>&1

set "versionOnly=!versionTag:v=!"
set "versionStr=!versionOnly:.=!"
set "verOnlineNum=000000000!versionStr!"
set "verOnlineNum=!verOnlineNum:~-9!"

echo [[36mINFO[0m] Online firmware version: !versionOnly! (compare: !verOnlineNum!)

if not defined downloadUrl (
    echo [[31mERROR[0m] Could not extract firmware download URL.
    goto :wait
)

for %%f in (!downloadUrl!) do set "firmwareFile=%%~nxf"

:: ===== Step 3: Download firmware if needed =====
if !verOnlineNum! GTR !latestLocalVer! (
    echo [[36mINFO[0m] Newer firmware found. Downloading...
    echo        !downloadUrl!
    curl --ssl-no-revoke -L -o "!firmwareFile!" "!downloadUrl!"
    if errorlevel 1 (
        echo [[31mERROR[0m] Failed to download firmware file.
        goto :wait
    )
    echo [[32mSUCCESS[0m] Firmware downloaded.
    set "latestLocalFile=!firmwareFile!"
    set "latestLocalVer=!verOnlineNum!"
) else (
    echo [[36mINFO[0m] Local firmware is up to date.
)

:: ===== Step 4: Flash firmware =====
if not defined latestLocalFile (
    echo [[31mERROR[0m] No firmware file found. Aborting.
    goto :wait
)

echo.
echo [[36mINFO[0m] Flashing firmware: !latestLocalFile!
timeout /t 1 >nul

%DEPLOYER% firmware update "!latestLocalFile!"
set "flashCode=%errorlevel%"
echo.

if "!flashCode!"=="0" (
    echo [[32mSUCCESS[0m] Firmware flashed successfully!
) else (
    echo [[31mERROR[0m] Flash failed with error code: !flashCode!
)

:: ===== Exit =====
:wait
echo.
echo [[32mEND[0m] Press any key to exit...
pause >nul
exit /b
