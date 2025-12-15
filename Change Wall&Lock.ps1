Write-Output "
                    _  _  _  
 _ _  _  _ _  _ -// //_//_/_
/ / //_// / //_///_/  //_// 
---------------------------------"

Write-Output "Follow me on TikTok @momo1098r"

# Define the image URL
$imageUrl ="https://r4.wallpaperflare.com/wallpaper/974/565/254/windows-11-windows-10-minimalism-hd-wallpaper-c876bde870303c5820cce16ed8a244ca.jpg"

# Get the user's Pictures folder path
$folderPath = [System.Environment]::GetFolderPath("MyPictures")

# Define the file name for the downloaded image
$imageFileName = "background.jpg"

# Compose the full path to save the image
$imagePath = Join-Path -Path $folderPath -ChildPath $imageFileName

# Download the image from the web and save it at the specified location
Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath

# Function to set the wallpaper with "Fill" fit
function Set-Wallpaper {
    param (
        [string]$Path
    )
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    public const int SPI_SETDESKWALLPAPER = 0x0014;
    public const int SPIF_UPDATEINIFILE = 0x01;
    public const int SPIF_SENDWININICHANGE = 0x02;
}
"@

    [Wallpaper]::SystemParametersInfo([Wallpaper]::SPI_SETDESKWALLPAPER, 0, $Path, [Wallpaper]::SPIF_UPDATEINIFILE -bor [Wallpaper]::SPIF_SENDWININICHANGE)
}

# Set the downloaded image as the desktop wallpaper
Set-Wallpaper -Path $imagePath

# Set the downloaded image as the lock screen wallpaper
$Key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP'

if (!(Test-Path -Path $Key)) {
    New-Item -Path $Key -Force | Out-Null
}

Set-ItemProperty -Path $Key -Name LockScreenImagePath -Value $imagePath
Set-ItemProperty -Path $Key -Name LockScreenImageStatus -Value 1

Write-Host "The image has been downloaded and set as the desktop and lock screen wallpaper."
