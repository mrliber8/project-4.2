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

$plinkAndPath = "C:\users\patrick ten brinke\downloads\plink.exe"
$username = Read-Host -Prompt "Input username"
$password = Read-Host -Prompt "Input password"
# Get the ip Ranges
$iprange = Get-Content "C:\users\patrick ten brinke\downloads\iprange.txt"
# Commands to execute:
$Commands = Get-Content "C:\users\patrick ten brinke\downloads\command.txt"
ForEach ($hostname in $iprange){
    Invoke-SSH -username $username -hostname $hostname -password $password -plinkAndPath $plinkAndPath -commandArray $Commands -connectOnceToAcceptHostKey $true > C:\MyScripts\output.txt
}