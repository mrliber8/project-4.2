<#
    Author: Patrick ten Brinke
    Description: Powershell script to automate Cisco device maintenance using the Posh-SSH module.
    Required dependencie: Posh-SSH module.
    Required extra file: A iprange.txt file with IP ranges or hostnames of the Cisco Devices
    Required extra file: A commands.txt file with commands to send to the Cisco Devices
#>

#Install-Module -Name Posh-SSH

function InitSSH {
    param ($Ipaddress, $secusrname, $secpasswd)

    #Convert username and password to credentials
    $creds = New-Object System.Management.Automation.PSCredential ($secusrname, $secpasswd)

    #Start the SSH session
    $session = New-SSHSession -ComputerName $Ipaddress -Credential $creds -AcceptKey -Force

    #Open a shell for Cisco devices. Cisco devices close the connection after entering a command, so we have to open a 
    #shell as a stream object that we can write to and reda from.
    $stream = $session.Session.CreateShellStream("dumb", 0, 0, 0, 0, 1000)

    #To enable the console of Cisco devices a password is required. This prompt does not accept a regular command, so we have to give the password
    #as a "secure" action. The following code piece gives the command "en" and if it sees the line "Password:" given back it will enter the password.
    $result = Invoke-SSHStreamExpectSecureAction -ShellStream $stream -Command "en `n" -ExpectString "Password:" -SecureAction $secpasswd -verbose

    #Get a txt file with commands
    $commands = Get-Content "./commands.txt"

    #Loop through the commands
    ForEach ($command in $commands){
        
        #There is a delay between executing the command and the result, depending on the connection speed.
        #Therefore EVERY command needs a sleep timer in front of it, or errors will occur.
        Start-Sleep -Milliseconds 100
        
        #Execute the command
        $stream.WriteLine($command)
    }

    #Read the stream
    $stream.Read()

    #Close the SSH Session
    Remove-SSHSession -Index 0
}

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
}

#Keep the window open to see the commands being executed as well as their output
Read-Host -Prompt "Press Enter to exit"
