#pad waar het wordt opgeslagen
$Installer = "C:/AVGAntiVirus"; 

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
$filename = "avg_antivirus_free_setup.exe";

#Link naar de download 
Invoke-WebRequest "https://bits.avcdn.net/productfamily_ANTIVIRUS/insttype_FREE/platform_WIN_AVG/installertype_ONLINE/build_RELEASE/cookie_mmm_bav_003_999_a6k_m"  -OutFile $Installer/$filename; 

Write-Output "AVG Antivirus installer is uitgevoerd"




Invoke-Expression -Command $Installer/$filename