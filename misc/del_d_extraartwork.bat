@ECHO off
TITLE %~dp0
COLOR B

ECHO -------------------------------------------------------------------------
ECHO  Delete all 'extrathumbs' 'extrafanart' Folders, Artwork and NFO Files
ECHO  in "%~dp0"
ECHO.
SET /p c=Are you sure you want to continue[y/n] ?  
IF /i "%c%" EQU "y" GOTO :delete
IF /i "%c%" NEQ "y" GOTO :quit

:delete
ECHO.
ECHO matching folders found in "%~dp0"
FOR /d /r %%d in (extrathumbs extrafanart) DO IF EXIST "%%d" (
	ECHO - "%%d"
	rd /s /q "%%d"
	ECHO.
)
GOTO :quit

:quit
ECHO.
IF /I "%c%" EQU "Y" ECHO press key to close
IF /I "%c%" NEQ "Y" ECHO      ------- you quit without actions - press key to close -------
ECHO.
PAUSE > NUL