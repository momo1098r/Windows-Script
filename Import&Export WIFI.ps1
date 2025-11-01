# Funzione per verificare se lo script è in esecuzione come amministratore
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Riavvia lo script come amministratore se non lo è
if (-not (Test-Administrator)) {
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"" + $myInvocation.MyCommand.Definition + "`"";
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
    exit
}

# Aggiungi i moduli di Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Crea il form
$form = New-Object System.Windows.Forms.Form
$form.Text = "WiFi Export/Import"
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = "CenterScreen"

# Crea il pulsante per l'esportazione
$exportButton = New-Object System.Windows.Forms.Button
$exportButton.Location = New-Object System.Drawing.Point(50,50)
$exportButton.Size = New-Object System.Drawing.Size(200,30)
$exportButton.Text = "Esporta Reti WiFi"
$exportButton.Add_Click({
    $outputFolder = "C:\WiFiProfiles"
    if (-not (Test-Path $outputFolder)) {
        New-Item -ItemType Directory -Path $outputFolder
    }
    netsh.exe wlan export profile key=clear folder=$outputFolder
    [System.Windows.Forms.MessageBox]::Show("Reti WiFi esportate in $outputFolder")
})

# Crea il pulsante per l'importazione
$importButton = New-Object System.Windows.Forms.Button
$importButton.Location = New-Object System.Drawing.Point(50,100)
$importButton.Size = New-Object System.Drawing.Size(200,30)
$importButton.Text = "Importa Reti WiFi"
$importButton.Add_Click({
    $importFolder = "C:\WiFiProfiles"
    if (Test-Path $importFolder) {
        $profiles = Get-ChildItem -Path $importFolder -Filter *.xml
        foreach ($profile in $profiles) {
            netsh.exe wlan add profile filename="$($profile.FullName)"
        }
        [System.Windows.Forms.MessageBox]::Show("Reti WiFi importate da $importFolder")
    } else {
        [System.Windows.Forms.MessageBox]::Show("La cartella $importFolder non esiste. Assicurati di aver esportato le reti WiFi.")
    }
})

# Aggiungi i pulsanti al form
$form.Controls.Add($exportButton)
$form.Controls.Add($importButton)

# Mostra il form
$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
