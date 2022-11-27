@echo off
REM Ga naar de c schijf
cd c:\

REM Clone Moodle
git clone git://git.moodle.org/moodle.git

REM Ga naar de moodle directory
cd moodle

REM Maak een branch genaamd MOODLE_400_STABLE wat de laatste stable moodle versie is
git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE

REM Switch naar de nieuwe branch
git checkout MOODLE_400_STABLE 

REM Pauze houd de window open maar staat er alleen in voor testen.
REM PAUSE