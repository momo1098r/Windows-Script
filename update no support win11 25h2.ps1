# Path to Downloads folder
$DownloadPath = "$env:USERPROFILE\Downloads"
$IsoFile = "$DownloadPath\Win11_25H2_Italian_x64.iso"

# Official Microsoft Windows 11 download page
$MsDownloadPage = "https://www.microsoft.com/software-download/windows11"

Write-Host "Opening Windows 11 download page..." -ForegroundColor Cyan
Start-Process $MsDownloadPage

# Wait for the user to manually download the ISO
Write-Host "After downloading the ISO to your Downloads folder, press ENTER to CONTINUE." -ForegroundColor Yellow
Pause

# Check if the ISO exists
if (-not (Test-Path $IsoFile)) {
    $IsoFile = Read-Host "Enter the ISO file path if it's not in the Downloads folder"
    if (-not (Test-Path $IsoFile)) {
        Write-Host "ISO file not found. Stopping the script." -ForegroundColor Red
        exit
    }
}

# Mount the ISO image
Write-Host "Mounting ISO image..."
$mountResult = Mount-DiskImage -ImagePath $IsoFile -PassThru
$driveLetter = ($mountResult | Get-Volume).DriveLetter

if (-not $driveLetter) {
    Write-Host "Unable to determine the ISO drive letter." -ForegroundColor Red
    exit
}

# Path to the sources folder
$SourcesPath = "$driveLetter`:\sources"

if (-not (Test-Path $SourcesPath)) {
    Write-Host "'sources' folder not found in the ISO image." -ForegroundColor Red
    exit
}

# Open PowerShell as administrator in the sources folder and run cmd with setupprep
Write-Host "Opening PowerShell as administrator in the 'sources' folder..." -ForegroundColor Green

$Command = "cd `"$SourcesPath`"; cmd /k setupprep.exe /product server"

Start-Process powershell -ArgumentList "-NoExit", "-Command", $Command -Verb RunAs

Write-Host "PowerShell started as administrator in the 'sources' folder. You can see the command running." -ForegroundColor Cyan



