# Windows - Powershell Script
Before running the script, make sure you’ve executed:
Before running the script, make sure you’ve executed:  

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force
```
<h3><b> 🧰 Restore Windows 10 Right Click Button 🧰 </b></h3>

This script restores the classic Windows 10 context menu on Windows 11, replacing the new compact version introduced by Microsoft.
With just one click, it brings back the full, familiar right-click menu, giving you quick access to useful options like Properties, Open file location, Send to, and more.

Main features:
- Restores the classic Windows 10 context menu.
- Works directly through the Windows Registry, no extra software required.
- Fully compatible with all editions of Windows 11.

Perfect for users who prefer the speed and convenience of the classic Windows 10 right-click menu.

---

<h3><b> 💻 Update no support win11 25h2 💻 </b></h3> 

A PowerShell utility that automates downloading the latest Windows 11 ISO, prepares an installer environment, and launches the upgrade/installation process. The script can optionally attempt to work around strict hardware or TPM/secure-boot checks so the installation can proceed on unsupported hardware.

---

<h3><b> 🌌 Change Your Desktop and Lock Screen Wallpaper with a Single Click! 🌌 </b></h3>
  
This PowerShell script automates the process of downloading an image from a specified URL and setting it as your desktop wallpaper and lock screen on Windows. It uses the SystemParametersInfo API to update the desktop wallpaper and modifies the system registry to change the lock screen background.

Features:<br>
Downloads an image from a specified URL.
Saves the image in the user's "Pictures" folder.
Sets the downloaded image as the desktop wallpaper using the "Fill" fit option.
Changes the lock screen background by modifying the system registry.
Easy to customize the image URL.

How to use:<br>
Edit the image URL in the script if needed.
Run the script in PowerShell as Administrator.
The script will automatically download the image and set it as the desktop and lock screen wallpaper.

Requirements:<br>
PowerShell 5.1 or later.
Administrator privileges are required to change the lock screen settings.

This script is compatible with Windows 10 and later versions.
