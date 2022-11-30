@ echo off
REM Set default document voor IIS
%systemroot%\system32\inetsrv\AppCmd.exe set config /section:defaultDocument /enabled:true /+files.[value='index.php']

REM Download de laatste versie van Maria DB
curl https://archive.mariadb.org//mariadb-10.10.2/winx64-packages/mariadb-10.10.2-winx64.msi --output mariadb-10.10.2-winx64.msi --ssl-no-revoke

REM Perform a silent install
msiexec /i mariadb-10.10.2-winx64.msi SERVICENAME=MySQL DATADIR=C:\mariadb5.2\data UTF8=1 /qn /l*v InstallLogFile.txt

REM Execute een.sql script die een database aanmaakt samen met een user met de correcte rechten
"C:\Program Files\MariaDB 10.10\bin\mysql.exe" -u root <  MakeMoodleDatabaseAndUser.sql

REM Pauze houd de window open maar staat er alleen in voor testen.
PAUSE

