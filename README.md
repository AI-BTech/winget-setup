# Winget Setup

This repository contains scripts and configuration files to help you set up and configure the Windows Package Manager (winget) on your system.

## 🚀 Quick Installation

Open PowerShell as administrator and run:

```powershell
# Download and run the installer script directly from this repository
iwr -useb https://raw.githubusercontent.com/AI-BTech/winget-setup/main/winget-installer.ps1 | iex
```

## 🛠️ Manual Installation

If the quick installation doesn't work, follow these steps:

1. Download the [winget-installer.ps1](https://raw.githubusercontent.com/AI-BTech/winget-setup/main/winget-installer.ps1) script
2. Open PowerShell as administrator
3. Navigate to the download location
4. Run: `.\winget-installer.ps1`

## ⚙️ Configuration

To use the custom configuration:

1. Download [winget-config.json](https://raw.githubusercontent.com/AI-BTech/winget-setup/main/winget-config.json)
2. Place it in: `%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json`

Or run this PowerShell command:

```powershell
$configPath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"
if (-not (Test-Path $configPath)) { New-Item -Path $configPath -ItemType Directory -Force }
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AI-BTech/winget-setup/main/winget-config.json" -OutFile "$configPath\settings.json"
```

## 🔍 Troubleshooting

If you're still having issues:

- Make sure your system meets the [requirements](https://github.com/microsoft/winget-cli#installing-the-client)
- Try installing App Installer from the [Microsoft Store](https://www.microsoft.com/p/app-installer/9nblggh4nns1)
- Reset winget sources: `winget source reset --force`
- Check for updates: `winget source update`

## 📑 Features

The configuration includes:

- Rainbow progress bar
- Experimental features enabled
- User-scoped installations by default
- Disabled telemetry
- Optimized network settings