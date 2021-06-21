@ECHO off
TITLE %~dp0
COLOR B

ECHO -------------------------------------------------------------------------
ECHO  Delete all NFO Files
ECHO  starting from here : "%~dp0"
ECHO.
SET /p c=Are you sure you want to continue[y/n] ?  
IF /i "%c%" EQU "y" GOTO :delete
IF /i "%c%" NEQ "y" GOTO :quit
:delete
ECHO.

ECHO matching files found in "%~dp0"
FOR /r %%a in ("*.nfo") DO IF EXIST "%%a" (
	ECHO - "%%a" 
	del "%%a"
	ECHO.
)
GOTO :quit

:quit
ECHO.
IF /I "%c%" EQU "Y" ECHO press key to close
IF /I "%c%" NEQ "Y" ECHO      ------- you quit without actions - press key to close -------
ECHO.
PAUSE > NUL