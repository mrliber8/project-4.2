#
#Controleer of de Web Server er al op staat
$srv = Get-WindowsFeature *Web-Server*
if ($srv.installed) {#Do Nothing, if statement staat erin voor het testen zodat we hem vaker uit kunnen voeren
} else {
    Install-WindowsFeature -name Web-Server -IncludeAllSubFeature -IncludeManagementTools #Installeer de IIS Web-Server
}

#De IIS Web-Server kan benaderd worden op het IP_Address van de server
#Krijg het IP-Address en sla deze op in een variabele
$SIPAddress = (Get-NetIPAddress -AddressFamily IPV4 -InterfaceAlias Ethernet0).IPAddress

#Open de url van de webserver in firefox om te testen dat IIS werkt
#Voor Edge moet je Firefox vervangen door msedge
#Voor Chrome moet je Firefox vervangen door chrome
[system.Diagnostics.Process]::Start("firefox","$SIPAddress")
#>

#Download GIT om de laatste versie van moodle te downloaden
$url = "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe"
$outpath = "C:/Git-2.38.1-64-bit.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#Silent Install van GIT
.\Git-2.38.1-64-bit.exe /VERYSILENT /NORESTART

#Open de MoodleGit.cmd file om moodle te clonen
Invoke-Item "MoodleGit.cmd"

#Download en installeer php 7.3.7. 8.x is niet supported en 7.4 is minder stabiel met moodle dan 7.3.
Invoke-Item "PHPInstall.cmd"

#Zet de goede configuratie values in PHP:

#Wat moeten we vervangen:
$old = @(";max_input_vars = 1000", ";fastcgi.impersonate = 1", ";opcache.enable=1", ";extension=curl", ";extension=fileinfo", ";extension=gd2", ";extension=intl", ";extension=mbstring", ";extension=exif", ";extension=mysqli", ";extension=openssl", ";extension=pdo_mysql", ";extension=soap", ";extension=sodium", ";extension=xmlrpc")

#Waar vervangen we het mee:
$new = @("max_input_vars = 5000", "fastcgi.impersonate = 1", "opcache.enable=1", "extension=curl", "extension=fileinfo", "extension=gd2", "extension=intl", "extension=mbstring", "extension=exif", "extension=mysqli", "extension=openssl", "extension=pdo_mysql", "extension=soap", "extension=sodium", "extension=xmlrpc")

#Do the loop baby
foreach ($value in $old){
    #Open de file
    (Get-Content C:\php\php.ini) | 
    #loop en vervang
    Foreach-Object {$_ -replace $value, $new[$var]} | 
    #Schrijf de change naar de file
    Set-Content C:\php\php.ini
}

#Download en installeer MariaDB. Maak ook de database aan met een user.
Invoke-Item "MariaDBInstall.cmd"

