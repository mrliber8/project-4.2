#ADDS&DNS Installation
 
#ADDS role Installation
 
Install-windowsfeature AD-domain-services -IncludeAllSubFeature -IncludeManagementTools
Import-Module ADDSDeployment
 
#ADDS configurations
 
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "Harderwijk.local" `
-DomainNetbiosName "Harderwijk" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true