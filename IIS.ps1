<#
#Controleer of de Web Server er al op staat
$srv = Get-WindowsFeature *Web-Server*
if ($srv.installed) {#Do Nothing, if statement staat erin voor het testen zodat we hem vaker uit kunnen voeren
} else {
    Install-WindowsFeature -name Web-Server -IncludeManagementTools #Installeer de IIS Web-Server
}

#De IIS Web-Server kan benaderd worden op het IP_Address van de server
#Krijg het IP-Address en sla deze op in een variabele
$SIPAddress = (Get-NetIPAddress -AddressFamily IPV4 -InterfaceAlias Ethernet0).IPAddress


#Open de url van de webserver in firefox
#Voor Edge moet je Firefox vervangen door msedge
#Voor Chrome moet je Firefox vervangen door chrome
[system.Diagnostics.Process]::Start("firefox","$SIPAddress")
#>
$url = "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe"
$outpath = "$PSScriptRoot/Git-2.38.1-64-bit.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
.\Git-2.38.1-64-bit.exe /VERYSILENT /NORESTART
Invoke-Item "path to cmd file"
