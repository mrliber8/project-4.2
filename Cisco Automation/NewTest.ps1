Function Invoke-SSH{
    param($hostname, $username, $password)
    $commandFile = ""
    $remoteCommand = ""
    $commandFile = Get-Content "D:\Project-4.2\project-4.2\Cisco Automation\commands.txt" 
    $commandFile | % { $remoteCommand += [string]::Format('{0}; ', $_) }
    $remoteCommand += "exit"
    
    $plinkOptions1 = "-batch -l "
    $plinkCommand = [string]::Format('{0} {1} {2} "{3}" {4} "{5}" "{6}"', 'plink.exe', $hostname, $plinkOptions1, $username, "-pw", $password, $remoteCommand )
    Invoke-Expression $plinkCommand
}

Function Start-SSH{
    $hostname = ""
    $iprange = Get-Content "Cisco Automation/iprange.txt"
    $username = Read-Host -Prompt "Input username"
    $password = Read-Host -Prompt "Input password"

    ForEach ($hostname in $iprange){
        #Write-Output $hostname
        Invoke-SSH -hostname $hostname -username $username -password $password
    }

}

Start-SSH
