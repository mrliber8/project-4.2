#pad waar het wordt opgeslagen
$Installer = "C:/7-zip"; 

#Controleren of de folder 'AVGAntiVirus' bestaat, anders aanmaken.
if (Test-Path $Installer) {
   
    Write-Host "Folder Exists"
    # Perform Delete file from folder operation
}
else
{
  
    #PowerShell Create directory if not exists
    New-Item $Installer -ItemType Directory
    Write-Host "Folder Created successfully"
}

#naam van de AVG Antivirus exe
$filename = "7z2201-x64.exe";

#Link naar de download 
Invoke-WebRequest "https://www.7-zip.org/a/7z2201-x64.exe"  -OutFile $Installer/$filename; 

Write-Output "7-zip installer is uitgevoerd"




Invoke-Expression -Command $Installer/$filename