# Winget Installer Script
# This script will install or repair winget on your Windows system

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    exit
}

Write-Host "Starting winget installation/repair process..." -ForegroundColor Cyan

# Function to check if winget is already installed
function Test-WinGet {
    try {
        $null = Get-Command winget -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Install dependencies
Write-Host "Installing required dependencies..." -ForegroundColor Yellow

# Install VCLibs
try {
    Write-Host "Installing VCLibs..."
    $vcLibsUrl = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    $vcLibsPath = "$env:TEMP\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    
    Invoke-WebRequest -Uri $vcLibsUrl -OutFile $vcLibsPath
    Add-AppxPackage -Path $vcLibsPath -ErrorAction Stop
}
catch {
    Write-Warning "Failed to install VCLibs: $_"
}

# Install UI Xaml
try {
    Write-Host "Installing UI Xaml..."
    $xamlUrl = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx"
    $xamlPath = "$env:TEMP\Microsoft.UI.Xaml.2.8.x64.appx"
    
    Invoke-WebRequest -Uri $xamlUrl -OutFile $xamlPath
    Add-AppxPackage -Path $xamlPath -ErrorAction Stop
}
catch {
    Write-Warning "Failed to install UI Xaml: $_"
}

# Install winget
try {
    Write-Host "Installing/repairing winget..." -ForegroundColor Yellow
    $wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $wingetPath = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    
    Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetPath
    Add-AppxPackage -Path $wingetPath -ErrorAction Stop
    
    Write-Host "Winget has been successfully installed!" -ForegroundColor Green
}
catch {
    Write-Warning "Failed to install winget: $_"
}

# Reset sources if winget is installed
if (Test-WinGet) {
    Write-Host "Resetting winget sources..." -ForegroundColor Yellow
    try {
        winget source reset --force
        Write-Host "Winget sources have been reset." -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to reset winget sources: $_"
    }
    
    # Verify winget is working
    Write-Host "Testing winget..." -ForegroundColor Yellow
    try {
        winget --version
        Write-Host "Winget is working properly!" -ForegroundColor Green
    }
    catch {
        Write-Warning "Winget may not be working correctly: $_"
    }
}
else {
    Write-Warning "Winget installation may have failed. Please try again or install manually from the Microsoft Store."
}

Write-Host "Script completed. If you're still having issues, try restarting your computer." -ForegroundColor Cyan