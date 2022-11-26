@ echo off
REM Maak een folder aan voor php
mkdir C:\php

REM Verander de working directory naar die folder
cd C:\php

REM Download de laatste versie van php
curl https://windows.php.net/downloads/releases/php-8.1.13-nts-Win32-vs16-x64.zip --output ./php-8.1.13.zip --ssl-no-revoke

REM Pak de zipfile uit
tar -xf php-8.1.13.zip

REM Stel de path voor PHP in
set phptpath=C:\php

REM Clear current PHP handlers
%windir%\system32\inetsrv\appcmd clear config /section:system.webServer/fastCGI

REM The following command will generate an error message if PHP is not installed. This can be ignored.
%windir%\system32\inetsrv\appcmd set config /section:system.webServer/handlers /-[name='PHP_via_FastCGI']

REM Set up the PHP handler
%windir%\system32\inetsrv\appcmd set config /section:system.webServer/fastCGI /+[fullPath='%phppath%\php-cgi.exe']
%windir%\system32\inetsrv\appcmd set config /section:system.webServer/handlers /+[name='PHP_via_FastCGI',path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='%phppath%\php-cgi.exe',resourceType='Unspecified']
%windir%\system32\inetsrv\appcmd set config /section:system.webServer/handlers /accessPolicy:Read,Script

REM Configure FastCGI Variables
%windir%\system32\inetsrv\appcmd set config -section:system.webServer/fastCgi /[fullPath='%phppath%\php-cgi.exe'].instanceMaxRequests:10000
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%phppath%\php-cgi.exe'].environmentVariables.[name='PHP_FCGI_MAX_REQUESTS',value='10000']"
%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/fastCgi /+"[fullPath='%phppath%\php-cgi.exe'].environmentVariables.[name='PHPRC',value='%phppath%\php.ini']"