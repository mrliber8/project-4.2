#Ask for username and password
$secpasswdprompt = Read-Host -Prompt "Enter Password"
$secusrname = Read-Host -Prompt "Enter Username"

#Convert the password to secure string
$secpasswd = ConvertTo-SecureString $secpasswdprompt -AsPlainText -Force

#Get the ip addresses to later loop through, so we can automate multiple devices
$iprange = Get-Content "./iprange.txt"

#For every address in the iprange.txt file, execute the SSH session

ForEach ($Ipaddress in $iprange){
    InitSSH -Ipaddress $Ipaddress -secusrname $secusrname -secpasswd $secpasswd
    Invoke-Expression "D:\Project-4.2\project-4.2\Cisco\Scripts\test.ps1 $Ipaddress $secusrname $secpasswd"
}