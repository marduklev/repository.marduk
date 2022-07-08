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
FOR /d /r %%d in (extrathumbs extrafanart .actors) DO IF EXIST "%%d" (
	ECHO - "%%d"
	rd /s /q "%%d"
	ECHO.
)
ECHO matching files found in "%~dp0"
FOR /r %%a in (*.jpg *.png *.nfo) DO IF EXIST "%%a" (
	ECHO - "%%a" 
	del "%%a"
	ECHO.
)
ECHO.
REM ECHO remaining files in "%~dp0"
REM FOR /r %%a in (*.*) DO IF EXIST "%%a" ECHO - %%a
GOTO :quit

:quit
ECHO.
IF /I "%c%" EQU "Y" ECHO press key to close
IF /I "%c%" NEQ "Y" ECHO      ------- you quit without actions - press key to close -------
ECHO.
PAUSE > NUL