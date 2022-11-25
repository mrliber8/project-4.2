@echo off
:: This is a comment
cd c:\
::This command initializes the new local repository as a clone of the 'upstream' (i.e. the remote server based) moodle.git repository. The upstream repository is called 'origin' by default. It creates a new directory named moodle, where it downloads all the files. This operation can take a while as it is actually getting the entire history of all Moodle versions
git clone git://git.moodle.org/moodle.git
cd moodle
::This command lists all available branches.
git branch -a
::Create a new local branch called MOODLE_400_STABLE and set it to track the remote branch MOODLE_400_STABLE from the upstream repository.
git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
::This command actually switches to the newly created local branch.
git checkout MOODLE_400_STABLE 
:: The PAUSE Command keeps the windows open, is useful for testing
PAUSE