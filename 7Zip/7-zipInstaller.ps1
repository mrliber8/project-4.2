#Naam meegeven
$software = "7-Zip 22.01 (x64)";
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null



Write-Host "'$software' wordt uitgevoerd.";

#pad waar het wordt opgeslagen
$Installer = "C:/7-zip"; 

#Controleren of de folder '7Zip' bestaat, anders aanmaken.
if (Test-Path $Installer) {
   
    Write-Host "Folder bestaat"
    # Perform Delete file from folder operation
}
else
{
  
    #PowerShell Create directory if not exists
    New-Item $Installer -ItemType Directory
    Write-Host "Folder aangemaakt"
}

#naam van de 7zip  exe
$filename = "7z2201-x64.exe";

#Link naar de download 
Invoke-WebRequest "https://www.7-zip.org/a/7z2201-x64.exe"  -OutFile $Installer/$filename; 

Write-Output "7-zip installer is uitgevoerd"

#Invoke-Expression -Command $Installer/$filename
Start-Process 7zipSilentInstaller.cmd  


