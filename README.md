# Welkom bij de repo voor project-4.2 Infra & SOC
Deze repository bevat de code voor:
* Het uitrollen voor de diensten
* Het uitrollen van de Windows Computers
* De configuratie files voor de L3 en L2 Switches
* De configuratie files voor de Fortigate en de Routers


Verbinden met de servers: zie inrichten_vmware.txt in de map FortiGate_VMWare --> inrichting_netwerk_std.zip

---

## Documentatie

tHe CoDe ExPlAiNs It SeLf

---

## Wat hebben we nu?

### IIS en Moodle

IIS.ps1 installeert de iis webserver. Hierna wordt GIT gedownload zodat de stable versie van moodle via git gekloond kan worden. Dan wordt PHP 7.3.7 geinstalleerd. PHP 8.x is niet supported en 7.4 is minder stabiel met moodle dan 7.3, dus wordt de laatste 7.3 versie gedownload. 

Deze wordt in C:\php gezet, waarna de handlers voor php worden ingesteld. Ook wordt de PHP.ini aangepast zodat de juiste extensies van php ingesteld staan voor Moodle. Vervolgens wordt MariaDB geïnstalleerd & wordt er een database aangemaakt voor moodle samen met een user.

### Splunk

Splunk.ps1 maakt een user aan in de AD en geeft de benodigde rechten aan die user. Splunk 9.0.2 wordt daaran gedownload en uitgevoerd/


---

## To Do

Te veel :(

### IIS en Moodle

* Een silent install van Moodle

### Splunk

* Uitzoeken wat de correcte flags zijn voor bij de installatie via CLI
* Splunk configureren dat er logs verzameld worden

### Algemene To Do Servers

* Active Directory Certificate services
* Active Directory Domain Services
* AVG Anti-Virus
* DFS
* DHCP Server
* DNS Server
* Network Policy and Access Services (NPS Server)
* Exchange
* Squid Proxy
* Syslog
* 
* Group Policy Management?
* SMTP?

### Algemene To Do Client Software

* 7-Zip
* AVG Anti-Virus
* Auto Enroll in AD
* MS Edge
* Office 2010/2013/2016
* Outlook 2013/2016




