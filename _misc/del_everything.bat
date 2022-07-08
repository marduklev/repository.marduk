@echo off
TITLE "%~dp0"
COLOR B

ECHO -------------------------------------------------------------------------
ECHO  Delete everything
ECHO  starting from here : "%~dp0"
ECHO.
SET /p c=Are you sure you want to continue[y/n] ?  
IF /i "%c%" EQU "y" GOTO :delete
IF /i "%c%" NEQ "y" GOTO :quit

:delete
for /r %%b in ("*") do (
echo "%%~b"
rd /s /q "%%b"
del /s /q "%%b"
)
GOTO :quit

:quit
ECHO.
IF /I "%c%" EQU "Y" ECHO press key to close
IF /I "%c%" NEQ "Y" ECHO      ------- you quit without actions - press key to close -------
ECHO.
PAUSE > NUL