# Percorso cartella Download
$DownloadPath = "$env:USERPROFILE\Downloads"
$IsoFile = "$DownloadPath\Win11_25H2_Italian_x64.iso"

# URL ufficiale della pagina di download di Windows 11
$MsDownloadPage = "https://www.microsoft.com/software-download/windows11"

Write-Host "Apro la pagina ufficiale di download di Windows 11 25H2..." -ForegroundColor Cyan
Start-Process $MsDownloadPage

# Attendi che l’utente scarichi manualmente la ISO
Write-Host "Dopo aver scaricato la ISO in formato .iso nella cartella Download, premi INVIO per continuare." -ForegroundColor Yellow
Pause

# Controlla se la ISO esiste
if (-not (Test-Path $IsoFile)) {
    $IsoFile = Read-Host "Inserisci il percorso completo della ISO se non è in Downloads"
    if (-not (Test-Path $IsoFile)) {
        Write-Host "❌ ISO non trovata. Interrompo lo script." -ForegroundColor Red
        exit
    }
}

# Monta la ISO
Write-Host "Montaggio dell’immagine ISO..."
$mountResult = Mount-DiskImage -ImagePath $IsoFile -PassThru
$driveLetter = ($mountResult | Get-Volume).DriveLetter

if (-not $driveLetter) {
    Write-Host "❌ Impossibile determinare la lettera dell’unità ISO." -ForegroundColor Red
    exit
}

# Percorso cartella sources
$SourcesPath = "$driveLetter`:\sources"

if (-not (Test-Path $SourcesPath)) {
    Write-Host "❌ Cartella 'sources' non trovata nell'immagine ISO." -ForegroundColor Red
    exit
}

# Apri PowerShell come amministratore nella cartella sources e lancia cmd con setupprep
Write-Host "🚀 Apertura di PowerShell come amministratore nella cartella sources..." -ForegroundColor Green

$Command = "cd `"$SourcesPath`"; cmd /k setupprep.exe/product server"

Start-Process powershell -ArgumentList "-NoExit", "-Command", $Command -Verb RunAs

Write-Host "PowerShell avviato come amministratore nella cartella 'sources'. Puoi vedere il comando in esecuzione." -ForegroundColor Cyan

