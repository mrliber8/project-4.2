Import-Module ActiveDirectory  

$gebruikerlijst = Import-csv -Delimiter "," -Path "C:\Users\ITV2F-W19-19\Documents\users\users.csv"

foreach ($User in $gebruikerlijst)
{

       $Firstname = $User.firstname
       $Lastname = $User.lastname
       $Username = $User.username
       $Password = $User.password
       $Email = $User.email

       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
             Write-Warning "De gebruiker $Username bestaat al."
       }
       else {

            New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@Minerva_F.hanze10" `
            -Name "$Firstname $Lastname" `
            -EmailAddress $Email `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $false 

       }
}