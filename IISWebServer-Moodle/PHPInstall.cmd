@ echo off
REM Maak een folder aan voor php
mkdir C:\php

REM Verander de working directory naar die folder
cd C:\php

REM Download de laatste 7.3 php versie. Php 8 is niet supported, en php 7.4 is niet "officieel" supported
curl https://windows.php.net/downloads/releases/archives/php-7.3.7-nts-Win32-VC15-x64.zip --output ./php-7.3.7.zip --ssl-no-revoke

REM Pak de zipfile uit
tar -xf php-7.3.7.zip

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

rename php.ini-production php.ini

REM Pauze houd de window open maar staat er alleen in voor testen.
PAUSE