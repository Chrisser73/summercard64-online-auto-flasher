# 🕹️ SummerCart64 Auto Online Firmware-Updater & Deployer (Windows)

![Shell](https://img.shields.io/badge/Shell-Batch-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-%F0%9F%94%A5-lightblue)
![Windows](https://img.shields.io/badge/Platform-Windows-0078D6?logo=windows&logoColor=white)
![Auto-Update](https://img.shields.io/badge/Feature-Auto--Updater-brightgreen)
![GitHub Release](https://img.shields.io/github/v/release/Chrisser73/summercard64-online-auto-flasher?label=Latest%20Release)

A fully automated Batch script to check, download, and update the latest **SummerCart64 firmware** and **sc64deployer tool** from the official GitHub repository.

This script ensures you're always using the **latest stable firmware version** and the corresponding **sc64deployer executable**, with minimal effort — just plug in and click.

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

> 📌 **Before running the script**, ensure the SummerCart64 cartridge is connected!

1. Plug your **SummerCart64** into a USB port on your PC.
2. Wait until you hear the **Windows "connected" sound** confirming the USB device is recognized.
3. Double-click the file named `UPDATER.bat`.
4. Follow on-screen instructions — the script will handle the rest.

No command line knowledge required.

---

## 📦 Features

- **Full automation** – checks, downloads, and flashes without any manual interaction
- **Smart version comparison** – skips downloads if your firmware is already up to date
- **Self-updating deployer** – keeps `sc64deployer.exe` fresh
- **Colored output** – easier to read status and warnings
- **Cleanups** temporary files after each run
- **Error detection & guidance** – detects locked files, access denied errors, etc.

---

## ⚠️ Notes & Tips

- Do **not** run multiple instances of the updater simultaneously.
- If flashing fails with a "file access denied" message, make sure no other instance of `sc64deployer.exe` or the firmware file is open.
- The script requires **Internet access** to check for the latest release on GitHub.
- **PowerShell is required**, but no admin rights are needed.

---

## Credits

This script was built around:

- [SummerCart64 by Polprzewodnikowy](https://github.com/Polprzewodnikowy/SummerCart64)
- Windows Batch scripting magic and PowerShell JSON parsing
- Real-world frustration turned into automation ❤️

---

Made with ☕, ✨ and a few `"." kann syntaktisch nicht verarbeitet werden` errors.
