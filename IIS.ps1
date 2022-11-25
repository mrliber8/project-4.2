#Controleer of de Web Server er al op staat
$srv = Get-WindowsFeature *Web-Server*
if ($srv.installed) {#Do Nothing, if statement staat erin voor het testen zodat we hem vaker uit kunnen voeren
} else {
    Install-WindowsFeature -name Web-Server -IncludeManagementTools #Installeer de IIS Web-Server
}