Function Invoke-SSH
{
    <#
    Source: (Author: Robin Malik) Modified from: http://www.zerrouki.com/invoke-ssh/
    #>
    
    Param($hostname,$username,$password,$commandArray,$plinkAndPath,$connectOnceToAcceptHostKey = $false)
    
    $target = $username + '@' + $hostname
    $plinkoptions = "-ssh $target -pw $password"
     
    # On first connect to a host, plink will prompt you to accept the remote host key.
    # This section will login and accept the host key then logout:
    if($ConnectOnceToAcceptHostKey)
    {
        $plinkCommand  = [string]::Format('echo y | & "{0}" {1} exit', $plinkAndPath, $plinkoptions )
        $msg = Invoke-Expression $plinkCommand
    }
    
    # Build the SSH Command by looping through the passed value(s). Append exit in order to logout:
    $commandArray += "exit"
    $commandArray | % { $remoteCommand += [string]::Format('{0}; ', $_) }
    
    # Format the command to pass to plink:
    $plinkCommand = [string]::Format('& "{0}" {1} "{2}"', $plinkAndPath, $plinkoptions , $remoteCommand)
     
    # Execute the command and display the output:
    $msg = Invoke-Expression $plinkCommand
    Write-Output $msg
}

#Set the Path for Plink
$plinkAndPath = plink.exe
#Prompt for username
$username = Read-Host -Prompt "Input username"
#Prompt for Password
$password = Read-Host -Prompt "Input password"
#Get the ip Ranges
$iprange = Get-Content Cisco/iprange.txt
#Commands to execute:
$Commands = Get-Content Cisco/command.txt
#Loop through the IPRanges and make all the changes
ForEach ($hostname in $iprange){
    Invoke-SSH -username $username -hostname $hostname -password $password -plinkAndPath $plinkAndPath -commandArray $Commands -connectOnceToAcceptHostKey $true > output.txt
}