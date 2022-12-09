<#
Splunk kan data verzamelen door middel van een forwarder of door het WMI framework te gebruiken. De Splunk website zegt dit over de verschillende opties:
Use a universal forwarder to get data in from a remote Windows host. A universal forwarder offers the most types of data sources, provides more detailed data (for example, in performance monitoring metrics), minimizes network overhead, and reduces operational risk and complexity. It is also more scalable than WMI in many cases.
In circumstances where you collect data remotely, such as when corporate or security policy restricts code installation, or when there are performance or interoperability concerns, you can use the native WMI interface to collect event logs and performance data. 

Het gebruik van AD domain controllers en Exchange servers levert vaak een hoge utilisatie van die servers op, waardoor een forwarder beter is aangezien die een kleinere performance hit heeft.
#>

#Splunk moet gedownload en geinstalleerd worden door een account met local admin rechten. Om splunk te downloaden wordt dan oook de volgende code uitgevoerd:


#https://docs.splunk.com/Documentation/Splunk/9.0.2/Installation/PrepareyourWindowsnetworkforaSplunkinstallation
#Voor het runnen van Splunk word er een nieuwe domain user aangemaakt met de benodigde rechten
#Import de AD PowerShell module
Import-Module ActiveDirectory

#Maak de nieuwe user aan:
New-ADUser -Name SplunkServiceAccount `
-SamAccountName SplunkServiceAccount `
-Description "Splunk Service Account" `
-DisplayName "Service:Splunk" `
-Path "<CN=SplunkServiceAccount, OU=Managed Service Account, DC=harderwijk, DC=local>" `
-AccountPassword (Read-Host -AsSecureString "trAgdD7T") ` #Willekeurig gegenereerd ww
-CannotChangePassword $true `
-ChangePasswordAtLogon $false `
-PasswordNeverExpires $true ` #Vereiste voor splunk, tenzij wij een beleid opstellen waarin dit niet mag. Dan moeten wij beleid opstellen waarin dit wachtwoord optijd gewijzigd wordt.
-PasswordNotRequired $false `
-SmartcardLogonRequired $false `
-Enabled $true `
#-LogonWorkstations "<server>" ` #The LogonWorkstations argument is not required, but lets you limit which workstations a managed service account can use to log into the domain. Nu uitgezet vanwege tests.

#Configureer de security policy
#Voeg het account toe aan de local administrator groep:
$group = [ADSI]"WinNT://<server>/Administrators,group"
$group.Add("WinNT://harderwijk.local/SplunkServiceAccount")

#Maak een Backup file met de rechten van alle users op dit moment
secedit /export /areas USER_RIGHTS /cfg OldUserRights.inf

#Bewerk de backupfile om de rechten toe te passen
Get-Content OldUserRights.inf `
| Select-String -Pattern `
"(SeTcbPrivilege|SeChangeNotify|SeBatchLogon|SeServiceLogon|SeAssignPrimaryToken|SeSystemProfile)" `
| %{ "$_,harderwijk.local\SplunkServiceAccount" } `
| Out-File NewUserRights.inf

#Maak een nieuwe header en voeg het samen
( "[Unicode]", "Unicode=yes" ) | Out-File Header.inf
( "[Version]", "signature=`"`$CHICAGO`$`"", "Revision=1") | Out-File -Append Header.inf
( "[Privilege Rights]" ) | Out-File -Append Header.inf
Get-Content NewUserRights.inf | Out-File -Append Header.inf

#Zet de nieuwe file terug
secedit /import /cfg Header.inf /db C:\splunk-lsp.sdb
secedit /configure /db C:\splunk-lsp.sdb

#Download Splunk
wget -O splunk-9.0.2-17e00c557dc1-x64-release.msi "https://download.splunk.com/products/splunk/releases/9.0.2/windows/splunk-9.0.2-17e00c557dc1-x64-release.msi"

#Install Splunk
# Flags: https://docs.splunk.com/Documentation/Splunk/9.0.2/Installation/InstallonWindowsviathecommandline#Install_Splunk_Enterprise_from_the_command_line
msiexec.exe /i splunk-9.0.2-17e00c557dc1-x64-release.msi 
AGREETOLICENSE=Yes 
LOGON_USERNAME="<domain\username>" 
