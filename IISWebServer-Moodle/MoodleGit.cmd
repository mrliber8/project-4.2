@echo off
REM Ga naar de c schijf
cd C:\inetpub\wwwroot

REM Clone Moodle
"C:\Program Files\Git\cmd\git.exe" clone git://git.moodle.org/moodle.git

REM Ga naar de moodle directory
cd moodle

REM Maak een branch genaamd MOODLE_400_STABLE wat de laatste stable moodle versie is
"C:\Program Files\Git\cmd\git.exe" branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE

REM Switch naar de nieuwe branch
"C:\Program Files\Git\cmd\git.exe" checkout MOODLE_400_STABLE 

REM Pauze houd de window open maar staat er alleen in voor testen.
PAUSE