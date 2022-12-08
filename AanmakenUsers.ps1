#Requires -RunAsAdministrator

#Domein vastleggen
$domain = "Harderwijk.local"

#Eigenschappen van de nieuwe gebruiker
$userName = "Gebruikersnaam"
$password = Read-Host -Prompt "Voer een wachtwoord in die voldoet aan de eisen"
$givenName = "Voornaam"
$surname = "Achternaam"
$Identity = "Groep"

#Create user
New-ADUser -Name $userName -GivenName $givenName -Surname $surname -SamAccountName $userName -UserPrincipalName "$userName@$domain" -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -Enabled $true

#User toevoegen aan een nieuwe groep (Identity = de group)
Add-ADGroupMember -Identity $Identity -Members $userName