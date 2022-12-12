$IsInstalled = ((Get-WindowsFeature -Name Web-Server).installed)
if ($isinstalled -eq $false){
    Install-WindowsFeature Web-Server -IncludeManagementTools -IncludeAllSubFeature -Confirm:$false
    Write-Output "Installation Complete"
}
else{
    Write-output "IIS Server (WebServer) is already installed"
}