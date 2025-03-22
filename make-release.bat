@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ===== Settings =====
set "RELEASE_PREFIX=RELEASE SummerCart64 Online Updater v"
set "ZIP_PREFIX=SummerCart64 Online Updater v"
set "VERSION_FILE=version.txt"
set "ICON_DIR=icon"

:: ===== Read version =====
if not exist "%VERSION_FILE%" (
    echo [ERROR] Version file not found: %VERSION_FILE%
    goto :end
)
set /p VERSION=<%VERSION_FILE%

set "RELEASE_FOLDER=%RELEASE_PREFIX%%VERSION%"
set "ZIP_NAME=%ZIP_PREFIX%%VERSION%.zip"

echo [INFO] Creating "%RELEASE_FOLDER%"...

:: ===== Clean up existing folder =====
if exist "%RELEASE_FOLDER%" (
    echo [WARN] Folder already exists. Removing...
    rmdir /s /q "%RELEASE_FOLDER%"
)
mkdir "%RELEASE_FOLDER%"

:: ===== Copy main .exe files =====
for %%F in (*.exe) do (
    echo [INFO] Copying %%F...
    copy "%%F" "%RELEASE_FOLDER%" >nul
)

:: ===== Copy UPDATER.bat =====
if exist "UPDATER.bat" (
    copy "UPDATER.bat" "%RELEASE_FOLDER%" >nul
    echo [INFO] Copied UPDATER.bat
) else (
    echo [WARN] Missing UPDATER.bat
)

:: ===== Copy icon folder =====
if exist "%ICON_DIR%\icon.ico" (
    xcopy "%ICON_DIR%" "%RELEASE_FOLDER%\%ICON_DIR%" /E /I /Y >nul
    echo [INFO] Copied icon folder
) else (
    echo [WARN] icon.ico not found in %ICON_DIR%
)

:: ===== Create ZIP file =====
echo.
echo [INFO] Creating ZIP: "%ZIP_NAME%"
powershell -nologo -noprofile -Command ^
    "Compress-Archive -Path '%RELEASE_FOLDER%\*' -DestinationPath '%ZIP_NAME%'"

if exist "%ZIP_NAME%" (
    echo [INFO] ZIP file created successfully.
    echo [INFO] Cleaning up folder: "%RELEASE_FOLDER%"
    rmdir /s /q "%RELEASE_FOLDER%"
) else (
    echo [ERROR] Failed to create ZIP file.
)

echo.
echo [SUCCESS] Release package is ready: "%ZIP_NAME%"

:end
endlocal
echo.
pause
