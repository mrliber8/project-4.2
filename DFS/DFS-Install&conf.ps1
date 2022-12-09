#DFS Features installeren op de server
- Install-WindowsFeature FS-DFS-Namespace -IncludeManagementTools

#Maak de root map voor DFS Namespace Share
- mkdir c:\DFSRoosts\Share

#Smbshare instellen voor DFS Namespace
- New-SmbShare -Name 'Share' -Path 'c:\DFSRoots\Share' -FullAccess 'Everyone'

#DFS namespace aanmaken
#Path van Share
#Type DomainV1
#TargetPath (target share path : met de naam van de server)
- New-DdsnRoot -Path '\\Harderwijk.local\Share' -Type DomainV2 -TargetPath '\\WindowsServer5\Share'

#Instellingen bevestigen
- Get-DfsnRoot -Path '\\Harderwijk.local\Share' | Format-List
