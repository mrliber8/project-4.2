#Moet als administrator worden uitgevoerd.


#pad naar de installer
$EdgeInstallPad = 'https://go.microsoft.com/fwlink/?linkid=2108834&Channel=Stable&language=nl&brand=M100'

#Hier wordt de exe opgeslagen
$LokaalPad = 'C:\MicrosoftEdgeSetup.exe'

#Argumenten voor een silent install
$EdgeInstallerArgs = '/silent /install'

#Uitvoeren van de installer
Invoke-WebRequest -Uri $EdgeInstallPad -OutFile $LokaalPad

Start-Process $LokaalPad -ArgumentList $EdgeInstallerArgs -Wait

Write-Output "Microsoft Edge is gedownload" 