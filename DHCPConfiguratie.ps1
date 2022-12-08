Install-WindowsFeature -Name DHCP -IncludeManagementTools

#Range van de DCHP hier invoeren, evenals subnetmask
Add-DhcpServerv4Scope -Name "DHCP Scope 1" -StartRange 10.0.0.0 -EndRange 10.0.0.255 -SubnetMask 255.255.255.0

#IP van de DNS server en Default Gateway (router) hier invoeren
Set-DhcpServerv4OptionValue -DnsServer 10.0.1.1 -Router 10.0.1.1
Set-DhcpServerv4Scope -ScopeId 10.0.1.1 -LeaseDuration 1.00:00:00

Restart-Service Dhcpserver
