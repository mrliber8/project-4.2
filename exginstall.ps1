Invoke-WebRequest "https://download.microsoft.com/download/b/c/7/bc766694-8398-4258-8e1e-ce4ddb9b3f7d/ExchangeServer2019-x64-CU12.ISO"  -OutFile "C:/";

Mount-DiskImage -ImagePath "C:\ExchangeServer2019-x64-CU12.íso";

E:;

.\Setup.exe /IAcceptExchangeServerLicenseTerms /PrepareSchema;
.\Setup.exe /IAcceptExchangeServerLicenseTerms /PrepareAD /OrganizationName:"*invullen*";
.\Setup.exe /IAcceptExchangeServerLicenseTerms /PrepareAllDomains; () #Alleen bij meerdere domains
.\Setup.exe /IAcceptExchangeServerLicenseTerms /mode:install /Role:Mailbox;

