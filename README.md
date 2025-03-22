# 🕹️ SummerCart64 Auto Online Firmware-Updater & Deployer (Windows)

![Shell](https://img.shields.io/badge/Shell-Batch-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-%F0%9F%94%A5-lightblue)
![Windows](https://img.shields.io/badge/Platform-Windows-0078D6?logo=windows&logoColor=white)
![Auto-Update](https://img.shields.io/badge/Feature-Auto--Updater-brightgreen)
![GitHub Release](https://img.shields.io/github/v/release/Chrisser73/summercart64-online-auto-flasher?label=Latest%20Release)
![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)

A fully automated firmware & deployer updater for **SummerCart64** users on Windows.  
This tool checks online for the latest firmware and `sc64deployer.exe`, downloads and installs them if needed — all in one click.

---

## ⚙️ What does this script do?

- ✔️ Automatically detects the latest firmware release from GitHub
- ✔️ Checks if a newer version of `sc64deployer.exe` is available
- ✔️ Downloads and extracts the latest deployer if needed
- ✔️ Compares your local firmware version against the newest release
- ✔️ Downloads firmware only if an update is required
- ✔️ Flashes the firmware via `sc64deployer.exe`
- ✔️ Provides user-friendly status messages, colors, and error hints

---

## 🛠️ How to use

> **Before running, make sure the SummerCart64 cartridge is plugged in via USB.**

1. Connect your **SummerCart64** cartridge to your PC via USB.
2. Wait for the Windows **"device connected"** sound.
3. Run the appropriate updater for your system:
   - `SummerCart64 Online Updater (64 Bit).exe` → for most modern systems
   - `SummerCart64 Online Updater (32 Bit).exe` → for older systems
   - `UPDATER.bat` → for fallback/manual usage
4. Follow the on-screen instructions — everything else is automatic!

> No command line knowledge required. Internet connection needed.

---

## 📦 Features

- **Full automation** – checks, downloads, and flashes without any manual interaction
- **Smart version comparison** – skips downloads if your firmware is already up to date
- **Self-updating deployer** – keeps `sc64deployer.exe` fresh
- **Colored output** – easier to read status and warnings
- **Cleanups** temporary files after each run
- **Error detection & guidance** – detects locked files, access denied errors, etc.

---

## Tips & Troubleshooting

- **Do not open multiple instances** of the updater simultaneously.
- If flashing fails with "access denied" or "file is in use":
  - Close all running instances of `sc64deployer.exe`
  - Make sure the firmware `.bin` file isn't open elsewhere
- Run from a folder with write permissions (e.g., not `C:\Program Files`)
- PowerShell is required, but admin rights are **not** needed

---

## Credits

This script was built around:

- [SummerCart64 by Polprzewodnikowy](https://github.com/Polprzewodnikowy/SummerCart64)
- Windows Batch scripting magic and PowerShell JSON parsing
- Real-world frustration turned into automation

---

Made with ☕ and a few `"." kann syntaktisch nicht verarbeitet werden` errors.
