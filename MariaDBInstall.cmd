@ echo off

REM Download de laatste versie van Maria DB
curl https://archive.mariadb.org//mariadb-10.10.2/winx64-packages/mariadb-10.10.2-winx64.msi --output mariadb-10.10.2-winx64.msi --ssl-no-revoke

REM Perform a silent install
msiexec /i mariadb-10.10.2-winx64.msi SERVICENAME=MySQL DATADIR=C:\mariadb5.2\data PASSWORD=trAgdD7T UTF8=1 /qn /l*v InstallLogFile.txt

REM Ga naar de directory waar MariaDB in staat
cd C:\Program Files\MariaDB 10.10\bin

REM Maak een database aan genaamd moodle met character set utf8
mysql -u root -ptrAgdD7T -e "CREATE DATABASE moodle /*\!40100 DEFAULT CHARACTER SET utf8 */;"

REM Staat er in voor het testen en toont de aanwezige databases
mysql -u root -ptrAgdD7T -e "show databases;"

REM Maakt een user genaamd moodleTestAdmin aan met het wachtwoord trAgdD7T
mysql -u root -ptrAgdD7T -e "CREATE USER moodleTestAdmin@localhost IDENTIFIED BY 'trAgdD7T';"

REM Geeft alle rechten aan moodleTestAdmin van de moodle database
mysql -u root -ptrAgdD7T -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodleTestAdmin'@'localhost';"

REM Ververs de rechten voor de database
mysql -u root -ptrAgdD7T -e "FLUSH PRIVILEGES;"


